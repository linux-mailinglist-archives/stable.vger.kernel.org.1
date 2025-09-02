Return-Path: <stable+bounces-176968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A956DB3FBE7
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 797534E3B0F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D562F066A;
	Tue,  2 Sep 2025 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi41NKc7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319392EFDA6;
	Tue,  2 Sep 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807859; cv=none; b=t5LWCCIfCbCuNmJzb4ILqG5fbq4/VONdfbD3cpUJ+z7++77n9JDYb198HxbGG6yvxmrdjcCT8ti0AxQugad1dp8ObBJvVGje7V+qQpP+cq/aCH5GkT884SjjLDXNWYRTkulYdGg91KRdLoIaFBsnlI4mPt/YE+DsE6qEfAvvvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807859; c=relaxed/simple;
	bh=Mtr5MCbc0h/mb+zSCvTu5sa3HQ5gTpS8UKQLq6uDb5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sfVnx2x96X8EuLq9MHTd+jZjvCcxVfbGpBVS4GRWTfjpdLBETOC/9Qq4AXXcvRS/W71ncLtvPOBeDGZQ5VfxGQ3OchDLRxWYGmw5CWwVtmwyCYOfx3C/YeRezwaacmL2SprnQ5a4/uvDtCIOysrwBRp0oaxTwBCaP6p4IXOUfFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi41NKc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EA8C4CEED;
	Tue,  2 Sep 2025 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756807857;
	bh=Mtr5MCbc0h/mb+zSCvTu5sa3HQ5gTpS8UKQLq6uDb5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fi41NKc7luwuxyJtrewGaePX618DxghhZIrMG6mn5RaTnbYHQ3vgid+zVHuTsc6lq
	 hTe2wlaPgxlqUh1u/+aXrkNaDpYWUTjKBNqbiNDgVSLQjeF8RQgmyzfOyTbqg9ypaq
	 f+g8xGsfCzPCm8WrdHxCAwaAR5amammeoHcc2TqxnoGXb3Hb7d1QQL0ZsKRgFJsmhe
	 7oV2z4sp5faU5NEDTPC4yMrweocSrDJAeINx9JjSgvIZn2x8PhovOtrGZ6MBIDn8b7
	 tUSXEbfmGRf6d/TApW3YqE0xGsG1PMaTlzs1zgwTAYc9qgxES+L3A+xy+SrKE0fTLd
	 u+IxpTO8IHOEg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Pawel Moll <pawel.moll@arm.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable@vger.kernel.org
In-Reply-To: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
Subject: Re: [PATCH 0/2] mfd: vexpress: convert the driver to using the new
 generic GPIO chip API
Message-Id: <175680785548.2247963.242433624241359060.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 11:10:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Mon, 11 Aug 2025 15:36:15 +0200, Bartosz Golaszewski wrote:
> This converts the vexpress-sysreg MFD driver to using the new generic
> GPIO interface but first fixes an issue with an unchecked return value
> of devm_gpiochio_add_data().
> 
> Lee: Please, create an immutable branch containing these commits after
> you pick them up, as I'd like to merge it into the GPIO tree and remove
> the legacy interface in this cycle.
> 
> [...]

Applied, thanks!

[1/2] mfd: vexpress-sysreg: check the return value of devm_gpiochip_add_data()
      commit: 14b2b50be20bd15236bc7d4c614ecb5d9410c3ec
[2/2] mfd: vexpress-sysreg: use new generic GPIO chip API
      commit: 8080e2c6138e4c615c1e6bc1378ec042b6f9cd36

--
Lee Jones [李琼斯]


