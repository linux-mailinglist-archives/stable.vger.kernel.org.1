Return-Path: <stable+bounces-114408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93752A2D828
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 19:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DABB165923
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D847D1F3BA1;
	Sat,  8 Feb 2025 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ROWo4Sp6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3846015098A;
	Sat,  8 Feb 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739041095; cv=none; b=BjT5Z8h1i3/rfWjNHLs4N8Z2bMRxcEjfdIdlY2f57Y9scEKYCLGdUi8CtD96rDY4E4AWgLm5AUsntUvQNs9GJvNRB3EWjVgc+Ag8dzktyZXRE+nA+CXLw+MUO01rtyJ9nc4wbXWEOoW9QyAbTgB0RHUKhDkUMFXIEI455/vbHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739041095; c=relaxed/simple;
	bh=QPw/tufNCFipVmsdv1e3sXTWfU4aMyQrNWI0/6GC4Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkpAykZujVDMV9/NMAITDWEFzM+sLpuoWJpom5CNLH/yXZKvt3UXMJBcB+y5Wcr6Dff93G3eAyhZyKUhJ1hw3pfKNen3l0BkfE/qnpJlY+BzZSdRtuS1avBQk4ZmPmpMO+7sHoEP2fNzo/y0zold7klb8NETKT0Ts8WS9dZQeA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ROWo4Sp6; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 518Fslqs005161;
	Sat, 8 Feb 2025 18:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=jezfX
	q91rX7vzpsdyLM3jNK64iAOMhsPSU8cNBWupxk=; b=ROWo4Sp6MnmirYnXRIujQ
	WD5jjQ26kBbV4fgyKSTaTlBhbLDFUKXRy8Usv8Ju/uuIIYhEVqnqolkGLc7YNJD/
	cFPYVOwNo4Ft8nNQM0fJ5UUmH6tABLATlD2PoF3haRT09j2ZCgKtzjlSsYiReJVQ
	htwRcz0mnFHfVCeVlQkpbiu+yjx0AtizrogtzBGJZsna6s1XdL+3wXPqSrsAaPJW
	clFbpX7QEgd3e6bS9TD4wlqRv6rinzIbcpr+DrwIpBwHi+Ak6qxVe2uEjbssiGBL
	SLLE2toyvRp6LXMLBEYZKIjLr3BzqnQm/6dOy1ZAbT/B1wih9sSzeDtQthapv5HV
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q28enw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 18:58:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 518E5DsY017845;
	Sat, 8 Feb 2025 18:58:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc7xbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Feb 2025 18:58:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 518Iw0gY035363;
	Sat, 8 Feb 2025 18:58:04 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44nwqc7xap-2;
	Sat, 08 Feb 2025 18:58:04 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        jiri@resnulli.us, liuhangbin@gmail.com, kuba@kernel.org,
        netdev@vger.kernel.org, stfomichev@gmail.com, shannon.nelson@amd.com,
        darren.kenny@oracle.com, Stanislav Fomichev <sdf@fomichev.me>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.1.y 2/2] selftests: rtnetlink: update netdevsim ipsec output format
Date: Sat,  8 Feb 2025 10:57:55 -0800
Message-ID: <20250208185756.2998240-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250208185756.2998240-1-harshit.m.mogalapalli@oracle.com>
References: <20250208185756.2998240-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502080160
X-Proofpoint-GUID: 3gvB2-l5oX1-hjih41LvIHMTpE1iwVVe
X-Proofpoint-ORIG-GUID: 3gvB2-l5oX1-hjih41LvIHMTpE1iwVVe

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
index cafd14b1ed2a..ff1242f2afaa 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -813,10 +813,10 @@ kci_test_ipsec_offload()
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


