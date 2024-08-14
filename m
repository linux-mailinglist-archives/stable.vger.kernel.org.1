Return-Path: <stable+bounces-67704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E547952274
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 21:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4811F2418B
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 19:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A441BE864;
	Wed, 14 Aug 2024 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtaaPsLp"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715351BE844
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723662155; cv=none; b=YPn8U2HvRYlvR+VplnuZ+9BQD3SXcbRkP9b4UyqDIl4ciUhvgflUwgU5St0UKG4orfwH80DJ54rgJz0aO4uZwGmWn3KG7uofWajxwMNEVAzIwBzTGRYIkWsmZJy3sxQ0TozMax8P9GyibWmpr5QZgyM5t0f33fF+J2BO13zKBB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723662155; c=relaxed/simple;
	bh=/gQAx//LLHunDUHHUyadR6Ntsfu9RtzzOdDAO3gpR1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVfVVddG5u6LWmpX7y3ZRUolQ8fvEXlETP7DMDpfXR79MOn4uGoOXJRHdZGkCOmn5GRRp7po3/26WT8GpramWZbQ1KfRMDwNmxbED8PSvOmG82A0upbX4FqbSt5TfD+/10jg9AfRHuql7bprLS/1svaAnZEfVyKu8EyL+JNnuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtaaPsLp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723662153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnCD2jCv8+LRBXs1DCD1n71FWSSYMHrFi8IT/1BCheY=;
	b=WtaaPsLpCKV31SUwXe5xgvsvR0BxpoziR2N3ccqZHf/aQ+eTsxvFGImrLi7wFWc4bAhg0W
	Md/npVRDrTILg+MpBvSaBJsoLPupIPJmj5861tXWqfq8uxkqGK5QDXCWrSTCxowjEzUFaB
	P3/imGZjAyJrulAQIDbI3IX9GD/8Yew=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205--yCz_wvxPGiD8RTeLWKdOg-1; Wed,
 14 Aug 2024 15:02:18 -0400
X-MC-Unique: -yCz_wvxPGiD8RTeLWKdOg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87B7A1955F06;
	Wed, 14 Aug 2024 19:02:13 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C3E319560AA;
	Wed, 14 Aug 2024 19:02:10 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] ACPI: video: Add backlight=native quirk for Dell OptiPlex 7760 AIO
Date: Wed, 14 Aug 2024 21:01:59 +0200
Message-ID: <20240814190159.15650-4-hdegoede@redhat.com>
In-Reply-To: <20240814190159.15650-1-hdegoede@redhat.com>
References: <20240814190159.15650-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Dell All In One (AIO) models released after 2017 may use a backlight
controller board connected to an UART.

In DSDT this uart port will be defined as:

   Name (_HID, "DELL0501")
   Name (_CID, EisaId ("PNP0501")

The Dell OptiPlex 7760 AIO has an ACPI device for one if its UARTs with
the above _HID + _CID. Loading the dell-uart-backlight driver shows that
there actually is a backlight controller board attached to the UART,
which reports a firmware version of "G&MX01-V15".

But the backlight controller board does not actually control the backlight
brightness and the GPU's native backlight control method does work.

Add a quirk to use the GPU's native backlight control method on this model.

Fixes: 484bae9e4d6a ("platform/x86: Add new Dell UART backlight driver")
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2303936
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index e509dcbf3090..674b9db7a1ef 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -823,6 +823,21 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 
+	/*
+	 * Dell AIO (All in Ones) which advertise an UART attached backlight
+	 * controller board in their ACPI tables (and may even have one), but
+	 * which need native backlight control nevertheless.
+	 */
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=2303936 */
+	 .callback = video_detect_force_native,
+	 /* Dell OptiPlex 7760 AIO */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7760 AIO"),
+		},
+	},
+
 	/*
 	 * Models which have nvidia-ec-wmi support, but should not use it.
 	 * Note this indicates a likely firmware bug on these models and should
-- 
2.46.0


