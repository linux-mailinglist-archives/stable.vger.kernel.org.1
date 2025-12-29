Return-Path: <stable+bounces-203526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2ECE6A7A
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 611693011F6F
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76AA197A7D;
	Mon, 29 Dec 2025 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fl0i5p8G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tfNmxvy2"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B4290F;
	Mon, 29 Dec 2025 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767010530; cv=none; b=JRHbVZ0CKgrQx5Fo0gX7uf+PZk8GEMZ+Tn4Xy0sKsi463eF8Z6maKzMfTVmNFLvExjJjY7C0zBWwgVE28PuhTqKxTdacfk04m2Cfc1AWzE6FlOSsdW4xcbA2tMP9oRf0Gnb1SewMEreupJKmn+NbdiVvAW6jGMXVIqYRSb1vvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767010530; c=relaxed/simple;
	bh=QHq/Lso702AHpeRtQVR7YUX8eMVqM50P+v30WX1uJOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MduceazPofuq4Ze3cuNzT4WKIFS3gI2cGTMbPCUg/+L2t6IX1pgK/vKc8qSZffaQldYJqxfPs0JBCmsPbt/yCYa3idOy7iDlh0T5p1vUuwbpj4m8Uq45oxGeuIV4ZbzQQ2Cy7OBDyYm2uAth8QAh3HpNF4hG84bbSh8sRliiBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fl0i5p8G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tfNmxvy2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767010526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6kLfQS1q9JNXykk+4gVed8AeFxOiYJJs8EgVmrDYMRU=;
	b=fl0i5p8GeArBa/Na9CWzS0aCBFWwIUsDQpFZU5HgR5yQURUIqyVfN4MbFVpuVbtC7x7Vqx
	wJKmZ5TkGW7HG9Qmr3EorMgXh/Ir+s6B/8ogQAYZLmq8s94kVGkQlEMUtSKZZ6n/yPULBt
	GL6ZCWCKtfqO34euWiCYayRhANz3FLZwy2MSHT3u4XcnHTC10u53QSjJsm6kDxAQ8NoIjc
	IvEceklU6FRLKcW2HLvp253wP6umCAtr/RGXYGirHt0IOoluEaKEhJdrFsNEs/NhUVM/gC
	f74ztFnwGlYGh31sQFIzlIW9Y9gngCxgGOlufrjDAHpKqk2naA6p8Qx8oz9IDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767010526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6kLfQS1q9JNXykk+4gVed8AeFxOiYJJs8EgVmrDYMRU=;
	b=tfNmxvy2o4cCIQxgl9D8J+kzx3g/zlJCE0Nl2BvYr7TdXFWlazEcqGdWRlXvBBkZsKcOeT
	Xux2PEmkAiKediCw==
To: gregkh@linuxfoundation.org, gregkh@linuxfoundation.org,
 pmladek@suse.com, sherry.sun@nxp.com, stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org
Subject: Re: Patch "printk: Avoid scheduling irq_work on suspend" has been
 added to the 6.18-stable tree
In-Reply-To: <2025122945-trial-frosted-cef9@gregkh>
References: <2025122945-trial-frosted-cef9@gregkh>
Date: Mon, 29 Dec 2025 13:21:25 +0106
Message-ID: <877bu58owy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Greg,

On 2025-12-29, <gregkh@linuxfoundation.org> wrote:
> This is a note to let you know that I've just added the patch titled
>
>     printk: Avoid scheduling irq_work on suspend
>
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      printk-avoid-scheduling-irq_work-on-suspend.patch
> and it can be found in the queue-6.18 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This patch should be accompanied with the preceeding commit:

d01ff281bd9b ("printk: Allow printk_trigger_flush() to flush all types")

and the later commit:

66e7c1e0ee08 ("printk: Avoid irq_work for printk_deferred() on suspend")

in order to completely avoid irq_work triggering during suspend for all
possible call paths.

John Ogness

