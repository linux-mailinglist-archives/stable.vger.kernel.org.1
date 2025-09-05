Return-Path: <stable+bounces-177797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B912B4559E
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2410A032D7
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98732275E;
	Fri,  5 Sep 2025 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FsNBCjOm"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D82C028F
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070253; cv=none; b=ieltQsBGi6BdlLnDF5539qC5+HlY9ckePW+vOSjJ4ks3Befc72K1W1byU8H89fIRWHZA7VWbr8gKMw3w5O0F84d42v6q4aEodhG5xNlIQSM/6Ej0nfPm1hrSN/yG465W43M8+nT110peMsANevzgsi88nRdgbnFXv7bEOF27dtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070253; c=relaxed/simple;
	bh=S9PIS6Ukzr5cBYoDeGUF8Xfv32E9g8G5K81Bhk2I7Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HxCEzv5A4FzQuPbLdwGIULxkNayPRD0c01RD8cB9eXb0cH+rgnTrCkoLaOo8E+9NguS/gvNnG92cmWhhZF/wzZAfuJHZL/YQyO8kq26ir0CKvgXcNzopboHzEyzRzFRCD1j+TWmjDjPQ7WGwKFTB+3RslaYFxW8fHE9G3dF0Uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FsNBCjOm; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585AttnO004246
	for <stable@vger.kernel.org>; Fri, 5 Sep 2025 11:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=FcwGQk2wQ2697wOy
	IY10pNN8ppKUNQHJ+ZXMequNubY=; b=FsNBCjOmXA3N2FXXRtfMZTHehZAnX8D2
	/bNOIvo87zGnCJMKr8xOGwD6SAANotZ7gYs5C7ol0S106c1jS7yjrlvMaj56msTY
	zDspGnGv4h94Zh0twbwCCzo+xszKN0LtqSm+lgpuK64RjdOJVH5kRruzROmThy+/
	3J5nrKJWgkQ5cOiM3Q3DjrM3Xp99d+aMGsDIx2lc2DEQ+/ZZ31ReW8CPsuEiE1g5
	9t1uZf6OZflx+39AQ3MwT+rgR6I+v/+Zz8oRdh0lwuJ+cYh7yrF1vvxHCBS/otIn
	0ZaDylAtEtFfd8SKtZzEKVFxMi3G0NDtV8RglBU+B1S6W7zQbTM9DQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yx2jg1pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Fri, 05 Sep 2025 11:04:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859Jbh0019755
	for <stable@vger.kernel.org>; Fri, 5 Sep 2025 11:04:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcqqvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Fri, 05 Sep 2025 11:04:10 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585B49hA030057
	for <stable@vger.kernel.org>; Fri, 5 Sep 2025 11:04:09 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrcqqux-1;
	Fri, 05 Sep 2025 11:04:09 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 00/15] Backport few CVE fixes to 6.12.y
Date: Fri,  5 Sep 2025 04:03:51 -0700
Message-ID: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050108
X-Authority-Analysis: v=2.4 cv=S5LZwJsP c=1 sm=1 tr=0 ts=68bac3aa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=gj6PM3SIPMwNv6KP5hcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDA5OSBTYWx0ZWRfX3l5vctu95xK/
 AECi1ruWzED9bB8PSaj3EmcZgtk+7kkLQaYfJeiODegc/PF1oi+F3Re65jlXwZBdi3stweUjqg7
 1KxZQ/UC60lJMk9RO2AtBCCX5i7orOX+p07bI4GB8asQeWsY8f/wC0wXYS8DT4YdAmXCU9yYHtI
 bIyMvsBiNmrZP9FSBoan9itS3V/PDcmTfilTNdlY38zWXOl4JxDoig7mwyZNGpxxs4dOUpvPWDG
 rwY20ZgFTsapPDc5NqVZTwTkttN5EUEZTe+H8e1iZOuRSPg/9FuP1gTP1GADsFxA001ZoidG6D/
 oYRgzVlX1uv4x3KnDO6gvskWNXKQSJeUUR5XXr/1VLZ8qmrzRd7I8TM4ke2pA8F0+HI8sTcspJz
 +kZdx8gH
X-Proofpoint-GUID: i3dAXqS7w7y8Fdm8NhonlQImRZhzLfSf
X-Proofpoint-ORIG-GUID: i3dAXqS7w7y8Fdm8NhonlQImRZhzLfSf

Hi stable maintainers,

I have tried backporting some fixes to stable kernel 6.12.y which also
have CVE numbers and are fixing commits in 6.12.y.

I am not a subsystem expert and have only done overall testing that we
do for stable release candidate testing and not any patch specific testing.

