Return-Path: <stable+bounces-136048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBC5A991C5
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096D71BA19B0
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3A8285405;
	Wed, 23 Apr 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DlopaIke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE927D763;
	Wed, 23 Apr 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421518; cv=none; b=ZymEaHR1h1e2MJ9df1lsNQgOvX/srx9J61l8brMR+fKuAtBo9Gz8jIx+UpsShkIT8HpdNVN5kD4ueWkk90XUCIBdxieESSjrfLf+fku+rUkjc/OFHjAWkWd8bLbkQoTdw+U5+FRHgymB+QbFEhV9cf+KtNkGY2aZnMjyI1eoK0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421518; c=relaxed/simple;
	bh=BbSXPBg/xAy9vOC0WBzRtxJsliynNp+hGlToQbeD1rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+taWnLrfAayOXT3/DXNFSGHZ3cKEvfY0bEvHGJVY024Q/ABD7u2Quq6LbKJ1wRt9KCI/5XytbhbB2L2qamSj/A/Q/yavUib7zm5bjYTmqqOXLh7emopxDW1Ak2HMM8ogEqm10aGwaFywfzccXdiHV0iQ0kNUO97iYvUCKQoTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DlopaIke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C038C4CEE2;
	Wed, 23 Apr 2025 15:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421518;
	bh=BbSXPBg/xAy9vOC0WBzRtxJsliynNp+hGlToQbeD1rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DlopaIkekPjj4bm9oJKy+lssGyAbaq8U6lzQpi3+nbBEIomFBvY82KeH7WV/K+dbC
	 Ee3EbT0j07okBG0a8bRVVrh/1z4kCSZXM2LvQjDoGMyYp12UzHtEfiFVol+g2JLved
	 G0jnDlGGh2XbaDHHeWsq8K+IkdrpN61ecyLRpSqE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brendan King <brendan.king@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>
Subject: [PATCH 6.14 198/241] drm/imagination: fix firmware memory leaks
Date: Wed, 23 Apr 2025 16:44:22 +0200
Message-ID: <20250423142628.598852603@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brendan King <Brendan.King@imgtec.com>

commit a5b230e7f3a55bd8bd8d012eec75a4b7baa671d5 upstream.

Free the memory used to hold the results of firmware image processing
when the module is unloaded.

Fix the related issue of the same memory being leaked if processing
of the firmware image fails during module load.

Ensure all firmware GEM objects are destroyed if firmware image
processing fails.

Fixes memory leaks on powervr module unload detected by Kmemleak:

unreferenced object 0xffff000042e20000 (size 94208):
  comm "modprobe", pid 470, jiffies 4295277154
  hex dump (first 32 bytes):
    02 ae 7f ed bf 45 84 00 3c 5b 1f ed 9f 45 45 05  .....E..<[...EE.
    d5 4f 5d 14 6c 00 3d 23 30 d0 3a 4a 66 0e 48 c8  .O].l.=#0.:Jf.H.
  backtrace (crc dd329dec):
    kmemleak_alloc+0x30/0x40
    ___kmalloc_large_node+0x140/0x188
    __kmalloc_large_node_noprof+0x2c/0x13c
    __kmalloc_noprof+0x48/0x4c0
    pvr_fw_init+0xaa4/0x1f50 [powervr]

unreferenced object 0xffff000042d20000 (size 20480):
  comm "modprobe", pid 470, jiffies 4295277154
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 09 00 00 00 0b 00 00 00  ................
    00 00 00 00 00 00 00 00 07 00 00 00 08 00 00 00  ................
  backtrace (crc 395b02e3):
    kmemleak_alloc+0x30/0x40
    ___kmalloc_large_node+0x140/0x188
    __kmalloc_large_node_noprof+0x2c/0x13c
    __kmalloc_noprof+0x48/0x4c0
    pvr_fw_init+0xb0c/0x1f50 [powervr]

Cc: stable@vger.kernel.org
Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Signed-off-by: Brendan King <brendan.king@imgtec.com>
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
Link: https://lore.kernel.org/r/20250318-ddkopsrc-1339-firmware-related-memory-leak-on-module-unload-v1-1-155337c57bb4@imgtec.com
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/imagination/pvr_fw.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -732,7 +732,7 @@ pvr_fw_process(struct pvr_device *pvr_de
 					       fw_mem->core_data, fw_mem->core_code_alloc_size);
 
 	if (err)
-		goto err_free_fw_core_data_obj;
+		goto err_free_kdata;
 
 	memcpy(fw_code_ptr, fw_mem->code, fw_mem->code_alloc_size);
 	memcpy(fw_data_ptr, fw_mem->data, fw_mem->data_alloc_size);
@@ -742,10 +742,14 @@ pvr_fw_process(struct pvr_device *pvr_de
 		memcpy(fw_core_data_ptr, fw_mem->core_data, fw_mem->core_data_alloc_size);
 
 	/* We're finished with the firmware section memory on the CPU, unmap. */
-	if (fw_core_data_ptr)
+	if (fw_core_data_ptr) {
 		pvr_fw_object_vunmap(fw_mem->core_data_obj);
-	if (fw_core_code_ptr)
+		fw_core_data_ptr = NULL;
+	}
+	if (fw_core_code_ptr) {
 		pvr_fw_object_vunmap(fw_mem->core_code_obj);
+		fw_core_code_ptr = NULL;
+	}
 	pvr_fw_object_vunmap(fw_mem->data_obj);
 	fw_data_ptr = NULL;
 	pvr_fw_object_vunmap(fw_mem->code_obj);
@@ -753,7 +757,7 @@ pvr_fw_process(struct pvr_device *pvr_de
 
 	err = pvr_fw_create_fwif_connection_ctl(pvr_dev);
 	if (err)
-		goto err_free_fw_core_data_obj;
+		goto err_free_kdata;
 
 	return 0;
 
@@ -763,13 +767,16 @@ err_free_kdata:
 	kfree(fw_mem->data);
 	kfree(fw_mem->code);
 
-err_free_fw_core_data_obj:
 	if (fw_core_data_ptr)
-		pvr_fw_object_unmap_and_destroy(fw_mem->core_data_obj);
+		pvr_fw_object_vunmap(fw_mem->core_data_obj);
+	if (fw_mem->core_data_obj)
+		pvr_fw_object_destroy(fw_mem->core_data_obj);
 
 err_free_fw_core_code_obj:
 	if (fw_core_code_ptr)
-		pvr_fw_object_unmap_and_destroy(fw_mem->core_code_obj);
+		pvr_fw_object_vunmap(fw_mem->core_code_obj);
+	if (fw_mem->core_code_obj)
+		pvr_fw_object_destroy(fw_mem->core_code_obj);
 
 err_free_fw_data_obj:
 	if (fw_data_ptr)
@@ -836,6 +843,12 @@ pvr_fw_cleanup(struct pvr_device *pvr_de
 	struct pvr_fw_mem *fw_mem = &pvr_dev->fw_dev.mem;
 
 	pvr_fw_fini_fwif_connection_ctl(pvr_dev);
+
+	kfree(fw_mem->core_data);
+	kfree(fw_mem->core_code);
+	kfree(fw_mem->data);
+	kfree(fw_mem->code);
+
 	if (fw_mem->core_code_obj)
 		pvr_fw_object_destroy(fw_mem->core_code_obj);
 	if (fw_mem->core_data_obj)



