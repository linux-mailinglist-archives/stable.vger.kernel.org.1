Return-Path: <stable+bounces-167648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3BB23107
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD971AA30EB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648152FE562;
	Tue, 12 Aug 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ITxxbiel"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131372FE566;
	Tue, 12 Aug 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021523; cv=none; b=uck3DL/7CPXAY5HYeb0Fseb0fKN30igpWe7kutJB+g1Ao4lMlwpyRQfWrznDyRilR1fV4N/i78/DMgneP//kK+ytbsCl6eQBJ/4qte7jCZp+mm9I8F3aVyVhTuO1sCrrD1lk6e2mv5h5w0mlEqAaQevYPmJsrEuHxUD0j8gLfdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021523; c=relaxed/simple;
	bh=CUn8dc7wpZD3pvXI/b97ngh+f1uuRlr0y8uUkB91eY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eum+mOQEbFZdgST1vZkPiYZ9Z6ndWTNMwZJi0I4AfycOsMzXYOnkYIjk5sSBtQiSKRLkR1cC/D4VbBpy0G98phr4UAXEZMXVSODgFYCGRMki4KTm0V7DAuJIIpyfJzB2K7TfF2MXNYtANRbXNY0zYBHHt23wfljjRI9+krb8jBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ITxxbiel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CC1C4CEFA;
	Tue, 12 Aug 2025 17:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021522;
	bh=CUn8dc7wpZD3pvXI/b97ngh+f1uuRlr0y8uUkB91eY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITxxbieludTeChOHHufOHjCKGM7O+h+NqDU0m7TmtgwprfpQnd24oBdJpJ9Orv7AR
	 wOuVZl1LxJdai8/B4P25pEELnUa1yjQ01550ZpdofqgGLCH9mrGVkT5scPIPCXEgA2
	 v2gsTYACrs9q9oEtfDfVMh4dyEurDTFogXXJ/Llc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 120/262] fanotify: sanitize handle_type values when reporting fid
Date: Tue, 12 Aug 2025 19:28:28 +0200
Message-ID: <20250812172958.220082391@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 8631e01c2c5d1fe6705bcc0d733a0b7a17d3daac ]

Unlike file_handle, type and len of struct fanotify_fh are u8.
Traditionally, filesystem return handle_type < 0xff, but there
is no enforecement for that in vfs.

Add a sanity check in fanotify to avoid truncating handle_type
if its value is > 0xff.

Fixes: 7cdafe6cc4a6 ("exportfs: check for error return value from exportfs_encode_*()")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250627104835.184495-1-amir73il@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 9dac7f6e72d2..723ff9cad9ed 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -445,7 +445,13 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	dwords = fh_len >> 2;
 	type = exportfs_encode_fid(inode, buf, &dwords);
 	err = -EINVAL;
-	if (type <= 0 || type == FILEID_INVALID || fh_len != dwords << 2)
+	/*
+	 * Unlike file_handle, type and len of struct fanotify_fh are u8.
+	 * Traditionally, filesystem return handle_type < 0xff, but there
+	 * is no enforecement for that in vfs.
+	 */
+	BUILD_BUG_ON(MAX_HANDLE_SZ > 0xff || FILEID_INVALID > 0xff);
+	if (type <= 0 || type >= FILEID_INVALID || fh_len != dwords << 2)
 		goto out_err;
 
 	fh->type = type;
-- 
2.39.5




