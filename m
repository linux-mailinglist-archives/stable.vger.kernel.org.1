Return-Path: <stable+bounces-102893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E369EF3F4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B6D288F70
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BFC22A7EB;
	Thu, 12 Dec 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lny2fE8q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFF222D59;
	Thu, 12 Dec 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022890; cv=none; b=H3jDriD70iXzZj7xRkdWx2uc7AEWnqvI6W08P8zW0B5DU5eh5qc6AWh8PMyJXBlaf2iPEHmL+94LVEOuu/MIjaNeV94bEuT2qhNrtVVzjoOj7n6HAe7CrOP+cHALJ7nEqIArrLd+CPyK4TVkfExX26pFlqL2pBogc2wHpSw0kAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022890; c=relaxed/simple;
	bh=Lujznu1Kdk+e21QcvoFG8PLZbA/mLhtsgy9mWoOO31o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErQY7JzZHRAQzaElk3Ypbm+AYu8gRj5bwGRkGz+os98DRsdf5XPpJQI4UKK645Jiie80rKqqf4fhf1rO/d32ykSemVLmSq9lDzb3tW9g0h/AAH/S+dl4aJzVeIA9fcRLhKUrDF409rclAFmMNnICWI/s/3mxsSsGVta81dO3zDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lny2fE8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51286C4CECE;
	Thu, 12 Dec 2024 17:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022889;
	bh=Lujznu1Kdk+e21QcvoFG8PLZbA/mLhtsgy9mWoOO31o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lny2fE8qK8Rj+zk93yQlyvIw8hqY/tL81/96w5R7i/NcKEZPcO1Xrjmyb6JJjUnar
	 NDT8oc/CvZgPrGuZpQvqKTwxsKEIQfwpK/Yv8S/MFYTZkvf2h/UE8opdlmsXI/MEXN
	 CJGNdIPHZPf/due6dULj4fvcupwBDkY3LjuUdYqA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 362/565] ubi: fastmap: Fix duplicate slab cache names while attaching
Date: Thu, 12 Dec 2024 15:59:17 +0100
Message-ID: <20241212144325.924529798@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit bcddf52b7a17adcebc768d26f4e27cf79adb424c ]

Since commit 4c39529663b9 ("slab: Warn on duplicate cache names when
DEBUG_VM=y"), the duplicate slab cache names can be detected and a
kernel WARNING is thrown out.
In UBI fast attaching process, alloc_ai() could be invoked twice
with the same slab cache name 'ubi_aeb_slab_cache', which will trigger
following warning messages:
 kmem_cache of name 'ubi_aeb_slab_cache' already exists
 WARNING: CPU: 0 PID: 7519 at mm/slab_common.c:107
          __kmem_cache_create_args+0x100/0x5f0
 Modules linked in: ubi(+) nandsim [last unloaded: nandsim]
 CPU: 0 UID: 0 PID: 7519 Comm: modprobe Tainted: G 6.12.0-rc2
 RIP: 0010:__kmem_cache_create_args+0x100/0x5f0
 Call Trace:
   __kmem_cache_create_args+0x100/0x5f0
   alloc_ai+0x295/0x3f0 [ubi]
   ubi_attach+0x3c3/0xcc0 [ubi]
   ubi_attach_mtd_dev+0x17cf/0x3fa0 [ubi]
   ubi_init+0x3fb/0x800 [ubi]
   do_init_module+0x265/0x7d0
   __x64_sys_finit_module+0x7a/0xc0

The problem could be easily reproduced by loading UBI device by fastmap
with CONFIG_DEBUG_VM=y.
Fix it by using different slab names for alloc_ai() callers.

Fixes: d2158f69a7d4 ("UBI: Remove alloc_ai() slab name from parameter list")
Fixes: fdf10ed710c0 ("ubi: Rework Fastmap attach base code")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/ubi/attach.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index ae5abe492b52a..adc47b87b38a5 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -1447,7 +1447,7 @@ static int scan_all(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	return err;
 }
 
-static struct ubi_attach_info *alloc_ai(void)
+static struct ubi_attach_info *alloc_ai(const char *slab_name)
 {
 	struct ubi_attach_info *ai;
 
@@ -1461,7 +1461,7 @@ static struct ubi_attach_info *alloc_ai(void)
 	INIT_LIST_HEAD(&ai->alien);
 	INIT_LIST_HEAD(&ai->fastmap);
 	ai->volumes = RB_ROOT;
-	ai->aeb_slab_cache = kmem_cache_create("ubi_aeb_slab_cache",
+	ai->aeb_slab_cache = kmem_cache_create(slab_name,
 					       sizeof(struct ubi_ainf_peb),
 					       0, 0, NULL);
 	if (!ai->aeb_slab_cache) {
@@ -1491,7 +1491,7 @@ static int scan_fast(struct ubi_device *ubi, struct ubi_attach_info **ai)
 
 	err = -ENOMEM;
 
-	scan_ai = alloc_ai();
+	scan_ai = alloc_ai("ubi_aeb_slab_cache_fastmap");
 	if (!scan_ai)
 		goto out;
 
@@ -1557,7 +1557,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 	int err;
 	struct ubi_attach_info *ai;
 
-	ai = alloc_ai();
+	ai = alloc_ai("ubi_aeb_slab_cache");
 	if (!ai)
 		return -ENOMEM;
 
@@ -1575,7 +1575,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 		if (err > 0 || mtd_is_eccerr(err)) {
 			if (err != UBI_NO_FASTMAP) {
 				destroy_ai(ai);
-				ai = alloc_ai();
+				ai = alloc_ai("ubi_aeb_slab_cache");
 				if (!ai)
 					return -ENOMEM;
 
@@ -1614,7 +1614,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 	if (ubi->fm && ubi_dbg_chk_fastmap(ubi)) {
 		struct ubi_attach_info *scan_ai;
 
-		scan_ai = alloc_ai();
+		scan_ai = alloc_ai("ubi_aeb_slab_cache_dbg_chk_fastmap");
 		if (!scan_ai) {
 			err = -ENOMEM;
 			goto out_wl;
-- 
2.43.0




