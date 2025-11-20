Return-Path: <stable+bounces-195369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB597C7594E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6E4D34644E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A511371DD4;
	Thu, 20 Nov 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF91YOyE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3A36CDFF;
	Thu, 20 Nov 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658688; cv=none; b=K3vRlaLklzCfgKxUR3o3x6crlme1cZyNHqEv3RdLHlHWtO14RFaa6iQM1+cmxBAU76BV9a56Wd/3+EfNY8oTAB/fMGlIdo8n3n67nKdGyiqUIITo4ZOse9vDpzoMaRtk3G7HQVcvFTc0A0Zt1sMz/lAaDdbxIGIDVG5SD6kVviU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658688; c=relaxed/simple;
	bh=IABz3Vm9WE8tNAIYgl3s7DgNhJLHFMdvNzFll8AaOrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EDBO1Y36Ae0KSwwAXHQ1wCith4PtZnBSxiU1XcBwbVsbHGKXeGdgl5SyYrAS4YO1N5iAJQcfTKq9Qjvy0YLhHUnRNWoi1Do9D14cBJFt12c4soBSMxUA6dKM2ECGTGUTVXN81kNdzRM+1HLSWuW4W+tYYIuiyBIBCJM8Fx+dgCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UF91YOyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A64C116D0;
	Thu, 20 Nov 2025 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763658687;
	bh=IABz3Vm9WE8tNAIYgl3s7DgNhJLHFMdvNzFll8AaOrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UF91YOyEeFNguuHHLAdKTR9eAYMaQEjGov78H/L9q/PSBxcLKwMGwHx57I9Evbnm+
	 T4qlamnkQ9ugk0Ggq98YlDHt+CsBwBVP4AVMBwqhe1TEIaxrP4fZk1qTetghCmnrBB
	 mZ4LgM8KLZB35rVdtQRxE5Dr1BcZjGFCTeivy9iKofuAirk1DWlrdtoe+nz5eK+jB4
	 pHbcruZfsgFl1qGXmqRHT8A8fJ1KqA8jxcVZD3O/Ux0XZB+a5UQnq+o9kSBdPHvKvN
	 aw5URqSKw83JQQ13oqWyv5HLwt7flM6Wy4gKlTYm/kKHTXhB6qogGnmATJ0jMs2DR+
	 vgT6tZJuKzucg==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
References: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix clock prepare imbalance
Message-Id: <176365868405.207696.4847424403085518315.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 22:41:24 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Mon, 06 Oct 2025 09:07:12 +0100, André Draszik wrote:
> Commit f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend
> with UDC bound (E850+)") incorrectly added clk_bulk_disable() as the
> inverse of clk_bulk_prepare_enable() while it should have of course
> used clk_bulk_disable_unprepare(). This means incorrect reference
> counts to the CMU driver remain.
> 
> Update the code accordingly.
> 
> [...]

Applied, thanks!

[1/1] phy: exynos5-usbdrd: fix clock prepare imbalance
      commit: 5e428e45bf17a8f3784099ca5ded16e3b5d59766

Best regards,
-- 
~Vinod



