Return-Path: <stable+bounces-189110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DCCC0102B
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 14:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92371882AD8
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 12:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD3C26F28A;
	Thu, 23 Oct 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o+O6ZaS1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7868C30F947
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221475; cv=none; b=uxdGcRZLKJl4VGUXquktg7AnvuUZAhrtvMQd+VA/mFL+HQzUM1CR2IFYmX1c4fqEskWIzuJEOfG3se+SYtaLbdXBt4BFKjFTIxG/xEIYE1gfdD2RtSiJeQpIS6xTIFZG2obJ9EzFmAaIApnmVJOjhf1/j6yT+O0KS7Z2pOtEevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221475; c=relaxed/simple;
	bh=CYvHylNS6hcYBLpiTAK2C78cwJbw2AHwBn5or1y+tnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYX6/muxMlzS/2hvpVwP04+Q9CBi68oUqilwsxVGuawMiDsK/zqqqOAfFrTt6MbFAuRTWgUHmqiLv4vDWYoYU56WNAfToeRkXC2PZOJT6+CixaqzmI5QVYQUW+jJQTB+iamwlopGpi2chC33YugL9LfhU/UlY7dU164S3JI7Cv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o+O6ZaS1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MNVL0P000967
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 12:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cWn/jUqusXDQWE9Tg
	Plye4s6kmopJKbZmYMbKIAqkbM=; b=o+O6ZaS1gTqUZ9cD6kCIK4BIKWhqQPoeY
	IPCq52Hc01Au5MgPUP1dGlj9+X55MhyLBEgYywkYhI3Tct1SLOXyGgc5mvaMkVxV
	uHMZF0zhEzgrr1KhTiHc4MobjxrTqDo74n9wCD8JsNi7Uc/czwXS2yGbka4Nayrh
	RDWaC2nHMEz1T2xUiU2XDmN+2u+gUau8MD3HDcboqQSSbq0pQYBlC1BL0DMMvMjZ
	j9NsLob1RO9Qe3BRw598t1PGas1FYUHa3RaGAODdEUL898/QYTTgyP5UQQiU53VT
	MrgnpKVAIkBI7pj7yNfrM1XjrxgimfoXkYXIWoWLDINOkjsFSNqjg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgn2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 12:11:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAk03U024940
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 12:11:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk5gw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 12:11:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NCB6k742795456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 12:11:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F23DB2004D;
	Thu, 23 Oct 2025 12:11:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE0812004B;
	Thu, 23 Oct 2025 12:11:05 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 12:11:05 +0000 (GMT)
From: Vineeth Vijayan <vneethv@linux.ibm.com>
To: stable@vger.kernel.org
Cc: hca@linux.ibm.com, oberpar@linux.ibm.com
Subject: [PATCH 5.15.y] s390/cio: Update purge function to unregister the unused subchannels
Date: Thu, 23 Oct 2025 14:11:05 +0200
Message-ID: <20251023121105.2414775-1-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025101905-depress-banjo-bc7e@gregkh>
References: <2025101905-depress-banjo-bc7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QnqJW7pMxZXkP0eImBSAzHk2syQPKHQP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7AkcY7ZtLyeQ
 ZFyEGoSlygtEZl7iYThzTOKGt6x0yDMlGBcg+cNZlGDFlkaLaI/bduweShngDdCyTBz8G5xc8QX
 edluPObZNJWfBVv0KuzPZYGqqquPKsFCxILpk/Ims4q+NAiGpL+/SYU09s21ft05D3eqfm9FKpu
 QyFb9I31rr0qgOrH9NaHRMEO+NTqeD6ZLTuHqnpeuhrMHYyHZuJ5M7v18bxOPjkEQfp+6G56M8j
 krm9YEvd7647JtIO91g8mIGdM/M67zzalnnWJ8pvf0Yuw3llWNY58gBmZ6cLuVnLG73sbNan8ho
 invrbbV+c6uikBN1yUXGXOaEa+sbs3tB0IiiSqcn/5vuOtUkkoHtY6C15tWNWHcfM12SV5qfTgE
 q76WQmULjQpHilvmObt8dhFmUlGWqw==
X-Proofpoint-GUID: QnqJW7pMxZXkP0eImBSAzHk2syQPKHQP
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa1b5e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=qBIcWJXr8Lgkn95qcsUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
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
index 70c5b85d2dfc..7f1d4b41391a 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1323,23 +1323,34 @@ void ccw_device_schedule_recovery(void)
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
@@ -1355,7 +1366,7 @@ static int purge_fn(struct device *dev, void *data)
 int ccw_purge_blacklisted(void)
 {
 	CIO_MSG_EVENT(2, "ccw: purging blacklisted devices\n");
-	bus_for_each_dev(&ccw_bus_type, NULL, NULL, purge_fn);
+	for_each_subchannel_staged(purge_fn, NULL, NULL);
 	return 0;
 }
 
-- 
2.48.1


