Return-Path: <stable+bounces-194864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A57A0C61296
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 11:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3813D35B332
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 10:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E0283FF0;
	Sun, 16 Nov 2025 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="osMFSXO7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kdXIQIbH"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A12820C6;
	Sun, 16 Nov 2025 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763289267; cv=none; b=RbIXgd7HWcPwLxQLBsGD1swq2YNPq89ujIHD6sSU6LoTNuF8TAE1il2idoIh45g/L4H1sGNFvpwKhj0CYzRWmZhR05/17MEmNbJMhzoX8604XTXq9WeMr64gaJ5iAsH0RtjyPFpwLi7KM+EOsTL9vn6t0VqJX3saj/JwGzlWVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763289267; c=relaxed/simple;
	bh=WeLcTNWTtKCNpaGl149fmjSv68BzHaZ5b1bdxUMBTbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7/Sr7eUo1lF8so7y53KZ+QA0ofynnZjoybqnok2QCgd97x0e+/euxxmXnms3ruP8/RZA+WhEo/G9oW05l7zG6lg7BDG1w3ApepVOBvsjKeVrYLgsE7YlpLG0RoQLn2IC9eHSopswBRAI6NizrgaO8N9Set3n/UABRJ1O8XEnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=osMFSXO7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kdXIQIbH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763289264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6pTjzVxChEOemvV94YQTWhrI+z8H4dIIfgJGU6pFoc=;
	b=osMFSXO7LOUWflGQZsuffFo+kgRT1sXB4muT4Tkxj4eJpQUnhdMLD8tew5srZUbqkEhKKe
	d6Bya2Vz4qb/cexzmAvQ/rK/3gukAkCaqE0BAHhiFqXfDnkcmwjNoGtOTjZ8cZIisW0QiA
	L5h0jzqIYMnzLdY4wNdrd6DgYUN2b2/YGUh35QSZUcOTJcZOOs2c3MYcHm3RqUUPZKESg+
	0Qau3w1D1dcT74lc3G4MiYAgYa2+X2N4xMg6hovU+tAE+DCzz591NpFoT3pzdWxXSrzoOo
	T5anTuoKh3Kke0pZwpmASDX1dhKYoopQzEQBQKjXGA6CCCD4PB6z2aarf8cwLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763289264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6pTjzVxChEOemvV94YQTWhrI+z8H4dIIfgJGU6pFoc=;
	b=kdXIQIbH5Hry8X0TptE1g+00yUmNjlIaNYTgPJCgtyiGYMfwnPo+I+zHyOCjuuxIhEBZPm
	pX42ZV4mQxBRazCQ==
To: Ma Ke <make24@iscas.ac.cn>, maz@kernel.org, shawn.guo@linaro.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Ma Ke
 <make24@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] irqchip: Fix error handling in qcom_mpm_init
In-Reply-To: <20251116081602.28926-1-make24@iscas.ac.cn>
References: <20251116081602.28926-1-make24@iscas.ac.cn>
Date: Sun, 16 Nov 2025 11:34:22 +0100
Message-ID: <874iqu9sgh.ffs@tglx>
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

Already fixed in a more elegant way:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=irq/drivers&id=1e3e330c07076a0582385bbea029c9cc918fa30d


