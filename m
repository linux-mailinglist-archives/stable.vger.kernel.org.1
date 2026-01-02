Return-Path: <stable+bounces-204507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D11FCEF508
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 21:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FEA0301FF7F
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C72C026E;
	Fri,  2 Jan 2026 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AcKsS9z/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CA226A0DB
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767386259; cv=none; b=NTQbVTff/p33Qzls54deolhEpee7IjftUmjluZH2YXXFY1rl62HVTNTG8r/n7BopaLg4SvVPf1EvMzPWCCoDfC4L/n5+WtkiYIkYZpMwPLxk0qzSQMWItzk1E1XT0EjgQv4KGuB4+O6nMnUYmq1L8U4nH19eCDKlZtMDnFHcuT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767386259; c=relaxed/simple;
	bh=mx9B0m0SgwMebw0PvjfMoTp5WTbAu1eoFBma0p8gjoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wa39aenr+g7tRtrld2QJMAqleuUSx68XJHbKBiET+9FwnQD5+qjRbXswXESEXqbpj2lEFZrr0iI9ZF1WaFYcCnI6kGwygkb3wz7PeWnuxXHRrUnCZfzL/1uT6KgswcGUaE3xeJZb5UE3OOobg4MSvS5B9rUVXksI0nLg5+T6G3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AcKsS9z/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602BunkX2923646
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 20:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=FrUXAp244QNFVaDyYlcS64c26UTk2
	LpUieVLjMHHWCU=; b=AcKsS9z/9npYOl0xb/9RQNe/gDWdmqa2XyXisT5Uz8bQm
	TrGHCcBf2jLf1719SW68kAJDwASQ+QKt2NIKG0wyTTrDeX+F8GKtxJZwIV7BV0yL
	n8m4ydTaQh5QxX/Mk3O1RzpdHV91f+x8XiWnXmmhrj04s+pXRoflBxideg7yzK62
	JA79hFIx0RS9AqDcrHsvi3TjVJFfPbkj0zTrtw58HqE604PUti0Is55J9G7emL6I
	bWFZZ0Zv91jK5Vk8vPHxZ2mlyzc84FXHTfbmA4fvo78CBvn2yDCOpYgg68aqYAZs
	w3lViKUYXwzUufaRw7L2mx1rWKEaI8JyLlfjk07IA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba6c8wh1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 20:37:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 602KG5No022512
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 20:37:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5wa66fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 20:37:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 602KbZ4T025726
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 20:37:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ba5wa66fb-1;
	Fri, 02 Jan 2026 20:37:35 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 0/7] Few CVE fixes.
Date: Fri,  2 Jan 2026 12:37:20 -0800
Message-ID: <20260102203727.1455662-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
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
X-Authority-Analysis: v=2.4 cv=a4E9NESF c=1 sm=1 tr=0 ts=69582c90 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=aZw8RoVIG5dPnLBs_scA:9
X-Proofpoint-GUID: SQAue66_wRCw-Ov9qKiuTb5hoA2Sw0N9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4NSBTYWx0ZWRfXw3ppyTWkPBVI
 ZYGbdvSE1KrbW9Z5/8R+69T6jbfKpdapD1URkl5D0DX47XV89QPInQtKh4gb5a46CIsnZFaV6Ct
 wt7/10OAMnuTIYKcr6tD16WUEVsbuWjyPkcCfW1dreOi2LvJN4RPLw1BYLQ6nWqAxXATeBrXT2V
 Yu3XmoouInGIM7JGxaEMocGeYCR20riRsu8dOOuo4ORD0pYkWgNuwrQvLzF7KWzkTyhbgWEV5wI
 OO4qKuS30E7a3qpWSmwDQkZq8goWSntcTngpNHQZLwbqqVid4c95wFdsACAtBsDY6iHPB1CH1aY
 wlZQ0H0Rs5ubNCl0bP+zkT5DbZ1kNeN6+Pjo42Gji6fQBizDGzldL2Bv9xaJK2XVxQS9E/oZ56o
 o4edri9ID9aOFyRVTOH/gum+sM9KocuxDedzYOWapNlX+/tXXT5OS68igCXdSLjjMtsqoJRnOVT
 4gA/A9hr9LzVZskqlxA==
