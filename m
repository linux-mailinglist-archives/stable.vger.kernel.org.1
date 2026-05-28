Return-Path: <stable+bounces-254991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDdbODZHGGr2iQgAu9opvQ
	(envelope-from <stable+bounces-254991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:46:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F415F2F3A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7373027961
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618253ED126;
	Thu, 28 May 2026 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS++qDNi"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FDF3F6C28
	for <stable@vger.kernel.org>; Thu, 28 May 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975620; cv=pass; b=iAHGOoAIWbDo3U8OofmmSLpe+vwJZepI0fKy49FLjxyN0HsVSpl3gM2o89YhjoJpNehDkeEdraPaIJCUbJznQdNRPn/YQkhOYMasUI0R1FCmwigkbVqGD2Dkj3s0ewNP4EBBzuyW8azuYAYK3Q0xEHukweNRzYomH3L8Zrq38L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975620; c=relaxed/simple;
	bh=KNTUanOOjBrTnxR4pmWBIGsAiQo6MGI8WKkMcO3Eedg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dfbsCo7V9FC+fo9GdGL7sBaMYay9J2TFgXrWa8I57kfJPAQuGkIAznulXkp2F0VLtuoNK+CH0R9Fn12/f08F/lXuumEPYOFX50ry6/sOjL16zx4jRWn0L9gFuk96hFc8ADhkqklF6XBN5cm0CI8ydi4s5lcDa/vKnfq3uuTIJrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS++qDNi; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69498319ee7so6549984eaf.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 06:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975615; cv=none;
        d=google.com; s=arc-20240605;
        b=dWSM8bVxTuAS2EgbrQpicIbTY3CtUuTpwVdgfBe8EsnTsaVuXzyS9Z5wnkK8K0axN5
         Zr9ZBalBYV2MgRM11O4QGLij9ErRZX7i3E7Lx+hhyAXHdLtEFPkPtlKsvOMfOMwKrlHr
         GTwB8+lcpQDKakdJURp6z7fxPZJ7qWwqFXZYlaYZ0s+O689VlIXy/p8BxK+aZNTlyfAZ
         UcDMHhKTfZJWKwOU5kbHRsdHs2nd4q5G0oII4F0u2kwD+tF2S0G0msOhTMPlxY97Pm3H
         /pGzNhj5mADEghTYTlOIeWw2MDu8XwsC7orE/kPJZ0zPDCONgUNi0JC6D8GrrdSCCVnR
         7JQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=o/OQ7V/HHVFhw6uCybNx3p4Srl1M7rYCCl0IG1Fc9ms=;
        fh=OfHm8H4uHSxA87U0smWBKxmW41O9p0EtEAd9yl2YtKQ=;
        b=aL6zJlKIeUXnWKCcznh2h5FzSq2cZiUBeHAJv4qydFO5a2EZnASZzkSNjdnQuZ7H5g
         km+jl9xXGGBZqQG+GD04deC7dQPph1u68GXt12ayRUjIqqSvfrmSYd/zhBv4psV+r/RR
         u1GnE/a+UCrzvnN+hVxdYlCB+N8ql0zLaQ7Yf3A+RHRQPTlcJinYTHJqzHi/4mVDIK/U
         qK0pxt/Wc4rp2dOhmRLQikuyP1qLjPHpPb5nUe6dlbGVYvDUcFV8nAfLp17S9Hm45+Rr
         hlslSdXcgQdBOGFDyUzoZhiLX8FMkkjxfXyCObgNN9QkQKWfgE6cZJgIm4aF3k6GiFdp
         dIZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779975615; x=1780580415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o/OQ7V/HHVFhw6uCybNx3p4Srl1M7rYCCl0IG1Fc9ms=;
        b=aS++qDNiiGZ2mzwmF8FV9Ryt+ZqOWGXggKCy/ollc+j41TgM50Q4FVFIj3uJtssEep
         ZYeF4BwZZb7CBwbF4xqLF51uU1o+LiHitY18Vp0cJGxJq/t0Vm2dmM/Kk1UnACcK1AVN
         cBB7ZCsqPkoOZ/WeYkK6rrF4vKFqjI0oCNz9z2jFUu1fcGNfxMed9UJ9nKa2IY8rDwsm
         sIlZlDoLHXRESVrmz8daHuAt810Q4qeMAUCDDymDvtzSOOTjvyGM+O9nWp//+lbDDZjB
         DCxFEGmd0s+RZYZcACTjf/XnDWUbEiMMciN9SvodXL5f5Nu2SYj99ioRbIqdUh6aphHH
         n/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975615; x=1780580415;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/OQ7V/HHVFhw6uCybNx3p4Srl1M7rYCCl0IG1Fc9ms=;
        b=rABSbakIcAb/a08U48JcRmacZl/KzoVTtzyqJOTQY4hsHF6LES62wQKvtmKJcxmNTM
         5gHtOEZI7GANmIUc4j/8y9wDFf0zSPZAJG45kDbcHcEASfMq9eOpxQHS/0yvsP17F/cg
         1U3AHrvtJPqPrznoBcW5m8BwBcvei+1+pGS2zBiU36wcwLkFGsPYwhNA4XikH+19Jzr8
         NRkQ+IoWe1EimWGTPwP6VUSH26Rm1vHEDpU6T/TVR1djfbIF5MFBDgIhhUbQBQourLHC
         z80Tc5t9CaYlxPggXkx+VLN0GSG9zZjAbCT4boHBCzWaL4Ndw1RAMKfkNQyio+vpDJDJ
         mIWg==
X-Forwarded-Encrypted: i=1; AFNElJ+h1lkDxYd3CJABjztJd5tyk2oDEmX2MXl/Y6/SaNykv0121LNX02A3WOp1ibGkmyGQBHYVfes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4moEymz3HIyZCCvwFaL5cGSMFUQC7obIaLe3p/crUM3t9h4Yd
	ikchwQ4ehwMSfw1rrMOCGaZyOKptUF/APIOC0sW2yXAPokIadO2IqAU2v/+mljK/VOGssgl/ygf
	V7J6rdfgHmeJvmDKw/3J2ZtbaRLyADWTR7RLWPew=
X-Gm-Gg: Acq92OGJfzI+/S7AitMtwY6jyXIOikW7OfLynKg27iMYcEDcyUf6qNQEAHasb4QPwLl
	wsc0bl+bfyt9/orhvaAsEjLqsINSYe6Ruq94F+okpRj/yoAdL2/0R+dwqES8eQmo63cKIqBvmEX
	69IkSKtI1KRzb7BJWhJTgBmukEQKwm7eNTQtziEbJdEKEU+NkyF/fby198OKGocMekUXSR34J5m
	RJW4SSJPHz3Ik9fQYKJMsDTS0w+Mi+qnSf0NdiWXi0hOm/jWxnrlpxb1QMpTGjqTJcwcsG9DoQa
	LVZdZTZF5J+19wz3AMQOno4NmA==
X-Received: by 2002:a05:6820:1514:b0:69b:8e24:8523 with SMTP id
 006d021491bc7-69dfa8cc5d5mr572077eaf.30.1779975614573; Thu, 28 May 2026
 06:40:14 -0700 (PDT)
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 06:40:13 -0700
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 06:40:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siho Lee <25esihoya@gmail.com>
Date: Thu, 28 May 2026 06:40:13 -0700
X-Gm-Features: AVHnY4JXYGs3S0_mcaACUuFljEkuqUaAf_GrutdRvpL5G16OnCEiVbGJccw5zHk
Message-ID: <CAOYEF6=_rSZMGQP2nMPVd3=zrG=dDzecjMSqaXgzR_5M1juUFw@mail.gmail.com>
Subject: [PATCH v1 0/4] media: atomisp: prevent integer overflow in DVS table allocations
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254991-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25esihoya@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 36F415F2F3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 8955328f674e82dea60f6c9982f20623b10a3619 Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Tue, 26 May 2026 00:29:26 +0900
Subject: [PATCH v1 0/4] media: atomisp: prevent integer overflow in
DVS table allocations

CVE-2022-50399 (commit 51b8dc5163d2) fixed an integer overflow in
sh_css_set_black_frame() by using array3_size(). However, the same
overflow pattern exists in 9 other locations that were not updated.

The most critical is in alloc_dvs_6axis_table() (sh_css_param_dvs.c)
where width_y * height_y multiplication overflows on 32-bit arithmetic
when the user sets a large resolution via VIDIOC_S_FMT. ATOM_ISP_MAX_WIDTH
is set to UINT_MAX which imposes no limit.

For example, with frame_res width=16777216, width_y becomes 262145:
    262145 * 262145 = 524289 (32-bit, overflowed)
    262145 * 262145 = 68720001025 (64-bit, actual)

This causes kvmalloc() to allocate only ~2 MB instead of the required
~64 GB, leading to an out-of-bounds write in
init_dvs_6axis_table_from_default() that triggers a kernel panic.

Patches 1-3 use array3_size() to prevent overflow at the remaining
locations. Patch 4 reduces ATOM_ISP_MAX_WIDTH/HEIGHT from UINT_MAX
to 8192 as a hard limit (mathematically: DVS_BLOCKDIM=64, max blocks
129*129, 129*129*sizeof(u32)=66564 bytes which cannot overflow u32).

Tested on: 5.15.0 (hardware), 6.8.0 (hardware), v7.0.10 stable (QEMU),
v7.1-rc5 mainline (static analysis). No Intel Atom ISP hardware
available for V4L2 ioctl path verification.

Siho Lee (4):
  staging: atomisp: prevent integer overflow in DVS 6-axis allocation
  staging: atomisp: prevent integer overflow in sh_css_params DVS
    allocation
  staging: atomisp: prevent integer overflow in shading table allocation
  staging: atomisp: add resolution limits to prevent DVS overflow

 drivers/staging/media/atomisp/pci/atomisp_internal.h     | 4 ++--
 drivers/staging/media/atomisp/pci/sh_css_param_dvs.c     | 8 ++++----
 drivers/staging/media/atomisp/pci/sh_css_param_shading.c | 2 +-
 drivers/staging/media/atomisp/pci/sh_css_params.c        | 8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.43.0



From 99ca51470fb296b4b33283a106d9388521646cb3 Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Tue, 26 May 2026 00:28:35 +0900
Subject: [PATCH v1 1/4] staging: atomisp: prevent integer overflow in DVS
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

Fixes: a49d25364dfb ("staging/atomisp: add support for DVS")
Cc: stable@vger.kernel.org
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



From 6205ae2498aea5944d41cae04135daf4912e0a2f Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Tue, 26 May 2026 00:28:56 +0900
Subject: [PATCH v1 2/4] staging: atomisp: prevent integer overflow in
 sh_css_params DVS allocation

Same integer overflow pattern as the previous commit, in the same file
where CVE-2022-50399 was fixed (line 954) but these four locations
(lines 4481, 4486, 4491, 4497) were missed.

Fixes: a49d25364dfb ("staging/atomisp: add support for DVS")
Cc: stable@vger.kernel.org
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



From e9c253be79c1f78008c27514f4d01230c8a260f5 Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Tue, 26 May 2026 00:29:08 +0900
Subject: [PATCH v1 3/4] staging: atomisp: prevent integer overflow in shading
 table allocation

The width * height multiplication in ia_css_shading_table_alloc() can
overflow on 32-bit arithmetic when width and height are large, causing
an undersized kvmalloc() and subsequent out-of-bounds write.

Use array3_size() to prevent the overflow, consistent with the
CVE-2022-50399 fix and the previous commits.

Fixes: 3c4efab94858 ("staging/atomisp: allocate shading table separately")
Cc: stable@vger.kernel.org
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



From 8955328f674e82dea60f6c9982f20623b10a3619 Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Tue, 26 May 2026 00:29:20 +0900
Subject: [PATCH v1 4/4] staging: atomisp: add resolution limits to prevent DVS
 overflow

ATOM_ISP_MAX_WIDTH and ATOM_ISP_MAX_HEIGHT are set to UINT_MAX, which
allows userspace to set arbitrarily large resolutions via VIDIOC_S_FMT.
This is the root enabler for the integer overflow in DVS table allocation
fixed in the previous commits.

Add reasonable limits (8192x8192) as a defense-in-depth measure. The
Intel Atom ISP hardware does not support resolutions beyond 8192x8192,
so this should not affect any real use case.

Fixes: a49d25364dfb ("staging/atomisp: add support for DVS")
Cc: stable@vger.kernel.org
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

