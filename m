Return-Path: <stable+bounces-132702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE38A89563
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 09:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23093AAE15
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711C527C854;
	Tue, 15 Apr 2025 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C3Rmg2V2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q/YHYOto"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7222741D2;
	Tue, 15 Apr 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702931; cv=none; b=DBZrzvapcL2w8eOJaxoW445VDcp2903IDXS0A4L6KwiJ52OaEQtt0iwRc2JoKcerKpu+3XuY6bMrkJyj2In4P+dKatPI9AWeKWO8TFuRXLu2Mh4UB1Zx+0pxIU/aX9xN5LIP9Km7QXbbZ2rDKS9gp3IYFFrNop/4JD5Vv1eFlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702931; c=relaxed/simple;
	bh=QDVMAx5MlARdC2LaXnq7udd+FMk5iGx9CQabNikH0l8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ftmynDYuZk3lK09EcYTuwoS/IIMQIig++4qErRKr6Gw5A9g9jLwtqUjXOzVJEgMYTidu/IVbQRaHJAJbpTlUNJoNnMxT6zo3CFYD7ggH3NRG1pXTnboisHwm+HN+ThvZb8qSqCMHyewVauWIuXL7jPEZ/a/nY7XKEzb9pMxFRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C3Rmg2V2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q/YHYOto; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744702927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDVMAx5MlARdC2LaXnq7udd+FMk5iGx9CQabNikH0l8=;
	b=C3Rmg2V2Bdl6Bfqk9/nK29BCqi0Xa3COFDiC7DSnlrM0d8SsxFo1j+qHnMHxFNAFnY3HMD
	WAWpoMMpGJEgccXjV6aC1fuYHYX9FELmSL8UBx+zOZ2SjrZUvf/sobNZvRk4E50Yrg/qIq
	MhKOT/Qem7E2LyiMQnE8KYgMi+gAj2RfDyKz4OmXtzkq/syV8bWuN9PEqbxDL7PuzlP8tl
	XlhaNpqalHuCOp+bYIAfeukrG/OMY7Cku11HCMfSxIURuytCuvW1cLCyVgTS8Bxo2qgNi3
	nKsAelmSqrkoef83iMMdG2zJ3EcjaKBawZy05hEK47/safInIGnJL7PUer+inQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744702927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDVMAx5MlARdC2LaXnq7udd+FMk5iGx9CQabNikH0l8=;
	b=q/YHYOto9UJGHAXAN3OUEc/qILEJvP/XwRECgpUJRqc58CbVFkAb61e9M002EeZCNJd+YY
	7nVM1XZR3HcbdSBg==
To: Ryo Takakura <ryotkkr98@gmail.com>, alex@ghiti.fr,
 aou@eecs.berkeley.edu, bigeasy@linutronix.de, conor.dooley@microchip.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pmladek@suse.com, samuel.holland@sifive.com,
 u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-serial@vger.kernel.org, stable@vger.kernel.org, Ryo Takakura
 <ryotkkr98@gmail.com>
Subject: Re: [PATCH v3] serial: sifive: lock port in startup()/shutdown()
 callbacks
In-Reply-To: <20250412001847.183221-1-ryotkkr98@gmail.com>
References: <20250412001847.183221-1-ryotkkr98@gmail.com>
Date: Tue, 15 Apr 2025 09:48:06 +0206
Message-ID: <84r01tooq9.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-04-12, Ryo Takakura <ryotkkr98@gmail.com> wrote:
> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
> The register is also accessed from write() callback.
>
> If console were printing and startup()/shutdown() callback
> gets called, its access to the register could be overwritten.
>
> Add port->lock to startup()/shutdown() callbacks to make sure
> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
> write() callback.
>
> Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

