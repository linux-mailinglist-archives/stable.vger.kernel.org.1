Return-Path: <stable+bounces-146436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB32FAC4F87
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 15:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AD71BA056D
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5872274661;
	Tue, 27 May 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqQ0+p/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7612741B6;
	Tue, 27 May 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351997; cv=none; b=sPvllsr+j7o/7ce1kAswDQsmv7y4acYeULtWhOz7WHwxQoZrcUZ5ETQbC37qdn/yPqDK8uW+yX3CugJgNl7nEL+Z7T/hSf+WQLiqLBudMi/IUiim6bfjvubTa7PYw7AXjxCRiRHwB/uMI9SgYWXsmado+VBbW1mfWCSLbaJtM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351997; c=relaxed/simple;
	bh=p0d+3bGE6JxCPUmnuQ1SY0iA51qNIt+mDfBJ/Fs+YzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AQgtD7ibIXoSNQNFogEikBH7pwzFCKvxS7IEzXd8K3BkXvsUyo/jUw2KqK39nUUpYdQPMcM7g8GmVfvazls9LQB639LfKfQNrwvyPCZhWfimje1pDLvqjN7AUte1LpHAshZSgwqX++8r+3FflBm3+kDGutFF9CMT1SEo+HwC2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqQ0+p/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776D9C4CEE9;
	Tue, 27 May 2025 13:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748351997;
	bh=p0d+3bGE6JxCPUmnuQ1SY0iA51qNIt+mDfBJ/Fs+YzE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IqQ0+p/WibI2sjdUcs4j9Cwgi26wOb3DcDT0o85cLvAaYp1VfV+52kY77Z+yqY4ZF
	 HO6FP/xibAt5WlKled7j2ekmKINSFhNIaLGfKTO8L1+D8dwMhVqOkoyRoT6ItcsVOp
	 TEb1GAQB9qbb+gk4BkpNCdElfmV5Um/45fKRO9YGtOYEowXLhl67U8ruOpyqLVV8TT
	 zmiyL3md4y/B9JmB1zc8JNdRkvUVGtaEr3Q9CZCA27Z024h4Dnkb3SBQdjD0A6lgzt
	 0jOMv+Vvjty37fB80/8H0ScnMIkk+w+ML3bjgz7lVVzwPW3lrsjpozg02qiqMqawzR
	 914Rt17K14iGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEED380AAE2;
	Tue, 27 May 2025 13:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_qca: move the SoC type check to the right
 place
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174835203174.1634553.14732152604532181599.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 13:20:31 +0000
References: <20250527074737.21641-1-brgl@bgdev.pl>
In-Reply-To: <20250527074737.21641-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, krzysztof.kozlowski@linaro.org,
 chharry@google.com, bgodavar@qti.qualcomm.com, jiatingw@qti.qualcomm.com,
 vincentch@google.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, bartosz.golaszewski@linaro.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 May 2025 09:47:37 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Commit 3d05fc82237a ("Bluetooth: qca: set power_ctrl_enabled on NULL
> returned by gpiod_get_optional()") accidentally changed the prevous
> behavior where power control would be disabled without the BT_EN GPIO
> only on QCA_WCN6750 and QCA_WCN6855 while also getting the error check
> wrong. We should treat every IS_ERR() return value from
> devm_gpiod_get_optional() as a reason to bail-out while we should only
> set power_ctrl_enabled to false on the two models mentioned above. While
> at it: use dev_err_probe() to save a LOC.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_qca: move the SoC type check to the right place
    https://git.kernel.org/bluetooth/bluetooth-next/c/8df2c74d466c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



