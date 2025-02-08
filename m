Return-Path: <stable+bounces-114406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD4AA2D824
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 19:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA4018887A9
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CD71F3B94;
	Sat,  8 Feb 2025 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wemxk046"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6424112E;
	Sat,  8 Feb 2025 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739041047; cv=none; b=l3U7fNgz+HZar8BMoMA8UUiZzYaT9vFC3kf8+aTZzOxIRVohABjs58NIGkU2PPjsnJ7kEr9p3Y0L8FlE28WWTggFlPXL0AQTxsQKnIV3S0NHUzzn9GWcBvHdk83u++bFk6kFtvuNR957OrsR7tl26HMOsiUpwcpbntkHfFzGzrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739041047; c=relaxed/simple;
	bh=qPXY63DBeTQGwJY7Ves16xpU8WdX3Ym2FjIxTJbkJ2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCglIJAD0k65TiisDqJHAwDhU+1mXchJc9GqX3UA/kewsd7cTnD4U4hxDJuKnjVkNQMjwGvbvbNjonSSYHO4G5H93jCRZej/XkUH6jTQblaiRnaTGM6OmYwTr/2YP1STR18ViJQvQLnbqv5buSDypbjBCrc038CarD8r4cSW0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wemxk046; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 518Hkw5P003573;
	Sat, 8 Feb 2025 18:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=dAiwz
	FDYFkOlClvo655yYrG5GSByibPvwP2kJHr1ZZQ=; b=Wemxk0468JLRC7/q5fXtI
	DNP0v0ZQB1+pkzvmyEWB6pybSh7+NUaB2xA8UTJudMzV6037BB6LqVklKnRIFPfU
	fv5vfau4Kvj6rkGqj7XT05ulQdNp/bzY6e8yxGyyC1K8IMFy90eFSmkgKLY7ywFD
	1X+I2BhNRiNEAAsRD+yUoMrr+3G9cq5EhrpQFnKhibMSoSqw53gPao35M3PLVynt
	J5D5Nu9mDaDqVSlErkzTFsnMaD7w1SkK9IuEkVLnO+iGlz2GNUm+mOLkCZ9mv2Ym
	dfCfnx4yygM9QQhu4hZXWQVy79QVcXMsy6GtV53J7A8YTLEjSYxFr0uyBysU3/uR
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn0e3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 18:57:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 518G5b0D037797;
	Sat, 8 Feb 2025 18:57:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44p62vej2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 18:57:16 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 518IvEgA029223;
	Sat, 8 Feb 2025 18:57:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44p62vej18-2;
	Sat, 08 Feb 2025 18:57:16 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        jiri@resnulli.us, liuhangbin@gmail.com, kuba@kernel.org,
        netdev@vger.kernel.org, stfomichev@gmail.com, shannon.nelson@amd.com,
        darren.kenny@oracle.com, Stanislav Fomichev <sdf@fomichev.me>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.6.y 2/2] selftests: rtnetlink: update netdevsim ipsec output format
Date: Sat,  8 Feb 2025 10:57:11 -0800
Message-ID: <20250208185711.2998210-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250208185711.2998210-1-harshit.m.mogalapalli@oracle.com>
References: <20250208185711.2998210-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502080160
X-Proofpoint-GUID: 2VEGDApJoieo_pA5GhZqYJRNa6hlgZti
X-Proofpoint-ORIG-GUID: 2VEGDApJoieo_pA5GhZqYJRNa6hlgZti

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 3ec920bb978ccdc68a7dfb304d303d598d038cb1 ]

After the netdevsim update to use human-readable IP address formats for
IPsec, we can now use the source and destination IPs directly in testing.
Here is the result:
  # ./rtnetlink.sh -t kci_test_ipsec_offload
  PASS: ipsec_offload

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://patch.msgid.link/20241010040027.21440-4-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 3ec920bb978ccdc68a7dfb304d303d598d038cb1)
[Harshit: backport to stable kernels]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 488f4964365e..855505c40ed8 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -921,10 +921,10 @@ kci_test_ipsec_offload()
 	# does driver have correct offload info
 	diff $sysfsf - << EOF
 SA count=2 tx=3
-sa[0] tx ipaddr=0x00000000 00000000 00000000 00000000
+sa[0] tx ipaddr=$dstip
 sa[0]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
 sa[0]    key=0x34333231 38373635 32313039 36353433
-sa[1] rx ipaddr=0x00000000 00000000 00000000 037ba8c0
+sa[1] rx ipaddr=$srcip
 sa[1]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
 sa[1]    key=0x34333231 38373635 32313039 36353433
 EOF
-- 
2.46.0


