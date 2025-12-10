Return-Path: <stable+bounces-200714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 901ECCB2D0D
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D136831234C8
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7F2F616C;
	Wed, 10 Dec 2025 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R+xDVAM5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FZ/CQHky"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7122FB978
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365886; cv=none; b=Jy+jBe/AEwrrxJv2mebiEj91CeZbO6Nfss+WcQB/hHkLXQ6ngrCpx8mKUrPR9vCNeI03sglHl0Vts0ArqIIcXJUjDJMlPlbE4a92zP1FR9BkLBAyUFMtxfrzZQfduJ/4qhUjNWWXe13lVlFr/BWeROlrjzYtKlz5ORe4H4h85+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365886; c=relaxed/simple;
	bh=xUP8XzWIweXeY5tthMtwg5GemgkerL2mBixHq0gzRfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyfuMoyvJypqfTRH7Bf+1OEFYJETErdzwaZhRy/Pf+Iri88KCE7UHtXlbKwPN8W583ZEWjQcfyNFUn+pDrLgdadASLx/W7s0buEMsT3B4yWpSF+myg5zShtrHEKdhBA3z5znp03P0+4PJR7NlJWsfpdsAa3vobEXpANVJuv3Cgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R+xDVAM5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FZ/CQHky; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA8e5en1817911
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8A4UmN9C1RmT+bHKjESVdg8JDmS/sCtWT2ZZfK7PdRs=; b=R+xDVAM5uz1jmZTT
	Ydzx8KHMA2KcSkbJS+WOU5v1n/vi0M6lBUxkWEQ1JKKb+yDJh7/s7qlYneDnqZ1F
	RFsiY/Gad2zYuLlVx0E1a15LrETjlHOZpUbnuwm5NciH9cee7CwXhfsefmxSIEtb
	/j9ZoEQks1ZSxW8xXcpsDM4M39xZHjUpKEXxbeekNuHj3cgKW6cNhYbYXBpqi7RC
	aEEIjshZSmroiNqqDPw8XEPsHNZeHT+J5qT1RI8kpATZ5DfTuUTqPuh1pNySPTKY
	44gdngryqGo1ds83SF0Y21IIc5TBuq9RCGeeo7jjvpbSOtKbJRY3lILrsxU5R+Cn
	nxqy9A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay2e0h2us-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4edaf9e48ecso172513941cf.0
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 03:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765365883; x=1765970683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A4UmN9C1RmT+bHKjESVdg8JDmS/sCtWT2ZZfK7PdRs=;
        b=FZ/CQHkydbTXvynezresY58hkDL/N9TWCgETg8pjSBj48ekY0rmOrK9md/17BZIuSX
         rCbFevSFj4LeH0NVbaM8DP6ccpxHneEW25eZ5taw8QFUN3lezsDtDxRu5Jjl/Ys+m+GJ
         CR+d0sbjGugHomSqrqRi2IhU77jpAPwhb2s1ep7SyV9PEObP9dfiUGjuCs+kZh0e1kly
         4b66c3dTCHTOXKxUtasRs0bFOXYL4dxiXPd/4k0Bxl+zmgnpVWSEgo+aENbVkh3qA7fc
         9YnzVSkE0RKXMrCxVxtI4Hv0HRzjowEH8yslb9POft0Hc8xVzPndZMDyC22oOp9ypuvP
         S9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765365883; x=1765970683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8A4UmN9C1RmT+bHKjESVdg8JDmS/sCtWT2ZZfK7PdRs=;
        b=a6BjowfyT3jUZSsbuEbSGMC/GglUuojTzF7S4jYyLpyTu7khJyNcm9KGowC9K7tNdk
         YuHi1n5ARc6pi4c5/4W6xw27c3Si8g9vxB6l16nmLLnSLsTHnzzVQ07BVZ7sXB1q4SSS
         Hm8iGc3jKhm7pZ8qi62nUR414/25TUpyGoJ0IxVlW8HERwyK6RLB3l6BJgWB+Vfpbo/O
         NHtqVF6KrzZGWm62aWyV7r1qXbdS/XP6ygzl4wGKzikHL3tpYmBBvkKlshugy0DMTVWl
         o/SmDhl2Zpg6yanasoA5Cb6sxP5Wsp+8X2wAqvH9zoQwbLQ6LvXA5r1QtyKZj/T87Z9D
         HejQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBpQp8BTIE3M5iCronuFbooTnzdjCWOeordM5Q81y9yRbVqywP01LFKdGRt5LhEGws09bDtGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu1QDxGuypXjZmacACRDxmHCVX2+UUvvDRfxa3rIqO9HFJsTku
	g0a5YqourU23pJWXCILmhmOq5bwa0/joVNvx2G3dE8KNciig9G5ivruI5pSTLEKA5NsTgQ9xOgQ
	HGkutesDD3M1Xb2vKKAOaPNSP1d8jpYhnuaz8oPRT7RFC1E8Js0NxSBQxrFI=
