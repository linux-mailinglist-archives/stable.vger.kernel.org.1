Return-Path: <stable+bounces-103194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09399EF62A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE78189AB31
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001AC205501;
	Thu, 12 Dec 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gftdfXvf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139E4F218;
	Thu, 12 Dec 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023827; cv=none; b=fgY7UaY1v7SfQGgdGV3vt3dDxrplI/pneQHwauHtB5Jd+xNugAGgDszGy260CUhe0ZOAyB+95s+f/PcNGR7w5lhnUAK1khc75IyV6QyXcZhrINBPjEZYzXrTbcTehioA0frTbwENfbt0lpVJmPM3w93OEwYmClI1vuhr2ZtPI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023827; c=relaxed/simple;
	bh=BzKBG6CCF8JgCve6sa1T17RpAlB+EyWHaZCogWarrz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmvtphDhEXxSJeZKxFwq94PQKku2zDRDP4bmOFocQxkEksps6sgbNXPjbRhgiCmNudsDxQWHtPItpEdZJmZ9XqSK+z38yV5D5Ml3uBr3PWgXD/m2jvik1Im5Dsu1Qan67b4wIAX7YZ67/qnjk/JCBr7G8caBrxmdLocGStmdXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gftdfXvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C8CC4CECE;
	Thu, 12 Dec 2024 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023827;
	bh=BzKBG6CCF8JgCve6sa1T17RpAlB+EyWHaZCogWarrz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gftdfXvfwiN8pzO7kYpzh68bMfZf3xouQIkC5wmq3rBR6/hgRAeMocfg6A2kP868k
	 wOXvKr2Hz7lVmF2SjtbFo48Fd/5Fmb/I3Yxdfj56Gt8Twi7P5EvFIp7J8L/HYWCo15
	 wuXEWbOwnWETjVEnbBfs0sv9HN9f8Dptnt7XYP6w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 096/459] media: atomisp: remove #ifdef HAS_NO_HMEM
Date: Thu, 12 Dec 2024 15:57:14 +0100
Message-ID: <20241212144257.305515682@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 63705da3dfc8922a2dbfc3c805a5faadb4416954 ]

