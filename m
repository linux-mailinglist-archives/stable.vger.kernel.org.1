Return-Path: <stable+bounces-208327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9BDD1CCEC
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 08:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17B0E300DDA5
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 07:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5035F8DC;
	Wed, 14 Jan 2026 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lQhFQJgL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B635F8B9
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375500; cv=none; b=j6MeT7inR3RnaWxlFoYjH8vXvStOpOxXS3Ufx2vDMGZy4eUysvBQgatptoQqqhLyHAX6mxA1juswcGLZodZoqWo4AVG4UbhcHOXFKJTzU+rHJplBE7CuGLeWkATcdZ3n8hd9FEeFUUGqRA8rRAbhMb/ne+tdMZjf7JOinM7ZHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375500; c=relaxed/simple;
	bh=52p8I4JwBKGU2vmHCPgvcTMi0FAqudS+dxf7AArUnKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tVAYWOWiZaEdLHpkeDApRCvajC/I4UUwj0Cgjhfq63JzaqCIklYhwWPavEKp1SuIkKLgpHVLDkyMmRviTxteWhhzdFHt8s15waejWdFfHpbcBd+sOL1le8KUyKjwnr9s67NrfWgjxdbmv5QIBVA/wKF4WeAg6H38jkTbNNp6M3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lQhFQJgL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E7NUgj032261;
	Wed, 14 Jan 2026 07:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=3EsM6fsCuyZR7jfkZK39hL3LKS0W
	d+eeqbJN8ThtLnE=; b=lQhFQJgLkeVQ70kUeoMB/3Q18qzKhrLnflCty7Gr0RlC
	tKj08ctOSSMcRwPwwXcBVW346NbnOT+Ng7JO7kHHPOIgFLolpKaH793lyjSILBiY
	3CbP+Ky2GUPij6A0TJ7vFITuRZYcns10BLxH0Vqkz9rPxO4QAK77oCgi07PWtXvh
	Q8dpu+1tZKvGPXF6LIgCOUtHkuVqIKiIbQCl57a8VJkrNffAHtwsB2J3s+eTU3JB
	Pm9yzLmNdxfcFM5rpz1SUE7+1DWnugQJDnFOcwnkEMZTBpkI9YhdXtvow5BB7L+W
	U6gFMEptkqS0XiFiWMCyhfRroQNXefd4S8CNa7GEMg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsyt3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 07:24:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60E6QtWZ002511;
	Wed, 14 Jan 2026 07:24:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13srxqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 07:24:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60E7OTto56492436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 07:24:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 262B720043;
	Wed, 14 Jan 2026 07:24:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 543F920040;
	Wed, 14 Jan 2026 07:24:23 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.133.154])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 07:24:23 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: jmeneghi@redhat.com, wagi@kernel.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, james.smart@broadcom.com, hare@suse.de,
        shinichiro.kawasaki@wdc.com, wenxiong@linux.ibm.com,
        nnmlinux@linux.ibm.com, emilne@redhat.com, mlombard@redhat.com,
        gjoyce@ibm.com, Nilay Shroff <nilay@linux.ibm.com>,
        stable@vger.kernel.org
Subject: [PATCH] nvme: fix PCIe subsystem reset controller state transition
Date: Wed, 14 Jan 2026 12:54:13 +0530
Message-ID: <20260114072416.1901394-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA1NiBTYWx0ZWRfXwLfjDh4qtMp9
 NdImLvS9dI4wYvjFiRrQ64PcDDRdwIbI2gkr16j+u9cyiyKXT6RXGJqTE7y8I/WXM4ztxte7Xp1
 vy3/2wzybq4u89FxImnQfvQRspaUIjy87A3tb4l/m1bWeR2I5hxNPzW7HVwZoWw+nCsSN/6wC90
 W3iRgbQzC3WT5LReiXUKUxR8ufGvGD9s1geSjIQX0v+HfkC3NZ+be/LhTFu6pkUdWhxyPa2j8tx
 +2YEMrRElzEXPKl7yjmX+H9ONy30PA1BSozahhtwD7AHnQzUEXRQ+MwsRSpoLKHqGK8yktca1qb
 ivcm3FP/Sbr3L21VS018ZvZkKVCzj8ha/w/RCTYoUDxKYwNZNO8yi7yMt4G7kkX/CfjjTii4fL/
 swmPc2NAAX1QGEjMSsDIQooLX9g29bXeV0IhHOWQdQLcxdzgE3r7s2tahp4tL2JIqOulbbyZOPd
 DCXJIQaDXkhS4jc1G/A==
X-Proofpoint-GUID: gW0OW5-_sg8mLAJKpRtZuVXmQOrGgZHC
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=696744b2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=bihmBxQwaCVq7hZI4EMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gW0OW5-_sg8mLAJKpRtZuVXmQOrGgZHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140056

The commit d2fe192348f9 (“nvme: only allow entering LIVE from CONNECTING
state”) disallows controller state transitions directly from RESETTING
to LIVE. However, the NVMe PCIe subsystem reset path relies on this
transition to recover the controller on PowerPC (PPC) systems.

On PPC systems, issuing a subsystem reset causes a temporary loss of
communication with the NVMe adapter. A subsequent PCIe MMIO read then
triggers EEH recovery, which restores the PCIe link and brings the
controller back online. For EEH recovery to proceed correctly, the
controller must transition back to the LIVE state.

Due to the changes introduced by commit d2fe192348f9 (“nvme: only allow
entering LIVE from CONNECTING state”), the controller can no longer
transition directly from RESETTING to LIVE. As a result, EEH recovery
exits prematurely, leaving the controller stuck in the RESETTING state.

Fix this by explicitly transitioning the controller state from RESETTING
to CONNECTING and then to LIVE. This satisfies the updated state
transition rules and allows the controller to be successfully recovered
on PPC systems following a PCIe subsystem reset.

Cc: stable@vger.kernel.org
Fixes: d2fe192348f9 ("nvme: only allow entering LIVE from CONNECTING state")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0e4caeab739c..3027bba232de 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1532,7 +1532,10 @@ static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
 	}
 
 	writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
-	nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
+	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+		goto unlock;
 
 	/*
 	 * Read controller status to flush the previous write and trigger a
-- 
2.52.0


