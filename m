Return-Path: <stable+bounces-155123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892B1AE19E7
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AB73A3F73
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A668283FEE;
	Fri, 20 Jun 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IfenBHCO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4JlBMyjr"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDF225E479;
	Fri, 20 Jun 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418404; cv=none; b=opuEULPbo2zFsLjpnzGc9eAA6q9kx9vag3KiFLNJuTm2nlZUJJ9MVyJfsyWIhLR/vSVHbwBz23Slgy64l1AqJYOuiE8ycVaTY6n3Lfuc6HwhbXqTM4SQDUZpWjzenLOJ+ElsN3fZgWogodPlf1PB9xYVDv0vjR40jReamm5kr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418404; c=relaxed/simple;
	bh=iRX4jiyASWwZNjvp8+lt29LIi2pbzwldzyTRMZCejDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HLedQcjoHGbtr18XS5JIl/0QidDG10nT0oNQMYOnwvG1iVaM+ZWGk5knjOI9ACuG7O2aov8kc60/E26zBB3Lb//PVP0PUZRbKtTmHDFen6UeLPkFj9UQCLJ6/TNafXV5HFTbTungtQKztenleN2NVrLdtOJYrujsUcMy9kyrL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IfenBHCO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4JlBMyjr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750418399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48S3J+SGLw7x3DaSxzDEz0cUwEhO4zPv8TOnoSh8LdE=;
	b=IfenBHCOIaCjT501fu6+KiLFXwM7OTo5yBXexAKsRyuH+8nqOf1btk2wUotA9OThWu49YD
	BRzCcNNt2R+fFu4bof5x7QqQq9RnYcxdmV2301wEt9Hg8OFgZaChaZDTM8YjaHJxiGGmrs
	jymhz6s/IehvrLxkqHtNA1jIcnSMzxq7BxJPl70fmcMnUZc7VtqOL4PIhyV3Tl9hyYN8S1
	SL4PSkPam4CZVTFywgs15ZWiymAaGlaqT7GHWyK9OxbY4DBc7pCqCDYEOU4qam1ykCFUfU
	FSIHI6mzf/cUmhp5HSwXYMM+jX/PANX6tcrZ3hPpaKjXrCili6QK23p3yxUtdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750418399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48S3J+SGLw7x3DaSxzDEz0cUwEhO4zPv8TOnoSh8LdE=;
	b=4JlBMyjrOxLX0IQ45O/wXMG1TQ8DQKAFY+QHbrfmZ5sqz8cQOJoY1rXQ5A1A32z2ouMtTz
	SMTHVLf012mcqQDA==
To: Yunhui Cui <cuiyunhui@bytedance.com>, arnd@arndb.de,
 andriy.shevchenko@linux.intel.com, benjamin.larsson@genexis.eu,
 cuiyunhui@bytedance.com, gregkh@linuxfoundation.org,
 heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 jirislaby@kernel.org, jkeeping@inmusicbrands.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de,
 paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com,
 sunilvl@ventanamicro.com, tim.kryger@linaro.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v9 1/4] serial: 8250: fix panic due to PSLVERR
In-Reply-To: <20250610092135.28738-2-cuiyunhui@bytedance.com>
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-2-cuiyunhui@bytedance.com>
Date: Fri, 20 Jun 2025 13:25:58 +0206
Message-ID: <84bjqik6ch.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-10, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> an error response if an attempt is made to read an empty RBR (Receive
> Buffer Register) while the FIFO is enabled.
>
> In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> Execution proceeds to the serial_port_in(port, UART_RX).
> This satisfies the PSLVERR trigger condition.
>
> When another CPU (e.g., using printk()) is accessing the UART (UART
> is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
> (lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
> dw8250_force_idle().
>
> Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->lock
> to fix this issue.
>
> Panic backtrace:
> [    0.442336] Oops - unknown exception [#1]
> [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> ...
> [    0.442416] console_on_rootfs+0x26/0x70
>
> Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
> Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Cc: stable@vger.kernel.org

Reviewed-by: John Ogness <john.ogness@linutronix.de>

