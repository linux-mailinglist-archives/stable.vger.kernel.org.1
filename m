Return-Path: <stable+bounces-189106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6ACC00E73
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 13:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7E23ADB0D
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 11:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BD02FF155;
	Thu, 23 Oct 2025 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HLHAkNtG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907130ACE1
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220162; cv=none; b=kekTiMVp3oJGI3/uSVzmRzw+DTaf93MoZc1LUYbM/LWhMgF9cnKoojaDvFi0k/9KxHkk/9fZeYAuh+0SozUmEOm3aFI7HoUj3T/vIW5ZnQVMQ6oJcIvrRUzQac4CVYvFbVx4UpLE4zqp+4Xeh/RBmjS2hwQJ/tC8FmmJ5kUVfV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220162; c=relaxed/simple;
	bh=79iPdzIZcXEpOn2fJV7WPTXQQVSW5jnCu/uqZCE2w0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYtd7m/1++MHLAkLYapYaPduIm1LdOsYNt8+l2qS35yckD0+lymmgYCioB7VGSOzxZe83Nl44kM4LSAMbZM5MUkA7q3MMIENS8p0IZfhmHTqD0Oqmp6WJRFyYImvtYz3TFro4QqefptrUD3ZoB7sJj3x6o9II3tf7ckLctaTR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HLHAkNtG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NASVNE017019
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=W0YCnq2GUik2GrvaW
	cxPamC9//NEB2FcRp6bT1Acs/E=; b=HLHAkNtG1Dn1i/kseh6xb1SbkV6nMW9O6
	FcZ/D4479HWPJfaae4WQvAR9UBP18QmyX69NmSCFauxysOanAIzxAZUsfzKLNMEt
	6m8tTHO1CuU4yXn+tv6aFzekUsiRnDoroKsUlqN3ZH3WSbbJbp9gMtwDNHpge4Cr
	hebtwls5CLMcnmHHrbRMq1p8zs4DUVwfBCS7HKx+Xiurj6Gbh+yO0iVksjamOzvq
	oZD43IZ0mVldBZ3Tzpx7k6ChMofQgdey4h9OCNO8VI5bFDZihrnLEZoV/KriL6wj
	Z6FabzEFzeU+QMHO53YDu+LR5YPEBReMavFEarHEmxTCeqJC1J5qg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hrd3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:49:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9dfr4017052
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:49:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky5mcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:49:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NBnDfX31916300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 11:49:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3F722004B;
	Thu, 23 Oct 2025 11:49:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA5BD20043;
	Thu, 23 Oct 2025 11:49:13 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 11:49:13 +0000 (GMT)
From: Vineeth Vijayan <vneethv@linux.ibm.com>
To: stable@vger.kernel.org
Cc: hca@linux.ibm.com, oberpar@linux.ibm.com
Subject: [PATCH 6.6.y] s390/cio: Update purge function to unregister the unused subchannels
Date: Thu, 23 Oct 2025 13:49:13 +0200
Message-ID: <20251023114913.2143450-1-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025101904-seltzer-landslide-60b6@gregkh>
References: <2025101904-seltzer-landslide-60b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7a6Z4E+F+1PR
 VX0nNJUL3cE+X0HQS/92YFnXs6uQjN76XhjaLMQPskhUw/p9al5QrlmdE+fZpsOXbuNo1cB98yF
 WXqOgwqqO3viyBdvEecNFIItqDV5VTTcZCo6xsb+PT55ZMwMDus7cDmenElvpvO4oxIaUPHCmtS
 bTekPNAS8nYXZSO+2Zg6pSuWypyJackGZTlrFAzbRJJq7js3CmgOSsA1Y1hNKdnzMLCQt6NxPxX
 oCfAbgz1J23yK/UDt2hD/sXym1Rzm59+i5OWXJtHjDjaqLFM7oD6vK/VMeyejWaJ0w9vo1rz6Wd
 sI3BLNd9/afQr+Z5A0BK3Q69ZX0hzePJZmxttCkCVzqgPZJQ7w+AMB0iZcA8no+Dg07/9IEeT9H
 6TqTS6+NDVFr7q40bDuwob0IJsS0Mw==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fa163e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=qBIcWJXr8Lgkn95qcsUA:9
