Return-Path: <stable+bounces-100920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3349EE823
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F7C283AD9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7552135BE;
	Thu, 12 Dec 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jxsn3K1X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+p4DQoi5"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7F748D
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011928; cv=none; b=b36arVEDIXmNvsVNR2DlNwVNYA8zC8vemf2HBO4FXVucmp8xIX5M8xOj5voeb3ZFdpQEv9owNnbDN+Iex/Uoo0p+oxxNyBC2DYpSUEmTlfeMj/9aMUz01KIOyCSQzT1ln7452dgfXLq9fLZ8jbqeKupKDnE0RvabyjhdCxMMekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011928; c=relaxed/simple;
	bh=KL66DB43YprDjp7Jg/DVmS77JVj83TX68VeUapZJm2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/1GBqqAhqUTWCqgEB7Gg+J/hwVlmlL9SINo9YnigFIGROR/UFSL2sVh1jvscg1gi8PWVqDoDUFPwOAVRiW3OvcL3LTiMFWRn7TWFrRhXXyJxczU+SH2y7vQR76OzRFLVOpiNjm9UQrAe+YPvSiz8hteD+K1RAulyrAt2PAbbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jxsn3K1X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+p4DQoi5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734011923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XHNwyv2ItsN+GcsZYjVbJW17PiPb6vbywReSf4sylTI=;
	b=jxsn3K1XP/E3cv6DyHZDY9/pxAGC7UBwmllYw2tjsAwIWBg+30RDDeGwMBgRtDhfr3aU6h
	IBhGMdqDcWztLwfqCI54ECjIe7ZwOlM7Y1KNUf+Yw6OBjWfHT6BgidQB+BvGqwp7XGhX/I
	M3tjtuB7JJvHsXiYuMtt0u8nZoUnWJZ0OC05yv0chrU8oUooP+ZIpLoaF2jlP7SIdMuqwS
	DjFCWa7rYpd6qQNu3/L7POCiYEfsh0o9h6dqfFCV0cZh4YbuXoT9hyKtF9v8uxwAxGl2ue
	FekPhAOAgmNmQ5f5+MWwuXSvBB6hgopXDH5LjXe0W/m2PdFgqOyNx2S0pLf1MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734011923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XHNwyv2ItsN+GcsZYjVbJW17PiPb6vbywReSf4sylTI=;
	b=+p4DQoi5EwNHJTYfoKulEOCllCpAxZtF+y2SVXmYZA2b9VsdTKjh2ZpOCP1CNEzNBHo6nN
	ep1Mgxbn2xcnEqDQ==
To: gregkh@linuxfoundation.org, linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clocksource: Make negative motion
 detection more robust" failed to apply to 6.12-stable tree
In-Reply-To: <2024121203-griminess-blah-4e97@gregkh>
References: <2024121203-griminess-blah-4e97@gregkh>
Date: Thu, 12 Dec 2024 14:58:42 +0100
Message-ID: <87ikrp9f59.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 12 2024 at 14:03, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 76031d9536a076bf023bedbdb1b4317fc801dd67
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121203-griminess-blah-4e97@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
>
> Possible dependencies:
>

There clearly is a dependency:

> From 76031d9536a076bf023bedbdb1b4317fc801dd67 Mon Sep 17 00:00:00 2001
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Tue, 3 Dec 2024 11:16:30 +0100
> Subject: [PATCH] clocksource: Make negative motion detection more robust

<snip>

> Fixes: c163e40af9b2 ("timekeeping: Always check for negative motion")

This was merged in the 6.13 merge window into Linus tree and not
backported to 6.12.y according to my clone of the stable tree.

AI went sideways?

But I don't think these two commits are necessarily stable material,
though I don't have a strong opinion on it. If c163e40af9b2 is
backported, then it has it's own large dependency chain on pre 6.10
kernels...

Thanks,

        tglx

