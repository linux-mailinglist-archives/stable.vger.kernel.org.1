Return-Path: <stable+bounces-100585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC8E9EC882
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 10:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2487D18839B2
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C8D2210D0;
	Wed, 11 Dec 2024 09:10:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480C1F8691;
	Wed, 11 Dec 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908244; cv=none; b=rhz1ff35IpdCxdQ6y/hVwfwb5V9Is8lFZpEtbr1lcs3dD248phTl8Jx+RtHO6tNE2kFFjTnpIZ2IXqcdC+OQNGPUtknr1KOq4lQ6c20oB4PY+W2iTmG/AW9CBX68dYDDDtYJu5y6UpsNIG4xAhXd0U/Rj05Nnn0RsXnptZoABiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908244; c=relaxed/simple;
	bh=a3K64jJA2uqJMe1HS7E60k7y1DffRW1euJVCcFm1q9Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SP5lqzRclCyl2URuna+ixTwFoMO8dfmBwAb232XvNKwWuXFy5vq46Ek0FKKo6pit+sX1vK8r1ecBbY4FeMPg5NbuhWLIpeD7ZkYnE13iTh/PsnyT4D7a6/OQ3EcFaF0AtrfuETkL1CHjIyreA3d4V0+M4mE8S302jGcWXaGPjic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB5lpTm000975;
	Wed, 11 Dec 2024 09:10:21 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3kysv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 11 Dec 2024 09:10:21 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 11 Dec 2024 01:10:19 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 11 Dec 2024 01:10:17 -0800
From: <jianqi.ren.cn@windriver.com>
To: <rtm@csail.mit.edu>, <gregkh@linuxfoundation.org>,
        <almaz.alexandrovich@paragon-software.com>
CC: <patches@lists.linux.dev>, <stable@vger.kernel.org>,
        <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Wed, 11 Dec 2024 18:08:11 +0800
Message-ID: <20241211100811.2069894-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5NpboHxqjj25SPvjgNMWaF6Wh2cWABDp
X-Proofpoint-ORIG-GUID: 5NpboHxqjj25SPvjgNMWaF6Wh2cWABDp
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=675956fd cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=GFCt93a2AAAA:8 a=t7CeM3EgAAAA:8 a=fATKHIbVh68Ky4GJMjkA:9 a=0UNspqPZPZo5crgNHNjb:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_08,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110068

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
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