This is not defined anywhere, so, solve the ifdefs, getting
rid of them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: ed61c5913950 ("media: atomisp: Add check for rgby_data memory allocation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../atomisp/pci/isp/kernels/bh/bh_2/ia_css_bh.host.c   |  2 --
 .../raw_aa_binning_1.0/ia_css_raa.host.c               |  2 --
 .../pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a.host.c      |  5 -----
 .../media/atomisp/pci/runtime/binary/src/binary.c      |  4 ----
 drivers/staging/media/atomisp/pci/sh_css_params.c      | 10 ----------
 5 files changed, 23 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/bh/bh_2/ia_css_bh.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/bh/bh_2/ia_css_bh.host.c
index 82aa69b74677c..2091f001502d4 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/bh/bh_2/ia_css_bh.host.c
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/bh/bh_2/ia_css_bh.host.c
@@ -13,7 +13,6 @@
  * more details.
  */
 
-#if !defined(HAS_NO_HMEM)
 
 #include "ia_css_types.h"
 #include "sh_css_internal.h"
@@ -63,4 +62,3 @@ ia_css_bh_encode(
 	    uDIGIT_FITTING(from->ae_y_coef_b, 16, SH_CSS_AE_YCOEF_SHIFT);
 }
 
-#endif
diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/raw_aa_binning/raw_aa_binning_1.0/ia_css_raa.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/raw_aa_binning/raw_aa_binning_1.0/ia_css_raa.host.c
index 29c707ecf9f3b..9b756daddee06 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/raw_aa_binning/raw_aa_binning_1.0/ia_css_raa.host.c
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/raw_aa_binning/raw_aa_binning_1.0/ia_css_raa.host.c
@@ -13,7 +13,6 @@
  * more details.
  */
 
-#if !defined(HAS_NO_HMEM)
 
 #include "ia_css_types.h"
 #include "sh_css_internal.h"
@@ -32,4 +31,3 @@ ia_css_raa_encode(
 	(void)from;
 }
 
-#endif
diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a.host.c
index ba52c80df4a58..bd7b89d9475bf 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a.host.c
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a.host.c
@@ -227,10 +227,6 @@ ia_css_s3a_hmem_decode(
     struct ia_css_3a_statistics *host_stats,
     const struct ia_css_bh_table *hmem_buf)
 {
-#if defined(HAS_NO_HMEM)
-	(void)host_stats;
-	(void)hmem_buf;
-#else
 	struct ia_css_3a_rgby_output	*out_ptr;
 	int			i;
 
@@ -291,7 +287,6 @@ ia_css_s3a_hmem_decode(
 	out_ptr[0].g -= diff;
 	out_ptr[0].b -= diff;
 	out_ptr[0].y -= diff;
-#endif
 }
 
 void
diff --git a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
index 060d387495704..002bd8cf28634 100644
--- a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
+++ b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
@@ -805,11 +805,7 @@ ia_css_binary_3a_grid_info(const struct ia_css_binary *binary,
 	s3a_info->deci_factor_log2  = binary->deci_factor_log2;
 	s3a_info->elem_bit_depth    = SH_CSS_BAYER_BITS;
 	s3a_info->use_dmem          = binary->info->sp.s3a.s3atbl_use_dmem;
-#if defined(HAS_NO_HMEM)
-	s3a_info->has_histogram     = 1;
-#else
 	s3a_info->has_histogram     = 0;
-#endif
 	IA_CSS_LEAVE_ERR_PRIVATE(err);
 	return err;
 }
diff --git a/drivers/staging/media/atomisp/pci/sh_css_params.c b/drivers/staging/media/atomisp/pci/sh_css_params.c
index 8d6514c45eeb6..90aa8fc999ef8 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_params.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
@@ -16,12 +16,10 @@
 #include "gdc_device.h"		/* gdc_lut_store(), ... */
 #include "isp.h"			/* ISP_VEC_ELEMBITS */
 #include "vamem.h"
-#if !defined(HAS_NO_HMEM)
 #ifndef __INLINE_HMEM__
 #define __INLINE_HMEM__
 #endif
 #include "hmem.h"
-#endif /* !defined(HAS_NO_HMEM) */
 #define IA_CSS_INCLUDE_PARAMETERS
 #define IA_CSS_INCLUDE_ACC_PARAMETERS
 
@@ -1513,10 +1511,8 @@ ia_css_translate_3a_statistics(
 		ia_css_s3a_vmem_decode(host_stats, isp_stats->vmem_stats_hi,
 				       isp_stats->vmem_stats_lo);
 	}
-#if !defined(HAS_NO_HMEM)
 	IA_CSS_LOG("3A: HMEM");
 	ia_css_s3a_hmem_decode(host_stats, isp_stats->hmem_stats);
-#endif
 
 	IA_CSS_LEAVE("void");
 }
@@ -2255,9 +2251,7 @@ ia_css_isp_3a_statistics_allocate(const struct ia_css_3a_grid_info *grid)
 		me->vmem_size = ISP_S3ATBL_HI_LO_STRIDE_BYTES *
 				grid->aligned_height;
 	}
-#if !defined(HAS_NO_HMEM)
 	me->hmem_size = sizeof_hmem(HMEM0_ID);
-#endif
 
 	/* All subsections need to be aligned to the system bus width */
 	me->dmem_size = CEIL_MUL(me->dmem_size, HIVE_ISP_DDR_WORD_BYTES);
@@ -4360,12 +4354,8 @@ ia_css_3a_statistics_allocate(const struct ia_css_3a_grid_info *grid)
 	me->data = kvmalloc(grid_size * sizeof(*me->data), GFP_KERNEL);
 	if (!me->data)
 		goto err;
-#if !defined(HAS_NO_HMEM)
 	/* No weighted histogram, no structure, treat the histogram data as a byte dump in a byte array */
 	me->rgby_data = kvmalloc(sizeof_hmem(HMEM0_ID), GFP_KERNEL);
-#else
-	me->rgby_data = NULL;
-#endif
 
 	IA_CSS_LEAVE("return=%p", me);
 	return me;
-- 
2.43.0




