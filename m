Return-Path: <stable+bounces-100102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C229E8BD2
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 08:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC477163DCA
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 07:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9F42144A5;
	Mon,  9 Dec 2024 07:08:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180D1EB3D;
	Mon,  9 Dec 2024 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728085; cv=none; b=m0PPd/IQ4Vhjqd9ivbw1w4ViSWx7NNYZIWeRjAw6PDPq1Mh86tAxdYKmqAjwfH1LejDZwaVbD+kaXViOwMenCFqf3zbrDoWVoZ3xA5BuMFvR37DCKAVxGFTBun+//YtNuThldUkcK4KKKU8cgMpo6yc1OWjFUZi4XoWVAWdHvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728085; c=relaxed/simple;
	bh=a3K64jJA2uqJMe1HS7E60k7y1DffRW1euJVCcFm1q9Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AWLlm0upmDm1i58Py2ryPVWWLAxnTK+iXG0C3vOosH4sQ4Jb6P4qObuUq3uO7mAl9QGm6JOvcGbB6Dr2WVRsFo0QQg0HAxDDoWWr+QPNwvgY/LPOeKHcjuEnwEZrmKFqFg3Abs1edNEIu3K64THmVTfRlBmY/SnQgAUV46a1dRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B95TvkO012069;
	Sun, 8 Dec 2024 23:07:51 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx1u12sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Dec 2024 23:07:51 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 8 Dec 2024 23:07:50 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 8 Dec 2024 23:07:49 -0800
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <almaz.alexandrovich@paragon-software.com>
CC: <stable@vger.kernel.org>, <ntfs3@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Mon, 9 Dec 2024 16:05:41 +0800
Message-ID: <20241209080541.3541969-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H/shw/Yi c=1 sm=1 tr=0 ts=67569747 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=RZcAm9yDv7YA:10 a=GFCt93a2AAAA:8 a=t7CeM3EgAAAA:8 a=fATKHIbVh68Ky4GJMjkA:9 a=0UNspqPZPZo5crgNHNjb:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: _qr2igixvVPsItVcCOxlYaUVZREp9f7U
X-Proofpoint-GUID: _qr2igixvVPsItVcCOxlYaUVZREp9f7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_04,2024-12-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412090055

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


