Return-Path: <stable+bounces-196630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D292C7ECEE
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 03:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93873A4E63
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 02:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222E539FD9;
	Mon, 24 Nov 2025 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FWHqq7YK"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861EB36D4FF
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763950593; cv=none; b=MaUVqHMgIhRZkmcahB9Ub483fjyEfUxcDVqw1W+FO8VTL+ElVlkM8er1cuONQrVJdSR9devDlQAgdcwauIWrAbygZRi6QV03txUrnxvkNbTRSQooRaQPmdi7+qtoYuwkwYNE6/rz+YbZsQxE36vLb4E0Of2Vk19dkFTrIs+Mpvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763950593; c=relaxed/simple;
	bh=888BHWiS7ec5yufAqpWGnlWW+ohceq6R44aLs6AoCO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u9s/BPUCkySXJ/nP+18cY2xIEs1EyTZR3Yr9smTpZUY9Y8sUxr8YfJKUzTx9xIGOz3rLP7cr4MFWnSby7F7ALu14rLB35Nq4HJbxOccKu2ahs1wavpBongxzLaFu4rTdcboDuaZD96MAAbre9/kgUNBBQsoSeK5RDsidYtL6idQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FWHqq7YK; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1763950530;
	bh=tlwydK0pQM9PXcbC8HT7OpkKdVWT3W5cYJBFd0H7b7c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=FWHqq7YKywAQO3HOIvR9QnKYb3hkLG24GXYOTOecfuzSGL7zrqAg1AMsCwnZdQjeW
	 6VHiC5Ax3WXFNwxFEzuuD4PP39byon3nFoFIlCYpvIDVbJSYoJRwTtj+eJAj7vpw9b
	 NqJwS1zIijnUFo3tLwpM1BS1fR98BJm2sQSZzyyE=
X-QQ-mid: esmtpsz17t1763950521t0941dbb7
X-QQ-Originating-IP: zhEx+X09pSgK/Yts7zUvK4PZ8OueWRhfXbzAYHq1VuE=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Nov 2025 10:15:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4272393424526828332
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: tatyana.e.nikolova@intel.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.12] Revert "RDMA/irdma: Update Kconfig"
Date: Mon, 24 Nov 2025 10:14:59 +0800
Message-Id: <20251124021459.691989-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OT+IXMQ0pPucoJFjONIt3ltCZYlyMV2iu6kRmDBZDS6G70e5yf98+VB5
	VR3sH3PrAjLokPBeyi1TJjRLevYdU2vrbJoMMCwQg7l0RXXA+WQBLLRYcYFCMOcKztK9ZDE
	4Lw4EAgH/5cvHLpuG52rLdGPDe1gPZjqaCs9jhWcVMpt3zKUG/HHH8JDSKVc/rjqtWTx9j6
	QF9/7iXuYGuW6e73srSRUwGwBVtHYjekAzzy42mJUlLN7gfC1h9IOsemxNLtv2hkRJO/IG+
	4cxPecJiMKv2n5Nbp4xAiBo3bzltwMpJtekhIiydZAI5XqzApR3W6zQsrO4c2OPQ39ndEsb
	y3m6B4YAPHtZeQthJZSfJJ6vCmF5lKbdqmpPpqgKidkibjjYq6AyU7ztM/OI/iow7HDS2DI
	xNzGg7CKyPYT8gX41LXYtVzJ1rTESX3YiFi6H37M1/srnYQ+1ajQV2FiswaVpXaqa3HOQSa
	uqP+gThQptHbt83KQRhxsOYa9dfZNwbaF78tNnmJuWBk/2RPqW5isR+ou1mWcH739tWTL4S
	S/PYdqOSvfSVEZLjcb17N/erG0bHIpQ0YsA+ZpYiWEVsyHgKj28geUEh+G0wItNWI9dh/Rn
	Jb/ZenLJzvEVKagg7c6RLYsnAj2gEIJuG4U/EmL/tK3DdOjNS5tAebgukl4VyF+aNwariiw
	sffshyyKrOCn8OetW5TUwiH1UE5DxcPC9ckN3hqmjK6vPl3/OGBrh1RHnuPNNu3KOdvlc0f
	CEqzYpoGGpm6oBm2W/Pm5UhanQU4PrBMnZMm7hzzlb8wEaCsbRFXwlcTbj8gqsTXx5PLVDa
	z0slm1ZznO/0ZxGA8l+LbkDuIS79Vg5nOgfHSI7QqJ2o+pYrVcHhmMENfHTunsx0gn+vJoj
	0S0uds9wZjgF8rpmMFkZm++lRbZ2+am/Z9a+4aA2rn1EpR6e1cpdse26IzlZh75Gx1Sk+3Y
	ALv1Y5r24fqbU4oMYgC4vweAVMHEWJiChOq9Qi4MgFnToJP7HE+i94kNeoSWDX9lUT7wUU0
	f1wrEOJvolms0VMnX0HbuO8t3m24Fh5ZHfKtKAPOFTyFY80RrekGDiWowX6klba1TeSzzv/
	tTjUi2DgoPL
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Revert commit 8ced3cb73ccd20e744deab7b49f2b7468c984eb2 which is upstream
commit 060842fed53f77a73824c9147f51dc6746c1267a

It causes regression in 6.12.58 stable, no issues in upstream.

The Kconfig dependency change 060842fed53f ("RDMA/irdma: Update Kconfig")
went in linux kernel 6.18 where RDMA IDPF support was merged.

Even though IDPF driver exists in older kernels, it doesn't provide RDMA
support so there is no need for IRDMA to depend on IDPF in kernels <= 6.17.

Link: https://lore.kernel.org/all/IA1PR11MB7727692DE0ECFE84E9B52F02CBD5A@IA1PR11MB7727.namprd11.prod.outlook.com/
Link: https://lore.kernel.org/all/IA1PR11MB772718B36A3B27D2F07B0109CBD5A@IA1PR11MB7727.namprd11.prod.outlook.com/
Cc: stable@vger.kernel.org # v6.12.58
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/infiniband/hw/irdma/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/Kconfig b/drivers/infiniband/hw/irdma/Kconfig
index 41660203e0049..b6f9c41bca51d 100644
--- a/drivers/infiniband/hw/irdma/Kconfig
+++ b/drivers/infiniband/hw/irdma/Kconfig
@@ -4,10 +4,9 @@ config INFINIBAND_IRDMA
 	depends on INET
 	depends on IPV6 || !IPV6
 	depends on PCI
-	depends on IDPF && ICE && I40E
+	depends on ICE && I40E
 	select GENERIC_ALLOCATOR
 	select AUXILIARY_BUS
 	help
-	  This is an Intel(R) Ethernet Protocol Driver for RDMA that
-	  supports IPU E2000 (RoCEv2), E810 (iWARP/RoCEv2) and X722 (iWARP)
-	  network devices.
+	  This is an Intel(R) Ethernet Protocol Driver for RDMA driver
+	  that support E810 (iWARP/RoCE) and X722 (iWARP) network devices.
-- 
2.20.1


