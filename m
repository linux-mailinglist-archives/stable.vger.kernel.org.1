Return-Path: <stable+bounces-138150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C59AA1693
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069397A5683
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F2D244686;
	Tue, 29 Apr 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SUYdv4yL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF73B22DF91;
	Tue, 29 Apr 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948323; cv=none; b=uscmJzl1jjC9+qvl0rA4tFkpdC3Vuo1ZYftmsYvWrsJ4+aAyXkCbKgRXaU60Nq6hDg3uwj+oBbehPeUibCls9HjioLjXbWLzfwkQc3MAYFXKKmqn9s34Nu68LmNbgmsejRhEkLHRfjEJAHsx4Ixgsry5ZPSAq+VcqEs4RZttP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948323; c=relaxed/simple;
	bh=qXVj/JpcSXevtNgfxoCcbT0ldTXdN8oaUq8grEAxxPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2d28B++LPG6yUKqyEdcrcy7FYDgJiebWNRWmdeewyqaPJQvH003k1y/ZivJBfSxW7pD4mVboWHGOGsYxKAM8OYWxLK6sgpSNA39zI09gAMnBNch5W/0CzhDi2mOzr/AHf/re13rWf96vytlgNpdm9ANfysZv02+4wKCLiLGjss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SUYdv4yL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09FBC4CEE3;
	Tue, 29 Apr 2025 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948323;
	bh=qXVj/JpcSXevtNgfxoCcbT0ldTXdN8oaUq8grEAxxPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUYdv4yLPqTNUuHmLFid/u43dmAAYf5O1pYSWmc/UqIUtiIdXTCDw8IeiRg+35nSP
	 JDtvghHX2fcFZJ5T9faxMDG1XdmmtQosnqtbe8VzMlkYv0mb97mLAayXwhhmReNqCq
	 oztdT2tjX32we/v4zn4I2HgEJkMgXAydTA9UVoxQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.12 253/280] xfs: rename xfs_iomap_swapfile_activate to xfs_vm_swap_activate
Date: Tue, 29 Apr 2025 18:43:14 +0200
Message-ID: <20250429161125.475628018@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>

Commit 3cd6a8056f5a2e794c42fc2114ee2611e358b357 upstream

Match the method name and the naming convention or address_space
operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_aops.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


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
@@ -549,11 +549,11 @@ const struct address_space_operations xf
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



