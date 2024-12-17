Return-Path: <stable+bounces-104496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72FC9F4BF6
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 14:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5378E175608
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2621F63F4;
	Tue, 17 Dec 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="aeIDAQFI"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62B1F63DA
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440873; cv=none; b=jRu1VM4V6sWI78CG981e7z/vgymwBlHq+Gv73rw8h0k4ydWxaCjQf+Lf0FCtyR3dlNQfomJebP11YtZ0wcdQgCto7fYLMi9VOzERrJ2ZReOSrgkfmPNbGVPT+biCtRBK3jd7FJX7nEaie86r8tLQb7foiGEAxzOUicSpPSj6bAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440873; c=relaxed/simple;
	bh=F7VAazrVJ3p7QlbMjlcZ0vd+3ltdvGaw1yJxrtSHdRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rkzf7kt2iWJ3QrU4QqqkVLhSVbluVVUE9cN7dFYrlPxW5K1+QB9et8vRZB+rW9bewhHoGvDnJhFIO9QX41fPkMb1iz1ymV/lanJL7/GikGM7Ej9Cr5FDa97uFuKlzDO3MzNEoRxJX23qscVkIfWU55eq2TpMIYBNH2inX80NKH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=aeIDAQFI; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734440871;
	bh=1qAwxeqobZh1wxnxdDloQZW9DdsopGVNulsZoYj9sn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=aeIDAQFILvCLmhmo5TYzU1vl+CC1YfeH4lc91AkyjCEu4SUGtlLHuOvM7mIpwYohe
	 SwLce3Y9RPiOOsNJC4U2KKL8FxWenQVjOILiCI+iPX/7pkvpTRbvuYZAqH1a3t/LFf
	 pfh2YRQAtj+VqGsoSuPmtCMovxOPG7eQ7E/TdXfBvx3j47s3zMrOboInlfc8gIZPpw
	 sQPx4cq7uZZuwTYDb5kneZaZZAK4D2pUEHfb8Lwqpa0kaNtiVM9tGlXBWZqdaILvQm
	 +0yJY8SYeenVjLaS1UXRd7gcCfNVtrFbEr1ZmYrceaXxPrQkOYAix4q1ZDyV05iRrs
	 3r/FUBTnz06Mg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 865F796010C;
	Tue, 17 Dec 2024 13:07:48 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 17 Dec 2024 21:07:25 +0800
Subject: [PATCH v3 1/7] of: Correct child specifier used as input of the
 2nd nexus node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-of_core_fix-v3-1-3bc49a2e8bda@quicinc.com>
References: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
In-Reply-To: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: mcreafzY2S92rpbezCZ1gMuaiFrnMRjF
X-Proofpoint-ORIG-GUID: mcreafzY2S92rpbezCZ1gMuaiFrnMRjF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_07,2024-12-17_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170105
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


