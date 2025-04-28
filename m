Return-Path: <stable+bounces-136940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB20A9F8BA
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A0217F003
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185FD291166;
	Mon, 28 Apr 2025 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnOBwwIB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F961BBBFD;
	Mon, 28 Apr 2025 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865591; cv=none; b=jpLXHiBVQhDpUW7eQrs60a5uJjjXYqlDdcoaYnZa2UnLfWBxHjKP4G0W9/MQckyPQuWzJ9cJga2+z117kHRybnIV8I8FL8BvCWM3ZY81VWE+9ahO7SMR4PydVz6KWUQ1GqzC7/wRX94zP9zq87Bk6fRFN7Oa7Qz85rEvOOejIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865591; c=relaxed/simple;
	bh=hfIlQwh0TF0P74/aFGOJ5+54bFc53pV48Nt9kLOBcTc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+hWB3J01dC7b2zcWAhOMUz2fJFELOR0pHlCmI3ySN1UeCwb5vo4Ra4i5r3P64t7fUWY7XcKx56qIg40g+vrI8SEoOMhsIZCJA38sFAD2/YWBBuKhk3cyKVEVCw9uA5p0RRySTkyrKMgRY2Iims9OPiq4fwKZWqgNm0UpHmmh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnOBwwIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904DAC4CEE4;
	Mon, 28 Apr 2025 18:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745865591;
	bh=hfIlQwh0TF0P74/aFGOJ5+54bFc53pV48Nt9kLOBcTc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AnOBwwIBc45fR1xNlk5Y93x6CGhtvM0BI9+43peraglhfcTi1BBsL1FVVjIWYZUil
	 0Uvz+ZYKw4pazPVaHVylbAq69/KPUmEHZFsm2D3Dd9YdNnoQNeL0J78tulWWzH3v5k
	 4aTKtQZWSDPZOUh5IFVS0zdjdVQ/6I/PcjJfJR6XF2ui75Lr6mLObxXPivCVALlo7V
	 OYGBWaayLRgHUUWfG8FtBdPrSxq2yWhcfKMDEPLiN4woBXNfNLYXlPYtmxYeCx+XVU
	 WGI02YFnf9DDl1Km6/lWFvvHL8AUwA2/gwfxo8G1wrhU+rIZUKluLLgZXYOMBdOAeu
	 gY0LohpwomNJw==
Date: Mon, 28 Apr 2025 11:39:51 -0700
Subject: [PATCH 3/4] xfs: rename xfs_iomap_swapfile_activate to
 xfs_vm_swap_activate
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: cem@kernel.org, dchinner@redhat.com, hch@lst.de, stable@vger.kernel.org
Message-ID: <174586545440.480536.11026423037943384392.stgit@frogsfrogsfrogs>
In-Reply-To: <174586545357.480536.7498456094082551730.stgit@frogsfrogsfrogs>
References: <174586545357.480536.7498456094082551730.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Christoph Hellwig <hch@lst.de>

Commit 3cd6a8056f5a2e794c42fc2114ee2611e358b357 upstream

Match the method name and the naming convention or address_space
operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_aops.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 559a3a57709748..d2c7be12f5666b 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -528,7 +528,7 @@ xfs_vm_readahead(
 }
 
 static int
-xfs_iomap_swapfile_activate(
+xfs_vm_swap_activate(
 	struct swap_info_struct		*sis,
 	struct file			*swap_file,
 	sector_t			*span)
@@ -549,11 +549,11 @@ const struct address_space_operations xfs_address_space_operations = {
 	.migrate_folio		= filemap_migrate_folio,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
 	.error_remove_folio	= generic_error_remove_folio,
-	.swap_activate		= xfs_iomap_swapfile_activate,
+	.swap_activate		= xfs_vm_swap_activate,
 };
 
 const struct address_space_operations xfs_dax_aops = {
 	.writepages		= xfs_dax_writepages,
 	.dirty_folio		= noop_dirty_folio,
-	.swap_activate		= xfs_iomap_swapfile_activate,
+	.swap_activate		= xfs_vm_swap_activate,
 };