X-Proofpoint-ORIG-GUID: SQAue66_wRCw-Ov9qKiuTb5hoA2Sw0N9

Hi stable maintainers,

I have tried backporting some fixes to stable kernel 6.12.y which also
have CVE numbers and are fixing commits in 6.12.y.

I am not a subsystem expert and have only done overall testing that we
do for stable release candidate testing and not any patch specific testing.

Note: All these patches are present backports from upstream.

PATCH 1: The broken commit is in 6.12.y, and the fix is a clean
cherry-pick and addresses CVE-2025-68206

PATCH 2: The broken commit is present in 6.12.y and the fix is a clean
cherry-pick and addresses CVE-2025-40325.

PATCH 3: The broken commit is present in 6.12.y and backport needed a
minor conflict resolution due to missing commit fe69a3918084
("drm/panthor: Fix UAF in panthor_gem_create_with_handle() debugfs
in 6.12.y

PATCH 4,5,6: Patch 4 and 5 are pulled in as prerequisites for PATCH 6 which
is a fix for CVE-2025-40170 and needed a minor conflict resolution due to missing
commit: 22d6c9eebf2e ("net: Unexport shared functions for DCCP.")  in 6.12.y 

PATCH 7: The broken commit in present in 6.12.y and the backport of the
fix needed a minor conflict resolution due to missing commit in 6.12.y.
This is fix for CVE-2025-40164.

Please let me know if there are any comments.

Regards,
Harshit

Andrii Melnychenko (1):
  netfilter: nft_ct: add seqadj extension for natted connections

Boris Brezillon (1):
  drm/panthor: Flush shmem writes before mapping buffers CPU-uncached

Eric Dumazet (2):
  ipv6: adopt dst_dev() helper
  net: use dst_dev_rcu() in sk_setup_caps()

Justin Iurman (1):
  net: ipv6: ioam6: use consistent dst names

Xiao Ni (1):
  md/raid10: wait barrier before returning discard request with
    REQ_NOWAIT

Zqiang (1):
  usbnet: Fix using smp_processor_id() in preemptible code warnings

 drivers/gpu/drm/panthor/panthor_gem.c | 18 +++++++++++++
 drivers/md/raid10.c                   |  3 +--
 drivers/net/usb/usbnet.c              |  2 ++
 include/net/ip.h                      |  6 +++--
 include/net/ip6_route.h               |  4 +--
 include/net/route.h                   |  2 +-
 net/core/sock.c                       | 16 +++++++-----
 net/ipv6/exthdrs.c                    |  2 +-
 net/ipv6/icmp.c                       |  4 ++-
 net/ipv6/ila/ila_lwt.c                |  2 +-
 net/ipv6/ioam6_iptunnel.c             | 37 ++++++++++++++-------------
 net/ipv6/ip6_gre.c                    |  8 +++---
 net/ipv6/ip6_output.c                 | 19 +++++++-------
 net/ipv6/ip6_tunnel.c                 |  4 +--
 net/ipv6/ip6_udp_tunnel.c             |  2 +-
 net/ipv6/ip6_vti.c                    |  2 +-
 net/ipv6/ndisc.c                      |  6 +++--
 net/ipv6/netfilter/nf_dup_ipv6.c      |  2 +-
 net/ipv6/output_core.c                |  2 +-
 net/ipv6/route.c                      | 20 +++++++++------
 net/ipv6/rpl_iptunnel.c               |  4 +--
 net/ipv6/seg6_iptunnel.c              | 20 ++++++++-------
 net/ipv6/seg6_local.c                 |  2 +-
 net/netfilter/nft_ct.c                |  5 ++++
 24 files changed, 118 insertions(+), 74 deletions(-)

-- 
2.50.1


