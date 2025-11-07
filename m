Return-Path: <stable+bounces-192711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 732EEC3F8E4
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 11:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C90B034E4A0
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4782D7DF9;
	Fri,  7 Nov 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ipfe5PL6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="COuwrsvw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6561FE47B
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512311; cv=none; b=khgMLx8wcpZqPiIxvKNdApESrI1cWh/mhpC/hbOHAUVEoa+GgTb2mjwUcFNpq0/wKaaxOQzpEut86zpQxCg6ibtaunxraCW2ch28J7Rqikas6nOEfxP+SESH5Oz5q5UCwrE6LMUQX6bzEAy00krLJj5FKquoHvmONf6KQvexjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512311; c=relaxed/simple;
	bh=cldVxJpRNKgcFoYyGi5TZxiwhzfN4EJKPJL34klWTCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dkMWbyMMvGfKAyaKq9IAG2i0qhH6xt1MhQv7/gmpvUxMzIcgzsDJQFlY1n+mrVH+APzEqCgxDQAt+tsFb2GziwRR3d9Kx1AfgLAV2eVAD5QFr4wShaOj5tunkIdVQxZuHmj0WwKpue8z6tBOLna/NBmYWGFptAZzNURkUTirQu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ipfe5PL6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=COuwrsvw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A757kui2273776
	for <stable@vger.kernel.org>; Fri, 7 Nov 2025 10:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jzF0z6hZFHuEWKL0+LuBE3RXthAv/UoQBwr
	q4S+rbnQ=; b=ipfe5PL6a6URkUKf47E+fnN8OJTeFFpPmO/56E5fGfl/Z/LIWPA
	lw6qMCHtDTx6QUB24WoH2ZAC0mU4pKVutO9ZpHmUai+t99OUP2h6BUozLojhz0Hj
	/e63Ysz3kAGX76R5XwMdfgnUZ5X7iXcRivTEQv9IBSU4y9kHHjhvmLAF6z7lImDh
	VXEMBOiicE7urIDLTc6EYoYxCuPikzQqZso73+7PhJGHq29J/x+Lz1bda7GjFrrL
	DA0e2HlSMA9mbxjqcTgjZnIJ6WNd3d3IyHSwO51xRapsyZipFmm0ZLto97E9Cr6E
	Ib9dfW+7yNmAtwywZrSZ4TQJzd1gq/xTjtQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9abmrydk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Nov 2025 10:45:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so1174175a91.2
        for <stable@vger.kernel.org>; Fri, 07 Nov 2025 02:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762512308; x=1763117108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzF0z6hZFHuEWKL0+LuBE3RXthAv/UoQBwrq4S+rbnQ=;
        b=COuwrsvwxJ3FDqreh/0ScuO/NBIIZDY6iBeNImtg5qWYQJYr5gR9cyFUa3ogxyAAZC
         C5siMllSDe5cQynPIIbBf5tUUXbOUlMpxe5gbi5ZJsXKXI5IovgV3QNysv2jAu2Uz7EK
         f7hdmJVN+D8VIyI9Gi5ntXIWq7tYl1zdwXlI31Bl5f6ML8Lyhhzl1XYDbpdQKXhF9KyN
         3B7oSlc41HbbRa9s2DoQW7YuSiTftKps67wnTDzB2/jW/jHDwy/cNxq13EMbY8hiDfXF
         SczHCTrFvYT5cbX8uiRIlJOGbQahdktAuLxG1YOWwJESg0aQm3dTukGj2+UwRdJj8rOT
         YHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762512308; x=1763117108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzF0z6hZFHuEWKL0+LuBE3RXthAv/UoQBwrq4S+rbnQ=;
        b=DbdgMpx/EL5nfH3/BuRcWjhz2DYR06C4Wd+TkKW0HooNMWEZfIjYsAt1H/w+U2xhfQ
         zQy8NyHCNIYkdqCr3XcbL4HLqOoTrfuh1+kJo1k/x+A3C8Dgb8XEO76FtPJXthvd6IY8
         YqyeZEu22UDF3kA8p1sSBnzh0zhDKntMvBgFwFMfdpNQIwmEP8DVJoeRUnUwCA1QEvWZ
         klkCEw/WKloe+cYmZvpfkIXBGMjMG/F1xuUEk/Q65R8cjnjQiaybRDku5UZwawoz3rW7
         KPe4oIFNg4KyNV7+C21aFpZmvycyjW/2jjh/sKbQ8mJIL3ucY6K3YojXX5yOFtrw1aj2
         wRUw==
X-Forwarded-Encrypted: i=1; AJvYcCUdd5LXBWDBVM4oB4yjeYRqyFFMOySrNEyZldN9skQYJoWC3Y7NqNpmdVhbqde3LKI3n5kFpyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PTY+UZyU3x4VzNHOPPP2/segV1WhKkvPdgoLS8agFkP4ViOB
	mIZUpxLW6uJMkNYuMQY+1TI7trsFvsiQ+lRnLOvCcLz+bHT8AqlQGUut7yBxFdiSZmmbe617ndI
	EGDBs7qJyUuaIMXVV+NwHML14kQrcIRrP+mv3sQjIMtbH5QKkOha3ex4Ta34=
