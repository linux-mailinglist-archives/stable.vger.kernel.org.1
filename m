Return-Path: <stable+bounces-132228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AB9A85C92
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA188C2A7B
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7064298CC8;
	Fri, 11 Apr 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/wQGC7v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2542980DA;
	Fri, 11 Apr 2025 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373418; cv=none; b=sKiC1rNuXJf3u+as3/46+b/xbf2nd9iQ7rBZV8iV2aUDUa3S/T4pQrdK4EbF32usED7ZOE2z44QK2UVBzx6gnh9CkwteEt9vPq0M2zx+VePGcGu8ro1rnqtTXC3Bpidim9eIEhvXbbN+vVOaWozsNVhPJpAe6405LvfjpYJKSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373418; c=relaxed/simple;
	bh=Ncgr/bHwGWav0++g7h6qO7mSC7ga7BpzOJD/jKK+NKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TQ32/KWancTpNH1OI0hdp310+hYnG9QuQmKfYwhqEmL9wBAf4SDyYsCqdx2LWXSNnd+tQEqnsxmEdexqz8F4ePGR5Azhx4rYDgvNloRl92lWkK90Bc6tE5qO0sW1zEfyNnLqkmRF4//FeLCnd9iWOL7OZkU6NNUlDz9Rvm0VARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/wQGC7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564EFC4CEE2;
	Fri, 11 Apr 2025 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744373417;
	bh=Ncgr/bHwGWav0++g7h6qO7mSC7ga7BpzOJD/jKK+NKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N/wQGC7vrzvR7qbFAp5Haf03GN3YrAALauuaUPTYuw+nVIhvcnISJshYgzU0YIfh2
	 tYTPw+CfexM8MVtYpICAiQWAPWskohNC8N1T5YEXa09WC3TT3+M2x6+zfayEQ6q8bb
	 tGrolWJCtIHrRBRZ7cACRs4oQIZlyBqzizYlUaXjT9Tspb2fEwOItRST8aUac3IIrR
	 QBwvoXHFwseNY10lnv4L5CWKoEO/hNxG9+WSPGFZUW07hHDJmRYSqxdVzkYIH+UNG9
	 ul21nt68g8eFPYkqbrDUh8Ls+mQrBhbWybepk6BkBoZ0eCeoFquqdfL89Dz9H7Eo4f
	 8r/An6v9qRyqg==
From: Vinod Koul <vkoul@kernel.org>
To: jonathanh@nvidia.com, thierry.reding@gmail.com, jckuo@nvidia.com, 
 kishon@kernel.org, Wayne Chang <waynec@nvidia.com>
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250408030905.990474-1-waynec@nvidia.com>
References: <20250408030905.990474-1-waynec@nvidia.com>
Subject: Re: [PATCH V3 1/1] phy: tegra: xusb: Use a bitmask for UTMI pad
 power state tracking
Message-Id: <174437341497.673813.4496801277326172956.b4-ty@kernel.org>
Date: Fri, 11 Apr 2025 17:40:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 08 Apr 2025 11:09:05 +0800, Wayne Chang wrote:
> The current implementation uses bias_pad_enable as a reference count to
> manage the shared bias pad for all UTMI PHYs. However, during system
> suspension with connected USB devices, multiple power-down requests for
> the UTMI pad result in a mismatch in the reference count, which in turn
> produces warnings such as:
> 
> [  237.762967] WARNING: CPU: 10 PID: 1618 at tegra186_utmi_pad_power_down+0x160/0x170
> [  237.763103] Call trace:
> [  237.763104]  tegra186_utmi_pad_power_down+0x160/0x170
> [  237.763107]  tegra186_utmi_phy_power_off+0x10/0x30
> [  237.763110]  phy_power_off+0x48/0x100
> [  237.763113]  tegra_xusb_enter_elpg+0x204/0x500
> [  237.763119]  tegra_xusb_suspend+0x48/0x140
> [  237.763122]  platform_pm_suspend+0x2c/0xb0
> [  237.763125]  dpm_run_callback.isra.0+0x20/0xa0
> [  237.763127]  __device_suspend+0x118/0x330
> [  237.763129]  dpm_suspend+0x10c/0x1f0
> [  237.763130]  dpm_suspend_start+0x88/0xb0
> [  237.763132]  suspend_devices_and_enter+0x120/0x500
> [  237.763135]  pm_suspend+0x1ec/0x270
> 
> [...]

Applied, thanks!

[1/1] phy: tegra: xusb: Use a bitmask for UTMI pad power state tracking
      commit: b47158fb42959c417ff2662075c0d46fb783d5d1

Best regards,
-- 
~Vinod



