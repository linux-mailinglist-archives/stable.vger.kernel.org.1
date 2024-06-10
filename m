Return-Path: <stable+bounces-50110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEE790288C
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 20:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545421F21CBF
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 18:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A81494B9;
	Mon, 10 Jun 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MDjdbKon";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7B4O+8a3"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2F15A8;
	Mon, 10 Jun 2024 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043793; cv=none; b=K6UfQkB9zmh5XZXFRHTslZYyhjV5mXqUsjwN3yYfgNGhKL6nOnZ6T+CwmcLmBTcVO+wSSfbiT6BNmWkYTbaRnHek3abNZYQDasC8gOdZWSc77YSGDwXAcL+jeJ9CctDQubqMhQEecn6q6K7aMeywoztELUcLjkFCgqKjtZJfIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043793; c=relaxed/simple;
	bh=IYp/Eu2YbA2P68s7eG9aebS5dGio86h9J8gtwGZ3P/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JcI1KOtrWQ2OuVdydtM1ppu+FacjrHndxwPC3EweAwtg+CqCGE6mGP1c4ZgPm8nAwYTfNUE/iXcnAxFhXPsW+sL1PnH5wk7lKGrv9CkHg5/D4Q6rKuxuTXRoB75C1KVQfuGWnekPeVKzQ7eJK8Pe4DH2eE6TeawT+LV0LeivOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MDjdbKon; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7B4O+8a3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718043789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m4Pj/Je9A5FG/IZDCfStO8t9dhzu69BwE+sdDR8YKBY=;
	b=MDjdbKon8frK80IXx9Io9Q+o/iRM9aXXNubuqKEBoCU0jwZTaSjLSZpeSIU0BQ76sQ2u0V
	cEbFXQdWJ5F88hHMt+vqH3hOI0L89iqjsW7JEzYMr3090NolcxFPrUSf24dgmsBxQm99mE
	LB0z+548S/GtY57hCL9IVs9SAZImodNKT/+LRgyyHf6OkMjfswGwzti5Y2qhWhMiWpL4Di
	eYWAgk1uzvfXPJPge/GQzrG9W5IHU+BB6myCMv5yxQ+/zG2SpH5Fzdm1CBCRQyyZQdrfCI
	w4k/OLxRqQAqDo4zhzauAuq4YWGFGYyHWvb7OcbJ4s83a8D8lh8tojmdQHmYaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718043789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m4Pj/Je9A5FG/IZDCfStO8t9dhzu69BwE+sdDR8YKBY=;
	b=7B4O+8a3CRiHfb/dt3owFewzGAjZgY0QbpL3yW26fps4djF3vlAv1qcIEC5g+Fw2UaHGIL
	sNIFfpCEJdGtMABw==
To: Peng Liu <iwtbavbm@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, maz@kernel.org, vincent.whitchurch@axis.com,
 iwtbavbm@gmail.com, 158710936@qq.com
Subject: Re: [PATCH] genirq: Keep handle_nested_irq() from touching
 desc->threads_active
In-Reply-To: <20240609183046.GA14050@iZj6chx1xj0e0buvshuecpZ>
References: <20240609183046.GA14050@iZj6chx1xj0e0buvshuecpZ>
Date: Mon, 10 Jun 2024 20:23:09 +0200
Message-ID: <877cewwtbm.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 10 2024 at 02:30, Peng Liu wrote:
> handle_nested_irq() is supposed to be running inside the parent thread
> handler context. It per se has no dedicated kernel thread, thus shouldn't
> touch desc->threads_active. The parent kernel thread has already taken
> care of this.

No it has not. The parent thread has marked itself in the parent threads
interrupt descriptor.

How does that help synchronizing the nested interrupt, which has a
separate interrupt descriptor?

> Fixes: e2c12739ccf7 ("genirq: Prevent nested thread vs synchronize_hardirq() deadlock")
> Cc: stable@vger.kernel.org

There is nothing to fix.

> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> ---
>
> Despite of its correctness, I'm afraid the testing on my only PC can't
> cover the affected code path. So the patch may be totally -UNTESTED-.

Which correctness?

The change log of the commit you want to "fix" says:

    Remove the incorrect usage in the nested threaded interrupt case and
    instead re-use the threads_active / wait_for_threads mechanism to
    wait for nested threaded interrupts to complete.

It's very clearly spelled out, no?

Thanks,

        tglx

