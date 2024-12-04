Return-Path: <stable+bounces-98199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E619E316E
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C476B29A40
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 02:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC60720DF4;
	Wed,  4 Dec 2024 02:31:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF14A1A
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279497; cv=none; b=Ye8pl5IdVumVxWkF1khP3GpqF1lG7coiSfclmJPoD5q/8MlPfb31ZYZFryWf02exKe0hPkHqXH1XnlYzVXLBt+3IBqCovsCYmU0N+tWiY3hCQhF2LL7mzynILmeM0Inz/G0tSto/oNcFxc+yugxEG7i0TTR3Y0l2cT2+LIjWhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279497; c=relaxed/simple;
	bh=TWNvdrWkrN9k8hk+AZ/kJ9jvsNNylEqCMe5p/fRSM9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HOLNVsTVOpeBv+YN/JzflkQ/2myFRf/RslFMONZka7aNT8qQ/ov1F7rJAco08qzPzBifaSBQZrFDZpy82l8JPTpRacul9RhAY1dhiok3JGNP29wdAjeMn7GluwFrRJa8TpUvS2Yzu8VJZOFYEmBiHQIjSHRXHEG3qc16xEv5fIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B41MVvR026057;
	Wed, 4 Dec 2024 02:31:26 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 437sp746s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 04 Dec 2024 02:31:25 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 3 Dec 2024 18:31:24 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 3 Dec 2024 18:31:23 -0800
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <almaz.alexandrovich@paragon-software.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH 6.1.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Wed, 4 Dec 2024 11:29:13 +0800
Message-ID: <20241204032913.1456610-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Qvqk3Uyd c=1 sm=1 tr=0 ts=674fbefd cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=GFCt93a2AAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=fATKHIbVh68Ky4GJMjkA:9 a=0UNspqPZPZo5crgNHNjb:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: DDMigFwQ6WxS07-muSBVQyw0O2Oj1sRb
X-Proofpoint-GUID: DDMigFwQ6WxS07-muSBVQyw0O2Oj1sRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_01,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412040020

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Jianqi.ren.cn@windriver.com <jianqi.ren.cn@windriver.com>
---
 fs/ntfs3/record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 7ab452710572..826a756669a3 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -273,7 +273,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (t16 > asize)
 			return NULL;
 
-		if (t16 + le32_to_cpu(attr->res.data_size) > asize)
+		if (le32_to_cpu(attr->res.data_size) > asize - t16)
 			return NULL;
 
 		if (attr->name_len &&
-- 
2.25.1


