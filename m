Return-Path: <stable+bounces-108116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE6BA0776E
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A493C3A8AEE
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A571821A94D;
	Thu,  9 Jan 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="P404Aq6D"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1708E219A81
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429350; cv=none; b=QjkokCaKlTCLEgP+uR3Evywl3bDVTLUOX1hUdwgtoG/aBSd+5EliD7Ce79k5FGGy1r4EC8aAp4pFaNUJgEBOkPrfYNL52taVer7tqfX95jzYfpywlMc1Cxi1cAC58deYfVtIkAAMhKLOP2jM1vMb37GA3w92APXcSu3YqqBfyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429350; c=relaxed/simple;
	bh=3gkUALn9+NB6/ofCJz/GwddV8tFmIWMBEl64x6rz1hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vv5wj3sO7TbMJoPYmTQwthyzZ4s3I72L9CK8etdEmspOd6Y30eRztdTemQMs/Og/vk5QzCIodj16gbwzqZlZPub8jENcG3JLsxO34syhkCyRyTMDjhh5TD6fmzi6Q8wCU3aybRL3EpKkhQWHetT95bypvROSjEjnpj+Yo32th0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=P404Aq6D; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736429348;
	bh=RM7PGJ/ggDBiewYKpe35tdRJkSx6Q2TZ8sgtiIjl2gk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=P404Aq6DqSgs1Gm2pcazDfNJ+D1/mWNHALSDB9Tf5lZfBIu1gk4v1adk/SMwEESZW
	 QzcV9DFxeNUW6lZZQKm1p894HV4xI7hicaGiaKDBjav8v5e4+3pwuV5jgaosA7aCMB
	 TvezfoDp8w8aYhjbcw9sNWieXj7Jw8//AWes8kzOemcGXF0Fz4DOh09q6+iH3ZueOn
	 +2BJcHXKc1kPAF7EkwCENv0LHbPlmDWDO7jfq0ByJqujgVuX9NzQU2p1MHT5tS2z11
	 x9XP6zlJ5B0xXoT++W/Z3dF7cAAOjorefXGEiYCRlIiZeauQz4u8na73wVm/bhhPYJ
	 VEInCwsm6VHag==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id DDDB834BA8E0;
	Thu,  9 Jan 2025 13:29:02 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 09 Jan 2025 21:27:02 +0800
Subject: [PATCH v4 11/14] of: reserved-memory: Warn for missing static
 reserved memory regions
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-of_core_fix-v4-11-db8a72415b8c@quicinc.com>
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
In-Reply-To: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>, Marc Zyngier <maz@kernel.org>, 
 Andreas Herrmann <andreas.herrmann@calxeda.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mike Rapoport <rppt@kernel.org>, 
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Sx2HeXIt3f-tKm-aNM272E87DfxWy3af
X-Proofpoint-ORIG-GUID: Sx2HeXIt3f-tKm-aNM272E87DfxWy3af
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_05,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=651 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501090108
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For child node of /reserved-memory, its property 'reg' may contain
multiple regions, but fdt_scan_reserved_mem_reg_nodes() only takes
into account the first region, and miss remaining regions.

Give warning message when missing remaining regions.

Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/of_reserved_mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 03a8f03ed1da165d6d7bf907d931857260888225..e2da88d7706ab3c208386e29f31350178e67cd14 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -263,6 +263,11 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 			       uname);
 			continue;
 		}
+
+		if (len > t_len)
+			pr_warn("%s() ignores %d regions in node '%s'\n",
+				__func__, len / t_len - 1, uname);
+
 		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
 		size = dt_mem_next_cell(dt_root_size_cells, &prop);
 

-- 
2.34.1


