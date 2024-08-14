Return-Path: <stable+bounces-67605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97181951425
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 08:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6A2B216DC
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 06:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B851481B9;
	Wed, 14 Aug 2024 06:07:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F08874BF8
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723615655; cv=none; b=LuNzEypLICSoe3xGJ1USQjrrsYynGzaufjWxPW6r7wOb3/FJFIRcsBSCN8VYUf2RGdoegXKgz5vhmnEjMqEWbS16CVX2amm8zg9jTM9OMMiApqvlylc16HgeQljc51H0eEi6xT7mtu5cQTBkRjcDHEZweBNsqmBqy1sqMbbmh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723615655; c=relaxed/simple;
	bh=SBrY6b4L2KOkvuY4vo+phw6rbjW/U+9giLoXlGN29ys=;
	h=From:Date:Subject:To:Cc:Message-Id; b=TLMGFf4KICT/9nEhLpaiYjw9bxmBMOafJQBBU0nWO5B06wMhXeJqOWLBt+nysh4mqas+JyGA88hxbYode+iTERwSHuHcFDpWDSFmmUG4fj64irma6v085xb1epRWQfXpO8xRyqND/R14b9g0oo0MPv8Jpiad9FvbQfauJ/O/YAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1se7AO-0007R8-2m;
	Wed, 14 Aug 2024 06:07:32 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Wed, 14 Aug 2024 06:06:07 +0000
Subject: [git:media_stage/fixes] media: atomisp: Fix streaming no longer working on BYT / ISP2400 devices
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1se7AO-0007R8-2m@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: atomisp: Fix streaming no longer working on BYT / ISP2400 devices
Author:  Hans de Goede <hdegoede@redhat.com>
Date:    Sun Jul 21 17:38:40 2024 +0200

Commit a0821ca14bb8 ("media: atomisp: Remove test pattern generator (TPG)
support") broke BYT support because it removed a seemingly unused field
from struct sh_css_sp_config and a seemingly unused value from enum
ia_css_input_mode.

But these are part of the ABI between the kernel and firmware on ISP2400
and this part of the TPG support removal changes broke ISP2400 support.

ISP2401 support was not affected because on ISP2401 only a part of
struct sh_css_sp_config is used.

Restore the removed field and enum value to fix this.

Fixes: a0821ca14bb8 ("media: atomisp: Remove test pattern generator (TPG) support")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 .../staging/media/atomisp/pci/ia_css_stream_public.h  |  8 ++++++--
 drivers/staging/media/atomisp/pci/sh_css_internal.h   | 19 ++++++++++++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

---

diff --git a/drivers/staging/media/atomisp/pci/ia_css_stream_public.h b/drivers/staging/media/atomisp/pci/ia_css_stream_public.h
index 961c61288083..aad860e54d3a 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_stream_public.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_stream_public.h
@@ -27,12 +27,16 @@
 #include "ia_css_prbs.h"
 #include "ia_css_input_port.h"
 
-/* Input modes, these enumerate all supported input modes.
- *  Note that not all ISP modes support all input modes.
+/*
+ * Input modes, these enumerate all supported input modes.
+ * This enum is part of the atomisp firmware ABI and must
+ * NOT be changed!
+ * Note that not all ISP modes support all input modes.
  */
 enum ia_css_input_mode {
 	IA_CSS_INPUT_MODE_SENSOR, /** data from sensor */
 	IA_CSS_INPUT_MODE_FIFO,   /** data from input-fifo */
+	IA_CSS_INPUT_MODE_TPG,    /** data from test-pattern generator */
 	IA_CSS_INPUT_MODE_PRBS,   /** data from pseudo-random bit stream */
 	IA_CSS_INPUT_MODE_MEMORY, /** data from a frame in memory */
 	IA_CSS_INPUT_MODE_BUFFERED_SENSOR /** data is sent through mipi buffer */
diff --git a/drivers/staging/media/atomisp/pci/sh_css_internal.h b/drivers/staging/media/atomisp/pci/sh_css_internal.h
index a2d972ea3fa0..959e7f549641 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_internal.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_internal.h
@@ -344,7 +344,14 @@ struct sh_css_sp_input_formatter_set {
 
 #define IA_CSS_MIPI_SIZE_CHECK_MAX_NOF_ENTRIES_PER_PORT (3)
 
-/* SP configuration information */
+/*
+ * SP configuration information
+ *
+ * This struct is part of the atomisp firmware ABI and is directly copied
+ * to ISP DRAM by sh_css_store_sp_group_to_ddr()
+ *
+ * Do NOT change this struct's layout or remove seemingly unused fields!
+ */
 struct sh_css_sp_config {
 	u8			no_isp_sync; /* Signal host immediately after start */
 	u8			enable_raw_pool_locking; /** Enable Raw Buffer Locking for HALv3 Support */
@@ -354,6 +361,10 @@ struct sh_css_sp_config {
 	     host (true) or when they are passed to the preview/video pipe
 	     (false). */
 
+	 /*
+	  * Note the fields below are only used on the ISP2400 not on the ISP2401,
+	  * sh_css_store_sp_group_to_ddr() skip copying these when run on the ISP2401.
+	  */
 	struct {
 		u8					a_changed;
 		u8					b_changed;
@@ -363,11 +374,13 @@ struct sh_css_sp_config {
 	} input_formatter;
 
 	sync_generator_cfg_t	sync_gen;
+	tpg_cfg_t		tpg;
 	prbs_cfg_t		prbs;
 	input_system_cfg_t	input_circuit;
 	u8			input_circuit_cfg_changed;
-	u32		mipi_sizes_for_check[N_CSI_PORTS][IA_CSS_MIPI_SIZE_CHECK_MAX_NOF_ENTRIES_PER_PORT];
-	u8                 enable_isys_event_queue;
+	u32			mipi_sizes_for_check[N_CSI_PORTS][IA_CSS_MIPI_SIZE_CHECK_MAX_NOF_ENTRIES_PER_PORT];
+	/* These last 2 fields are used on both the ISP2400 and the ISP2401 */
+	u8			enable_isys_event_queue;
 	u8			disable_cont_vf;
 };
 

