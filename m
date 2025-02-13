Return-Path: <stable+bounces-115574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7459EA344A0
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDBC3B11F6
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE861FFC49;
	Thu, 13 Feb 2025 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="woMffTsr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB64138389;
	Thu, 13 Feb 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458523; cv=none; b=PBAG9YmXAj12ro4xkW97ZpNCASxQmo4UWjO7iZdRsVkPoS3Y6HEefu8TFvFB9UUUY1IY12gbJ3ORwa+B2QkBlIyv8FnvQsxTldE0emrbZYfq4jUg6XK42tMcyad3izCr8Pw2i1YFlLriEiR5t++vAMKJOoIDlBsElRtH5zS76J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458523; c=relaxed/simple;
	bh=hVgz5Ns1SknuPeNZ3h3lkVK3MqfH4o81YYl6xYG1UJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFy1drqrhrQmvzCKd6oEyO9lm0ndzLoaDDKodSGnZOYdGZUuJniQ504VxcAZ6uoc5mDYPHhS7w143yGn7Wp/0UU8Pxj6mhASCyjzkjnNc9J9JRfLJpCLtAWxqhOTfxWgV1tI6ppb4bwNQbV2J1BVEg+Qg83H6a5wQHaLh5epFd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=woMffTsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70854C4CED1;
	Thu, 13 Feb 2025 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458522;
	bh=hVgz5Ns1SknuPeNZ3h3lkVK3MqfH4o81YYl6xYG1UJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=woMffTsr7lCdq8eCMgInYI78Xyn0u/r0z5kN4DSBwVc02bGnV9lbGuWnlYjzqLBH2
	 OH8tZjmQ0PX5LlA/kNFPNcAus3Spv3hrqxvuieXs//qXseGsQkZTOWiJ3ZXf/C1u/Y
	 tEvQScoQX/9HbQj3tThuFp1TmQ5rMldoQKlEvRvY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.12 405/422] xfs: lock dquot buffer before detaching dquot from b_li_list
Date: Thu, 13 Feb 2025 15:29:14 +0100
Message-ID: <20250213142452.182461397@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darrick J. Wong <djwong@kernel.org>

commit 111d36d6278756128b7d7fab787fdcbf8221cd98 upstream

We have to lock the buffer before we can delete the dquot log item from
the buffer's log item list.

Cc: <stable@vger.kernel.org> # v6.13-rc3
Fixes: acc8f8628c3737 ("xfs: attach dquot buffer to dquot log item buffer")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_dquot.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -87,8 +87,9 @@ xfs_dquot_detach_buf(
 	}
 	spin_unlock(&qlip->qli_lock);
 	if (bp) {
+		xfs_buf_lock(bp);
 		list_del_init(&qlip->qli_item.li_bio_list);
-		xfs_buf_rele(bp);
+		xfs_buf_relse(bp);
 	}
 }
 



