Return-Path: <stable+bounces-69710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482D7958552
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 13:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0201C243DD
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 11:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201F118DF9A;
	Tue, 20 Aug 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QLOODk1E"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBFA18E353
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151707; cv=none; b=iXExhPvofCpawJmjdUKy465KHIwK5gPgs2QQBE+GJhNwpqkhzqRdbOx4U+reoQkNWAxd1jbgZlbRD0R0njqejChIpmlidnN+lRorVLrwdpiu3P7HMsGzRMkm8sP/LyM79d9ipW4Fp2tqvHb4u+2bIjuVxzTAd3XNrkTLKTgVul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151707; c=relaxed/simple;
	bh=3BOMc/I6AUvlSUOZTCgwNCSKreLKSM1oEQRQEXAPTDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XZtXMGtZvQKDQv58VWRa0cVdFM49+aqXUpSdK8K0ZvO1/Gv64ylBg56HnQOZlErAI26ZlUD4shhtHKCoPTiMzvCF5jiCQKnGAko+GaoC0Wcp5Kos8FPoHrhsDw5hS8RQQP/cpgdjvbpxFTmbaQp76lxw6cmi18lV1deINJEBbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QLOODk1E; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724151705;
	bh=UqkixdU7N5QLZDvZfiyEeqXZZrKl/m9LryM3N8LoHa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=QLOODk1EGMIkHi/M4LxeZ8kNvPDI0FMVgmQBOib1tx6zGiWVA8CdIwdwkYaKBY1bo
	 TY/7uSLEqHR4MbJMo04wvCuDDCUsFYWgPLHgn6e3aYxDWQf8hN/d7BUKBP3ssj11kx
	 E5NZkc75sIA1HU65k3464Qq1gK/GzuLQoVELCcEnRTeYi0jBfar0P1wwUlNUntxjjg
	 m20FpS1ATKpF7+lgzx7FA8H6k6SumZN0wNUh3oy+3RgenHbNVlU4lcK22B2rTZZlQ9
	 iFHOMEaLfUW0qIFMm642bzY0YIwzjo+5HT75ZiNlh1PtdaRip7fONwkrT+8Sd1DPI7
	 sUYYzWdg1yY2Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 7E5E3DC02FD;
	Tue, 20 Aug 2024 11:01:41 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 20 Aug 2024 19:01:27 +0800
Subject: [PATCH v2] usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group
 in remove_power_attributes()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-sysfs_fix-v2-1-a9441487077e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIZ3xGYC/23Myw7CIBCF4VdpZi0GJnjBle9hGkMptbOQKqPEp
 uHdHbt2+Z+cfAtwzBQZTs0CORZimpIEbhoIo0+3qKiXBtRo9dFYxTMPfB3ooxD1vo+u0+bgQP6
 PHGVerUsrPRK/pjyvdDG/9Z9SjDJCofXoPO5cd36+KVAK2zDdoa21fgFpzvKNpAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kevin Strasser <kevin.strasser@linux.intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: 6ZI_q_dh1mFYLwigoPRy9l_i9NesIjNz
X-Proofpoint-GUID: 6ZI_q_dh1mFYLwigoPRy9l_i9NesIjNz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1011 mlxlogscore=991 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408200082
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Device attribute group @usb3_hardware_lpm_attr_group is merged by
add_power_attributes(), but it is not unmerged explicitly, fixed by
unmerging it in remove_power_attributes().

Fixes: 655fe4effe0f ("usbcore: add sysfs support to xHCI usb3 hardware LPM")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Add stable tag
- Link to v1: https://lore.kernel.org/r/20240814-sysfs_fix-v1-1-2224a29a259b@quicinc.com
---
 drivers/usb/core/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index d83231d6736a..61b6d978892c 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -670,6 +670,7 @@ static int add_power_attributes(struct device *dev)
 
 static void remove_power_attributes(struct device *dev)
 {
+	sysfs_unmerge_group(&dev->kobj, &usb3_hardware_lpm_attr_group);
 	sysfs_unmerge_group(&dev->kobj, &usb2_hardware_lpm_attr_group);
 	sysfs_unmerge_group(&dev->kobj, &power_attr_group);
 }

---
base-commit: ca7df2c7bb5f83fe46aa9ce998b7352c6b28f3a1
change-id: 20240814-sysfs_fix-2206de9b0179

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


