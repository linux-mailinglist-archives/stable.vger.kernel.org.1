Return-Path: <stable+bounces-203229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00414CD6A47
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 17:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9A7F303894A
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 16:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1520330B04;
	Mon, 22 Dec 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xJZoY7l3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BlYrnsNq"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94E330663;
	Mon, 22 Dec 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766419998; cv=none; b=SF2MDIkNfxdDJIqrE8JYG2hmwNCsnkBRurwVJxBrg+C+0aEHhVa5hZ4Leknip6fRNpm0M0/ds55+T01uz2e+bYD3hNPgos8eVkbuLl0+dy8DbGsg4lbKHILIHfoeU1uQ/6WH/2apd8AM0WHIc+OJuS694GO0u9HqKuyat/+zsUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766419998; c=relaxed/simple;
	bh=XVYNXdfTSlv3B1+X3osl8zOBQWgFt1T2EeiVSdDxiFE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qUde4v706jb3Z2fAGp8C16KQh2XNIjizKGy1T23hIN43D5HnsyAciobtqKW/ydDEjgcbcfyu3aOOx5V9ZNmoX4zlhbzW2bj6CaGYjbUWSSTsP9qiaXFVWh4MbxLHXbpg4q8BaCMXTEelUOA+j0b0RpJ8LKI0dQdNfAhWg7Sunq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xJZoY7l3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BlYrnsNq; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBE79140007C;
	Mon, 22 Dec 2025 11:13:15 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 22 Dec 2025 11:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766419995;
	 x=1766506395; bh=yexxgvfeOqlU4iFlVrzT6HWMfGk+5xWNhXAHteFFPuw=; b=
	xJZoY7l3FIynRUCZOfwW6/jyl+44DnO+tY1vQ/UMFNIVx+ukVxRS3q1ekn1V0CEP
	3y8n7gOeJFLnAydv03Nq+obzAow5hAEMrXJuwc6/hmFlmtOOTLxjGsqsOjkPnWty
	HODgPMvqrP/vY78Wzui+PHEqEMMCNqJH3QPIFvYR99t0g3OIj3t6ec5K4LJw/WWo
	8pluee+p2yRiEztVqgGlLvIuu28YsnYY8pesAL3ZzaYBFHAg+Lcpf5mCOqeHZc/m
	EcGxDKmkwKZiHRQtAVcyAitsfz5O6PNQd+Q3veQ724gnryuCN5vnhnTNKL03q5wQ
	AQGDlZF3A9zzAPPFxwohbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766419995; x=
	1766506395; bh=yexxgvfeOqlU4iFlVrzT6HWMfGk+5xWNhXAHteFFPuw=; b=B
	lYrnsNq1uoH7TN3MoX53hVwJgA+4PjMiTJRX4h97f9c1fgzWLzFhkqhiWybvrJTR
	ocUxd0kCKALBo/zlp+IVyBbUlI0X6fdCQS2c71CMmEx2wiLrnoUWbCr2FacgZkKs
	o4JA6STGxkZuqUzo5ckAeJf4pKPgcCx/1VCQicW76FPmO/SMMUQnJ9AohqcYNeUo
	V8IehVRRCB3RLGx8RR6kq/u2I1n1MpMYZb4AaeWIyyM5NzuZA7bD3wU3t2JL0rdu
	mpo4dPuzRGc0TYD1hTrJZavqeraQj9m8uYsFNp8Ve9U3Gl5ivnlJu5f3X+YW5VQv
	8RAB1PFyu6MJvzytr+MYw==
X-ME-Sender: <xms:G25JaX1NgeWtzD6HFUVL-l8aSTR-EL7Db6BP9sutr7Z3YfcGw0LJfg>
    <xme:G25JaQ4gd5SBUbFLzer7hQ2njbwBRj9Qako16qm2XOge_UH7e5c7c0Ptw7BfNzpsc
    hDbWrRSukUrEzlz2fAe4Gs_FBh3WrhMSDCLqZ32eNJ_7Qq4XYVOrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehjeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlmhgssehishhovhgrlhgvnhhtrdgtohhmpdhrtghpthhtoheprghmih
    htsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopehvihhrthhurghlihiirghtihhonheslh
    hishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G25JafYvTlm6QSTpsfRekjA4TpZFd-JfXKeRNj893C52-qqo6RU-cA>
    <xmx:G25JaQp0986_9p_yqdW34ozm5LiQNaRCRgd3vxhbGXgGbtbi3-N_AA>
    <xmx:G25JaUNAGQLZhlsknJ2YuambLnTkGpY1qfPLwTC2y6KJ4JEs1zhSMg>
    <xmx:G25Jabr873qQ4RBB8NbmPuBOZ7m3Z6aYJKJG8-sSvhoslQDnmHHg5Q>
    <xmx:G25JaYgaSXOyxKhlRqXPASuF63RyBj67poIPB5tHgFp2ijgEcmkHF-20>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9178FC40054; Mon, 22 Dec 2025 11:13:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag3Cik6rCkEF
Date: Mon, 22 Dec 2025 17:12:55 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenz Bauer" <lmb@isovalent.com>, "Amit Shah" <amit@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <abdeaef1-e6d4-43c3-b8c4-d5f0c645a169@app.fastmail.com>
In-Reply-To: 
 <20251222-virtio-console-lost-wakeup-v2-1-5de93cb3f1c1@isovalent.com>
References: 
 <20251222-virtio-console-lost-wakeup-v2-1-5de93cb3f1c1@isovalent.com>
Subject: Re: [PATCH v2] virtio: console: fix lost wakeup when device is written and
 polled
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 22, 2025, at 17:04, Lorenz Bauer wrote:
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -971,10 +971,17 @@ static __poll_t port_fops_poll(struct file *filp, 
> poll_table *wait)
>  		return EPOLLHUP;
>  	}
>  	ret = 0;
> -	if (!will_read_block(port))
> +
> +	spin_lock(&port->inbuf_lock);
> +	if (port->inbuf)

As far as I can tell, you got the interrupt flag handling wrong
in both places: port_fops_poll() is called with interrupts
enabled, so you have to use spin_lock_irq() to block the
interrupt from hanging.

> @@ -1705,6 +1713,10 @@ static void out_intr(struct virtqueue *vq)
>  		return;
>  	}
> 
> +	spin_lock_irqsave(&port->outvq_lock, flags);
> +	reclaim_consumed_buffers(port);
> +	spin_unlock_irqrestore(&port->outvq_lock, flags);
> +
>  	wake_up_interruptible(&port->waitqueue);

The callback seems to always be called with interrupts
disabled(), so here it's safe to use spin_lock() instead
of spin_lock_irqsave().

     Arnd

