Return-Path: <stable+bounces-180110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABFAB7E8A5
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2057BA1B7
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D03A32BC1A;
	Wed, 17 Sep 2025 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AZ0kkKQS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E12EC0B6;
	Wed, 17 Sep 2025 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113417; cv=none; b=j03WQxvoyqUznKz64Dndxz6FeITZOvXEpyl4VepyU9rp5rBuVCRr1MzG+XF0HiT/8wkh7EJbHv4tyXq0HYf8U9h34rMrPfhczi6pvlwFoAOixb+fuKr8dWFGLN+CdmZJv8IUVQboYIJHEVL/+RALfe/K4L+rlFaXQqqRzWyWBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113417; c=relaxed/simple;
	bh=NcjRnkyQpbTK2gBovpJS5x+kAIKMvQoUHcbJ1eqbZlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZMhBd6NwTKwhkBImtTnAD6iBiVug1TgkQjwJCoq4jzObTd+6XZ6WGlAok+kBK6Tov+acmj32696t6Y70ThzNgMTMkfPhqQ02sbS7J71PmiPI/yfFTRtndIS6D96f+/5QqP1DqExWQgi5NbXx0ZVl+WvGxHBFlfs82vEJV8GP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AZ0kkKQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC85C4CEF5;
	Wed, 17 Sep 2025 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113416;
	bh=NcjRnkyQpbTK2gBovpJS5x+kAIKMvQoUHcbJ1eqbZlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZ0kkKQSD6g91TNw6nabktlBcj+CmDEbXzX0/7CRULYBl0O28TDubNLEnSnHc11u+
	 +CDGNU225GDpsp6GsEYkWeUR4hkK12kG6NEbDq1fB3418AxIUpcKUaSoMhi/aqdrIK
	 mW7QnN5Xoy0Jrm5xZIoL6ibrJaDbQjy3c9r6mqko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 035/140] NFSv4.2: Serialise O_DIRECT i/o and clone range
Date: Wed, 17 Sep 2025 14:33:27 +0200
Message-ID: <20250917123345.168038661@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit c80ebeba1198eac8811ab0dba36ecc13d51e4438 ]

Ensure that all O_DIRECT reads and writes complete before cloning a file
range, so that both the source and destination are up to date.

Fixes: a5864c999de6 ("NFS: Do not serialise O_DIRECT reads and writes")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1cd9652f3c280..453d08a9c4b4d 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -283,9 +283,11 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 
 	/* flush all pending writes on both src and dst so that server
 	 * has the latest data */
+	nfs_file_block_o_direct(NFS_I(src_inode));
 	ret = nfs_sync_inode(src_inode);
 	if (ret)
 		goto out_unlock;
+	nfs_file_block_o_direct(NFS_I(dst_inode));
 	ret = nfs_sync_inode(dst_inode);
 	if (ret)
 		goto out_unlock;
-- 
2.51.0




