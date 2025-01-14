Return-Path: <stable+bounces-108611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828ACA10AA0
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B1E1888A67
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625F215ECD7;
	Tue, 14 Jan 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="OdfSXwu/"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E1192B70
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868218; cv=none; b=mOY0nqeSMUJjZd7VWhPuZ2Xzg6bS9466GoQ5dvHMvs93OKjPAcZiQIjCRO8215SUWAX339vvKG5YKl6wG40Xkllc5ZrhZl2UjLEHodwpVrJOhQE90AIEhMpatAKqFbcypViY8EHGPX4I24EXJN4OPRGyVIDCiTL3oseofgAaMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868218; c=relaxed/simple;
	bh=lGKKT65YT/J1OZuDW42KsMza+DKElVbVsU+/tN1zlqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=COG8t7hGDytHyEq36z0nc9rlIyvJIly0rhKr4Q+SkMC0efBYO+C3ibctYKpw9liLth9gtXnO9tL0INuNBAkmBfOOtod03m13Y7vXlID+vUJnQL+vx9uZ7qzaSdEiaqGO8x+JNq0fQtJZt4IZrCTmNvJv1c+5u4Bw+gE2yEPW3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=OdfSXwu/; arc=none smtp.client-ip=17.58.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736868216;
	bh=PyfXevImhm43tCLlxWNyaBzWFsofOvKOTxaHlR/Qr5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=OdfSXwu/URj2CfXXkFw0IZNUwisKBCngAr3JT7TVjTsKWiAkhmjN5aItQeAXigkAL
	 2N8c97iY+Wa2O409dUGj3P49WIDk6DUlMCR1Vv8jlftC+EOKdRVFT41XkuTNj23jaj
	 9nsCYebyhKyyhaNFiCH2f4TGUG8noQOhgyOef5+8WTEwqEs5YsdFjT5lYBAPjFwfnd
	 TcZQaCXEjF0oweeRDcyNStFx9LRVrnbjYkfoNScl+UH6p6rVv+bwMsIfB7BWh69Raf
	 V7st/9dRA0XUKcYhp+oI5s3kQGThKl+VENAvA6ZHqbqEC8MJSocwQFZv7YJalkaYMv
	 MZ7CjAqwIsBSg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 358F2740375;
	Tue, 14 Jan 2025 15:23:32 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 14 Jan 2025 23:23:04 +0800
Subject: [PATCH v5 2/3] of: reserved-memory: Warn for missing static
 reserved memory regions
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-of_core_fix-v5-2-b8bafd00a86f@quicinc.com>
References: <20250114-of_core_fix-v5-0-b8bafd00a86f@quicinc.com>
In-Reply-To: <20250114-of_core_fix-v5-0-b8bafd00a86f@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 4Dhg0ki3FumCfmwtl0VcFP6dtH3kaZz7
X-Proofpoint-GUID: 4Dhg0ki3FumCfmwtl0VcFP6dtH3kaZz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=634
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501140121
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For child node of /reserved-memory, its property 'reg' may contain
multiple regions, but fdt_scan_reserved_mem_reg_nodes() only takes
into account the first region, and miss remaining regions.

But there are no simple approach to fix it, so give user warning
message when miss remaining regions.

Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/of_reserved_mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 17c57118c4960d8ac502add1904f7f464258f5a1..75e819f66a56139a800dba5e2e0044d0bbeb065e 100644
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


