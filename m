Return-Path: <stable+bounces-100312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872929EAB07
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4EB282134
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0857E2309AA;
	Tue, 10 Dec 2024 08:52:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92412DD88;
	Tue, 10 Dec 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820719; cv=none; b=YrLFoA7aEAOFyPCRJRB6wIbJZAUuthdBYb+SPaQVCiHGUPvIX6k96+dMQxakgBHM74gJsP8eqzOHthoX/1o3PC0sLQ1Qq9xGJ3tcZ8XVICrjEA1XBg1eQlywQDnpLfVDXBlvrtGaEjDtHYo0BPnDKpIh2NBcLilOAKTxc9noDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820719; c=relaxed/simple;
	bh=DpAHoxvmiwXP/aLXfZTq3taee0LbmccDW5qzfUr5CbU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VXzHtWzY/XQPdbtZJgJ0DkCHo07tVQB/C/16YR8e3LxEVQeT0AJFlw0k8x5VXPyrO8UN5VLUGpzu6Cw0SnVPy6+5xdkdVrJZe7yGM1Wyds0Y9L8rooZWljLSmWBvhn0HKCLKmvwfjFDRdrIOfQxmpsykDbNusoAlGrfluGcB3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA7cpv7020865;
	Tue, 10 Dec 2024 08:51:53 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3jfef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 10 Dec 2024 08:51:52 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 10 Dec 2024 00:51:51 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 10 Dec 2024 00:51:49 -0800
From: <jianqi.ren.cn@windriver.com>
To: <jianqi.ren.cn@windriver.com>, <quic_zijuhu@quicinc.com>,
        <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1.y] driver core: bus: Fix double free in driver API bus_register()
Date: Tue, 10 Dec 2024 17:49:42 +0800
Message-ID: <20241210094942.408718-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qqLo1Nwzfgq8qnJH6Fqj0f_Oc7QdtbVj
X-Proofpoint-ORIG-GUID: qqLo1Nwzfgq8qnJH6Fqj0f_Oc7QdtbVj
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=67580128 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=6aJXbah9MAW0KMSe_ywA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_04,2024-12-09_05,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412100067

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit bfa54a793ba77ef696755b66f3ac4ed00c7d1248 ]

For bus_register(), any error which happens after kset_register() will
cause that @priv are freed twice, fixed by setting @priv with NULL after
the first free.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20240727-bus_register_fix-v1-1-fed8dd0dba7a@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Using bus->p instead of priv which will be consistent with the context ]
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
---
 drivers/base/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 339a9edcde5f..028e45d2f7fe 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -853,6 +853,8 @@ int bus_register(struct bus_type *bus)
 	bus_remove_file(bus, &bus_attr_uevent);
 bus_uevent_fail:
 	kset_unregister(&bus->p->subsys);
+	/* Above kset_unregister() will kfree @priv */
+	bus->p = NULL;
 out:
 	kfree(bus->p);
 	bus->p = NULL;
-- 
2.25.1


