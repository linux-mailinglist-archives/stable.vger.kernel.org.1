Return-Path: <stable+bounces-76581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060F697AF93
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 13:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A271F2202A
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64191684A8;
	Tue, 17 Sep 2024 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="qHvMjHtq"
X-Original-To: stable@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A0160783;
	Tue, 17 Sep 2024 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571772; cv=none; b=OJHz7EJiB4TFsBHNdvB1ksbNT8AaiH74lF8QfgOYRaiw+rISNPQZutsCdzBF/WiaQ44iDOxsRdGpqsVm4jvP53qeqFjv1TtdH+UCyrE699j+k8EVJyugikEc7kw+1zE8TAZmXCBfHxEWBcJ3M4XGAWu8S1XtRLTzEAZvWble+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571772; c=relaxed/simple;
	bh=XaUYLXIqWZXFi1ya7GVV7DGLhcm+rPQJisRqHcBfWtM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JM1nYAcB7GN5M87LtrxZO3/1WvABLxDXpRWsijj7NgEY6OmQhh4zEBRO1VC1ZZl5HUZHpooe8yhzZzunwlGJ8oLT2WDGPu5gdneKJhkP+KN9E1zuhyVCRTrSS/YygaJrgS+izHNE/wRtH8zfVy2Ml6MLE5tmVvxJ2igS6iQCv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=qHvMjHtq; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 3A343100002;
	Tue, 17 Sep 2024 14:15:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1726571750; bh=6sgalFP85udVYT0SyDvdVc1QnWQOlj49H27drdPYLA8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=qHvMjHtq/7liKhnsXqGVGhZ93imTRzQS7cX0Lo1fd1TB7tDNsOPBxKIeezeXF4+UL
	 ZEY0OKsEeF30wG/wDEwRVwtAATEI8xl4dftwdJgLbnt7Ddm7cUl/ZmnMsqIGwETLSb
	 GmEfPEu9WROrRjsTbawENtJ/fSeu5fe19iINiaIhkYm1r+UIb8dD2K96Q6O5eotSoe
	 fMwJVjOIkKWOB1QVVf+u4RMBWW7Rc7J3g8eipt7Bwmu4+K1NV1vR8zoM71MC23gYmz
	 a3A6wInoFOijMPZO0iZkXUNODtMPx+pMTZ/7e7oPN5gKS4Wsy+c4B1dWjGRiMXXQiM
	 +gHhp419cC0uA==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 17 Sep 2024 14:15:04 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Sep
 2024 14:14:43 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Linus Walleij <linus.walleij@linaro.org>, <stable@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Marcel Holtmann
	<marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10/5.15/6.1] Bluetooth: btbcm: Handle memory allocation failure in btbcm_get_board_name()
Date: Tue, 17 Sep 2024 14:14:22 +0300
Message-ID: <20240917111422.33375-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187797 [Sep 17 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/17 10:04:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/17 09:54:00 #26602246
X-KSMG-AntiVirus-Status: Clean, skipped

No upstream commit exists for this commit.

The issue was introduced with commit 63fac3343b99 ("Bluetooth: btbcm:
Support per-board firmware variants").

In btbcm_get_board_name() devm_kstrdup() can return NULL due to memory
allocation failure.

Add NULL return check to prevent NULL dereference.

Upstream branch code has been significantly refactored and can't be
backported directly.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 63fac3343b99 ("Bluetooth: btbcm: Support per-board firmware variants")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/bluetooth/btbcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index de2ea589aa49..6191fd74ab3d 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -551,6 +551,8 @@ static const char *btbcm_get_board_name(struct device *dev)
 	/* get rid of any '/' in the compatible string */
 	len = strlen(tmp) + 1;
 	board_type = devm_kzalloc(dev, len, GFP_KERNEL);
+	if (!board_type)
+		return NULL;
 	strscpy(board_type, tmp, len);
 	for (i = 0; i < len; i++) {
 		if (board_type[i] == '/')
-- 
2.30.2


