Return-Path: <stable+bounces-98104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082309E272F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DEB16D565
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40C61F8907;
	Tue,  3 Dec 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K+a55xz9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922661F706D;
	Tue,  3 Dec 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242803; cv=none; b=bDhawxISEmTPxX9A3gNwLlFU/bJtbazunVh4gHB9F8aOKdtY82ghrrSK8cUd/N5MkWlbZiSEycZ97cN2MJUVK5Fvs7lpgn7o9Zuz60aakJT3quoXUZjfqJSiRXn9b2Jft21lx3rCvrsRV2JUfHmhgy6GxCEgFLCQPvmm1OJIMcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242803; c=relaxed/simple;
	bh=dhWo5qMh631ATD5nxH5DEXkDYYaB4AOrnf+kr8dGosI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9kFeTyqpSpu8Zy1BFppRYUJxkjM56liarmpUTZZmChU/T5578khiW5pK18AgPgq5SVTNrfQuSoop9q0pqk1rtH7j0aHcOImt2E6PZR2Pk9iGefMuCYO3R+bkuvavXUmXy2jw0nFSEDEmz1cHDjvVw4ot/RXIQAFcMOVRUDz1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K+a55xz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DC5C4CECF;
	Tue,  3 Dec 2024 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242803;
	bh=dhWo5qMh631ATD5nxH5DEXkDYYaB4AOrnf+kr8dGosI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+a55xz9J14n0xryb/dbUB0YPyddUwEpNz0ID4A/o/mdk0zXyH6YHkREDRYkXp6hE
	 y/nQl2VrUt4Psm0uOXAQpfkyoK7vaDFUTGQpxXT+5yLBrao/vGSgdP9dmRfEH05PAK
	 iUkS201tPykjodTK351ENu7CjJomjfVFBseu5cmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhangPeng <zhangpeng362@huawei.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 787/826] hostfs: Fix the NULL vs IS_ERR() bug for __filemap_get_folio()
Date: Tue,  3 Dec 2024 15:48:34 +0100
Message-ID: <20241203144814.459655295@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: ZhangPeng <zhangpeng362@huawei.com>

[ Upstream commit bed2cc482600296fe04edbc38005ba2851449c10 ]

The __filemap_get_folio() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Fixes: 1da86618bdce ("fs: Convert aops->write_begin to take a folio")
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hostfs/hostfs_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6d1cf2436ead6..084f6ed2dd7a6 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -471,8 +471,8 @@ static int hostfs_write_begin(struct file *file, struct address_space *mapping,
 
 	*foliop = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping));
-	if (!*foliop)
-		return -ENOMEM;
+	if (IS_ERR(*foliop))
+		return PTR_ERR(*foliop);
 	return 0;
 }
 
-- 
2.43.0




