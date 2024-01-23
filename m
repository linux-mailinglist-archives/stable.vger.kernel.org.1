Return-Path: <stable+bounces-15291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F97D8384AB
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EF6299D3C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59966745E6;
	Tue, 23 Jan 2024 02:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ct/dcrkR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D12745E1;
	Tue, 23 Jan 2024 02:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975452; cv=none; b=d3K8yGVO0HivvyXvz8jfyP4p4Zl/ludPOzBr168bggM0WYfx410oErTJaUmpKfQiY/lzgO+xfoag4J5vSK+k6cVffe8Vj5A5fAcD1UQ2p5xr8gCS9UqTAHXb3VZ0uAxQqeW5vDlNK01NFlSzR0Mmr4SF9dRGIVHiMqleQZvo7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975452; c=relaxed/simple;
	bh=5gQamw7OGDgIeb9q6gGIxMO0lKW8YVi1D9OT5xuWdCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1rSRVkvNStNbAg3pHvD3cPWSaH4xlezp3tVh4OyoDHSNq7tMykOv4YY1zc9HDfe1W7IxUVbvZPmPtO7FH74w3ba6SX/RbypygbuxIzfbBhFY64NH1aiKQ+Gk/DPhzw+6HK0LEX1qSjPERtIZCQcGhHXOb1xpVyFWYDcZsfiLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ct/dcrkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB55BC43399;
	Tue, 23 Jan 2024 02:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975451;
	bh=5gQamw7OGDgIeb9q6gGIxMO0lKW8YVi1D9OT5xuWdCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ct/dcrkRJCdi+P649Ijl/W474oxsxU5Oxjqlet7mzF4hST6SFKxAEufF52RuLTsjH
	 imWLgGBuEiNeGRm3j6Q5BvUNB3EXD1Vf+fxNOw0Bu7Pm2CJihR3n9rfcEihdnwnBOf
	 H6Lx2FoJ9KfaZvPcycNwRKK9jZAYw1YjkmCH6urM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Landley <rob@landley.net>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 6.6 408/583] rootfs: Fix support for rootfstype= when root= is given
Date: Mon, 22 Jan 2024 15:57:39 -0800
Message-ID: <20240122235824.461404511@linuxfoundation.org>
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

From: Stefan Berger <stefanb@linux.ibm.com>

commit 21528c69a0d8483f7c6345b1a0bc8d8975e9a172 upstream.

Documentation/filesystems/ramfs-rootfs-initramfs.rst states:

  If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
  default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
  line.

This currently does not work when root= is provided since then
saved_root_name contains a string and rootfstype= is ignored. Therefore,
ramfs is currently always chosen when root= is provided.

The current behavior for rootfs's filesystem is:

   root=       | rootfstype= | chosen rootfs filesystem
   ------------+-------------+--------------------------
   unspecified | unspecified | tmpfs
   unspecified | tmpfs       | tmpfs
   unspecified | ramfs       | ramfs
    provided   | ignored     | ramfs

rootfstype= should be respected regardless whether root= is given,
as shown below:

   root=       | rootfstype= | chosen rootfs filesystem
   ------------+-------------+--------------------------
   unspecified | unspecified | tmpfs  (as before)
   unspecified | tmpfs       | tmpfs  (as before)
   unspecified | ramfs       | ramfs  (as before)
    provided   | unspecified | ramfs  (compatibility with before)
    provided   | tmpfs       | tmpfs  (new)
    provided   | ramfs       | ramfs  (new)

This table represents the new behavior.

Fixes: 6e19eded3684 ("initmpfs: use initramfs if rootfstype= or root= specified")
Cc: <stable@vger.kernel.org>
Signed-off-by: Rob Landley <rob@landley.net>
Link: https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/
Reviewed-and-Tested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/r/20231120011248.396012-1-stefanb@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 init/do_mounts.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -510,7 +510,10 @@ struct file_system_type rootfs_fs_type =
 
 void __init init_rootfs(void)
 {
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
-		is_tmpfs = true;
+	if (IS_ENABLED(CONFIG_TMPFS)) {
+		if (!saved_root_name[0] && !root_fs_names)
+			is_tmpfs = true;
+		else if (root_fs_names && !!strstr(root_fs_names, "tmpfs"))
+			is_tmpfs = true;
+	}
 }