X-Proofpoint-GUID: ldgCoIFO2PdbxlNGMhUeFx2bpGDuZkwC
X-Proofpoint-ORIG-GUID: ldgCoIFO2PdbxlNGMhUeFx2bpGDuZkwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Starting with 'commit 2297791c92d0 ("s390/cio: dont unregister
subchannel from child-drivers")', cio no longer unregisters
subchannels when the attached device is invalid or unavailable.

As an unintended side-effect, the cio_ignore purge function no longer
removes subchannels for devices on the cio_ignore list if no CCW device
is attached. This situation occurs when a CCW device is non-operational
or unavailable

To ensure the same outcome of the purge function as when the
current cio_ignore list had been active during boot, update the purge
function to remove I/O subchannels without working CCW devices if the
associated device number is found on the cio_ignore list.

Fixes: 2297791c92d0 ("s390/cio: dont unregister subchannel from child-drivers")
Suggested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
(cherry picked from commit 9daa5a8795865f9a3c93d8d1066785b07ded6073)
---
 drivers/s390/cio/device.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 6b374026cd4f..3942aa492176 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1318,23 +1318,34 @@ void ccw_device_schedule_recovery(void)
 	spin_unlock_irqrestore(&recovery_lock, flags);
 }
 
-static int purge_fn(struct device *dev, void *data)
+static int purge_fn(struct subchannel *sch, void *data)
 {
-	struct ccw_device *cdev = to_ccwdev(dev);
-	struct ccw_dev_id *id = &cdev->private->dev_id;
-	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+	struct ccw_device *cdev;
 
-	spin_lock_irq(cdev->ccwlock);
-	if (is_blacklisted(id->ssid, id->devno) &&
-	    (cdev->private->state == DEV_STATE_OFFLINE) &&
-	    (atomic_cmpxchg(&cdev->private->onoff, 0, 1) == 0)) {
-		CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x\n", id->ssid,
-			      id->devno);
+	spin_lock_irq(sch->lock);
+	if (sch->st != SUBCHANNEL_TYPE_IO || !sch->schib.pmcw.dnv)
+		goto unlock;
+
+	if (!is_blacklisted(sch->schid.ssid, sch->schib.pmcw.dev))
+		goto unlock;
+
+	cdev = sch_get_cdev(sch);
+	if (cdev) {
+		if (cdev->private->state != DEV_STATE_OFFLINE)
+			goto unlock;
+
+		if (atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
+			goto unlock;
 		ccw_device_sched_todo(cdev, CDEV_TODO_UNREG);
-		css_sched_sch_todo(sch, SCH_TODO_UNREG);
 		atomic_set(&cdev->private->onoff, 0);
 	}
-	spin_unlock_irq(cdev->ccwlock);
+
+	css_sched_sch_todo(sch, SCH_TODO_UNREG);
+	CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x%s\n", sch->schid.ssid,
+		      sch->schib.pmcw.dev, cdev ? "" : " (no cdev)");
+
+unlock:
+	spin_unlock_irq(sch->lock);
 	/* Abort loop in case of pending signal. */
 	if (signal_pending(current))
 		return -EINTR;
@@ -1350,7 +1361,7 @@ static int purge_fn(struct device *dev, void *data)
 int ccw_purge_blacklisted(void)
 {
 	CIO_MSG_EVENT(2, "ccw: purging blacklisted devices\n");
-	bus_for_each_dev(&ccw_bus_type, NULL, NULL, purge_fn);
+	for_each_subchannel_staged(purge_fn, NULL, NULL);
 	return 0;
 }
 
-- 
2.48.1


