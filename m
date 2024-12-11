Return-Path: <stable+bounces-100511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4D79EC215
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 03:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690A2169864
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 02:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0811918EAD;
	Wed, 11 Dec 2024 02:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CcqNjutO"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB9C1BD9E6;
	Wed, 11 Dec 2024 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884021; cv=none; b=RaM/Oktmwo4d0+FdQWWLiyfwCwrAik8OTCfr3xCnqcyIq8kaF+FudpUbMK+QCET36yuVtqQDSYMNXqx11gP5DSgcsN/1nzy7SSHIXEWyYKDIpwFtsQGtLLQdqgj+Z/ZlaAIRGD7wQyrEymBKECTHxISmGF2XUzrayk/UFKWDwFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884021; c=relaxed/simple;
	bh=Q7gT5UPh646tXmWXFz8AQJe47Gh1rfWWFi5jofs2n6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aE94nHqa2meoUydQktmB2XIxv4PtTN45KT00tsX3I8xIR4RCtcKGxmurLhb0iaodTn/mv6RSswmajQexovZvfkAIgqJQr10PrNOrSr0Fu+XAviPpA3zJ0KBaIsBI3OTC1rjE6DAPBKMc75QOEnHmWyjmEdc1UyjJl69gHVCG8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CcqNjutO; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KKNPe
	pEhel2YrTC/NHwwhpdzTF8i+bHDK6KR7Fq9aa4=; b=CcqNjutOWOzWTrb/2frK8
	APw1osJLyOM15gArSpP37iccdK4joP9uOQ8J6uWqZNMNjii1I70diIHrOTGPVhFm
	8EmuZPj9jvbyJk2/afSs4urM92hnJY7F+WumivwBcRv2Q66fqXqA099zxOSXRUcz
	jv1jd7Hs9/+2NBVVBV8Muk=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBXjH9F+FhnTh6jAw--.23094S4;
	Wed, 11 Dec 2024 10:26:21 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vdronov@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] ptp: Check dev_set_name() return value
Date: Wed, 11 Dec 2024 10:26:12 +0800
Message-Id: <20241211022612.2159956-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBXjH9F+FhnTh6jAw--.23094S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyrGFy3uw48Cw15uryUJrb_yoWDCFXE9r
	W2vr9rJr1kWan3tF1vkrsIv3yIyrWDtF4xGFs2q393GFWrur1rCrWkZFyqgw4DXa1fGr15
	AFZrJry3Zr47tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRApnDUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBXxayC2dY8AxofgABsk

It's possible that dev_set_name() returns -ENOMEM. We could catch and
handle it by adding dev_set_name() return value check.

Cc: stable@vger.kernel.org
Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/ptp/ptp_clock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 77a36e7bddd5..82405c07be3e 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -348,7 +348,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	ptp->dev.groups = ptp->pin_attr_groups;
 	ptp->dev.release = ptp_clock_release;
 	dev_set_drvdata(&ptp->dev, ptp);
-	dev_set_name(&ptp->dev, "ptp%d", ptp->index);
+	err = dev_set_name(&ptp->dev, "ptp%d", ptp->index);
+	if (err)
+		goto no_pps;
 
 	/* Create a posix clock and link it to the device. */
 	err = posix_clock_register(&ptp->clock, &ptp->dev);
-- 
2.25.1


