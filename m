Return-Path: <stable+bounces-183860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA16BCC030
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 10:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF56D1A6461B
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3D2750E1;
	Fri, 10 Oct 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CBsueoYO"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EB272810;
	Fri, 10 Oct 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083242; cv=none; b=tZnHv0w5ghPwTEfIxiXbj+xiyDn+DvcDOFNdfnVWUy5Xc8W501nJs4P8W2bMj/vniLM+WJkDPezohf1Fk4GCf+1GLuEmTro2rdomCmn4tmjVnKEPQ9/0x13K8Q0lGwZ1nJMwQr2MX4L195ehQ3H1Z+3W28WKLt1qfhUNc9fm+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083242; c=relaxed/simple;
	bh=7VSc4VZGRf4kATJd9RpFMALSCnx/oi6QGglUySBWA3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GRbLv/AwsE0OnbelL2sVHWk/Bup54nCzsFvZuh9PqQgNpS5DlnncJimQPtKoaDIR0HpAX1RpQDIZVEyMU2rbyXtC4M/lY8HyZM1+w6VXOh7HmrHEeRf8oaZQt3NnLaYRYcHkxUOJaEadZ3oTQxIsn/h13anD88bUlbInt/nK3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CBsueoYO; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ri
	4q9fhZbJ9iRglDYBjtEDYzk9imyFA9mfEoZbEnZks=; b=CBsueoYOusTSV9Z6gD
	KUzdGe+lvatYdGArYQoUAOSMpTLvcIKtfTV/EHD+nKoXsm71P337FVUqey0dSLMM
	7MJ8znVx+zQuIqP1TSMGvRQjZlekImhBjKdXkt8X/TZeDJpH8phHAExBOA5MbpmT
	q+zxEtPGvjpTGsUiGYhHoIiS0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBH2wn3vOhoULLLDA--.5915S2;
	Fri, 10 Oct 2025 15:59:52 +0800 (CST)
From: yicongsrfy@163.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	oneukum@suse.com
Cc: horms@kernel.org,
	kuba@kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	yicong@kylinos.cn,
	stable@vger.kernel.org
Subject: [PATCH net v2] r8152: add error handling in rtl8152_driver_init
Date: Fri, 10 Oct 2025 15:59:49 +0800
Message-Id: <20251010075949.337132-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH2wn3vOhoULLLDA--.5915S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWrGFWfur1UXr1fJw43Wrg_yoWkZrcEkr
	yIga47Xr1DuFW5KF15WrWavrySkan0vFs3Zr4xt3sIgwnrXrn5Gr1UZr9xXw4UWrWfZFnx
	Ca1UGFyxCr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU82iiDUUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiLBPi22jouzAv0AAAsy

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


