Return-Path: <stable+bounces-104301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F139F2792
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 01:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E7318858A1
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 00:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B444B2745C;
	Mon, 16 Dec 2024 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EvI2/3b7"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B528DD0
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734309682; cv=none; b=XuOfTAHwPiZahLE7+Ydqi3BydzPh/JSZOI9j2rraCQkIpVpzgS/Ba1C2Eb8W1CPpozT7abPegDjjSUlklT4L46RAOJZKu4AcoePEuUWmvfihu9B0+7cIyQMGtQjrbalcczJeEt4PUsbbxFSZK09+faWkcnJ/D/D3QeKL4uQ0o9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734309682; c=relaxed/simple;
	bh=F7VAazrVJ3p7QlbMjlcZ0vd+3ltdvGaw1yJxrtSHdRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDoQeNGofvjKTTBRkHGJP4iR+/cF1uu58O4eWQ5+uqaXeBQzxELZ2+62da4m7mU9wr1zt8xr38rCleYTuqJvH/wrMlh9jMkMyci/uz9iogZYHEEVf9ZyH8Fx9yTeKVrtzxA6oIetTuNEkmW0dz18fOH7ssLPiXelzG1M8KqPKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EvI2/3b7; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734309680;
	bh=1qAwxeqobZh1wxnxdDloQZW9DdsopGVNulsZoYj9sn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=EvI2/3b7vO79Td/eHUfdKoPN87R2WhhuUIUNJBuBxH4WZqajCNVMv3h+IvGnVSD+0
	 SfLHgRrxwTI7SGYGNjswEIi+XqNR+H0IV7GE7sPR5A06PWADZTXMwbOblk6xMAp/67
	 +NVfKQQ8SwaSC5MH7VMtTtRBjFQXwAhOcjZIln4g+gUHiHZ6I/zagzIIfQaBQ6MzI5
	 YExaQxuV0Ve2Jbrkvx9OFeYgjyKiOQRUDJNtT87pWLzzXOIOE7AYiu4jFebwBqhxFa
	 515C4gFGmlIcueerpOE0pCIAh5SGDLE8euGVxAhRV/Zgpci5urNX1A2qyE1bV5TtyF
	 YWZ6kKcMdYHmg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id AF7E4D00191;
	Mon, 16 Dec 2024 00:41:16 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 16 Dec 2024 08:40:42 +0800
Subject: [PATCH v2 3/7] of: Correct child specifier used as input of the
 2nd nexus node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-of_core_fix-v2-3-e69b8f60da63@quicinc.com>
References: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
In-Reply-To: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: -ykJM0NGSyyXqdyLVu9ZY0Qb8rFOwFSa
X-Proofpoint-ORIG-GUID: -ykJM0NGSyyXqdyLVu9ZY0Qb8rFOwFSa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-15_10,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412160002
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

API of_parse_phandle_with_args_map() will use wrong input for nexus node
Nexus_2 as shown below:

    Node_1		Nexus_1                              Nexus_2
&Nexus_1,arg_1 -> arg_1,&Nexus_2,arg_2' -> &Nexus_2,arg_2 -> arg_2,...
		  map-pass-thru=<...>

Nexus_1's output arg_2 should be used as input of Nexus_2, but the API
wrongly uses arg_2' instead which != arg_2 due to Nexus_1's map-pass-thru.

Fix by always making @match_array point to @initial_match_array into
which to store nexus output.

Fixes: bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a nexus node")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index bf18d5997770eb81e47e749198dd505a35203d10..969b99838655534915882abe358814d505c6f748 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1536,7 +1536,6 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 		 * specifier into the out_args structure, keeping the
 		 * bits specified in <list>-map-pass-thru.
 		 */
-		match_array = map - new_size;
 		for (i = 0; i < new_size; i++) {
 			__be32 val = *(map - new_size + i);
 
@@ -1545,6 +1544,7 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 				val |= cpu_to_be32(out_args->args[i]) & pass[i];
 			}
 
+			initial_match_array[i] = val;
 			out_args->args[i] = be32_to_cpu(val);
 		}
 		out_args->args_count = list_size = new_size;

-- 
2.34.1


