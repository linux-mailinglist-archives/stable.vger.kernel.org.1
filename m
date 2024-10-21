Return-Path: <stable+bounces-87318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FF59A646A
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47D21C21DAC
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51B1EF0A6;
	Mon, 21 Oct 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="npk3RsA5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64941E32D7;
	Mon, 21 Oct 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507246; cv=none; b=p5jJ/Xv5jP5CljM/dTcV0mZYY+9/XJb6kcFjawnRCpU3vmFzn2o0fZgZnRsMh2znqMjao0pN3OdiYDId5M/xuwkU8FH5LmOB6ilj1yRGKjkqtx8HW2iMIczjVRcyxvBoDnoPM4ob3WE4AkCucD+oCPYHQ4ng2uepW4+Uo7yHwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507246; c=relaxed/simple;
	bh=Jw+n4VX9UXBo/DPkSPYgaIuzaLKfrcawsKa99HHr75Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWtZMyOR78ld7HKBnIi1W8KiUEx/DdI3KV19n0tkzV2/MKb0dcqHjOdm6OMZIoMUbK5D9up80ADf/DGrpFczsi/D65fHXYmgFxe8oXIJbYmeKt4TW2xXQZ4G3dUiPvZqk7cZK75tYHu+phQkklRYf4VvC3w7Tr+uDs9soO2WLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=npk3RsA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BECC4CEC3;
	Mon, 21 Oct 2024 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507246;
	bh=Jw+n4VX9UXBo/DPkSPYgaIuzaLKfrcawsKa99HHr75Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npk3RsA5coMlak5RekswxBSggllug2ss4bhUo+gnagz+p2oTTgFw3r8CqeGSKjfBc
	 ItRs43Ez9VEwRvLX39d6v26GB23hTRUR1UcljxiymfK2NzDrf1bujh1dgac0PuuLMs
	 vBzz8E7PJjfZ3O8EP3/k/t+7Oxf2Q+4zgXfpmuoE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 14/91] udf: Convert udf_get_parent() to new directory iteration code
Date: Mon, 21 Oct 2024 12:24:28 +0200
Message-ID: <20241021102250.365848709@linuxfoundation.org>
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

[ Upstream commit 9b06fbef4202363d74bba5459ddd231db6d3b1af ]

Convert udf_get_parent() to use udf_fiiter_find_entry().

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/udf/namei.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1366,17 +1366,15 @@ static struct dentry *udf_get_parent(str
 {
 	struct kernel_lb_addr tloc;
 	struct inode *inode = NULL;
-	struct fileIdentDesc cfi;
-	struct udf_fileident_bh fibh;
+	struct udf_fileident_iter iter;
+	int err;
 
-	if (!udf_find_entry(d_inode(child), &dotdot_name, &fibh, &cfi))
-		return ERR_PTR(-EACCES);
+	err = udf_fiiter_find_entry(d_inode(child), &dotdot_name, &iter);
+	if (err)
+		return ERR_PTR(err);
 
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-
-	tloc = lelb_to_cpu(cfi.icb.extLocation);
+	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
+	udf_fiiter_release(&iter);
 	inode = udf_iget(child->d_sb, &tloc);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);