Note: All these patches are present backports from upstream.

Patch 1: Fixes a race, by reading the code, I can confirm 6.12.y needs
this backport -- Few conflicts resolved. This is fix for CVE-2025-38306

Patch 2,3,4,5 -- So this set corresponds to fixing CVE-2025-38272,
commit:  1237c2d4a8db ("net: dsa: b53: do not enable EEE on bcm63xx").
While we can comeup with downstream fix byt writing a new function, I
think backporting some prerequisites would help us backporting future
fixes smoothly to 6.12.y. Patch 2,3,4 are pulled in as prerequisites.
Patch3 has minor conflict resolution due to other missing patches. And
Patch 5 is again a clean cherry-pick.

Patch 6,7,8: Patch 6 corresponds to the CVE-2025-22125 fix, Patch 7 is a
fix for Patch6 and and Patch 8 fixes Patch 7. patch 6 had minor conflict
resolution due to missing atomic writes feature in 6.12.y and Patches 7
and 8 are clean cherrypicks.

Patch 9, 10: Patch 10 is a fix for CVE-2025-22113 and patch 9 is pulled
in as a prerequisite. Both are clean cherry-picks.

Patch 11: Had conflict resolution in the header file, this is fix for CVE-2025-38453

Patch 12, 13 : Patch 12 is a clean cherrypick and a fix for CVE-2025-23133. This
wan't backported earlier or probably dropped as it showed up a
regression which is fixed by Patch 13.  [1], so we should be fine.

Patch 14: CVE-2025-22103 fix, clean cherry-pick

Patch 15: CVE-2025-22124 fix and a clean cherry-pick.

Please let me know if there are any comments.


Thanks,
Harshit


[1] https://lore.kernel.org/all/2025041740-tableware-flight-b781@gregkh/


Al Viro (1):
  fs/fhandle.c: fix a race in call of has_locked_children()

Jens Axboe (1):
  io_uring/msg_ring: ensure io_kiocb freeing is deferred for RCU

Jonas Gorski (1):
  net: dsa: b53: do not enable EEE on bcm63xx

Ojaswin Mujoo (2):
  ext4: define ext4_journal_destroy wrapper
  ext4: avoid journaling sb update on error if journal is destroying

Russell King (Oracle) (3):
  net: dsa: add hook to determine whether EEE is supported
  net: dsa: provide implementation of .support_eee()
  net: dsa: b53/bcm_sf2: implement .support_eee() method

Su Yue (1):
  md/md-bitmap: fix wrong bitmap_limit for clustermd when write sb

Wang Liang (1):
  net: fix NULL pointer dereference in l3mdev_l3_rcv

Wen Gong (2):
  wifi: ath11k: update channel list in reg notifier instead reg worker
  wifi: ath11k: update channel list in worker when wait flag is set

Yu Kuai (2):
  md/raid1,raid10: don't ignore IO flags
  md/raid1,raid10: don't handle IO error for REQ_RAHEAD and REQ_NOWAIT

Zheng Qixing (1):
  md/raid1,raid10: strip REQ_NOWAIT from member bios

 drivers/md/md-bitmap.c                 |   6 +-
 drivers/md/raid1-10.c                  |  10 +++
 drivers/md/raid1.c                     |  26 +++---
 drivers/md/raid10.c                    |  20 ++---
 drivers/net/dsa/b53/b53_common.c       |  16 ++--
 drivers/net/dsa/b53/b53_priv.h         |   1 +
 drivers/net/dsa/bcm_sf2.c              |   1 +
 drivers/net/ipvlan/ipvlan_l3s.c        |   1 -
 drivers/net/wireless/ath/ath11k/core.c |   1 +
 drivers/net/wireless/ath/ath11k/core.h |   5 +-
 drivers/net/wireless/ath/ath11k/mac.c  |  14 ++++
 drivers/net/wireless/ath/ath11k/reg.c  | 107 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/reg.h  |   3 +-
 drivers/net/wireless/ath/ath11k/wmi.h  |   1 +
 fs/ext4/ext4.h                         |   3 +-
 fs/ext4/ext4_jbd2.h                    |  29 +++++++
 fs/ext4/super.c                        |  32 ++++----
 fs/namespace.c                         |  18 ++++-
 include/linux/io_uring_types.h         |   2 +
 include/net/dsa.h                      |   2 +
 io_uring/msg_ring.c                    |   4 +-
 net/dsa/port.c                         |  16 ++++
 net/dsa/user.c                         |   8 ++
 23 files changed, 230 insertions(+), 96 deletions(-)

-- 
2.50.1


