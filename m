Return-Path: <stable+bounces-230164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH6tG2Obwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:10:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E43309F50
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D5C3021EB4
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3573DEFF7;
	Tue, 24 Mar 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J2mmHOWP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FDE3F99C0
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361104; cv=none; b=QCtWaqFoaxLj6sweDpLZPfM8+/6a5XC7JbmTTzUH+8u0fmCHYbTQIihuilbFWnWOYcMaSrcwkX3cQSwfkddZtIT6/hEnNXhHkQvZ5flZXKJAnJEs+OMCRnZ4OCTnYWKSYPKFNsIDN+usf6FSNij03og847WYiarzVcgqN11IiJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361104; c=relaxed/simple;
	bh=piTBGg+yrB4rFj7HA5yxCC89N8CWkq/9Iq5Tic1sVvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CFICk43gd1DEeYLVvlvFRifWHm/k8rZVpdlP/D3B1nxq9KYopMlk0PYreQJx+Shw3rV5YL8e4tQPzIf7otFtEE39LiIaKcLaX9FUqWU/RGdR0QXx9qgp0Zbj93eU5KvkDietQ/7zSNVp7uOK61qGC+PhoilKC1p1Zy1+RIUn+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J2mmHOWP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCCbmw1540303
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=PbaBevuJU0nZFuxR
	rJCC0ybPToOcYxX3csCVcksbL50=; b=J2mmHOWPg7y8Cou8wOYt6d2MccYmLPW0
	UlqWUl9wjJWa31z3Za1+CNyBCuoX66WRQ11weML7t9T54feNDIA9LJuU7B0V9rCC
	jiheanrvsYpPUYDQmvZLw/lfkxUW7ptqL2qfnJtEtvSjskKQkAarvE6Af/YCGMQv
	Bgu3lm6MMtObC3WaQTIaZiPTmy3CFIGblZki7n/n5BKlIfTHeo7fQJPSzj2sSg8B
	wcCkdtT31mXo1xWbXWeWrseFY8r/4c1171AvFGac52DC7qfVSVATyYA5VSft6i8f
	LnaWF6bHUbWJZWQZipj5oecfumKxgo2kpBIyG+rDLcsny+DNO5gUzg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kja4a87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ODbZRe039928
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs9pd7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:01 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OE50EW023161
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:00 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs9pd7j-1;
	Tue, 24 Mar 2026 14:05:00 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 0/9] Few stable backports for CVE fixes
Date: Tue, 24 Mar 2026 07:04:47 -0700
Message-ID: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=83
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMSBTYWx0ZWRfX3oNTmFJ7X7fb
 7is8IADM5TT73tb3iYy2ffrJVX+bL5qDwxHu6VWRmSlLUeXkfFDju59RO2HJhhY0uCt9yImrvE2
 JpFNpALIrXURnWo2oLHOgEZJxThsNVcheojlJOn868iJpAXvjP1aEBuqtUAl5WUtx65ArLj0Qre
 OuTDMhRQnZNNMNEZZaJzdtx7KcFlGQXShY6lWzSv4nIVJsnCxw46i4RFZ9Wrxf44KvaOKUoXAi+
 3fN/hf35pvyyAjbHhXHVMKZFS4xcvEFIYpqC7ChoL1nk8rZin/kLajXZtFTf1OWWelsEiNQcq90
 gaG+8iPLOqzlr22LwKKurdqMGj/gP4Z4py2ecAFIrpNx93OF+tsVttloVE8N4Mpjd2vZ4YGgE+u
 FK8Cj/jcaml2dBI4ZXb7bYZ0bJE0Exc/vVmijNyYiSM1W+Nhbo7SLQZa8sxzd/rWEqfYRYs7NPb
 Q/fBBG0t4zVfJR1plTw==
X-Proofpoint-GUID: ruUnTDGc7gSwEMzDye4sWBlu3kTKK28M
X-Authority-Analysis: v=2.4 cv=TPdIilla c=1 sm=1 tr=0 ts=69c29a0e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=_a_3DXWFroSYYbvNOTMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ruUnTDGc7gSwEMzDye4sWBlu3kTKK28M
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230164-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C1E43309F50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi stable maintainers,

I have tried backporting some fixes to stable kernel 6.12.y which also
have CVE numbers and are fixing commits in 6.12.y.

I am not a subsystem expert and have only done overall testing that we
do for stable release candidate testing and not any patch specific testing.

Note: All these patches are present backports from upstream.

Quick summary:

Patch 1 is pulled in as a prerequisite for patch2 which is a fix for
CVE-2025-68736, both of them are clean cherry picks.

Patch 3 fixes CVE-2025-22117, clean cherrypick
Patch 4 fixes CVE-2026-23104, needed a minor conflict resolution.
Patch 5 fixes CVE-2026-23210, needed conflicts resolution due to a
missing API around conflicts region.

Patch 6 fixes CVE-2025-22116, clean cherry-pick
Patch 7 fixes CVE-2026-22981, needed quite a few resolutions due to 4
large commits around the vulnerable code.
Patch 8 fixes CVE-2026-22981, is a clean cherry-pick but the backport
needs a slight modification for 6.12.y due to missing commit.
Patch 9 fixes CVE-2026-22993, had to resolve a conflict due to two
missing commits in 6.12.y(which are not candidates for backporting.

Please let me know if there are any comments.

Thanks,
Harshit

Aaron Ma (1):
  ice: Fix PTP NULL pointer dereference during VSI rebuild

Emil Tantilov (2):
  idpf: check error for register_netdev() on init
  idpf: detach and close netdevs while handling a reset

Mateusz Polchlopek (1):
  ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()

Mickaël Salaün (2):
  landlock: Optimize file path walks and prepare for audit support
  landlock: Fix handling of disconnected directories

Paul Greenwalt (1):
  ice: fix devlink reload call trace

Sreedevi Joshi (2):
  idpf: Fix RSS LUT NULL pointer crash on early ethtool operations
  idpf: Fix RSS LUT NULL ptr issue after soft reset

 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  17 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   5 +
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  24 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |   2 -
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 232 ++++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  38 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   5 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   9 +-
 security/landlock/errata/abi-1.h              |  16 ++
 security/landlock/fs.c                        |  78 ++++--
 11 files changed, 256 insertions(+), 176 deletions(-)
 create mode 100644 security/landlock/errata/abi-1.h

-- 
2.50.1


