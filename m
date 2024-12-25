Return-Path: <stable+bounces-106097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BABD9FC39C
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 06:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5211884323
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 05:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF6200A0;
	Wed, 25 Dec 2024 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LNulTn4u"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D38836;
	Wed, 25 Dec 2024 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735103822; cv=none; b=bcGe42bV/KL9S7snLgqzTynGrl12uQE5DNHkE0m1NBf2yNPwIlflwDcGoFc7zBj3jHI91+VPchnwl/86fqA8Onkc7iiYRgZC6dZHHhZKjoS+lH85OxdfG+ll7vz2NIeqtRPxuHLIMo4V4TYcNU44Zf1ti3tU3CcJX1YvaFXpS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735103822; c=relaxed/simple;
	bh=neM9CqkIOQmi4+Q195wR3+MOhoV5TVUMasCHhkQHfzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDivuUPLOK7O3q7U3PfOYNBZsqOn/wDGfOR3gtuwcfFkZwk4dP7Z4uFg44rG44vPkhX0y/6Qmoq/7KmyFkXT88f9zWBCTxmR4MxxI10bZV/bRVBDPUqmTWKqZzt2uEuIZKAGBefdF4MFbDVXQ7bIMlzEb9rF7JaQ37ZmFAHd2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LNulTn4u; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BP3tcAl002325;
	Wed, 25 Dec 2024 05:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=RKXLC8uSozWn24DyCkWgtXJT3hb7i
	8aTsBJI9RKlMCg=; b=LNulTn4udc3pmuTzhvC5Qal3GdFNH+fBP35+lvYEOpy1t
	YzigWIkgNG+VR3WxC0uY3Fm4pyBzZSG+ZWe4DzvGnzqTFu0MJOFIyRWDzlLWRUDp
	Yid9vevfBZnCd2IHGpArgGUbv5S5n9Exihi46uht7co6aV6rHmOm5a4jojFEzp0O
	A9klGk5wSEp/13Ht0qpdzJ+8LemMXbvYT7SkimYAtUA+Y//wE+zqiEAs37jeBNJz
	xu1e4gmAa/SU8XY48+6Y4YOL27H+dV0xbyCr2bwzahGzlY+yowTALMG1cYLg3+GK
	EkANh3LR5brsGxRgTSJho4WpdI8afOSsPhqnKQyPg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq6sd2qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 05:16:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BP1UZUH000937;
	Wed, 25 Dec 2024 05:16:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43pk8ucjr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Dec 2024 05:16:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BP5GPg4035712;
	Wed, 25 Dec 2024 05:16:25 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43pk8ucjr2-1;
	Wed, 25 Dec 2024 05:16:25 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        kuba@kernel.org
Cc: harshvardhan.j.jha@oracle.com, netdev@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 5.4.y 5.10.y 0/4] Backport of CVE-2024-44986 fix to stable 5.4 and 5.10
Date: Tue, 24 Dec 2024 21:16:20 -0800
Message-ID: <20241225051624.127745-1-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-25_01,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=733 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412250044
X-Proofpoint-ORIG-GUID: FeITE8uRUdYDJiv3DOkjpvOfiIB_MfuJ
X-Proofpoint-GUID: FeITE8uRUdYDJiv3DOkjpvOfiIB_MfuJ

Following is an attempt to backport fix of CVE-2024-44986 back to stable
5.4 and 5.10. 3 extra pre-requisite patches were required to introduce
the skb_expand_head() function and use it in ip6_finish_output2() for
the fix patch to be applicable.

Eric Dumazet (1):
  ipv6: fix possible UAF in ip6_finish_output2()

Vasily Averin (3):
  skbuff: introduce skb_expand_head()
  ipv6: use skb_expand_head in ip6_finish_output2
  ipv6: use skb_expand_head in ip6_xmit

 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 42 ++++++++++++++++++++++
 net/ipv6/ip6_output.c  | 82 ++++++++++++++++--------------------------
 3 files changed, 74 insertions(+), 51 deletions(-)

-- 
2.46.0


