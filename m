Return-Path: <stable+bounces-69721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEA99588BD
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 16:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E7D282B89
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D507191476;
	Tue, 20 Aug 2024 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TqLTaJZ8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE91917D4
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163199; cv=none; b=Q87R2z37cT2Crejd/BwF7MQadxC2GVXS2gKXQLfQMhp0tv881OZbEEMUi+2xUwQxx5dHD0h9NaEHsyzFIdcfBYzy0jC5mmjqAqkIr+iNwIfvSFXCCmi3XMqlmUjeuTs8rzgK/XlJxfFckXVNH05EzsmHW8uUjuPMq85TS69tFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163199; c=relaxed/simple;
	bh=l1SNEmn/nTSHdNrXcVTCmbfZmUkPyAUsYs1jYlboEls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgy+rymRAtBjwu8+Dg21fV6uZNjaYHeWxVHpuut5hD2C57XLbkf2SUuMtTPA92u1AflGfryFKBWxxGgEtkJ2xaM9Z85Ur+DdNvaDCqHvwKXnvpIkV/MD1NTwriqVzVJnGvCPR7dUeNDR3116IbCB/NSsissHoJEBI5h0xjXSCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TqLTaJZ8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KDnPsG001333;
	Tue, 20 Aug 2024 14:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	3oPjmZVcenR2XB/cC9N8suB8tCMa0R1BW80JLe9umtM=; b=TqLTaJZ8LrMM3frO
	tqqr+nQAW+UchGJW8FpCZR3DrdPXKsBoq/Px23vDlsuAlS+wxTMbjndiJ1pnCLEo
	kHEOEULQW7Go1/s4TxHPZbcfkHrthTOd+ZdgkrGtoh3thAcZjqdCS6Mub6DDKBRj
	zPvwPl/dWxnaVx7LYc4TLpw3P0thWksPpHX8TiSLWZsnHy/tolpXKtKgi4RmsF/D
	4KXNzKRIL/acgX816B1A9zFBLpBWPhqAhBhd3zpa44M0w+4Os2+avDzRNBVV2NKC
	iit7zbRCdvPzpq6KTCHUgySd9m6Wy5nOzfC0aljAIrtXyzwTWnz+5ks3wzM+gHHS
	cXXh4Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbfwgtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 14:13:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47KD1Ovf030060;
	Tue, 20 Aug 2024 14:13:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138dmay53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 14:13:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47KED8Ps18481418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 14:13:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C7C920043;
	Tue, 20 Aug 2024 14:13:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F00520040;
	Tue, 20 Aug 2024 14:13:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 14:13:08 +0000 (GMT)
From: =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, sth@linux.ibm.com
Subject: [PATCH] Revert "s390/dasd: Establish DMA alignment"
Date: Tue, 20 Aug 2024 16:13:07 +0200
Message-ID: <20240820141307.2869182-1-hoeppner@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024082014-riverbed-glutton-ae33@gregkh>
References: <2024082014-riverbed-glutton-ae33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I6MfK8-0LQKJXBq7zwhilw0tb7epm81q
X-Proofpoint-ORIG-GUID: I6MfK8-0LQKJXBq7zwhilw0tb7epm81q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200104

This reverts commit bc792884b76f ("s390/dasd: Establish DMA alignment").

Quoting the original commit:
    linux-next commit bf8d08532bc1 ("iomap: add support for dma aligned
    direct-io") changes the alignment requirement to come from the block
    device rather than the block size, and the default alignment
    requirement is 512-byte boundaries. Since DASD I/O has page
    alignments for IDAW/TIDAW requests, let's override this value to
    restore the expected behavior.

I mentioned TIDAW, but that was wrong. TIDAWs have no distinct alignment
requirement (per p. 15-70 of POPS SA22-7832-13):

   Unless otherwise specified, TIDAWs may designate
   a block of main storage on any boundary and length
   up to 4K bytes, provided the specified block does not
   cross a 4 K-byte boundary.

IDAWs do, but the original commit neglected that while ECKD DASD are
typically formatted in 4096-byte blocks, they don't HAVE to be. Formatting
an ECKD volume with smaller blocks is permitted (dasdfmt -b xxx), and the
problematic commit enforces alignment properties to such a device that
will result in errors, such as:

   [test@host ~]# lsdasd -l a367 | grep blksz
     blksz:				512
   [test@host ~]# mkfs.xfs -f /dev/disk/by-path/ccw-0.0.a367-part1
   meta-data=/dev/dasdc1            isize=512    agcount=4, agsize=230075 blks
            =                       sectsz=512   attr=2, projid32bit=1
            =                       crc=1        finobt=1, sparse=1, rmapbt=1
            =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
   data     =                       bsize=4096   blocks=920299, imaxpct=25
            =                       sunit=0      swidth=0 blks
   naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
   log      =internal log           bsize=4096   blocks=16384, version=2
            =                       sectsz=512   sunit=0 blks, lazy-count=1
   realtime =none                   extsz=4096   blocks=0, rtextents=0
   error reading existing superblock: Invalid argument
   mkfs.xfs: pwrite failed: Invalid argument
   libxfs_bwrite: write failed on (unknown) bno 0x70565c/0x100, err=22
   mkfs.xfs: Releasing dirty buffer to free list!
   found dirty buffer (bulk) on free list!
   mkfs.xfs: pwrite failed: Invalid argument
   ...snipped...

The original commit omitted the FBA discipline for just this reason,
but the formatted block size of the other disciplines was overlooked.
The solution to all of this is to revert to the original behavior,
such that the block size can be respected.

But what of the original problem? That was manifested with a direct-io
QEMU guest, where QEMU itself was changed a month or two later with
commit 25474d90aa ("block: use the request length for iov alignment")
such that the blamed kernel commit is unnecessary.

Note: This is an adapted version of the original upstream commit
2a07bb64d801 ("s390/dasd: Remove DMA alignment").

Cc: stable@vger.kernel.org # 6.0+
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_diag.c | 1 -
 drivers/s390/block/dasd_eckd.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 2e4e555b37c3..12db1046aad0 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -639,7 +639,6 @@ static void dasd_diag_setup_blk_queue(struct dasd_block *block)
 	/* With page sized segments each segment can be translated into one idaw/tidaw */
 	blk_queue_max_segment_size(q, PAGE_SIZE);
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
-	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
 }
 
 static int dasd_diag_pe_handler(struct dasd_device *device,
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index bd89b032968a..18b63210ac5d 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6895,7 +6895,6 @@ static void dasd_eckd_setup_blk_queue(struct dasd_block *block)
 	/* With page sized segments each segment can be translated into one idaw/tidaw */
 	blk_queue_max_segment_size(q, PAGE_SIZE);
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
-	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
 }
 
 static struct ccw_driver dasd_eckd_driver = {
-- 
2.43.0


