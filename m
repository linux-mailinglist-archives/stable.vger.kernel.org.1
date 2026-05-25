Return-Path: <stable+bounces-254192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOMsK/ScFGqpOwcAu9opvQ
	(envelope-from <stable+bounces-254192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:03:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 277155CDE2F
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E56330080BE
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 19:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05533793CD;
	Mon, 25 May 2026 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHV4YNql"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB78462
	for <stable@vger.kernel.org>; Mon, 25 May 2026 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735791; cv=pass; b=VBXQehqNrppBICcynez3ZFDtpsdGDxLHnWRiyfPflxnFZsOSjcJyfyEmFny8ipx+J+3AShYG4eN2oavtpXQqgkBHyTvujrjP5usLqdeiZ7pBoQEOBQv4jWtQ42mu0mqomRvuh6tKu2F6bRSOIaE9rKCrXWTWe8xS/ufAnJwHPbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735791; c=relaxed/simple;
	bh=rNuRS3gKDfkUNIN++QneMzt1SENNHdpa7pjIwz+eD74=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gPkeU05/2Sr52DNUjZE7GXUO5zo2IzfBbIhTeOme6Fllu2iCADbCudQUBv6DEZm4NIIn+N1HxI2K/uR7PfR6LMglehr1icGWKNwc8QG5zAB+b2Xl1NPl4XC+nbCeqhmQmKkxrmwpCJrt0QuezIQdHdkrPeJZ1mMOuu5RkQau5JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHV4YNql; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69d8ff0ca12so1893454eaf.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 12:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779735789; cv=none;
        d=google.com; s=arc-20240605;
        b=lwNMCg5Hx+EbpmYTsIIQlp5H27/qBn1/eui3kV5s4/KvWNzzaSJVIl1WrT5OxS0Hsp
         phM1XBKnu+Qx4c6B3jbb71DK+xnCxKmCOz0nyrn6V4G/jxFFXBZW1kKy6WqHDZQDkXFY
         KL5KIMQs23q7S+cl/AO/tXcPMjWTAJwoIdLvU2zdIZjqDzchlJMvT98TFk49j4miNk5Z
         d/gAMsPKGXUMP7cuolF30nKpQv/XJoTJeqvg9MciQ9i9Sq08lhTwG69UzFQVq/zo6pxF
         dA05k8zfwBfSyafe78+VFgSYTwthfFWUQ7sSC8jCQHp/hiKrO5ddoNIioWRe5Kg25S6L
         946Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=r6q3CM++ZaSHgRbspjUw6U7+IQ8CHEPlFHLP/7LXDJg=;
        fh=DLqGRMjSNyrzNnOjh6QkXOHxKdnF49rkUl3tzpwEjNc=;
        b=LSdZ+usIFyJMD1HLM0uO/bsxacx1DAGRcvTIwu6vkdrf7zz4i2zeCD7XVwtnz2E9GG
         VUtu+7Qixz28R7SsIwOaO1iYotqkj+24R8GCC/K6jpgSprPQqnDZLa2WqW5pLa1Ek/EV
         /hQ6ACjyQIGUjGjSWU5e+uekbiYXkHC0W5TqMvLq43bPIXGASFbE5OOq+pSbB0D1rFJ/
         V4k47w9LAJMaUrlVfT6Wq5w/ksoM6h/+CDp02aJORyDSj1tg9KQia9pS4tc88wSXWzhK
         thr5tq/j3kM6zEsCU5QoAbMhl7nI9GXulVQCP0Mxn7W4/O6lYatMpx5kKHaMC0hkOuFA
         j03g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779735789; x=1780340589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r6q3CM++ZaSHgRbspjUw6U7+IQ8CHEPlFHLP/7LXDJg=;
        b=aHV4YNql+a/BLMPNrzV/+4S+GsFdmFSZYjRPepG4a3TglRDMk26D9tKpVU8ejThO0I
         ZtU1UxJor1AW3DX7/u5A/unMux3O90z/vEh/WDNsKsQDpwd019Jz1OvCBuLVDpuxNNyu
         +NSbzv/7y2gScrocWNESq3V9MUvPeul2LLGFkQSfBbv852exoghFrqPVgPEQtWbIa/mz
         abW6Ia45rRvG3nq6sCr3s90NmrksXYgvwF9B7eion5tZEVi6SbgpRp3FDvqaRY0SnfJw
         QPaU7e+yi4L05n2NWJbtEgmx/nexfxOfSYyjDlanG2oNYEYsnz9BLUHBde0QWPbuFdeB
         4ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779735789; x=1780340589;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6q3CM++ZaSHgRbspjUw6U7+IQ8CHEPlFHLP/7LXDJg=;
        b=G+Wooe8Tmw286jh95Dw7Y1IiGg3dk/GtkItQISOMxGxOwQYuzp2Lif95oHO8c4XdeT
         td6BviofLBdeipnpXecSoVBqSovmRRlAvQv5VkzEEEq6vBDqxQxCF4kZVfKvvglI7Jvh
         yUI9x99N2uVAllKRdjzaZpjyYHGtsJLSMVdkl7vr0gYmhzW51ZBLWqqNJ8a2onRdj4X3
         nFm5V1LcUgbO0PoV+nA1DL0POYBII/ns5t33tMoPYN8dGvdeF0ZZDaz6IlhJfkIngyls
         yrAr3zuvbDNMpOBRhjviLCIQruFJB6MGIBieTPcRx5uM3i/0OM2sueZ+XlthGNBSfehZ
         +B0Q==
X-Gm-Message-State: AOJu0YxFvJ/ECMzL+Ma4PATJunL4drlmzF179P4mARinREBn2jMOZKYE
	k30PrJVZ3DSE89UWv/giRwinDpdfzbOYafERltEHYXLeyLyURt6g8mIieP0UXp4+3mZO/xisawd
	mu60kkgl2RhljF/u6/UEb4/5MOhgbNa39JJY9meU=
X-Gm-Gg: Acq92OEMshPoRRelKWECD7LK6LJGJV1M2/IynHaDiPGeTMtL/DMnHfOi9lEfNdeA6NI
	24WM8egaEQLugFPCvM3OLZ1FeJ2hXzb8gva4DCCGblieKCW9FU7cKaEGD1/K/o02e53L2a9j64D
	lOJkYPCQXg80dwiIDsVrvaEmU57rZZDzQ9FkD4B3jHQtlbIeFO33uIz+agS0N9kZnPG4iVHOVuX
	53OEEGixeSWg81WJHsgoum41+99/MW4HMCUW5mVkNFIQ3h8Hf0dSwLtGHskqBdoPOkpvh8kwnjT
	ha4bzC54lSWlUrQ8tLtqQAEdGbPbk7TVchNv
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ded0:0:b0:696:1291:fb29 with SMTP id
 006d021491bc7-69d7eb8db4amr6286688eaf.24.1779735788858; Mon, 25 May 2026
 12:03:08 -0700 (PDT)
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 May 2026 14:03:08 -0500
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 May 2026 14:03:08 -0500
From: Siho Lee <25esihoya@gmail.com>
Date: Mon, 25 May 2026 14:03:08 -0500
X-Gm-Features: AVHnY4KC63BXEfVegSGZGTbRjJJa7bn5Ya7zthw8-tloB1xM0zSX84dw-9CrSx0
Message-ID: <CAOYEF6nD8Li-MXB2WLtin0rP2i+Q3+dMRGkw=mUqMYe2+Gx5RA@mail.gmail.com>
Subject: [PATCH v1 4/4] staging: atomisp: add resolution limits to prevent DVS
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-254192-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25esihoya@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 277155CDE2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While reviewing the atomisp driver for integer overflow patterns, I found
that CVE-2022-50399 (commit 51b8dc5163d2, "media: atomisp: prevent integer
overflow in sh_css_set_black_frame()") fixed the overflow in
sh_css_set_black_frame(), but the same pattern exists in 9 other locations
that were not updated. The most critical is in sh_css_param_dvs.c where the
overflow leads to a kernel panic (DoS) via OOB write.

--- Summary ---

The same `width * height * sizeof()` overflow pattern exists in:
  - sh_css_param_dvs.c:     4 locations (lines 51, 59, 70, 78)
  - sh_css_params.c:        4 locations (lines 4481, 4486, 4491, 4497)
  - sh_css_param_shading.c: 1 location  (line 342)

In alloc_dvs_6axis_table(), width_y and height_y are unsigned int (32-bit).
When frame_res width/height = 16777216 (which ATOM_ISP_MAX_WIDTH = UINT_MAX
allows), width_y = height_y = 262145:

    262145 * 262145 = 524289      (32-bit, overflowed)
    262145 * 262145 = 68720001025 (64-bit, actual)

This allocates only 2 MB instead of 256 GB, and the subsequent writes in
init_dvs_6axis_table_from_default() cause an immediate OOB write that
triggers a page fault / kernel panic (local DoS).

Tested on kernel 5.15.0, 6.8.0, and v7.0.10 stable (QEMU) via kernel
module PoC: kvmalloc(2MB) succeeds with the 32-bit overflow, and OOB
write is confirmed. With panic_on_oops=1 and larger OOB writes, this
triggers a kernel panic. The vulnerable code is identical in v7.0.10
stable and v7.1-rc5 mainline. The V4L2 ioctl path could not be
verified due to lack of Intel Atom ISP hardware.

--- Incomplete fix context ---

CVE-2022-50399 fixed the identical overflow pattern in
sh_css_set_black_frame() (same file sh_css_params.c, line 954) using
array3_size(). However, the same pattern lines 4481-4497 (same file!) and
in sh_css_param_dvs.c and sh_css_param_shading.c was not updated.

--- Patch overview ---

Patch 1-3: Replace `width * height * sizeof(type)` with `array3_size()`
           (consistent with the CVE-2022-50399 fix)
Patch 4:   Add resolution limits (8192x8192) as defense-in-depth

Siho Lee (4):
  staging: atomisp: prevent integer overflow in DVS 6-axis allocation
  staging: atomisp: prevent integer overflow in sh_css_params DVS allocation
  staging: atomisp: prevent integer overflow in shading table allocation
  staging: atomisp: add resolution limits to prevent DVS overflow

 drivers/staging/media/atomisp/pci/atomisp_internal.h     | 4 ++--
 drivers/staging/media/atomisp/pci/sh_css_param_dvs.c     | 8 ++++----
 drivers/staging/media/atomisp/pci/sh_css_param_shading.c | 2 +-
 drivers/staging/media/atomisp/pci/sh_css_params.c        | 8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)


--- Patch 1/4 ---

From 99ca51470fb296b4b33283a106d9388521646cb3 Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Tue, 26 May 2026 00:28:35 +0900
 6-axis allocation

The width_y * height_y multiplication in alloc_dvs_6axis_table() can
overflow on 32-bit arithmetic when the user sets a large resolution via
VIDIOC_S_FMT, since ATOM_ISP_MAX_WIDTH = UINT_MAX imposes no limit.

For example, with frame_res width=16777216, width_y becomes 262145 and:
    262145 * 262145 = 524289 (32-bit, overflowed)
    262145 * 262145 = 68720001025 (64-bit, actual)

This causes kvmalloc() to allocate only 2 MB instead of the required
256 GB, leading to an out-of-bounds write in
init_dvs_6axis_table_from_default() that triggers a kernel panic.

Use array3_size() to prevent the overflow, consistent with the
CVE-2022-50399 fix in sh_css_set_black_frame().

Signed-off-by: Siho Lee <25esihoya@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_param_dvs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_param_dvs.c
b/drivers/staging/media/atomisp/pci/sh_css_param_dvs.c
index 9ccdb66de..3ea707528 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_param_dvs.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_param_dvs.c
@@ -48,7 +48,7 @@ alloc_dvs_6axis_table(const struct ia_css_resolution
*frame_res,
 		}

 		/* Generate Y buffers  */
-		dvs_config->xcoords_y = kvmalloc(width_y * height_y * sizeof(uint32_t),
+		dvs_config->xcoords_y = kvmalloc(array3_size(width_y, height_y,
sizeof(uint32_t)),
 						 GFP_KERNEL);
 		if (!dvs_config->xcoords_y) {
 			IA_CSS_ERROR("out of memory");
@@ -56,7 +56,7 @@ alloc_dvs_6axis_table(const struct ia_css_resolution
*frame_res,
 			goto exit;
 		}

-		dvs_config->ycoords_y = kvmalloc(width_y * height_y * sizeof(uint32_t),
+		dvs_config->ycoords_y = kvmalloc(array3_size(width_y, height_y,
sizeof(uint32_t)),
 						 GFP_KERNEL);
 		if (!dvs_config->ycoords_y) {
 			IA_CSS_ERROR("out of memory");
@@ -67,7 +67,7 @@ alloc_dvs_6axis_table(const struct ia_css_resolution
*frame_res,
 		/* Generate UV buffers  */
 		IA_CSS_LOG("UV W %d H %d", width_uv, height_uv);

-		dvs_config->xcoords_uv = kvmalloc(width_uv * height_uv * sizeof(uint32_t),
+		dvs_config->xcoords_uv = kvmalloc(array3_size(width_uv, height_uv,
sizeof(uint32_t)),
 						  GFP_KERNEL);
 		if (!dvs_config->xcoords_uv) {
 			IA_CSS_ERROR("out of memory");
@@ -75,7 +75,7 @@ alloc_dvs_6axis_table(const struct ia_css_resolution
*frame_res,
 			goto exit;
 		}

-		dvs_config->ycoords_uv = kvmalloc(width_uv * height_uv * sizeof(uint32_t),
+		dvs_config->ycoords_uv = kvmalloc(array3_size(width_uv, height_uv,
sizeof(uint32_t)),
 						  GFP_KERNEL);
 		if (!dvs_config->ycoords_uv) {
 			IA_CSS_ERROR("out of memory");
--
2.43.0


--- Patch 2/4 ---

From 6205ae2498aea5944d41cae04135daf4912e0a2f Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Tue, 26 May 2026 00:28:56 +0900
 sh_css_params DVS allocation

Same integer overflow pattern as the previous commit, in the same file
where CVE-2022-50399 was fixed (line 954) but these four locations
(lines 4481, 4486, 4491, 4497) were missed.

Signed-off-by: Siho Lee <25esihoya@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_params.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_params.c
b/drivers/staging/media/atomisp/pci/sh_css_params.c
index fcebace11..52ac15df1 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_params.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
@@ -4478,23 +4478,23 @@ ia_css_dvs2_6axis_config_allocate(const struct
ia_css_stream *stream)
 				    params->pipe_dvs_6axis_config[IA_CSS_PIPE_ID_VIDEO]->height_uv;
 	IA_CSS_LOG("table Y: W %d H %d", width_y, height_y);
 	IA_CSS_LOG("table UV: W %d H %d", width_uv, height_uv);
-	dvs_config->xcoords_y = kvmalloc(width_y * height_y * sizeof(uint32_t),
+	dvs_config->xcoords_y = kvmalloc(array3_size(width_y, height_y,
sizeof(uint32_t)),
 					 GFP_KERNEL);
 	if (!dvs_config->xcoords_y)
 		goto err;

-	dvs_config->ycoords_y = kvmalloc(width_y * height_y * sizeof(uint32_t),
+	dvs_config->ycoords_y = kvmalloc(array3_size(width_y, height_y,
sizeof(uint32_t)),
 					 GFP_KERNEL);
 	if (!dvs_config->ycoords_y)
 		goto err;

-	dvs_config->xcoords_uv = kvmalloc(width_uv * height_uv *
+	dvs_config->xcoords_uv = kvmalloc(array3_size(width_uv, height_uv,
 					  sizeof(uint32_t),
 					  GFP_KERNEL);
 	if (!dvs_config->xcoords_uv)
 		goto err;

-	dvs_config->ycoords_uv = kvmalloc(width_uv * height_uv *
+	dvs_config->ycoords_uv = kvmalloc(array3_size(width_uv, height_uv,
 					  sizeof(uint32_t),
 					  GFP_KERNEL);
 	if (!dvs_config->ycoords_uv)
--
2.43.0


--- Patch 3/4 ---

From e9c253be79c1f78008c27514f4d01230c8a260f5 Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Tue, 26 May 2026 00:29:08 +0900
 table allocation

The width * height multiplication in ia_css_shading_table_alloc() can
overflow on 32-bit arithmetic when width and height are large, causing
an undersized kvmalloc() and subsequent out-of-bounds write.

Use array3_size() to prevent the overflow, consistent with the
CVE-2022-50399 fix and the previous commits.

Signed-off-by: Siho Lee <25esihoya@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_param_shading.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
b/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
index 9105334c7..2a8756f1f 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_param_shading.c
@@ -339,7 +339,7 @@ ia_css_shading_table_alloc(
 	me->fraction_bits = 0;
 	for (i = 0; i < IA_CSS_SC_NUM_COLORS; i++) {
 		me->data[i] =
-		    kvmalloc(width * height * sizeof(*me->data[0]),
+		    kvmalloc(array3_size(width, height, sizeof(*me->data[0])),
 			     GFP_KERNEL);
 		if (!me->data[i]) {
 			unsigned int j;
--
2.43.0


--- Patch 4/4 ---

From 8955328f674e82dea60f6c9982f20623b10a3619 Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Tue, 26 May 2026 00:29:20 +0900
 overflow

ATOM_ISP_MAX_WIDTH and ATOM_ISP_MAX_HEIGHT are set to UINT_MAX, which
allows userspace to set arbitrarily large resolutions via VIDIOC_S_FMT.
This is the root enabler for the integer overflow in DVS table allocation
fixed in the previous commits.

Add reasonable limits (8192x8192) as a defense-in-depth measure.
With DVS_BLOCKDIM=64, this yields max block counts of 129x129,
giving 129*129*sizeof(u32) = 66564 bytes which cannot overflow.

Signed-off-by: Siho Lee <25esihoya@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_internal.h
b/drivers/staging/media/atomisp/pci/atomisp_internal.h
index 5a69580b8..bb2367d19 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_internal.h
+++ b/drivers/staging/media/atomisp/pci/atomisp_internal.h
@@ -55,8 +55,8 @@

 #define ATOM_ISP_MIN_WIDTH	4
 #define ATOM_ISP_MIN_HEIGHT	4
-#define ATOM_ISP_MAX_WIDTH	UINT_MAX
-#define ATOM_ISP_MAX_HEIGHT	UINT_MAX
+#define ATOM_ISP_MAX_WIDTH	8192
+#define ATOM_ISP_MAX_HEIGHT	8192

 /* sub-QCIF resolution */
 #define ATOM_RESOLUTION_SUBQCIF_WIDTH	128
--
2.43.0

