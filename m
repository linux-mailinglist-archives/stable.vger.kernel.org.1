Return-Path: <stable+bounces-203324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 846D0CDA249
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 18:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33A763024E0A
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98FB34B1A9;
	Tue, 23 Dec 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+Xn6033"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642472F2604;
	Tue, 23 Dec 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511251; cv=none; b=n8qU0kbVNv3IlnqCbb4OH83hrDkd9DRO9kcGVBHh8paCFHHL3KdRSs/KR3y05+Dagm2+B4yW18XbVReQGcX/HlekAaOeukYuMvPQJ2P+oCSeBnRRHJCSxgE+4503+MJPIdPOpjlzMcbwsLLLm3OOsIfWpnnZD0sa45b7IEnZwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511251; c=relaxed/simple;
	bh=udJxoZNtzJJ8YDA2L6z3Y5+PFcDl85FnCZanR1WdgZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YXA8K3eTk9CtR4ltbwMQQQQlFmqNgRk4Cs4PuG084V84XgRqdJ71wWFePDWX75bY1241upPIUdAHZZ5g7CneUV2J3+NuqDlX1tTyKXCQhAGEYmBsCMjltkKpnE7PQh9txKWVnSVltcqTYmyPzaXLzWKCrfpNw/MMeDxlrcru2/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+Xn6033; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9490C116B1;
	Tue, 23 Dec 2025 17:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511251;
	bh=udJxoZNtzJJ8YDA2L6z3Y5+PFcDl85FnCZanR1WdgZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N+Xn6033wpW+5QNkYVNRqHjEKGenxB/bSabbWnNLVOuh4frnVWP3HnsPbLcR31Tf6
	 PQBWaVajtxZ4oy1zoFk2xccN+shMwkSfy7YHedgWvj0xPS+5Hj2V9KuZmkxEqrnVNT
	 r/uHZpYgm8EC0FeA68GMduCPfwyFvIHo8JQ7/FOJ5ehBP0bbJ/kVJ6bRcfOpVHDch2
	 COlyQNzIUfSBbBx6unHPEZruHbGDJXGylIipV3+bnwR1DjvsgfYPnzfM3TjU9bH8JF
	 Rpjid6A1aPcSzmn5BpHsOK7TQ2hOrolkuibqvLccKZJdt87E8nQrRm79hPwnQTpqFm
	 QCg2BG0zTNyeg==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, William Wu <wulf@rock-chips.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20251127-rk3308-fix-usb-gadget-phy-disconnect-v2-0-dac8a02cd2ca@bootlin.com>
References: <20251127-rk3308-fix-usb-gadget-phy-disconnect-v2-0-dac8a02cd2ca@bootlin.com>
Subject: Re: [PATCH v2 0/2] phy: rockchip: inno-usb2: fix gadget mode
 disconnection after 6 seconds
Message-Id: <176651124639.749296.13619922936818344494.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:04:06 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 27 Nov 2025 11:26:15 +0100, Luca Ceresoli wrote:
> The USB OTG port of the RK3308 exibits a bug when:
> 
>  - configured as peripheral, and
>  - used in gadget mode, and
>  - the USB cable is connected since before booting
> 
> The symptom is: about 6 seconds after configuring gadget mode the device is
> disconnected and then re-enumerated. This happens only once per boot.
> 
> [...]

Applied, thanks!

[1/2] phy: rockchip: inno-usb2: fix disconnection in gadget mode
      commit: 028e8ca7b20fb7324f3e5db34ba8bd366d9d3acc
[2/2] phy: rockchip: inno-usb2: fix communication disruption in gadget mode
      commit: 7d8f725b79e35fa47e42c88716aad8711e1168d8

Best regards,
-- 
~Vinod



