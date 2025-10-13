Return-Path: <stable+bounces-184230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5374CBD308C
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 14:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FAB94E8857
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467FD2D4B5A;
	Mon, 13 Oct 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EWOvfKRG"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9436F242D6C;
	Mon, 13 Oct 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359571; cv=none; b=caPBT9es0z4bdxzSM2QB2+Elc8lx82E70X++C3kAK3OTrska/u3+FbpsgqV96YOuxpEMqS0guWlWaNAJhimn52j60mq5rRWHn364TUrXRXhVFtrFqRnDDYyk8tCjUFWa9kzHWltQ1S3YV/oabLMC1v1+DDSrPC65tr6XRAcktAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359571; c=relaxed/simple;
	bh=7P40zuZvFvUYXn34pA2KCvMj8wvo0X4GBbaGlQCasAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFHmGe9ZV9/gL4U/nCYkBodb3aOJ4aRF360BG0c/rLg0vSQkDtkg8bBO8Kl8hgVAS7lk8QowQUzGr+vehc+IcgSCB7DI0F8clh5piwFBzPEY+ARbQTNNr19YT5reWZnNRA145UKTcUbqhvmLKd3zbpdj2gHMGG/ux1D10wvq1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EWOvfKRG; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1760359520;
	bh=rwsnHwa/iE8xFSmy5SPXND8NAAEDndnyLRK8Tg4fMWg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=EWOvfKRGQ+4rnpZBAFL82FBsMZU3bcqg73mmXiUF4brH4nMvXeTEqsK+GxhpSfR+0
	 jDKFZWRMsFXS7ayK03ceWEPy/vX/QwEdJKkuhj+iQLsOKx4UrA6pXJo2nGapkmws0G
	 DOY1Nbe3LnyDlQiV9S+EVzIH1IHcS1gPrjAnn9/s=
X-QQ-mid: esmtpsz10t1760359511t62625ec4
X-QQ-Originating-IP: ihNxcwXG3bVkEMZZVgS0vhiqNkx1GcQJMaRhhVcS0IY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Oct 2025 20:45:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2256635266742006092
EX-QQ-RecipientCnt: 10
From: Wentao Guan <guanwentao@uniontech.com>
To: srini@kernel.org
Cc: miquel.raynal@bootlin.com,
	mwalle@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org,
	WangYuli <wangyl5933@chinaunicom.cn>
Subject: [PATCH v2] nvmem: layouts: fix nvmem_layout_bus_uevent
Date: Mon, 13 Oct 2025 20:41:29 +0800
Message-Id: <20251013124129.708733-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: OOYO4i1Nbl+HrWNFuQu/UPpEHV30jt3ChYqOQWZFWfrp6wj/mx6+YG8z
	cmQr7XxMJbLR7XBJo/fKLU61JtKrBeDq5oawdDIOm0fC0GoevRI17fUt2vm9WpdPyJQwdB+
	0fKz8PLTegWj1zT8yQ7pBl/VgsVyyWbDK/hr6tr4q2g5d5Bg6+Y97Mrv2Z9GJKO/anT3zZC
	tkdbCgFlXysfsTIndnhIf0DzyOQXDZ1wzdhEeXY9aONhQaedBHoCPxwfvTnjCeyr3MW5sRj
	JCmm7Dv+ERYp9kCCkhss6pvH3l2cFzW3+Hr1n2R1DhN4mbX7fmg9YY3hD8yPtW7Setx3WsU
	EneDx4ZsVkz6RhyGesXexiEXfAb8VmyUqsP70kbrVgLM66gSDs61Q1ebUstjWATVysnTzKQ
	yk39mdOrtXxvt5gz5pPwOj+3DQXxAn+tRumFW2CRiWRSZEwnCU9tGWYN6OteWUXr14F+Z3E
	6M964dldmBjIGfzpkQwwBn/2kQDoUw+08eRf2cXd3/oedApiN397ltHswigWFdY9mqA5PsZ
	4SkzvgQKBsUZ4m2EcOGTRY8bsQt4XY19REInKxHDokECcop1NQB2GlUho7agQdzyoCfqjUj
	p6R2n0DcGyy3uHDQbwyfzpLi8wTdWu/7/IZ5V+TgUM74qBqHLDIsXSRVtOIDo/sEfGIpOSd
	Aznh2Fwisrb73LMHb/h//Rd9rVZ7FlMfHz3Ow8U16tHCbMYHvQyRDzzI2MMfyNas9fd9sxw
	C4mDGYu2J8DGzh5NtdSwzYLWViWi6BtfocetPrhza6cEUBKSkLJQIas1zPkapVnp0KNOxAE
	cI7YQ83RGeqZpdvrKdaW2KUyEKF4eFBNGjZEz5DsvQ0F1LWDzUzWbIpL1UwVS9tlIfz8Xrq
	o7+8Y7aZ1bs/M1OUosjBt+jb+inqXxr/KgGCQs8r0CTJIgBBK9CBiL83OUIIBT3v/CNLEKK
	o1gvjU+o+MclGj2HALDpvOBAsbnLnniiE8EuHq7jDVvU1gehyFvqWGgFMCG90mZ6uctXf3j
	Ej08vbGea3FzE5FjkbW4856OivPxThI7AUu9RN+xZjxozchx/eGitOJ2+PP+zBy5jhste4l
	+fSTvu1xod6M2RSG2CpIg+CUiRHbjKGAMuM/pAUQYfWghp5mr7QPjZ6ophUEwR+iA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

correctly check the ENODEV return value.

Fixes: 810b790033cc ("nvmem: layouts: fix automatic module loading")
CC: stable@vger.kernel.org
Co-developed-by: WangYuli <wangyl5933@chinaunicom.cn>
Signed-off-by: WangYuli <wangyl5933@chinaunicom.cn>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
v2 changelog:
add cc stable.
---
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/nvmem/layouts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index f381ce1e84bd..7ebe53249035 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -51,7 +51,7 @@ static int nvmem_layout_bus_uevent(const struct device *dev,
 	int ret;
 
 	ret = of_device_uevent_modalias(dev, env);
-	if (ret != ENODEV)
+	if (ret != -ENODEV)
 		return ret;
 
 	return 0;
-- 
2.20.1


