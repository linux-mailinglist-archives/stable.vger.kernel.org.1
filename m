Return-Path: <stable+bounces-98890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6CE9E6290
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69039164934
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575515EE97;
	Fri,  6 Dec 2024 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vS/rPvlR"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15232BB09
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446399; cv=none; b=lxyCNoihjti+U5dLHIPRgFRioKfO6J/+RXyBM31eWYLg2QzXgxmwjvrw02q/afDIFSjvZ0wJ6jlgsGF4hv3+H4Cra73ZeTM1bqIwWSFHBwODjlUDKATBEAuZICASIeMwsBxWpprtI+sV8pgkfEms8rsD7rDnZA3VS+avAjiKKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446399; c=relaxed/simple;
	bh=QNsEWPAUkVVpVRHkibyslz6e/t3LkzhnTAjUDcHXryo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2LiG0S2fTwQGBfauSB1hCeDYM8IcPWxa8k7aZLjh87sYErua+BOShcmlxd5y9SH6H0fwiMExeOYobzwl8zHxp4I4C6YzbJEC/ShsF1DmSqrMBtnLIa2LTZVjzsGc3xR0hJq777UIKm7hqQ4Q9HR2heBhAVtnVqE8IHRJogE1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vS/rPvlR; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446397;
	bh=RWEwv6+w7N1voYBxavX8EFSb/Sf8/2DrEXYvWY7v5b8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=vS/rPvlRMVJdI3sTb6UxqxuUmZkywhQliTgtCNwf9IkCPmEeE+MYVn1rRYh7Ryc87
	 VQSbhHXg14duSX/X8ey6dc51Vd+D2+wj1MWZ3wP7iRGBmyM5J7pwAws6/oZP/iX33Y
	 JkAK4Xwv/H15KmCaM2M+31s0BQ+gf5vz8QWb0GqNGQX9ODlgKCz2fWvhfJSJKmxLJb
	 5/JrmlL4dhCJd0fIT0W/W+lKgHFa7NFgnNN1ZOyxSJZYtfi+fqyzEwueINiy+WJeQk
	 XMZ2/lKhArILdPHpRfnH+3x3xOQlzN73CuVkzCuqPicKJNLmrXI6sVv3wb0eUdKNwX
	 0lz+iI2BBA6Gw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 4E134A02CB;
	Fri,  6 Dec 2024 00:53:10 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 06 Dec 2024 08:52:28 +0800
Subject: [PATCH 02/10] of: Correct return value for API
 of_parse_phandle_with_args_map()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-of_core_fix-v1-2-dc28ed56bec3@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Leif Lindholm <leif.lindholm@linaro.org>, 
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: CmPjX01vzh582m55VjBZWZ-kMxVZ6PMg
X-Proofpoint-ORIG-GUID: CmPjX01vzh582m55VjBZWZ-kMxVZ6PMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060006
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

@ret is used by of_parse_phandle_with_args_map() to record return value
and it is preseted with -EINVAL before the outer while loop, but it is
changed to 0 by below successful operation within the inner loop:
of_property_read_u32(new, cells_name, &new_size)

So cause 0(success) is returned for all failures which happen after the
operation, that is obviously wrong.

Fix by restoring @ret with preseted -EINVAL after the operation.

Fixes: bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a nexus node")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9a9313183d1f1b61918fe7e6fa80c2726b099a1c..b294924aa31cfed1ec06983f420a445f7fae7394 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1516,6 +1516,8 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 			ret = of_property_read_u32(new, cells_name, &new_size);
 			if (ret)
 				goto put;
+			/* Restore preseted error code */
+			ret = -EINVAL;
 
 			/* Check for malformed properties */
 			if (WARN_ON(new_size > MAX_PHANDLE_ARGS))

-- 
2.34.1


