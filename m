Return-Path: <stable+bounces-200468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A114DCB082C
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 17:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF8873105566
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9563009D9;
	Tue,  9 Dec 2025 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SW5GfTEp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gOkv0d4w"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2C92FFFA4
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765296395; cv=none; b=rwobM5uOyM2n64qVjsYS9oa2dJcsVsy6lBZOxjQnYeClJ1hAw8fS02akG9Uv+mbb3NrNg2HmMKfdIVYM8xoJVYWw6TnVSasA9OhpQ1zA6fk6NrYrA7vGJ5v9P9NiIbhrf7jbmSR1vES5K8esiye7JkUXtQ9NR5t9a0QjzpeVeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765296395; c=relaxed/simple;
	bh=L174GWmru7ZF4OjbWwGfFdgE5zDp10ar9lX5+CU/Pw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqnaeaxgCoBVCOsBRUYRrp6RfVZm7T7VEEqdNcUXf6Pe0YKz5NKAS1lY0kZVCVvsFGSzI0nNJ7ebKthcaWb6XpIaInUQoYaHyEiOWfucikpdcWgl2EUW+ZWRFii2sjEir49lFD6bQoFrgNvGD7xQ8wJKR2NySWMqcygy0GHUHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SW5GfTEp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gOkv0d4w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B9Fha1R4145244
	for <stable@vger.kernel.org>; Tue, 9 Dec 2025 16:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PcgKvC7JRfGFnDl4d1cl7qh9ZdiZ08n1nj3k1pmly2E=; b=SW5GfTEpkBMHYiF+
	ComXj80omqehfxrg9TY3284G4vDdb+Ezgn3VcD3y9QJ2xYTshmIPzolrQfchVIvM
	yKB9nsrUlyFODnTmaxS9keP1Qxen8LW3nYUesAEyT00Kj7KLSVJmZLYqDjUIiexd
	i9aV0/dNF/fhflENYRo4AKF8uJVKxSo3/1TxJGCzwxBh9iiqRww/ImrFLk1Dly2M
	4JpwnVwQ81xmdQGF9NLmPca7TbMbnr38w9iaO0b8WR0m69K2YsVaSjN7xuuQjuJE
	Vi5PgMzHTyRS7TqSlvoy4mw2DRamDqS+3uxcWa98TIUpik35jHNtTPTBTImymfjf
	kDKCWA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axherh6c7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 09 Dec 2025 16:06:32 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-55b099d692dso3129577e0c.0
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 08:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765296391; x=1765901191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcgKvC7JRfGFnDl4d1cl7qh9ZdiZ08n1nj3k1pmly2E=;
        b=gOkv0d4w0HwaK/HsK9bYboW+JCKVzez6kttiJ0AVIVm6X1ujTPZuTKr+lNvPHt2d7x
         YRp520jxs7TueaFBD0ueslCxcnZ/9yRl5Qjk+BrJDVW25ugu79LtZBQ1tLScpDhQlGUZ
         lXPbsJ00RDNz0W1e397tsBlpF3xNsDZumJBXWfVJvh7SG74BcIoTSu00+Lk9iRGDy+tC
         nns4WHq/N0bZBsykYRzYlacCRZDisrRnsINhLjTIfjPqeh3+yKVXwJK8M2fvvsiLvdPX
         OTHzNG49thUhXGPjRGE6JncJ5xZGkXPwoizw8QfLTysLpUawBAQTorvxenMmdXOAI+23
         Q/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765296391; x=1765901191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PcgKvC7JRfGFnDl4d1cl7qh9ZdiZ08n1nj3k1pmly2E=;
        b=PuFrO5xjbvoDEBg39Nyoaz7jEzVSwlaHSAIFdtSs7xy/Ng0gqVdPxuq0hRCg+tenMr
         VKRUvzx2KlJvzD0OAkX7OWD6/QdoDJHJVmQo8AX8Vb0Ralo8IytOYCZE48MCXABZNJbs
         OHpVzLENH7jc9Q/YjGelLTwwzAZ8DZEYZS2Pro2VWYaAquJwpx9CRdlggsWXHk/3U5wM
         vjyHxsFg48rdeMvifeXnh07FcAfaHjcno7LbpBR5cPRJ/1FM0Odg29tccX67kZ0Lj3TD
         gSWzS9cCuULqp2aiU3jiknr//XWtQIMSQYmX8ln3oUII8RWvpNc0POAuKKAAF/9ofC9Z
         lGfA==
X-Forwarded-Encrypted: i=1; AJvYcCU33sGR4pakkfta726/bXeGB9SxOrQz9S44ZxgyTrZMNbX4a4LQKnltIIUtCJ7U3o6d96BAAy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HB886WofzfO+v39IWk8DJHnO2suAgf0bxUFDbUCXVOSBNbqv
	z0LpRp9O1MKZGLKXSb1v/6JEryvFVNtXa448KeKHTgx1XbXoD8+MwcldhFpTiby+Qu87s77DDzS
	4j9uWBVpWf17lSdo3QTFvNG5SJP2c4XVr2/LnpYhmK3RsD7hUADfB8GEoh34=
