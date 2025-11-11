Return-Path: <stable+bounces-193669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EA2C4A848
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B3F18969E5
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2D91F09B3;
	Tue, 11 Nov 2025 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kH2zG0Pk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8C346FA7;
	Tue, 11 Nov 2025 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823728; cv=none; b=gut8m2MgdGLhAJzNbTYY/tBAERCyx/bjqM3SZWQMWGod1CjOYBU8qHq3z+Wyk5bmaRt/dRjjF/oztQ1pWH2xCAYHQBrKcJDnxg5yNr1cTy3dAoB5FPGhA5uKKJMuzM8VATxaHu8M0QNLPocTTJYtXU0bwap8Xqpde3G7x6LYf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823728; c=relaxed/simple;
	bh=NxU2pDEjRZEaYkfS82R7FrzdTCXrEVN7DUH1udGvvMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSXU0B47edsueBsrNA/NJ6bwbmgC1yT2l+ze4Yg400YCZLBLa1x61kJYbSBBnmpqSu0TJouwWFfW8FdSa9y61Q5+wJn0Dym2dpARkguavvDA4BXp65CHwFpWIztXrB0LMThS0cgruQPURzYbRSuhTPLoqQ+j/KvYKHJV4ZTmYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kH2zG0Pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282EBC4CEF5;
	Tue, 11 Nov 2025 01:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823728;
	bh=NxU2pDEjRZEaYkfS82R7FrzdTCXrEVN7DUH1udGvvMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kH2zG0Pk6JgKyCEbVrPmlqMCFHb3k6ffugn4c81yB0eY2MSjW47SqFeb3WH3Yxieh
	 gq3IeyWLa9RHjADAieXCymGgnuwU+J2HDHCLCT2VBxAEpt1hXlK4Mu5afgmP+plM+C
	 PkarjwtLlYwuFOj4G7zG9p69YqFOZq6Vi7li4Jjc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 358/849] extcon: adc-jack: Fix wakeup source leaks on device unbind
Date: Tue, 11 Nov 2025 09:38:48 +0900
Message-ID: <20251111004545.073535767@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

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
index 46c40d85c2ac8..557930394abd2 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -164,6 +164,7 @@ static void adc_jack_remove(struct platform_device *pdev)
 {
 	struct adc_jack_data *data = platform_get_drvdata(pdev);
 
+	device_init_wakeup(&pdev->dev, false);
 	free_irq(data->irq, data);
 	cancel_work_sync(&data->handler.work);
 }
-- 
2.51.0




