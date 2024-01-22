Return-Path: <stable+bounces-14696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A29C8382AB
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32B1B2A321
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8034759B67;
	Tue, 23 Jan 2024 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QC53l+8G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF62B9B8;
	Tue, 23 Jan 2024 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974084; cv=none; b=p68AbxAGHN4+ojG/57M1lQDZXqJTXdSM83yE5ZPmyWoHjUisNZbqPnRpIB1o5XB7aoEVW0nLpJM2t0OLfHGWJRucFMig9LDgBCa5iybjzNvKsCbhhxU8r7HLO0EQh3QV5m7O4Quedgdb9Q8YWROSsgW/tJHrfE/4Z8cDrLedZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974084; c=relaxed/simple;
	bh=DW6cWvNrhDcYFo9kcEzZqZeXDmmaEKlcUp7IpGaRkpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igH3pCQKcc5TtdS3fztZyvciHNvSaZwBazlsTNaO9EvxTcyyZQ4ooMNsDkMpAq2nLLyjQ7zeyxWY5S+Kqb/eGxQWn8jB+5LoNZ1n9jD4ThrS3yShi/7PSWzBZ8xv8whuyRpvxaHygoYphgCqp1WOAkLfiat/58/cX7s/yE0MJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QC53l+8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9925BC43390;
	Tue, 23 Jan 2024 01:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974083;
	bh=DW6cWvNrhDcYFo9kcEzZqZeXDmmaEKlcUp7IpGaRkpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QC53l+8GpRWzZlrvgJi0bG1vxja0PJ9U2A79TEVduIc8pdkLzxx/bXIkdDLihujYF
	 pUQ3y6X2ocNdSQna2OZDc3oIMb5T4tdmS5m3d70+QjNE70GKNx1G3bkpC2dPc3BXE9
	 OL4WmNNZEi0GOfNe+k8bTp8Q87UmkiGS16vt6xc4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 032/583] efivarfs: Free s_fs_info on unmount
Date: Mon, 22 Jan 2024 15:51:23 -0800
Message-ID: <20240122235813.155872932@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 547713d502f7b4b8efccd409cff84d731a23853b ]

Now that we allocate a s_fs_info struct on fs context creation, we
should ensure that we free it again when the superblock goes away.

Fixes: 5329aa5101f7 ("efivarfs: Add uid/gid mount options")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/efivarfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 05c01694e852..d59d9670965c 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -299,6 +299,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 
 static void efivarfs_kill_sb(struct super_block *sb)
 {
+	struct efivarfs_fs_info *sfi = sb->s_fs_info;
+
 	kill_litter_super(sb);
 
 	if (!efivar_is_available())
@@ -306,6 +308,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
 
 	/* Remove all entries and destroy */
 	efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
+	kfree(sfi);
 }
 
 static struct file_system_type efivarfs_type = {
-- 
2.43.0




