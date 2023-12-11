Return-Path: <stable+bounces-5494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD480CE0A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147C71C21152
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8913B219FB;
	Mon, 11 Dec 2023 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqKeB+FI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EYzIPVN3"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22143A91;
	Mon, 11 Dec 2023 06:12:00 -0800 (PST)
Date: Mon, 11 Dec 2023 15:11:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702303919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZKIjBd21OWnGaJBiVOBN57bXhYz4xgeT/z9NbvImzs=;
	b=aqKeB+FIuovH58QJwNpR5zEZ0nfq4BxRJJZshJDFEW0lUoHNSJldnXl9gKcnvD0JwMsJa2
	rDVpKgsRA5FVdfg4ZsTmio8exgchy8EYcwzPCP4ByoOx/FYS0Vii2srPxmgtrxYjB8V2HN
	I9sC12MS3M1nKn2tTUjvbm9dQItpu4eooJexmkPl1uHGkq0pnQOuQC+vZUrKuIO9rDs5KJ
	kcAGcT6Z1huhwy4ZtMUswxlwPED7omMkTJ2gL9Ri6JVDozKGQkvlushfz5BPU4fgq9GqMe
	EV4m0AlK0m6tzC3dP8Z+OvuVxl4Yl4cJm5s78cK0Exp0v+2mVBd4zaABpC8EXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702303919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZKIjBd21OWnGaJBiVOBN57bXhYz4xgeT/z9NbvImzs=;
	b=EYzIPVN3fD74DLanAmeKpYTZ7fMEQ22FjkrGo2fy9E24npcGG53tahRZlmShZJ51DbTTlW
	Elh5LyELGlEAWRAA==
From: Nam Cao <namcao@linutronix.de>
To: Andreas Schwab <schwab@suse.de>
Cc: stable@vger.kernel.org, jiajie.ho@starfivetech.com, palmer@rivosinc.com,
 conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: Backport riscv kconfig for v6.6
Message-ID: <20231211151158.18de6a99@namcao>
In-Reply-To: <mvmwmtkq18l.fsf@suse.de>
References: <20231211145750.7bc2d378@namcao>
	<mvmwmtkq18l.fsf@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 15:10:02 +0100 Andreas Schwab <schwab@suse.de> wrote:

> On Dez 11 2023, Nam Cao wrote:
> 
> > Without this, it is not possible to configure the kernel with SPI drivers
> > for the Visionfive 2 board.  
> 
> Is it?  There is nothing that stops you from just enabling it.

config SPI_PL022
	tristate "ARM AMBA PL022 SSP controller"
	depends on ARM_AMBA

The "depends on" stops me.

Best regards,
Nam