X-Gm-Gg: ASbGncvzul1HkbnOVM2oB6iPzzE10MOrpRUUNVoUDs3zVB8gD8XBF9NOcRGBb6l9ATy
	ytdpk9as9DoP4SSg7LJXR1fRkb+gG439LN50/EVjHOHXVbPq4jsbNhkasGPjDGmnbdtIyKErtwV
	TQXDeyePyqRcJNXhPBCwtKqp6vDMgoq0hyg5oLkGbVzT5NAPOU9atdssIz/vKDKRDd+cIsOrJtc
	UknlMIg3NrAglJmPyD808YdUhHVRIfk7DPcaqXJGmaOAdUmrERXwMXDU8bEH1NnjmCWCReZdl8B
	8BhFdBzrgRyPyF+pwJ2NCmtVfPNdG2/p4jwyFCZhRfwHqxD1aIIh3QYKvhotDryrSRp9qWvGFV2
	Mel9TGgdqfFVs8saUElcly0Iif2A4TPvG7Z0xAwcNwUM/sX5vdK65
X-Received: by 2002:a17:90b:2b43:b0:340:d1a1:af6d with SMTP id 98e67ed59e1d1-3434c59666cmr3200927a91.36.1762512307544;
        Fri, 07 Nov 2025 02:45:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLIPMfoRBFdSkLK6MSwRI0bu0MIuKCQtHo+cC8zhSDBXAl4TEpY+PzJ0TgjkcmFqBio+utwA==
X-Received: by 2002:a17:90b:2b43:b0:340:d1a1:af6d with SMTP id 98e67ed59e1d1-3434c59666cmr3200902a91.36.1762512307083;
        Fri, 07 Nov 2025 02:45:07 -0800 (PST)
Received: from hu-punita-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d08b69e5sm2137711a91.0.2025.11.07.02.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:45:06 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: gregkh@linuxfoundation.org
Cc: Jamie Iles <jamie.iles@oss.qualcomm.com>, Thinh.Nguyen@synopsys.com,
        fabioaiuto83@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Subject: [PATCH v2] drivers/usb/dwc3: fix PCI parent check
Date: Fri,  7 Nov 2025 10:44:37 +0000
Message-Id: <20251107104437.1602509-1-punit.agrawal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y2mhbR1jo8dGu77N14P_U1JUaT7JhVwD
X-Proofpoint-ORIG-GUID: Y2mhbR1jo8dGu77N14P_U1JUaT7JhVwD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NiBTYWx0ZWRfX0vcrn0E8GMEu
 MgDyN63U3e4jGFopAYBmQDuHp/d1L2Cj5DNzbGetzFdbvk7V22DsP/+hqKiM3mENErU1Wc9NIxK
 XQcOT/qW6WWFaXLdYbwaG/m5Cka3+Y14LiwkffjV9tAcC1IUvh3bm4fihfq7cXGYT1uLOVH6bNJ
 z9eKGDCS/ry/bkg5+cOrKDx+jMZJeCOKHN6/iQBJ0Q7mGlGCNIEgXCDrIeP1pc3fPUEz445F599
 meHhe+DGX3dUESUQMZIkG6F/zo3AzPbY9lhkhG2apufmQyvj11YBVb4C2q5u57znMGoVcM8ksGm
 OFFt0h5S3EjjygNkeq2xd5rxTqYFrSXB9x08Sc15oNjKI3ZgzFFODjnZ9lOusXEGPFsqjhfrg8G
 ICQWDOl0kidz+6Gz7p+f3R6QL8O3Xw==
X-Authority-Analysis: v=2.4 cv=HPjO14tv c=1 sm=1 tr=0 ts=690dcdb4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jIQo8A4GAAAA:8 a=jM0-4Wpw8WwY0CpfOG8A:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070086

From: Jamie Iles <jamie.iles@oss.qualcomm.com>

The sysdev_is_parent check was being used to infer PCI devices that have
the DMA mask set from the PCI capabilities, but sysdev_is_parent is also
used for non-PCI ACPI devices in which case the DMA mask would be the
bus default or as set by the _DMA method.

Without this fix the DMA mask would default to 32-bits and so allocation
would fail if there was no DRAM below 4GB.

Fixes: 47ce45906ca9 ("usb: dwc3: leave default DMA for PCI devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jamie Iles <jamie.iles@oss.qualcomm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
v1[0] -> v2:
* Added tags
* Cc stable

[0] https://lore.kernel.org/all/20251105145801.485371-1-punit.agrawal@oss.qualcomm.com/

 drivers/usb/dwc3/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ae140c356295..c2ce2f5e60a1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/reset.h>
@@ -2241,7 +2242,7 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
 	dev_set_drvdata(dev, dwc);
 	dwc3_cache_hwparams(dwc);
 
-	if (!dwc->sysdev_is_parent &&
+	if (!dev_is_pci(dwc->sysdev) &&
 	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
 		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
 		if (ret)
-- 
2.34.1


