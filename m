Return-Path: <stable+bounces-198793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03222CA06B5
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB41B32FBD70
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE7234C123;
	Wed,  3 Dec 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EJL4ci1j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C7434BA22;
	Wed,  3 Dec 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777702; cv=none; b=bSPqD84AIGryTJy0+UxhxwafBpwc1MUT30/nRsH27NNQBhEJjsAmlmFLtznkxJrjV1kyU881CTorVgFFLFx+zNKgZvrRlsWI0pCYW3k8hOLoOd5uRmgi0CRkYUNW374zZymuolXSCkPkwZjzz6x9gcefecD5pJmLGF7o7h9T9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777702; c=relaxed/simple;
	bh=hUHx7ZobtydRwsFPzgY7yM9s0J+7iwJzPzr27dkiNEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sN7bT45H5jTiW6mlR49qDneQBFsnYR9Jgp+jcOODqdix9Dky6CYTP5bevQ+IEnx8qkeM/pcNQVTHSG8qET/xSq4pZu21qpUgkB7D307EpOofwTrDoeBDL+hOgYtpxOXH/1B1y9Ml1rj3vZ64WbEBuGlC88RxTe37wKss3ufzZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EJL4ci1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7F0C4CEF5;
	Wed,  3 Dec 2025 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777702;
	bh=hUHx7ZobtydRwsFPzgY7yM9s0J+7iwJzPzr27dkiNEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJL4ci1j18Vv7cDLDO99ZNV5P+n9IaXvoOiDH8bZ4BcX3FBuLZYYMuXEoBL2k/coS
	 53l+kc9nC636xBU2S+Q9UUdJDXKTXXgDhIuFHgLUEpbH2ZZQNAxb/LvWe7OZ+Fhsdv
	 Q/XYB/bQXtcjoktGKzhbvzeZxSRyrLstr9ZSZDGE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 119/392] extcon: adc-jack: Fix wakeup source leaks on device unbind
Date: Wed,  3 Dec 2025 16:24:29 +0100
Message-ID: <20251203152418.474146513@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 78b6a991eb6c6f19ed7d0ac91cda3b3b117fda8f ]

Device can be unbound, so driver must also release memory for the wakeup
source.  Do not use devm interface, because it would change the order of
cleanup.

Link: https://lore.kernel.org/lkml/20250501-device-wakeup-leak-extcon-v2-1-7af77802cbea@linaro.org/
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/extcon/extcon-adc-jack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
index 0317b614b6805..ea06cd4340525 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -162,6 +162,7 @@ static int adc_jack_remove(struct platform_device *pdev)
 {
 	struct adc_jack_data *data = platform_get_drvdata(pdev);
 
+	device_init_wakeup(&pdev->dev, false);
 	free_irq(data->irq, data);
 	cancel_work_sync(&data->handler.work);
 
-- 
2.51.0




