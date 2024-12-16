Return-Path: <stable+bounces-104300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229619F278D
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 01:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CF5164FFE
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 00:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF117993;
	Mon, 16 Dec 2024 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tUOSUB/Q"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1917597
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734309673; cv=none; b=jOcuzLYCWILts9WFstovQRR1djW/reJKXmM5g156iAVPiotE6semxYQoL/wZKYKinSH8Ku22NYszCnU73SqtPjND1jwyqF/eaLGPTP6zql7CJ2jt1kp6Mv/hDivGzeNEYAziSCAtpu1qNWaA6kFFz+eyy03gHXotLq5cl9TLNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734309673; c=relaxed/simple;
	bh=bW7CnirDx7zej4qtmPVX70ePmhN8Fwa34XfzNhqJIgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsK19lQY1FHocsTRUKltreQNRSAUIpMcLQw0TieewTbesiMkTMQ88v5bM8wRb/5hFagKYqe0SKCnOH39nSYeWlGJ6DUjYzlvDLBNMAfz+NR7Jvho1eAVJ0I5SyfaTqWl9HVzlr8bGvKNYoUsXdM1IkUn9rjSlrT9wo62/am6o9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tUOSUB/Q; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734309671;
	bh=fS1N4Pd37szoJLeCtWm7wLGDRu5IJW7gYY3s1rjRIUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=tUOSUB/Qtm1vG+NycGLcSdyErM2mxAoB4ldYO5hYpjeA33dP32KfxulWJVE/bTdU3
	 I5FB9CCucEZ2SEUbH4wEgqvNluAd0GPVvmhqdq69kyfsBvZWaEiqkT4k8SUgg8eEWF
	 Xko7Czd33lo1gx+W2CtqYUQWQ/jgYFIxtca/L4ezZYLX4DeiH/s+jSU6gxoMGFQbJH
	 TukbvbtalBNvL+FL7/5QKNmFsHr+BiJgLv3JjhovA+LJXJynSVZRHextc3HM/QV0da
	 b8lS1GxUzwOyuollJizVqXTzPFmt13xXimvywsX1OHVbNMe+tBqPI6Gt3D6gyDbAf6
	 B6paJLRWV0NdQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 95BCED00191;
	Mon, 16 Dec 2024 00:41:07 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 16 Dec 2024 08:40:40 +0800
Subject: [PATCH v2 1/7] of: Fix API of_find_node_opts_by_path() finding OF
 device node failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-of_core_fix-v2-1-e69b8f60da63@quicinc.com>
References: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
In-Reply-To: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: -XcEA3KUb7_IsMMnXqimvOsx4-FGHuwF
X-Proofpoint-ORIG-GUID: -XcEA3KUb7_IsMMnXqimvOsx4-FGHuwF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-15_10,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=952 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412160002
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

API of_find_node_opts_by_path() fails to find OF device node when its
@path parameter have pattern below:

"alias-name/node-name-1/.../node-name-N:options".

The reason is that alias name length calculated by the API is wrong, as
explained by example below:

"testcase-alias/phandle-tests/consumer-a:testaliasoption".
 ^             ^                        ^
 0             14                       39

The right length of alias 'testcase-alias' is 14, but the result worked
out by the API is 39 which is obvious wrong.

Fix by using index of either '/' or ':' as the length who comes earlier.

Fixes: 75c28c09af99 ("of: add optional options parameter to of_find_node_by_path()")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d2d021f7cf5809b6e765c14911bda0df55f36ca9..bf18d5997770eb81e47e749198dd505a35203d10 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -893,10 +893,10 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
 	/* The path could begin with an alias */
 	if (*path != '/') {
 		int len;
-		const char *p = separator;
+		const char *p = strchrnul(path, '/');
 
-		if (!p)
-			p = strchrnul(path, '/');
+		if (separator && separator < p)
+			p = separator;
 		len = p - path;
 
 		/* of_aliases must not be NULL */

-- 
2.34.1


