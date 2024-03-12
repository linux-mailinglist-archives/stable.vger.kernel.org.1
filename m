Return-Path: <stable+bounces-27468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CC0879724
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 16:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E25AB20BC7
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C9C7BB08;
	Tue, 12 Mar 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AW6CvO8p"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0678286
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256046; cv=none; b=i6oEZo7sbfw/K596zEBawF2vtLKwaK+F+oC1xA6jIhoM6wjWN0E3qt3qFng8vGNad9+M0bTwt9uBYJaxEuTd3Soc6/gJ1KX3hKrx4pbwaceg/S0ArRp1qyWk/hcPplUtAdUbKc68DAwHPL/UEJwJzV5tgwxn1MaVHdTulJpSI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256046; c=relaxed/simple;
	bh=4wEPk3ucT1MSdnEYfIIbwGnz4T5dazUC9VXCvGosiDk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=isgo+eaQSALFI5urtP3ccdS05ykC17OGHsSbTtLOR5/GSxxYJRrX1RSRxVzwcGZBlpplPum541zVn2JV1iPxxwVfiig1bHt8ktJeIFJ4kChSp9nCDqMEFvhnE7tdXZTpWJKSfWu2uQHnoqq+KUBJfb6PvSfYo5JrVjhnA8t6Av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AW6CvO8p; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CE42Q2019520
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 15:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=W1umPr9bOpZhWNhvzeQQArY4S4sjpYhMXY60kQzIvwA=;
 b=AW6CvO8pocQ1wRDGnf7or/talK/+LZukouU5cDPpGSCiAJCPRUbv9E2jr0F21ub919X7
 7u0OseiEao+XI8wQULig//5oaxY3+eM9sNJDKII/21g1Higxg3fVgq9+Kp2w8pl0K+Sf
 tZnTijpz3wB6Yg0Z3N2EZtYOIkRFRFqu7pZN6I71xO8rEmv9RTvMSThIvlj6QZXKdWj2
 AhuWuT9kD+ucF5ADePgaTiHlspCM6FXiqsOVDUELLao7YmaaFcKOZAhRJ2J39KxS/d9S
 Rm4AjzUe2S1NEzLSDIFv4FtcbdhQu2CcL1b5TIBIGLItuAe10/HO1ZP4o+U9xfNKARrA ZQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcuea6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 15:07:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42CDnwsT037708
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 15:07:16 GMT
Received: from localhost.localdomain (dhcp-10-191-130-14.vpn.oracle.com [10.191.130.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wre77bm83-1
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 15:07:16 +0000
From: Imran Khan <imran.f.khan@oracle.com>
To: stable@vger.kernel.org
Subject: [PATCH v4.14, v4.19, v5.4, v5.10, v5.15] igb: free up irq resources in device shutdown path.
Date: Wed, 13 Mar 2024 02:07:13 +1100
Message-Id: <20240312150713.3231723-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120115
X-Proofpoint-ORIG-GUID: vPigWvcww17F9qb_Sj4jobUutzGMxz7x
X-Proofpoint-GUID: vPigWvcww17F9qb_Sj4jobUutzGMxz7x

[ Upstream commit 9fb9eb4b59acc607e978288c96ac7efa917153d4 ]

systems, using igb driver, crash while executing poweroff command
as per following call stack:

crash> bt -a
PID: 62583    TASK: ffff97ebbf28dc40  CPU: 0    COMMAND: "poweroff"
 #0 [ffffa7adcd64f8a0] machine_kexec at ffffffffa606c7c1
 #1 [ffffa7adcd64f900] __crash_kexec at ffffffffa613bb52
 #2 [ffffa7adcd64f9d0] panic at ffffffffa6099c45
 #3 [ffffa7adcd64fa50] oops_end at ffffffffa603359a
 #4 [ffffa7adcd64fa78] die at ffffffffa6033c32
 #5 [ffffa7adcd64faa8] do_trap at ffffffffa60309a0
 #6 [ffffa7adcd64faf8] do_error_trap at ffffffffa60311e7
 #7 [ffffa7adcd64fbc0] do_invalid_op at ffffffffa6031320
 #8 [ffffa7adcd64fbd0] invalid_op at ffffffffa6a01f2a
    [exception RIP: free_msi_irqs+408]
    RIP: ffffffffa645d248  RSP: ffffa7adcd64fc88  RFLAGS: 00010286
    RAX: ffff97eb1396fe00  RBX: 0000000000000000  RCX: ffff97eb1396fe00
    RDX: ffff97eb1396fe00  RSI: 0000000000000000  RDI: 0000000000000000
    RBP: ffffa7adcd64fcb0   R8: 0000000000000002   R9: 000000000000fbff
    R10: 0000000000000000  R11: 0000000000000000  R12: ffff98c047af4720
    R13: ffff97eb87cd32a0  R14: ffff97eb87cd3000  R15: ffffa7adcd64fd57
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #9 [ffffa7adcd64fc80] free_msi_irqs at ffffffffa645d0fc
 #10 [ffffa7adcd64fcb8] pci_disable_msix at ffffffffa645d896
 #11 [ffffa7adcd64fce0] igb_reset_interrupt_capability at ffffffffc024f335 [igb]
 #12 [ffffa7adcd64fd08] __igb_shutdown at ffffffffc0258ed7 [igb]
 #13 [ffffa7adcd64fd48] igb_shutdown at ffffffffc025908b [igb]
 #14 [ffffa7adcd64fd70] pci_device_shutdown at ffffffffa6441e3a
 #15 [ffffa7adcd64fd98] device_shutdown at ffffffffa6570260
 #16 [ffffa7adcd64fdc8] kernel_power_off at ffffffffa60c0725
 #17 [ffffa7adcd64fdd8] SYSC_reboot at ffffffffa60c08f1
 #18 [ffffa7adcd64ff18] sys_reboot at ffffffffa60c09ee
 #19 [ffffa7adcd64ff28] do_syscall_64 at ffffffffa6003ca9
 #20 [ffffa7adcd64ff50] entry_SYSCALL_64_after_hwframe at ffffffffa6a001b1

This happens because igb_shutdown has not yet freed up allocated irqs and
free_msi_irqs finds irq_has_action true for involved msi irqs here and this
condition triggers BUG_ON.

Freeing irqs before proceeding further in igb_clear_interrupt_scheme,
fixes this problem.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---

This issue does not happen in v5.17 or later kernel versions because
'commit 9fb9eb4b59ac ("PCI/MSI: Let core code free MSI descriptors")',
explicitly frees up MSI based irqs and hence indirectly fixes this issue
as well. Also this is why I have mentioned this commit as equivalent
upstream commit. But this upstream change itself is dependent on a bunch
of changes starting from 'commit 288c81ce4be7 ("PCI/MSI: Move code into a 
separate directory")', which refactored msi driver into multiple parts.
So another way of fixing this issue would be to backport these patches and
get this issue implictly fixed.
Kindly let me know if my current patch is not acceptable and in that case
will it be fine if I backport the above mentioned msi driver refactoring
patches to LST.
 

 drivers/net/ethernet/intel/igb/igb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 7c42a99be5065..5b59fb65231ba 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -107,6 +107,7 @@ static int igb_setup_all_rx_resources(struct igb_adapter *);
 static void igb_free_all_tx_resources(struct igb_adapter *);
 static void igb_free_all_rx_resources(struct igb_adapter *);
 static void igb_setup_mrqc(struct igb_adapter *);
+static void igb_free_irq(struct igb_adapter *adapter);
 static int igb_probe(struct pci_dev *, const struct pci_device_id *);
 static void igb_remove(struct pci_dev *pdev);
 static int igb_sw_init(struct igb_adapter *);
@@ -1080,6 +1081,7 @@ static void igb_free_q_vectors(struct igb_adapter *adapter)
  */
 static void igb_clear_interrupt_scheme(struct igb_adapter *adapter)
 {
+	igb_free_irq(adapter);
 	igb_free_q_vectors(adapter);
 	igb_reset_interrupt_capability(adapter);
 }
-- 
2.34.1


