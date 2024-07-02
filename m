Return-Path: <stable+bounces-56358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9AD924170
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 16:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3BB2862EF
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA141BA87F;
	Tue,  2 Jul 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UBBFXPki"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3CB1B581C;
	Tue,  2 Jul 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932010; cv=none; b=rrItmpM+8SSzpizwZO06S0bXbXi3JV/XZMKvWDLCwnSsAe2KJ43c4b2KFIOJQ9ZDUC5+BXjIbqQKVMhxmnccuOJqakjMW89nQnsBDEviCpN7I98O1jdl15JTC57cgKhRpeqLtd7hqHhIhv3e4t62jh/aEcBPoS3xArha5xjH9+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932010; c=relaxed/simple;
	bh=b/1dUwC6RKrgPfMKrd9Jt4y4dSvrS1/lDZs7JH/wD+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hn4hhALFDdpNaTxZmNTEwOFvZidUMogZzc8F++rpJKZTsWRZY/lXUww/4qNfs0Yyzp7OmBm0ctbx02q+hx22PlYdvhzieUjXqDkxW7YEzevq+Ahh4/DddxRKEsAGzmI/Ez7gGOykBVH6bdozmB1MP4H8lvA9BwNTYlgVmvXoHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UBBFXPki; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462EVBev028802;
	Tue, 2 Jul 2024 14:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p8scXDmGAH0jtAF/6OgbD0Eo
	v/EYHKGkXAx07XvDz9E=; b=UBBFXPkigAxj+ZdgjL1fDmwJfe6Nxgb0iiQLlxKz
	C0n6xG2C3ekBBaa9wSbUqbR0vP1SJsLjj9sFQP8wXQtPAo9q9PrkwykoRy25ymb/
	SonWDOWxw1OLp06DHkH/h46PP+S5/nTeRV+axir7UdMFUQrPktZXcXQNdJ6BGJST
	LmRPyMc75QyzcnOLdykHl+L3w2svSl9xdcaXSVPwPP0lY/1JZjeLepL0wKtuL5O9
	aHAYsNljqIXcyhM8mqe/E6R3HHsQC2rKeRGZ008o0xCW4NQ3VKnTBwilXpFg63AO
	v5w5sptggcgHQv1o41dE5yvM213ZeGyLEoTe/L5dl0ptkQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404kctg521-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 14:53:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462ErHrA014775
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 14:53:17 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 2 Jul 2024 07:53:15 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <brgl@bgdev.pl>,
        <madalin.bucur@nxp.com>, <davem@davemloft.net>,
        <andriy.shevchenko@linux.intel.com>, <stable@vger.kernel.org>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
Subject: [PATCH v1 2/5] devres: Fix memory leakage caused by driver API devm_free_percpu()
Date: Tue, 2 Jul 2024 22:51:51 +0800
Message-ID: <1719931914-19035-3-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1719931914-19035-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1719931914-19035-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7tqcNHbKDwUGOLeGRAzPKXpwVtUtEtWs
X-Proofpoint-ORIG-GUID: 7tqcNHbKDwUGOLeGRAzPKXpwVtUtEtWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_10,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=503 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020110

It will cause memory leakage when use driver API devm_free_percpu()
to free memory allocated by devm_alloc_percpu(), fixed by using
devres_release() instead of devres_destroy() within devm_free_percpu().

Fixes: ff86aae3b411 ("devres: add devm_alloc_percpu()")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Previous discussion link:
https://lore.kernel.org/lkml/1718804281-1796-1-git-send-email-quic_zijuhu@quicinc.com/

 drivers/base/devres.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index ff2247eec43c..8d709dbd4e0c 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1225,7 +1225,11 @@ EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
  */
 void devm_free_percpu(struct device *dev, void __percpu *pdata)
 {
-	WARN_ON(devres_destroy(dev, devm_percpu_release, devm_percpu_match,
+	/*
+	 * Use devres_release() to prevent memory leakage as
+	 * devm_free_pages() does.
+	 */
+	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
 			       (__force void *)pdata));
 }
 EXPORT_SYMBOL_GPL(devm_free_percpu);
-- 
2.34.1


