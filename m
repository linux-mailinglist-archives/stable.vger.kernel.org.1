Return-Path: <stable+bounces-183858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FB4BCBFFE
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 09:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 602D64F8C9C
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D6227602A;
	Fri, 10 Oct 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DV5A/3CU"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058402750E1
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083102; cv=none; b=OL34CBbSk/FXW7idOGz9TnSiO3G6pzvqFo4D3sAkQ0lzzHEpmLc6GYCdle6YZL6bGjiZN3dPZI0KcQQMPcYXPjpp8uuibVZ6e/ErYXsZUkFsrvYcrkJnBEMgrEvW5DtfJXih/D9HrO+u7SThH1lJVT18JPR8QG97RuVc0O4B3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083102; c=relaxed/simple;
	bh=7VSc4VZGRf4kATJd9RpFMALSCnx/oi6QGglUySBWA3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EsuTxoAhDpB21IymadHqx85xdimhC1MBRlaN2RrlMMIOjvJbixV5eqbWISflp7Kpl2nebpBLH4aw30trjEobllj0OPABxBSrshVWAGVP3myK+y8FC16rZGtuF4JHb7I+ll/h6wKrbQnxCPflT1Shf8lk0eva+otCQLXW3e72boo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DV5A/3CU; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ri
	4q9fhZbJ9iRglDYBjtEDYzk9imyFA9mfEoZbEnZks=; b=DV5A/3CUKof5HbiAVU
	Km8kmY3kRjiMemkAl3O1tKi3/54UU9v7IWmMP8d2FqDdEvMONFpHtoDDvGoJuPcV
	LeEgjyQ39J+OEgIs9cRhbxRZvaxVahcqgEsGrzc/nQDCGC9g1SFgbvQKYpYsKo4B
	0H2rY1fJUN+y36jISePtG62aA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCXJPGMvOho+FghBw--.11709S2;
	Fri, 10 Oct 2025 15:58:05 +0800 (CST)
From: yicongsrfy@163.com
To: yicong@kylinos.cn
Cc: stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] r8152: add error handling in rtl8152_driver_init
Date: Fri, 10 Oct 2025 15:58:02 +0800
Message-Id: <20251010075802.336603-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCXJPGMvOho+FghBw--.11709S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWrGFWfur1UXr1fJw43Wrg_yoWkZrcEkr
	yIga47Xr1DuFW5KF15WrWavrySkan0vFs3Zr4xt3sIgwnrXrn5Gr1UZr9xXw4UWrWfZFnx
	Ca1UGFyxCr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbSAp7UUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBzRPi22joV1ebmwABsm

From: Yi Cong <yicong@kylinos.cn>

rtl8152_driver_init missing error handling.
If cannot register rtl8152_driver, rtl8152_cfgselector_driver
should be deregistered.

Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Cong <yicong@kylinos.cn>
Reviewed-by: Simon Horman <horms@kernel.org>

v2: replacing return 0 with return ret and adding Cc stable
---
 drivers/net/usb/r8152.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 44cba7acfe7d..8a0c824e9eb4 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10122,7 +10122,14 @@ static int __init rtl8152_driver_init(void)
 	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
 	if (ret)
 		return ret;
-	return usb_register(&rtl8152_driver);
+
+	ret = usb_register(&rtl8152_driver);
+	if (ret) {
+		usb_deregister_device_driver(&rtl8152_cfgselector_driver);
+		return ret;
+	}
+
+	return ret;
 }
 
 static void __exit rtl8152_driver_exit(void)
-- 
2.25.1


