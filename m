Return-Path: <stable+bounces-194885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4A0C61A75
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 19:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69FD84EAE67
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76F30FC20;
	Sun, 16 Nov 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vyo6J5tt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3N1YU/4z"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BF2F7AC5;
	Sun, 16 Nov 2025 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763316992; cv=none; b=UPGYkW6eB6I201+aGHrfYx/h3ARoR+tSLbYtVptJ7poeCeEqAi/5kvkm6tN1PJPlRtqdGwcr4i0nx6+QSynYhBXhvnXpBmUsIpOaIYEJA181MSxg3IXFa57zPZwYNUyrGhL4x3JycMmbsRJOjYWzYl+1mvPITc0InrP+Rl1SsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763316992; c=relaxed/simple;
	bh=HP34z7eR9mKVjYxjveu66xMtkd2K3K/BGg3xoelD6ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ommi3TZNnmF58/75YaiOqpGg3+gUiF+1Tm+yCc61kZyl4K+JXpGciW/U7Ykm5yrwZpmbM6WNEm6WCA5nxmvfaUPm+EY19fgS5tXpaFyl4ISGrU+T3WjtTPb4qHCFI+gYmvaErkBv4IU3RXDZZ6k07hk+tgKKc97+2gnESk6efEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vyo6J5tt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3N1YU/4z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763316989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOIkG1cenxXym0AokE46jiBs/wDOAMCFMCN4N3uWS0Y=;
	b=Vyo6J5ttZyjGh65TzRZZQC4F+kHTVniWMf18AjxXC3GI5AW2JgKsPsWYXSoCA/zK5Px9jv
	kmOjHvXMMHKc18FANOvWJxD29+Qd+ib1bAd0WxtAvMqgIfogFpd1+TnrLoQ88dR/Pop5nx
	FsVWAyl6sDZVW8HCHr3xH0/ACcUsUA8vKEksS8N7zzPm0Rs/55R6cJtJ8KPv4L2Xp8PB9G
	vixBeOWC5IDjIeyJkfNdMTyuYDWoEkcA/jJ2XWfTKg1KYcLsyXKwl2QY/fRRFGigviV1fJ
	/FD0AmqYiftEfyupUbHT0+i3laOEiTU5nufcF081jO+1q8w0+DAUj1MozFh4Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763316989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOIkG1cenxXym0AokE46jiBs/wDOAMCFMCN4N3uWS0Y=;
	b=3N1YU/4zcdmx3UiDoHeaS48syypf2MAvrYXi6XfqIYeaB6zZGaQeKkIuJAKUC1QAH8q+ka
	wBZas81Cd9SD/kAA==
To: Ma Ke <make24@iscas.ac.cn>, maz@kernel.org, shawn.guo@linaro.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Ma Ke
 <make24@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] irqchip: Fix error handling in qcom_mpm_init
In-Reply-To: <20251116081602.28926-1-make24@iscas.ac.cn>
References: <20251116081602.28926-1-make24@iscas.ac.cn>
Date: Sun, 16 Nov 2025 19:16:28 +0100
Message-ID: <87seed972b.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 16 2025 at 16:16, Ma Ke wrote:

> of_find_device_by_node() increments the reference count but it's never
> decremented, preventing proper device cleanup. Add put_device()
> properly to ensure references released before function return.
>
> Found by code review.

By whom? You sent 7 patches today which touch random parts of the
kernel:

  [PATCH] irqchip: Fix error handling in qcom_mpm_init
  [PATCH] phy: HiSilicon: Fix error handling in hi3670_pcie_get_resources_from_pcie
  [PATCH] ASoC: codecs: wcd937x: Fix error handling in wcd937x codec driver
  [PATCH] ASoC: codecs: Fix error handling in pm4125 audio codec driver
  [PATCH] powerpc/warp: Fix error handling in pika_dtm_thread
  [PATCH] USB: Fix error handling in gadget driver
  [PATCH] USB: ohci-nxp: Fix error handling in ohci-hcd-nxp driver

and in all of them you claim to have found them by code review.

Why do I have doubts especially when I look at your email address?

Thanks,

        tglx

