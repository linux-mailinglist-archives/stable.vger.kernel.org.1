Return-Path: <stable+bounces-87317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9A89A6469
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93B21C22182
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046941EABDD;
	Mon, 21 Oct 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xDDOihqG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16641E32D7;
	Mon, 21 Oct 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507243; cv=none; b=KQUWLR5AbIE9z+tUiRp/DYSFhaW5ss4+FTV6wS2cf+Rv2BEH+UQkrxxoKysDSveDx7sIfF1WGR5HdUlwzUNdenqNHx+UnPCaqHA890WLlK7tYgTE8jdkNLwFdMbwSnTTpdV+b+SAuyLBf60vY7jtStatQyMOb5vCmCxmf5aLBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507243; c=relaxed/simple;
	bh=Qzq4drrQ8nRJWuOxBchayyiXi+wF0qM80h6uUfiQFXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OW4HI5j7caXXwWrr3ojo6hgIcAiN9UYaFKUWQM8T2Ghx63t0A3RDpNO1cYBe85gY5B3W5tR8q77syPNWiZf2gYSzpEEbmWmgkITvQiUZJScAOIWPl2T4H2hUJUmnmQ+6btmV0cbXDm5WtRbw0yqF+5Bxc4H134iHB33RhxHZtYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xDDOihqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30767C4CEC3;
	Mon, 21 Oct 2024 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507243;
	bh=Qzq4drrQ8nRJWuOxBchayyiXi+wF0qM80h6uUfiQFXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xDDOihqGTAgTY4gctHKVCxNkOYQdN/DueVSkpCzRFR8IAtbBQ4RNYTQrAJDyObDW7
	 yexTrz2j3OlWZj7Cllrb2aSFWzMAul8MpO5I0qJJlNw5s9SHUF/8ONUbvCueKy7Vco
	 Y5oWCFzlv+CfEi2eRUwlnyuQl7TFAgdPaCE3rF4k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 13/91] udf: Convert udf_lookup() to use new directory iteration code
Date: Mon, 21 Oct 2024 12:24:27 +0200
Message-ID: <20241021102250.325048230@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102249.791942892@linuxfoundation.org>
References: <20241021102249.791942892@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit 200918b34d158cdaee531db7e0c80b92c57e66f1 ]

Convert udf_lookup() to use udf_fiiter_find_entry() for looking up
directory entries.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/udf/namei.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -366,25 +366,22 @@ static struct dentry *udf_lookup(struct
 				 unsigned int flags)
 {
 	struct inode *inode = NULL;
-	struct fileIdentDesc cfi;
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc *fi;
+	struct udf_fileident_iter iter;
+	int err;
 
 	if (dentry->d_name.len > UDF_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
-	if (IS_ERR(fi))
-		return ERR_CAST(fi);
+	err = udf_fiiter_find_entry(dir, &dentry->d_name, &iter);
+	if (err < 0 && err != -ENOENT)
+		return ERR_PTR(err);
 
-	if (fi) {
+	if (err == 0) {
 		struct kernel_lb_addr loc;
 
-		if (fibh.sbh != fibh.ebh)
-			brelse(fibh.ebh);
-		brelse(fibh.sbh);
+		loc = lelb_to_cpu(iter.fi.icb.extLocation);
+		udf_fiiter_release(&iter);
 
-		loc = lelb_to_cpu(cfi.icb.extLocation);
 		inode = udf_iget(dir->i_sb, &loc);
 		if (IS_ERR(inode))
 			return ERR_CAST(inode);