X-Gm-Gg: ASbGncuKhJj3cOGWaIp+/vrXwcuLg94wLNQwY43gBIoeH1uY7x4wGbyquMabzHlOnnc
	sgA4QpfbwrhMtahooiTPH9gfNcDl0lE4Wste5VPs1K38IEVHluVBHcLu9AEmXKEsF+/tkvWxG/a
	7cveSI6eR7VDcyJSaaSiehRmeKZhWLsxQg4CJQdi9kfl5OGI48fYfLj23qt7z9m7/n2jCotJ2vi
	exbtsIO9GF/0X+dXTla/FHdzp0RxCaEIfvp5vPwKAz60rtEhpa0XAsRryy9qWsqqmc/Uf5nNmAU
	FHjjhg9rH0MqFGbWOu08z97HESCd0Lb4aD9PFUxzNxluoxG11LwWj2JRR14u3/o6hcaoVzIIGwl
	TVukz41+606jSqXutyju34LkttUl/XzOrZ98df6kz6WYJJiYu0P8Ak9GWxiceVsxjq/c5A93oiu
	4NVeax5fsVlOzYxbOOeciukPwI6nLND8FPm+zV1TJIVW2MPQ==
X-Received: by 2002:a05:6122:1d54:b0:559:5ef5:b196 with SMTP id 71dfb90a1353d-55e846974a2mr2928937e0c.13.1765296391278;
        Tue, 09 Dec 2025 08:06:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8y8i6NIi/zLZoGQSXP19HWfbFC9YOHgJWNAUSeP81T3aN0pu44z0EHfMAC4QIBv/bGEookw==
X-Received: by 2002:a05:6122:1d54:b0:559:5ef5:b196 with SMTP id 71dfb90a1353d-55e846974a2mr2928870e0c.13.1765296390559;
        Tue, 09 Dec 2025 08:06:30 -0800 (PST)
Received: from t14s.space.revspace.nl (2001-1c00-2a07-3a01-8e96-3679-0b9c-de47.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:8e96:3679:b9c:de47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b3599050sm14324838a12.17.2025.12.09.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 08:06:29 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
        linux-media@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 4/5] media: ipu-bridge: Add DMI quirk for Dell XPS laptops with upside down sensors
Date: Tue,  9 Dec 2025 17:06:20 +0100
Message-ID: <20251209160621.6854-5-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209160621.6854-1-johannes.goede@oss.qualcomm.com>
References: <20251209160621.6854-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDEyMSBTYWx0ZWRfX6sn6DaEeWLRR
 ASfAW6irWNhjg5TG91no05FtXXqHs2RrVEtgJ3SbognphTZkAItZMvawp6idqk2d+fzTnFfiOP2
 yJntGOYvXwuXHD+aVxFShHSZupkgvHl49h3xcF9NaYA+1Q8dTOrA3Fw1NuJAmVmKb31erwC3iDH
 HId+vRc438ELLaz70y4PWY5/uJjYuZW1hsBzPUkofBjwtEGMgLuVkZUu0qay8iWb+zAlgdKVKhW
 q301umPHnUfSmn41nBEyOFxiBHI86LlUjlQvsxCe2+MqMvZVtAeylMbVTcTtqGuQvv+7Tnj1Ctf
 8bpaxA7+XklVQrxQFObhE/BB8MJF4lL/RI79zSix4Shcmb1IPcLkrt3VrjOdUCu4FIKOm0oF9Ms
 LrhUkd498IcGKTWOrSkOnGomDr76iQ==
X-Proofpoint-ORIG-GUID: pw2iqAavJj8UjVnfOuXq309iq8e79DYK
X-Proofpoint-GUID: pw2iqAavJj8UjVnfOuXq309iq8e79DYK
X-Authority-Analysis: v=2.4 cv=P7M3RyAu c=1 sm=1 tr=0 ts=69384908 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GbN0NnZvFBoPmIocWywA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090121

The Dell XPS 13 9350 and XPS 16 9640 both have an upside-down mounted
OV02C10 sensor. This rotation of 180° is reported in neither the SSDB nor
the _PLD for the sensor (both report a rotation of 0°).

Add a DMI quirk mechanism for upside-down sensors and add 2 initial entries
to the DMI quirk list for these 2 laptops.

Note the OV02C10 driver was originally developed on a XPS 16 9640 which
resulted in inverted vflip + hflip settings making it look like the sensor
was upright on the XPS 16 9640 and upside down elsewhere this has been
fixed in commit 69fe27173396 ("media: ov02c10: Fix default vertical flip").
This makes this commit a regression fix since now the video is upside down
on these Dell XPS models where it was not before.

Fixes: 69fe27173396 ("media: ov02c10: Fix default vertical flip")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 58ea01d40c0d..6463b2a47d78 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -5,6 +5,7 @@
 #include <acpi/acpi_bus.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/i2c.h>
 #include <linux/mei_cl_bus.h>
 #include <linux/platform_device.h>
@@ -99,6 +100,28 @@ static const struct ipu_sensor_config ipu_supported_sensors[] = {
 	IPU_SENSOR_CONFIG("XMCC0003", 1, 321468000),
 };
 
+/*
+ * DMI matches for laptops which have their sensor mounted upside-down
+ * without reporting a rotation of 180° in neither the SSDB nor the _PLD.
+ */
+static const struct dmi_system_id upside_down_sensor_dmi_ids[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 13 9350"),
+		},
+		.driver_data = "OVTI02C1",
+	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 16 9640"),
+		},
+		.driver_data = "OVTI02C1",
+	},
+	{} /* Terminating entry */
+};
+
 static const struct ipu_property_names prop_names = {
 	.clock_frequency = "clock-frequency",
 	.rotation = "rotation",
@@ -249,6 +272,12 @@ static int ipu_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
 static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
 				     struct ipu_sensor_ssdb *ssdb)
 {
+	const struct dmi_system_id *dmi_id;
+
+	dmi_id = dmi_first_match(upside_down_sensor_dmi_ids);
+	if (dmi_id && acpi_dev_hid_match(adev, dmi_id->driver_data))
+		return 180;
+
 	switch (ssdb->degree) {
 	case IPU_SENSOR_ROTATION_NORMAL:
 		return 0;
-- 
2.52.0


