Return-Path: <stable+bounces-109439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37712A15CB0
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 13:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E0166FE4
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD2D18CBFB;
	Sat, 18 Jan 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="be5FIzuH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O11cyjEZ"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0018C006;
	Sat, 18 Jan 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737203114; cv=none; b=mVhFcZVE4VsA/s23CJajJ3/h05W/1DAwGrGGxw/9q2vRGMrew7SiRp2XVgRUB0ZzO/q1gZc1rURZtCANM8IaOiQeTlXIa5mRwmijePSJ87OinDUKk3jUww7I1NPWmyucP9FEB2SbrI/zwBldLDTO284vxEJrjMB92EREDoR1CwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737203114; c=relaxed/simple;
	bh=M6ubYeBb8u9rYA6lBVQ/dQG49LCS2s6aL8T3AUh2vX8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A29q75guIm2DMolAsp7D5unwDlo1Y88IcAxwg3fhGOM7USdXTk3noLY4frJ60i0/CA7GMaAO9HHd2fRoAe/RBXEcwzJebvzUYBsNUP7cXIoc0BSkHBhr9i7z0T7p3rqOGqRFjyTOfq7jtrdXD7Kenes/q9Y5QCm8YaTyuGABl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=be5FIzuH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O11cyjEZ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C76C61380165;
	Sat, 18 Jan 2025 07:25:10 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-07.internal (MEProxy); Sat, 18 Jan 2025 07:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1737203110; x=1737289510; bh=CXrGw1rP9QJxcAwDB0fMFoC+lLq/IeQV
	e+guwr0qz2w=; b=be5FIzuHqe2+OvZvbhhUlMy5HM+aI+Ar2XXE9aopaaiMNCIY
	rHe+g/JG7oAQEPuMoXrRysGtBNs1WOVq3/CqV250nibX8sWZkS9iuAhBdToZ3j9a
	V0wksAo0KRdxa7TlZveU4oCQTLAFAxx2UPOHlmhDh6SYayq8jfOUAhqyTDjN5p2x
	mQQbZeOaoK1XgCRSTW5TeilAvE5tp9s+rME3fCyRkjH3xozC/p006ZarPpsSnZG0
	8wumFthsIAAL5txykXcHzZZ+7FcTMmy6UYSYCkNhknhkcd1T51NcMm7V7EjhYK/s
	eODbuSXnPUChWwW6z7dyYEytuKg9tImSR8uxOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737203110; x=
	1737289510; bh=CXrGw1rP9QJxcAwDB0fMFoC+lLq/IeQVe+guwr0qz2w=; b=O
	11cyjEZ9/geHrQd7GBSkaTOBHDs0Fh2sI/ecoy/RDOk/EzNhpkAJEqm6vgEyZhAP
	y1/N6uLeu71kUS7+ignUQFtFGiyUI+NcQd+WE4wc2WNLIFut6XdLtlqm0V5poT2A
	FK3XrG9wFpBIvNRd8ZKyL5yyajp14KeRQMa4zv2gfHt+xXL6Kbc426qmngUsqyNh
	yxHNY2y+dVRlO2/2tMaiXFgVoDrWe8Kfx7nlc3XqrZ0Y8imiTjK2aa7RyIimPzXA
	vyGnjN0sOGvAraNv6Mu8wDXP0kYM/qGfd5jToWHkBoATjZOkGwtd5OmI6CJIAjmh
	2AtAZI3/Nx3acVPwN++rQ==
X-ME-Sender: <xms:pJ2LZ8LKzBadFI-kPBSebold8OjiFXe6kfRYanY2KmV_6s6hSZfi9Q>
    <xme:pJ2LZ8K8KiLfyr9eD2GsbL7MbpicClx4M1NDuxR8TBv33xGdXLSNmyDG_U117oUEs
    TGaEthTfW14zIrO6fo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeihedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrh
    druggvvheqnecuggftrfgrthhtvghrnhepleefteeugeduudeuudeuhfefheegveekueef
    ffdvffektdffffelveffvddvueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohifihhntghhvg
    hnmhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgriieskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplh
    hinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtth
    hopehmrghrtggrnhesmhgrrhgtrghnrdhsthdprhgtphhtthhopegrlhihshhsrgesrhho
    shgvnhiifigvihhgrdhiohdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:pJ2LZ8sCASiP6L5kEJ1S_wC5IMGy_3vDR2VoDaFcFD0RA4U3rcVjjA>
    <xmx:pJ2LZ5b-99KkTN6cMcgS57bt-Tlov8DAUHHbn1HeAuRTi5kJ2EeP6w>
    <xmx:pJ2LZzbu3aRrWiPM9zgJLCU1waI8nSJdE-vbcI0v6z-5Cnj6SuAqyA>
    <xmx:pJ2LZ1CNMYVHb7iYfQjzDEnkaa62g8MseZuLs1DhUrmjqaqIVk0C-Q>
    <xmx:pp2LZxM08sXzLKlQsV864WOFqVC-FVyLtUdwCKXzLAK8fDNOTUMIotbS>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6EBE0BA006F; Sat, 18 Jan 2025 07:25:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 18 Jan 2025 13:24:47 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Nick Chan" <towinchenmi@gmail.com>, "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Marc Zyngier" <maz@kernel.org>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Message-Id: <aef452c6-1e12-4510-8fb9-1dc597cf69bf@app.fastmail.com>
In-Reply-To: <20250117170227.45243-1-towinchenmi@gmail.com>
References: <20250117170227.45243-1-towinchenmi@gmail.com>
Subject: Re: [PATCH] irqchip/apple-aic: Only handle PMC interrupt as FIQ when
 configured to fire FIQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,


On Fri, Jan 17, 2025, at 18:02, Nick Chan wrote:
> The CPU PMU in Apple SoCs can be configured to fire its interrupt in one
> of several ways, and since Apple A11 one of the method is FIQ. Only handle
> the PMC interrupt as a FIQ when the CPU PMU has been configured to fire
> FIQs.
>
> Cc: stable@vger.kernel.org
> Fixes: c7708816c944 ("irqchip/apple-aic: Wire PMU interrupts")
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  drivers/irqchip/irq-apple-aic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-apple-aic.c 
> b/drivers/irqchip/irq-apple-aic.c
> index da5250f0155c..c3d435103d6d 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -577,7 +577,8 @@ static void __exception_irq_entry 
> aic_handle_fiq(struct pt_regs *regs)
>  						  AIC_FIQ_HWIRQ(AIC_TMR_EL02_VIRT));
>  	}
> 
> -	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & PMCR0_IACT) {
> +	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) &
> +	    (FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {

That's a somewhat unusual way to use FIELD_PREP and I'm not sure the
expression even does what you want. It's true when only PMCR0_IACT is set and
your commit description mentions that you only when to handle these when
FIQ have been configured. Am I missing something here?


Best,


Sven

