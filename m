Return-Path: <stable+bounces-94093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B569D335C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 07:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1A7283E97
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 06:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774F71531F0;
	Wed, 20 Nov 2024 06:03:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0DA27447
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732082619; cv=none; b=OU4KwEVOpE4V2ZIs7jQ7qslV688W9Wjbka0P5Qj7F/SsQzx50Y/P7MBDz2u4JlCUO+VVOzL4Q6l1PfoahyWypS+MBXehtF+V7Khx4x5zXWhjbQIiHA1vtJHlVcVf3PoQmYEnxP809dNpameJ3shtJpO3jsRGQ4x1z5tYxDmTdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732082619; c=relaxed/simple;
	bh=xe2UuTOo1ONej21wZd5ahb+d5O1UCMDckf5BP34lT9U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UykrKWWJ3hd/iXWL/0qaIuCG4FqlGj7FagKVKUfAIZMqy6UNakB6JFSJsRSpeZq5GG7nzxNxdpcxEdWJtKOtLb6knbR2XxsAYhk13Ze/qqAIoyZDJcMp7m/2op/NJAFmH0o45Tc8Xzd/uJ8ToMIlPHXU23TAIUvzixu9mV0e4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK5o3w7031115;
	Wed, 20 Nov 2024 06:03:34 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0kyjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Nov 2024 06:03:33 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 19 Nov 2024 22:03:32 -0800
Received: from pek-blan-cn-d1.wrs.com (128.224.34.185) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 19 Nov 2024 22:03:31 -0800
From: Bin Lan <bin.lan.cn@windriver.com>
To: <eli.billauer@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH 6.1] char: xillybus: Prevent use-after-free due to race condition
Date: Wed, 20 Nov 2024 14:03:52 +0800
Message-ID: <20241120060352.3115727-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OOyqbs0-R4m7OLu4zrrYX47TmBm4zQSJ
X-Proofpoint-GUID: OOyqbs0-R4m7OLu4zrrYX47TmBm4zQSJ
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673d7bb5 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=xcIDifnWtur65-UD1b8A:9
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_02,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411200043

From: Eli Billauer <eli.billauer@gmail.com>

[ Upstream commit 282a4b71816b6076029017a7bab3a9dcee12a920 ]

The driver for XillyUSB devices maintains a kref reference count on each
xillyusb_dev structure, which represents a physical device. This reference
count reaches zero when the device has been disconnected and there are no
open file descriptors that are related to the device. When this occurs,
kref_put() calls cleanup_dev(), which clears up the device's data,
including the structure itself.

However, when xillyusb_open() is called, this reference count becomes
tricky: This function needs to obtain the xillyusb_dev structure that
relates to the inode's major and minor (as there can be several such).
xillybus_find_inode() (which is defined in xillybus_class.c) is called
for this purpose. xillybus_find_inode() holds a mutex that is global in
xillybus_class.c to protect the list of devices, and releases this
mutex before returning. As a result, nothing protects the xillyusb_dev's
reference counter from being decremented to zero before xillyusb_open()
increments it on its own behalf. Hence the structure can be freed
due to a rare race condition.

To solve this, a mutex is added. It is locked by xillyusb_open() before
the call to xillybus_find_inode() and is released only after the kref
counter has been incremented on behalf of the newly opened inode. This
protects the kref reference counters of all xillyusb_dev structs from
being decremented by xillyusb_disconnect() during this time segment, as
the call to kref_put() in this function is done with the same lock held.

There is no need to hold the lock on other calls to kref_put(), because
if xillybus_find_inode() finds a struct, xillyusb_disconnect() has not
made the call to remove it, and hence not made its call to kref_put(),
which takes place afterwards. Hence preventing xillyusb_disconnect's
call to kref_put() is enough to ensure that the reference doesn't reach
zero before it's incremented by xillyusb_open().

It would have been more natural to increment the reference count in
xillybus_find_inode() of course, however this function is also called by
Xillybus' driver for PCIe / OF, which registers a completely different
structure. Therefore, xillybus_find_inode() treats these structures as
void pointers, and accordingly can't make any changes.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
Link: https://lore.kernel.org/r/20221030094209.65916-1-eli.billauer@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/char/xillybus/xillyusb.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 3a2a0fb3d928..45771b1a3716 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -185,6 +185,14 @@ struct xillyusb_dev {
 	struct mutex process_in_mutex; /* synchronize wakeup_all() */
 };
 
+/*
+ * kref_mutex is used in xillyusb_open() to prevent the xillyusb_dev
+ * struct from being freed during the gap between being found by
+ * xillybus_find_inode() and having its reference count incremented.
+ */
+
+static DEFINE_MUTEX(kref_mutex);
+
 /* FPGA to host opcodes */
 enum {
 	OPCODE_DATA = 0,
@@ -1234,9 +1242,16 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
 	int rc;
 	int index;
 
+	mutex_lock(&kref_mutex);
+
 	rc = xillybus_find_inode(inode, (void **)&xdev, &index);
-	if (rc)
+	if (rc) {
+		mutex_unlock(&kref_mutex);
 		return rc;
+	}
+
+	kref_get(&xdev->kref);
+	mutex_unlock(&kref_mutex);
 
 	chan = &xdev->channels[index];
 	filp->private_data = chan;
@@ -1272,8 +1287,6 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
 	    ((filp->f_mode & FMODE_WRITE) && chan->open_for_write))
 		goto unmutex_fail;
 
-	kref_get(&xdev->kref);
-
 	if (filp->f_mode & FMODE_READ)
 		chan->open_for_read = 1;
 
@@ -1410,6 +1423,7 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
 	return rc;
 
 unmutex_fail:
+	kref_put(&xdev->kref, cleanup_dev);
 	mutex_unlock(&chan->lock);
 	return rc;
 }
@@ -2244,7 +2258,9 @@ static void xillyusb_disconnect(struct usb_interface *interface)
 
 	xdev->dev = NULL;
 
+	mutex_lock(&kref_mutex);
 	kref_put(&xdev->kref, cleanup_dev);
+	mutex_unlock(&kref_mutex);
 }
 
 static struct usb_driver xillyusb_driver = {
-- 
2.43.0


