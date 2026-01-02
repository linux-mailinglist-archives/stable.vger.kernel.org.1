Return-Path: <stable+bounces-204509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7852CEF50E
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 21:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D927D3012779
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848352C026E;
	Fri,  2 Jan 2026 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lebXm93K"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A126A0DB
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767386271; cv=none; b=heEiHfvtW4/1fqrj08yLZ+VtQwH9Bx5R1zOOq4/cMr0i169dphwhuCni2yUhdrFoEYI2/7BaTh1XR+OOc7lsVQYSWn3Jf1K1VqSYH4o8h9IZPbOaJcBrWOAKLDjuDIPe3wUz+xiD4T/6fyCLHZS8hJ5SYmP8Q+QpFRHwaQHQyY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767386271; c=relaxed/simple;
	bh=EW3Zs2S0WW7uhH++W6WPba/03hpfx3fmT6x1LxFnwiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzv+OcrUN0ZNKO5wEqf6mcRqjc/vMH2fGwrenX1FHOVLDsGZZ3v471pxIqc6SKf8sPMRAVkHKK9ZIrJKnLCi3d9tfe+1Yoe7IebJFzUfPMKdYkB0FUZc9gRwqHV5fPN7bru/+1LFVTiVQDNOqfdFyvozZzfTOjsSRIM9MPYPPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lebXm93K; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602Bv1u02742270;
	Fri, 2 Jan 2026 20:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=F6SH5
	xykTEAy4Q5oFN5+PhX94oAgTLTHLQ1rt4B1XaE=; b=lebXm93KExQ3tu4+vQSsL
	8BXH4AZdFaIlKWLwhLONCM0D4148QyksM4cKj1WdiRuqd8ukyyx+CwJ7CeIagWR6
	AMqcflzfhYNLXO1ZZx3gNp8OmRj1I9l93rE12/FIh6AjMDnKZ55Fjcna5F05OeIl
	bY7yvFOdJEsRCfa/rvVcBxHJklrUM6XxAHgs+Ld7VA5f/b/D9StUVZ8a5EXqbusM
	E7Sx30fjo/f96mYTLct45HrJhBO3c5grkZ8smwHFja8cFPzBiQ9+EC0vlx2H984P
	mqPtyezUXZkm0sWV1+5V/JvuHCJnxKg3T1gLPEpRXrzb6MO9cn5D4PAolIGzyTHz
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba80pwe5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 20:37:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602HMRHI022820;
	Fri, 2 Jan 2026 20:37:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5wa66hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Jan 2026 20:37:40 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 602KbZ4X025726;
	Fri, 2 Jan 2026 20:37:40 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5wa66fb-3;
	Fri, 02 Jan 2026 20:37:39 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Xiao Ni <xni@redhat.com>, Coly Li <colyli@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 2/7] md/raid10: wait barrier before returning discard request with REQ_NOWAIT
Date: Fri,  2 Jan 2026 12:37:22 -0800
Message-ID: <20260102203727.1455662-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260102203727.1455662-1-harshit.m.mogalapalli@oracle.com>
References: <20260102203727.1455662-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601020184
X-Proofpoint-ORIG-GUID: IPDk3Pr4QY4VY_M3Q8Odh5sKsnZ9gGOm
X-Proofpoint-GUID: IPDk3Pr4QY4VY_M3Q8Odh5sKsnZ9gGOm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4NSBTYWx0ZWRfX8aRRnqBYYcAw
 Xz7VgRxYpvtLthkbtlZYBXQ8rQNJ64g8lpDJeAbKX9KCM4U7T2/ICptgJpT1zJkZeq6s2yhBTJ1
 8SbPotUuwyDN0bKtkCRQeCMck4ZWwI1mn2mafjO9CBxGphlGBayRl/bSd2iGSu86RujMWQtzngz
 ETuRRRHyvhhyJu+FmGBuP5vf5RZs5guxu2WYg0/VqgxAKCDPvrEw0UnWFt4Fv6km6UFdw4sOmAh
 HvVVVyAy/6twjcbp+RR4MgiqiE50gaLUItQ0xp2TH1jCbgWhRR5cdNSOn0n5fazSKaDsIKpjKZP
 Xk8rg3UBuv6nTbjRI/0WPLoR+J+TVDAn4/90kwW7AsTdoqYb87jVVNmK3MiDjauGjI09Xk0BXh1
 LW6dlStfRDeFdJu52CzLorwz7sLJ9/iieB1J8XTP6AYS1wOoNuyabqtlicLR/v5wO1l2RpvVaHL
 e9/HgbjZYPr/Yl4FbwA==
X-Authority-Analysis: v=2.4 cv=RY2dyltv c=1 sm=1 tr=0 ts=69582c95 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8 a=WcisHBGqHJXTRc9MLVAA:9

From: Xiao Ni <xni@redhat.com>

[ Upstream commit 3db4404435397a345431b45f57876a3df133f3b4 ]

raid10_handle_discard should wait barrier before returning a discard bio
which has REQ_NOWAIT. And there is no need to print warning calltrace
if a discard bio has REQ_NOWAIT flag. Quality engineer usually checks
dmesg and reports error if dmesg has warning/error calltrace.

Fixes: c9aa889b035f ("md: raid10 add nowait support")
Signed-off-by: Xiao Ni <xni@redhat.com>
Acked-by: Coly Li <colyli@kernel.org>
Link: https://lore.kernel.org/linux-raid/20250306094938.48952-1-xni@redhat.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
(cherry picked from commit 3db4404435397a345431b45f57876a3df133f3b4)
[Harshit: Clean backport to 6.12.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/md/raid10.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b0062ad9b1d9..a91911a9fc03 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1626,11 +1626,10 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
 		return -EAGAIN;
 
-	if (WARN_ON_ONCE(bio->bi_opf & REQ_NOWAIT)) {
+	if (!wait_barrier(conf, bio->bi_opf & REQ_NOWAIT)) {
 		bio_wouldblock_error(bio);
 		return 0;
 	}
-	wait_barrier(conf, false);
 
 	/*
 	 * Check reshape again to avoid reshape happens after checking
-- 
2.50.1


