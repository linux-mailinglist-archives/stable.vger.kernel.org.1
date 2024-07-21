Return-Path: <stable+bounces-60646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C193854F
	for <lists+stable@lfdr.de>; Sun, 21 Jul 2024 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4489F28127E
	for <lists+stable@lfdr.de>; Sun, 21 Jul 2024 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE052907;
	Sun, 21 Jul 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmLJdvlQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152D16131C
	for <stable@vger.kernel.org>; Sun, 21 Jul 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721576340; cv=none; b=YbsoDg0mrNp5ZEjb7xOQl/FleoTZtpHJPtxR02c4r0oFYfz0VMAz6FpztGyWPqNeicXQFbtsBFC/vqd0atPEmBkcctQ4t/D2N6tN7ph3P8CT8YCZL0T330jPevTWTO32b8KZm13xjOnrzMRUpH3wMWslolv2wHtXNXHxB/lKmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721576340; c=relaxed/simple;
	bh=Pr7O132SEouT6vs/viVJWv1ZAnadnppWHL83ixCCUJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2audLydfoizrljypdB+26oay86QDcdpvoRloJ7mWOkbvgRRKuVhm9Pd4aZNLjLiTquTtmukkOLPXYNmvxL7m0aeBQq0gg4hjpiukTh59Ly/yhfv3M5hbBZnYiGxy92eSVQ+z4ceamzDrF3SNNhfU234wvOAKbcvSF4q9keGdNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmLJdvlQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721576337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h+WIUySG3X8s8gHCDhDyFH9aRpd0ZesC03oonoawAOs=;
	b=AmLJdvlQR2pBSsHM2+IpxB1xDZb6YON6Ti7DU7b3rV7ZL3mmDxEOYqXLIVw/uxyp5mwCqX
	6lC//FpPovXjEgQsPm2eq/TaNTOz0dHQ/nGQmcx4wC0TjAFFJ9hjQ/H9NkwjhXddeUPM9h
	om8PXMwPF3H/BjJi4HyUg47lUPtymHI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-iq8vFZicMUmipSz6xp7ZzA-1; Sun,
 21 Jul 2024 11:38:49 -0400
X-MC-Unique: iq8vFZicMUmipSz6xp7ZzA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 319CC19560A2;
	Sun, 21 Jul 2024 15:38:47 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1695B19560AE;
	Sun, 21 Jul 2024 15:38:41 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Tsuchiya Yuto <kitakar@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yury Luneff <yury.lunev@gmail.com>,
	Nable <nable.maininbox@googlemail.com>,
	andrey.i.trufanov@gmail.com,
	Fabio Aiuto <fabioaiuto83@gmail.com>,
	Kate Hsuan <hpa@redhat.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] media: atomisp: Fix streaming no longer working on BYT / ISP2400 devices
Date: Sun, 21 Jul 2024 17:38:40 +0200
Message-ID: <20240721153840.60617-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
---
 .../media/atomisp/pci/ia_css_stream_public.h  |  8 ++++++--
 .../media/atomisp/pci/sh_css_internal.h       | 19 ++++++++++++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

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
 
-- 
2.45.2


