Return-Path: <stable+bounces-230171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKqtLZGbwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:11:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02269309F7C
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95D07305540A
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075E03FADEC;
	Tue, 24 Mar 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r9sO8Xxe"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848683F65EC
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361124; cv=none; b=g7C/ENNtcWZPL0IZ83eSiIVqZvZ/gWNgi0iY7PajH5eR838eiTChX2/zFTWC6OYb4JMPuoW0VRLue6anXHVmay1T5uStDmxE2jmoeX3z0YSCkDSL7Hlc2Ylgt5os+5E0Th40z5EQA2yKHLoP0F0FJYQjZ+7spp5JK7pepfX7tQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361124; c=relaxed/simple;
	bh=eAakil53u9cOyucILLXCl/3got2LrW8XRbGWEasFkqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkBc8XXFvSpMxpo/bzSvTI3Akc/VpbUaFqL2xLfvusD90aeOsTsIi/xzXbONXlzD32+WgUSV6bwjwEqh/nejSbSffEAvNXub34kfamEPUqrrHprgrlOkbsU220j7dyOovRY2zZ/DoAjGcN7mTDcUwHI5VqQY00wEeD7z+ijydag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r9sO8Xxe; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCCifi2738033;
	Tue, 24 Mar 2026 14:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=SprPQ
	HGe1pyMPm1F/9Te8GDoyGc6ajFUDWPY+LIOSrg=; b=r9sO8XxeXXPEDtiFLPGb0
	lg7rCFRFAJr6i4+r5fSJX3sHsFDKAKybuy0E/UkDXQr35gIUeoHXZ1j2tStmy6PU
	1FR3cQ5kLUasqKF+XFXMaCjIMUEPNBVn8ynJxEDuSK1eb1VyZSAbvMj4RscgCeCW
	M7IBoXuN5VK0W+3ZlNLJvcTrHal2UafYhyFKJ2S4gSpT4akjcrQhk5T5zc7gxUaX
	XLbSfOE0Rff+YJKrbLMhw3hrpRzpNyX3FIBgdywJHA8kyds7tG2b4k7B/yi5x6pO
	ozlOYO3o8V0KKftliUGQ/UoJop0u3RP6RhEkiSn9CSFaMi+DzCpY8736ovJM2LMq
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khvvbkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCJRjK040012;
	Tue, 24 Mar 2026 14:05:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs9pdnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OE50Ee023161;
	Tue, 24 Mar 2026 14:05:09 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs9pd7j-5;
	Tue, 24 Mar 2026 14:05:08 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>, Rinitha S <sx.rinitha@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 4/9] ice: fix devlink reload call trace
Date: Tue, 24 Mar 2026 07:04:51 -0700
Message-ID: <20260324140456.832964-5-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
References: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMSBTYWx0ZWRfX7ARYg9OKY76v
 a0nQRE+LYDKtYy93+wRDopJ+EO8szNbA1PfULf2UNXOa0uOM3E96PSS6UPdsT0JJgrbW0LPaSzq
 kOEYq6K/CV/XK3m+lnbVwrR4S752WClFx5xXHSe/PlZMlSA/5wOJIpyZYFfP15yjUxSVwedtHEf
 paJNAbBS/4Nvaxan43cbipY1RRA7jPaPqsRDhKSgC8iQda0+YYwPVgjYvgo5gzF0ikWiUMvXF8W
 6zgtGhv4i4kwoQ3DEK7eMQeo4cUY2CmaVfDPha1UODVqxX8iZg+F2WPe4cJCfa16lkW1QtLsRp7
 FPD+xDQBoiaYknwJMfd+PZPTQCmuYcGz+14JpE7wfzOWwKDXaIXBcmAMSgc3EbSqaQrLV+hzCko
 5U9XG5VEMm7AN0LbpbJwsn5fiiBKQ0g0Udq+imLTqdOqMlNBokN5M6GVmYA3x8mvQb68LI2+oMl
 okC5zhrdELVZUgjXrFw==
X-Authority-Analysis: v=2.4 cv=VIXQXtPX c=1 sm=1 tr=0 ts=69c29a16 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=26lpZ-3Jh0eclsTWaiwA:9
X-Proofpoint-GUID: u0Uo0SweRg4hpYCIGglIdzCUinu8__Py
X-Proofpoint-ORIG-GUID: u0Uo0SweRg4hpYCIGglIdzCUinu8__Py
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230171-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mpg.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[oracle.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 02269309F7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Greenwalt <paul.greenwalt@intel.com>

[ Upstream commit d3f867e7a04678640ebcbfb81893c59f4af48586 ]

Commit 4da71a77fc3b ("ice: read internal temperature sensor") introduced
internal temperature sensor reading via HWMON. ice_hwmon_init() was added
to ice_init_feature() and ice_hwmon_exit() was added to ice_remove(). As a
result if devlink reload is used to reinit the device and then the driver
is removed, a call trace can occur.

BUG: unable to handle page fault for address: ffffffffc0fd4b5d
Call Trace:
 string+0x48/0xe0
 vsnprintf+0x1f9/0x650
 sprintf+0x62/0x80
 name_show+0x1f/0x30
 dev_attr_show+0x19/0x60

The call trace repeats approximately every 10 minutes when system
monitoring tools (e.g., sadc) attempt to read the orphaned hwmon sysfs
attributes that reference freed module memory.

The sequence is:
1. Driver load, ice_hwmon_init() gets called from ice_init_feature()
2. Devlink reload down, flow does not call ice_remove()
3. Devlink reload up, ice_hwmon_init() gets called from
   ice_init_feature() resulting in a second instance
4. Driver unload, ice_hwmon_exit() called from ice_remove() leaving the
   first hwmon instance orphaned with dangling pointer

Fix this by moving ice_hwmon_exit() from ice_remove() to
ice_deinit_features() to ensure proper cleanup symmetry with
ice_hwmon_init().

Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
(cherry picked from commit d3f867e7a04678640ebcbfb81893c59f4af48586)
[Harshit: Backport to 6.12.y, conflicts resolved due to missing
8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
in 6.12.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8e0f180ec38e..8683883e23b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4920,6 +4920,7 @@ static void ice_deinit_features(struct ice_pf *pf)
 		ice_dpll_deinit(pf);
 	if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_SWITCHDEV)
 		xa_destroy(&pf->eswitch.reprs);
+	ice_hwmon_exit(pf);
 }
 
 static void ice_init_wakeup(struct ice_pf *pf)
@@ -5451,8 +5452,6 @@ static void ice_remove(struct pci_dev *pdev)
 		ice_free_vfs(pf);
 	}
 
-	ice_hwmon_exit(pf);
-
 	ice_service_task_stop(pf);
 	ice_aq_cancel_waiting_tasks(pf);
 	set_bit(ICE_DOWN, pf->state);
-- 
2.50.1