X-Gm-Gg: ASbGncvkuhoHVjDLDgYBi2Cyp6RynFFjgNx+eT/75nAiwsNQr+zNFeYCnyvTZ/M1W6L
	NTrXxnMA6rAo3i7uxMo/PCNMHg0z+QoCnFeLYAggDRX/NyNkkexRyOwac7EO22wCVAXjVUzgn8v
	al9ukHdOf6lfXVQAQOafkcUwJxgG/25ic+fVsoybLbEFJOJMZwAq0CvD8DuxBiO/FOYzDhHM9wL
	5V8nQRjiNoYcRWZOiZZBPhkrR/JO7fmM20eOsht9bNCtOPdjPfnJ/2ZwUuU+88U0hfU8FzAzV6m
	llZdRdqnuzxi8ySu1+XILeKirwybofcAcxCTR/TML0wlgH6hyS0jpbAewjQWjbqldMPzGojDyu3
	4h/tCuXpKLey45+NH0/v3Pc/hq88lut3aarAr2Lv+ucR3Tyg6YOEo+H1Clz0hXKQZdIz8XPZ5OC
	H9zE6iNcHMZAxNm69yhDFRszLb
X-Received: by 2002:a05:622a:a05:b0:4ee:1857:2673 with SMTP id d75a77b69052e-4f1b1a09982mr24282041cf.35.1765365882666;
        Wed, 10 Dec 2025 03:24:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvqFYt9eLydcGuY9lV47+eP3sa0CMjo8qpb14v7pL7vN68cGfzQ1swYvSYCCexfPQD+SshPA==
X-Received: by 2002:a05:622a:a05:b0:4ee:1857:2673 with SMTP id d75a77b69052e-4f1b1a09982mr24281811cf.35.1765365882151;
        Wed, 10 Dec 2025 03:24:42 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49e3fb1sm1696851266b.60.2025.12.10.03.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 03:24:41 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Hans Verkuil <hverkuil@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-media@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 4/5] media: ipu-bridge: Add DMI quirk for Dell XPS laptops with upside down sensors
Date: Wed, 10 Dec 2025 12:24:35 +0100
Message-ID: <20251210112436.167212-5-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210112436.167212-1-johannes.goede@oss.qualcomm.com>
References: <20251210112436.167212-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA5MSBTYWx0ZWRfXzxg+xgXA3QPc
 SDMu14WkELm2dKS85eOU3nMW43oGUhQhI5xRonmIFUyoSMa5/VVZnb86GtSPG9SeMAD1824NXo1
 o/DlevUHmUEqBiwCG3g4yeycvdXeOp7cCwddwzVCiBrgf0NczEGP0Iv0FKrvK0gRp/d2K2Lf3MT
 CC6LG3TMi7VI9Kz/DYq4r6NCO3PFqkj3MxzQ4tfKatLML/seVWZVTIVlWIlX/wqnkO8idmLvB5s
 gUQKHITobrZmx146AlEsUuxZjEFtNxWRo1OhgGkGJ6vrNLARTMjWfYFjp+NzSrh+HqiUGMpXXjL
 tDmwJgW6AN9lbH6UkT9pnD8RGzLta1URhgf2Eam30QKLqWYO7OXQHGt9hFhIIyQ1x4/NrWLgJhS
 ljZ5YisGkCQ1eT855n7Pqq3K/fxzVA==
X-Proofpoint-ORIG-GUID: Tm_Sc7UgL5zev2hatY5so3VeUZk-J8Vk
X-Authority-Analysis: v=2.4 cv=G5oR0tk5 c=1 sm=1 tr=0 ts=6939587b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=io_fNSwh-MQL7jGs-6kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Tm_Sc7UgL5zev2hatY5so3VeUZk-J8Vk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100091

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

Fixes: d5ebe3f7d13d ("media: ov02c10: Fix default vertical flip")
Cc: stable@vger.kernel.org
Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v2:
- Fix fixes tag to use the correct commit hash
- Drop || COMPILE_TEST from Kconfig to fix compile errors when ACPI is disabled
---
 drivers/media/pci/intel/Kconfig      |  2 +-
 drivers/media/pci/intel/ipu-bridge.c | 29 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/Kconfig b/drivers/media/pci/intel/Kconfig
index d9fcddce028b..3f14ca110d06 100644
--- a/drivers/media/pci/intel/Kconfig
+++ b/drivers/media/pci/intel/Kconfig
@@ -6,7 +6,7 @@ source "drivers/media/pci/intel/ivsc/Kconfig"
 
 config IPU_BRIDGE
 	tristate "Intel IPU Bridge"
-	depends on ACPI || COMPILE_TEST
+	depends on ACPI
 	depends on I2C
 	help
 	  The IPU bridge is a helper library for Intel IPU drivers to
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


