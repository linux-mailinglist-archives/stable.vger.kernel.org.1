Return-Path: <stable+bounces-155641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818EDAE430A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C40318994C0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86695254B1F;
	Mon, 23 Jun 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lF1Q7iHq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9523A9BE
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684957; cv=none; b=o3vxTrgoihfdKUbr0HuW5IfqLhp4Q4i16ozvuH4hI8lqI8xGhC9JfVXvFUAaK5/bXgNR1NyJG0jD2V2Z2qpRtd9Am4EgfLl7VkX85tbqV/Kj29hU6Y/vvBBWPxPJnta8DPxX5CmoOdo31L1MfYxZrzoDCdEkS1oLNrGipaFc9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684957; c=relaxed/simple;
	bh=jBvLyQc9FV6Eeu10RFw+eU8fJCwh2eYNT1nmcOGlerA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NOhCfjgCXADE2ioagnEP8ia7613ODVBDm5RBfFNrarWJMgfhN5dM1YRRjmKZHIeQVKQUbrkkNGoLEnVEsRXDRwtpqvx/HpFLWxI8UXP9pgENwLiYxOYZzgXKve+H71JJ7AkOAlGOa2yam9T7kylDaxn4AyNZEFE1lYXIh3V8jag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lF1Q7iHq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9VRoO029832
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rznEHuI2XuSgv/8CBLTTfiQh8RCFbWIx5rfAY6qfH
	UQ=; b=lF1Q7iHqO+xK+VQny2fGjputpQGXiCE1aIFr/0RVZhmVj74DFlD+w6JhZ
	02XTIEBnKDeQzQv70TmH8gTLxyokOBGnkNHi/2hKH2/8aYLDMFlQAI1FjqCiWaXM
	g31M0eWpuueILcypCVRhWAyeIfEmbQRi7oyh5IbtLr4DG6Jxbm6ehDhd8HW+hCj0
	Mj4Cscq+AFPr8JVXKrs46xc7C2Hs5eVfFTUVj8wzf4ymL8konynIFuWoXByUTEv3
	zieegYia3G9RzMcdzkP2dIiDxh+mxVyZdKJiLBRMSvJls42gfw59fNnoOFE/G17N
	JrgkiaWc3a1CcgA2oDQqA6NmORAFw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tja93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:22:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBcVEE006403
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:22:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82nxusv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:22:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NDMMKB36503956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:22:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BF892004B
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:22:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E436420040
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:22:21 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:22:21 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] s390/entry: Fix last breaking event handling in case of stack corruption
Date: Mon, 23 Jun 2025 15:22:21 +0200
Message-ID: <20250623132221.891555-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G44iG21wgoJzihkvGRLppl1HxYiFkg-v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MCBTYWx0ZWRfXzKRVk2eSZXpA TzvkN6tPor8PihD7TRDTdpIreKYeaUdm2DgOU8Wx04uDeSMoxJhOwdRDuBHEQuXP8oPG2As6Tyt fV2Czgiau/zHHR/A6zfohmOKHlXPLQktc9K0W8SsL1vVsqwWDWtbu/VHDDIXenUChrLGb1VDSdp
 fzZnBCQ+2RMWNyEA1IcprpdPCYLeAv6zOTDth4tJ2TzyMol2XfMKugM8a+vlFzRYr3laf8J7+TF SBooAyToKWbuGn7XP6nONVeHoSDKxOOppb1raLSilVZq3K7YIyND7tN7OHuKqwsdFWQtbiXWgtZ vCE/m9TqV2LK6GX4bwMyQBsJntThqsKy5k98aYien1sRJ5MvjB5fT8IDNfch4F7b6PDDo6XxRh7
 ls+imXpjRVfUYEJXHwCvV6hxwmL1zpjKh9gOJzHFzcIb/qD3s2y0j9HNFDV6CXaX+QyJqdBR
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=68595510 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=8Ck9TpFAnHqLg_FyizcA:9
X-Proofpoint-GUID: G44iG21wgoJzihkvGRLppl1HxYiFkg-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=835 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230080

commit ae952eea6f4a7e2193f8721a5366049946e012e7 upstream.

Note: the GET_LC macro and all the infrastructe that comes with this does
not exist for this kernel release. Therefore the patch is slightly
different to the upstream variant.

In case of stack corruption stack_invalid() is called and the expectation
is that register r10 contains the last breaking event address. This
dependency is quite subtle and broke a couple of years ago without that
anybody noticed.

Fix this by getting rid of the dependency and read the last breaking event
address from lowcore.

Fixes: 56e62a737028 ("s390: convert to generic entry")
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 160290049e8c..14a5eff4d027 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -676,7 +676,7 @@ ENTRY(stack_overflow)
 	stmg	%r0,%r7,__PT_R0(%r11)
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_R8(64,%r11),0(%r14)
-	stg	%r10,__PT_ORIG_GPR2(%r11) # store last break to orig_gpr2
+	mvc	__PT_ORIG_GPR2(8,%r11),__LC_LAST_BREAK
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	jg	kernel_stack_overflow
-- 
2.48.1


