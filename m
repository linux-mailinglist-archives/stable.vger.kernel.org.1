Return-Path: <stable+bounces-89497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA8F9B93F7
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 16:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB6A1C2139B
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E01AA78E;
	Fri,  1 Nov 2024 15:08:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D054E12AAE2;
	Fri,  1 Nov 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473695; cv=none; b=hjjrDRHzhPnpWaoRw1OR5LRfqmfQbFrDlpjqgQ6/TnZO43RDO3MqwOsY3dX4mcOXDBLl7VchtZ58OQuMmbk+3dEG3eJe4TFUW6/Hk3jud/nKSwIivoG+yKdauwayToWpC0nPrPs9oMhSzZb4QGJEkC0vrRTf1PXlAWEJz9CpFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473695; c=relaxed/simple;
	bh=Z6Dr2PgbqzIdIWSiIp258pot0TuM6/5gHcxvt7FOJpY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BZImjWGmIj6asMQO1C52EShVmQ1TRhMDLqikZZ+m1kfvz6spXP4MzFm6wTJ4oxH1GNQEiuLmSaFntczmewOtvRv9og3jyiPQ+sonGE3NW2htuyWQc2Z5zMGpMBOLrMYOEE0zekIvn4XZarOIR8NO96FoX+Q0qVVTiXD5HazKkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A18jBJp023074;
	Fri, 1 Nov 2024 15:07:49 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42mf2e934y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 01 Nov 2024 15:07:48 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 08:07:47 -0700
Received: from pop-os.wrs.com (172.25.44.6) by ala-exchng01.corp.ad.wrs.com
 (147.11.82.252) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 1 Nov 2024 08:07:46 -0700
From: <Randy.MacLeod@windriver.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <sashal@kernel.org>
CC: <sherry.yang@oracle.com>, <bridge@lists.linux-foundation.org>,
        <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <nikolay@nvidia.com>, <roopa@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <randy.macleod@windriver.com>
Subject: [PATCH 0/1: 5.10/5.15] net: bridge: xmit: make sure we have at least eth header len bytes
Date: Fri, 1 Nov 2024 11:07:44 -0400
Message-ID: <20241101150745.3671416-1-Randy.MacLeod@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=K4dwHDWI c=1 sm=1 tr=0 ts=6724eec4 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=eMPNgDwjIQXpT8XC:21 a=VlfZXiiP6vEA:10 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=owxRARuu7T3lYmZcKXwA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: BE-Q3zTQ4R7TRNS4izKP4odOP0PX-KoJ
X-Proofpoint-ORIG-GUID: BE-Q3zTQ4R7TRNS4izKP4odOP0PX-KoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_09,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=993 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411010109

From: Randy MacLeod <Randy.MacLeod@windriver.com>

This is my first commit to -stable so I'm going to carefully explain what I've done.
I work on the Yocto Project and I have done some work on the Linux network
stack a long time ago so I'm not quite a complete newbie.

I took the commit found here:
   https://lore.kernel.org/stable/20240527185645.658299380@linuxfoundation.org/

and backported as per my commit log:
   Based on above commit but simplified since pskb_may_pull_reason()
   does not exist until 6.1.

I also trimmed the original commit log of the "Tested by dropwatch" section
as well as the full stack trace since that may have changed in 5.10/5.15 and
It compiles fine for 5.10 and 5.15 but I have not tested with dropwatch since
the patch is just dropping short xmit packets for bridging.

Finally, since the patch is much simpler than the original, I've removed the
original patch author's SOB line.

Please let me know if any of this is not what y'all'd like to see.

Randy MacLeod (1):
  net: bridge: xmit: make sure we have at least eth header len bytes

 net/bridge/br_device.c | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: 5a8fa04b2a4de1d52be4a04690dcb52ac7998943
-- 
2.34.1


