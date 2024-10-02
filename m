Return-Path: <stable+bounces-80560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A298DE69
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F2D1C20B7B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2AF1D094A;
	Wed,  2 Oct 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QaV4Thw8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E411CEEAF
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881630; cv=none; b=WfsX4/DEM0LbZ8EhafIargWnupgHbI07IqE792nQu60TJio6/6oBCv4mbeAf5XtQQRIBOwYlVNtMeV80RCbhvj2pBPtFBzVmYYEJuHj0Ma90FAFBDj8VBrpzPobaw8xs/vd4I7S66ozJkRQsoNQncqQNnJfPZeGePm9ZDL/+RaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881630; c=relaxed/simple;
	bh=XYtQ9DhzdZC8CdzT773a8WCgBNuLgz2oqDNannoXmz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Tbcy5iyU6WVarTdW33IxKWqDyWLVdJxwb7dEwopU6YVlTjo1vUpucj8YN2URAP0qmtyQjpzcRDJ7Br6vh3iIACmmchFzmLTtvEymxORJl/WbihHRYrPT8jve6mgqX/fnz5UhRMFAwnHvywnvR1YdXEblvBF04iBBHm7xYcT0TjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QaV4Thw8; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492CdAAB025182;
	Wed, 2 Oct 2024 15:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=corp-2023-11-20; bh=cMr8+ABFvCeqpc
	peKmnWbzcWFJhHMmUEhVaRyTx47Yw=; b=QaV4Thw8ytWVGptWbY2yhTE/Y6h3G5
	g6H6B9Ss6/zyi3mB1vL8TBTKzi39GQNz004exugxLE6jnS7TWIjHkO/DpY5I47A3
	c69fqjaJ0ZPNtypJFIU6sECO/iF4Fdi8099CReHz1vsxK3AK2OjZ6NNCWIlCkwSd
	yU99Prux5gqqYzuzkwmW9ijyi3jIDYSYiBpMtI+G71c8WOH9nSztk1ZoUT77sTlN
	38U8R0F17Pom6T3yuE13U8szMiOLfEYcTF1aY5w+KLKfMWgiy+71SP1x9Jz7ngBe
	pIWf9YuYcnHcE14uPuW2tX4cVE/Gnrfr1DTOhOIswAQe2IsEM8jbbw1g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d9j96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492El4QY017382;
	Wed, 2 Oct 2024 15:06:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888y019-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492F1lZC012831;
	Wed, 2 Oct 2024 15:06:25 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888xyse-1;
	Wed, 02 Oct 2024 15:06:25 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com, Vegard Nossum <vegard.nossum@oracle.com>,
        ahalaney@redhat.com, alsi@bang-olufsen.dk, ardb@kernel.org,
        axboe@kernel.dk, benjamin.gaignard@collabora.com, bli@bang-olufsen.dk,
        chengzhihao1@huawei.com, christophe.jaillet@wanadoo.fr,
        ebiggers@kernel.org, edumazet@google.com, fancer.lancer@gmail.com,
        florian.fainelli@broadcom.com, harshit.m.mogalapalli@oracle.com,
        hdegoede@redhat.com, horms@kernel.org, hverkuil-cisco@xs4all.nl,
        ilpo.jarvinen@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
        kirill.shutemov@linux.intel.com, kuba@kernel.org,
        luiz.von.dentz@intel.com, md.iqbal.hossain@intel.com,
        mpearson-lenovo@squebb.ca, nicolinc@nvidia.com, pablo@netfilter.org,
        rfoss@kernel.org, richard@nod.at, tfiga@chromium.org,
        vladimir.oltean@nxp.com, xiaolei.wang@windriver.com,
        yanjun.zhu@linux.dev, yi.zhang@redhat.com, yu.c.chen@intel.com,
        yukuai3@huawei.com
Subject: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
Date: Wed,  2 Oct 2024 17:05:51 +0200
Message-Id: <20241002150606.11385-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020109
X-Proofpoint-GUID: 1S5pxGhK8OifmgW76h3D8l6s964G76HB
X-Proofpoint-ORIG-GUID: 1S5pxGhK8OifmgW76h3D8l6s964G76HB

Hi,

We noticed some cases where a mainline commit that fixes a CVE has a
Fixes: tag pointing to a commit that has been backported to 6.6 but
where the fix is not present.

Harshit and I have backported some of these patches.

We are not subsystem experts and that's why we have marked this
series as RFC -- any review or feedback is welcome. We've tried to
document the conflicts and their causes in the changelogs. We haven't
done targeted testing beyond our usual stable tests, but this
includes for example the netfilter test suite, which did not show any
new failures.

Greg: feel free to take these patches or leave it as you want.
Conflict resolution always comes with the risk of missing something
and we want to be up-front about that. On the other hand, these were
identified as CVE fixes so presumably we're not the only ones who
want them.

[Note: we added some other people to Cc that we think would be
interested, let me know privately if you don't want to receive
emails like these in the future.]

Thanks,


Vegard

---

Benjamin Gaignard (1):
  media: usbtv: Remove useless locks in usbtv_video_free()

Chen Yu (1):
  efi/unaccepted: touch soft lockup during memory accept

Christophe JAILLET (1):
  null_blk: Remove usage of the deprecated ida_simple_xx() API

Luiz Augusto von Dentz (3):
  Bluetooth: hci_sock: Fix not validating setsockopt user input
  Bluetooth: ISO: Fix not validating setsockopt user input
  Bluetooth: L2CAP: Fix not validating setsockopt user input

Mads Bligaard Nielsen (1):
  drm/bridge: adv7511: fix crash on irq during probe

Mark Pearson (1):
  platform/x86: think-lmi: Fix password opcode ordering for workstations

Nicolin Chen (1):
  iommufd: Fix protection fault in iommufd_test_syz_conv_iova

Pablo Neira Ayuso (2):
  netfilter: nf_tables: fix memleak in map from abort path
  netfilter: nf_tables: restore set elements when delete set fails

Vladimir Oltean (1):
  net: dsa: fix netdev_priv() dereference before check on non-DSA
    netdevice events

Xiaolei Wang (1):
  net: stmmac: move the EST lock to struct stmmac_priv

Yu Kuai (1):
  null_blk: fix null-ptr-dereference while configuring 'power' and
    'submit_queues'

Zhihao Cheng (1):
  ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

 drivers/block/null_blk/main.c                 | 44 ++++++++------
 drivers/firmware/efi/unaccepted_memory.c      |  4 ++
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  | 22 +++----
 drivers/iommu/iommufd/selftest.c              | 27 +++++++--
 drivers/media/usb/usbtv/usbtv-video.c         |  7 ---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  8 +--
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 18 +++---
 drivers/platform/x86/think-lmi.c              | 16 +++---
 fs/ubifs/dir.c                                |  2 +
 include/linux/stmmac.h                        |  1 -
 net/bluetooth/hci_sock.c                      | 21 +++----
 net/bluetooth/iso.c                           | 36 ++++--------
 net/bluetooth/l2cap_sock.c                    | 52 +++++++----------
 net/dsa/slave.c                               |  7 ++-
 net/netfilter/nf_tables_api.c                 | 57 +++++++++++++++++--
 net/netfilter/nft_set_bitmap.c                |  4 +-
 net/netfilter/nft_set_hash.c                  |  8 +--
 net/netfilter/nft_set_pipapo.c                |  5 +-
 net/netfilter/nft_set_rbtree.c                |  4 +-
 20 files changed, 192 insertions(+), 153 deletions(-)

-- 
2.34.1


