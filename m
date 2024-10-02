Return-Path: <stable+bounces-80553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C777598DE5D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728B61F27EC4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A612DD90;
	Wed,  2 Oct 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RY5bT7GJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25141CEEAF
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881607; cv=none; b=VkOa91Yd9dye5nSg/a/KWwL1Uj/q9zVkSk7HuCFScphxYbFmulCkEZfrYnF8BmrJyNjPKU//grAPKgINZmd5p+BQSeQnAuDgeerRI+JBif6jYf06kM02JRngHRddIBTErXcQ5ZCDIR2uETFYM4s70rky0x8VPOfyxq2B/8UHU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881607; c=relaxed/simple;
	bh=ar9WGvtmDM7n2vbuAzEQHQ8noCp4SB2TLRz8+0tHRVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAUYoiwAQvD+BTHp/ts3n+OCAiMgQ4aKcee5AMbzPzEad//GL4BCRxSuqTSWA/8DSvv5l6KyfXmjsXLIJd3+EFWZ4gLKC9eEqHK7PuiDON6vl8WWEp/DTASQZ7RgIvfrf9Y6B5SpAcbwqFo/GqexDhxJVpXcmO5RHJBc/fLDkgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RY5bT7GJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cd4NR011671;
	Wed, 2 Oct 2024 15:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=d
	GstNvFloCwwllKaTXawq/9MBBJGAo6DGvjavKlon/A=; b=RY5bT7GJCBMPoq3S3
	yim3cv++WUXYUqgyWnL5YvdU4Bu4dG6zV86qMp4FxmL0HV2osQ6qbMHBILjhPxSn
	69SnD90LI9vlmzo653keYoKhAiZoXkZ06WpCyWxj3iUyhfXl2g53t3fI3ekfY3Ea
	9466g8jrHe8DDzJzYSnU4CTfiSgJCZig8DRCYNevVkZGRSbqCoM3hZanx/DMug1a
	4NZVFS6L+2dWJOm+7Q7F12HiOOIYRolfVWoR8xJrnUTmp7CCD0ebq56cAhiDlmot
	Q5IBCy0Mv7tNK1rbQvAuoR9SZlJzgWIGN8d+b+o/dW465IUn2OV7TOOQ/y1KsC6e
	DWI9A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k39p54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492E8x4w017443;
	Wed, 2 Oct 2024 15:06:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888y06r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:06:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492F1lZG012831;
	Wed, 2 Oct 2024 15:06:34 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888xyse-3;
	Wed, 02 Oct 2024 15:06:34 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 02/15] media: usbtv: Remove useless locks in usbtv_video_free()
Date: Wed,  2 Oct 2024 17:05:53 +0200
Message-Id: <20241002150606.11385-3-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002150606.11385-1-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020109
X-Proofpoint-GUID: qloCPlsc0RzueKpWyxwNhrjgJSp0jg6s
X-Proofpoint-ORIG-GUID: qloCPlsc0RzueKpWyxwNhrjgJSp0jg6s

From: Benjamin Gaignard <benjamin.gaignard@collabora.com>

[ Upstream commit 65e6a2773d655172143cc0b927cdc89549842895 ]

Remove locks calls in usbtv_video_free() because
are useless and may led to a deadlock as reported here:
https://syzkaller.appspot.com/x/bisect.txt?x=166dc872180000
Also remove usbtv_stop() call since it will be called when
unregistering the device.

Before 'c838530d230b' this issue would only be noticed if you
disconnect while streaming and now it is noticeable even when
disconnecting while not streaming.

Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the number of queue stored buffers")
Fixes: f3d27f34fdd7 ("[media] usbtv: Add driver for Fushicai USBTV007 video frame grabber")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil: fix minor spelling mistake in log message]
(cherry picked from commit 65e6a2773d655172143cc0b927cdc89549842895)
[Vegard: CVE-2024-27072; no conflicts]
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/media/usb/usbtv/usbtv-video.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 1e30e05953dc6..7495df6b51912 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -962,15 +962,8 @@ int usbtv_video_init(struct usbtv *usbtv)
 
 void usbtv_video_free(struct usbtv *usbtv)
 {
-	mutex_lock(&usbtv->vb2q_lock);
-	mutex_lock(&usbtv->v4l2_lock);
-
-	usbtv_stop(usbtv);
 	vb2_video_unregister_device(&usbtv->vdev);
 	v4l2_device_disconnect(&usbtv->v4l2_dev);
 
-	mutex_unlock(&usbtv->v4l2_lock);
-	mutex_unlock(&usbtv->vb2q_lock);
-
 	v4l2_device_put(&usbtv->v4l2_dev);
 }
-- 
2.34.1


