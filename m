Return-Path: <stable+bounces-201025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4424DCBD683
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 11:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 346963011752
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CDC29E0E5;
	Mon, 15 Dec 2025 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HtNpMVwy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pGUTIuIS"
X-Original-To: stable@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C022246798;
	Mon, 15 Dec 2025 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795752; cv=none; b=aUqasgC+2dWQbKOhFP+5ZXcNZP3gTg1aXBmocJruzKDYl628HJ7tINUx/gSXfLkj+NO8ePLFy7PjKBO3+ARh0EF2Mzm32/8XbBPn6ZEOe5A/RnMP4popq1iYHZnpIOp5Tk6s2rNp65s9yur0dDn08OFix2mtNkHWi08ybEZaX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795752; c=relaxed/simple;
	bh=5Wijvsg4uo5ATFCrWc7tXz233rfgrWOUut7UvoQl6QI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BbtPvHc3UMz9jAUEy70FPV1D+ImIvkqgwv2e5lDXZpprNzb3cPDrkxw0AVQqqvlhEgPzlRN+OezJJubAhUtd8Lb0qyAHl/tyP1bJueHjSCeoAS2/MU6vASZayTaPLxvdr+EWGMQS14JBXrlxSbZ9fl0OCUph+cbVEHK7Dhsw/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HtNpMVwy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pGUTIuIS; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 6D5241300369;
	Mon, 15 Dec 2025 05:49:09 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 15 Dec 2025 05:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765795749;
	 x=1765802949; bh=oiOS6K+FM4QkQHzShPdFmQzy4z6NCmQ77XPIDgp2QCI=; b=
	HtNpMVwycFP1pZSFteCA/fA1fjLOS8V4mQ15malVayLKhY59QLw8OVk7mh4HhH5z
	9KtV8edzh0NafgKdvEKp1TYTj2L4MrMimq6iwiIem1TfYfBAXiuTAFkdnE0F8Ik8
	pAGp8pQ2VI2N4UTiW/nigZboZEAbI8CYQ5rynVtxK+wgbB35ZVVwokpcLfRsJ5BP
	uxEC2nBmKs522k4uUwz8gidc0tldyzO0Py/mzRZAayjvyBnspJmrSeJK5sB2POAC
	oSroqDZVPGDNejEI4fSFbNOo1S2P14+3n0N1tlTKELuwSTxnI26f+VIRKPbjYOfY
	AKlh5e7rDyWxDaXwVdD74A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765795749; x=
	1765802949; bh=oiOS6K+FM4QkQHzShPdFmQzy4z6NCmQ77XPIDgp2QCI=; b=p
	GUTIuIS7RldgeA1VG+z2P9MhmBijd88YjBNmyodxVMAXcRu/g5NFb4Cr4DtUtMst
	x7TvJEz/izMi5hPtQzAHCDxJok3RhjnH7VFio/uZ3/D8XPLVOCB+fWQ5btvm/42J
	AWdkG0trsWCKmAaimoZ/emBfxsDiFqSYsWrcRvY5kK8wBphkB6ub8BnO0A2fx9rN
	ZHDFf4l1snVq+q2D3JeESX5/jMduciZVHd2yqPcvlkBmTm+MIzKlQEcfnvYVE/yg
	3joVMOZRJr32MP9BPUagZVVJQ9PMEmUGl3uXd90wB4tk///PJdnfUwZvX57bJcJ2
	OcJA2wgN65X02XH1yZzdw==
X-ME-Sender: <xms:pec_ad65ji8VEehzKbsxuToA9fOYH41NWeZlb0gK9i5tSLAgjSeiuw>
    <xme:pec_aVtr-TLfSwwcxt03W6Pt33jYcPvwOF1gGd2Uo9QTKU0GeyZ-_xa2i3St0yVaK
    2ZIy2nZtRlOY-BxzMVDxMyMYGaeElDHMv7-zXDS9Ndx4IZlqqx2eQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefieeitdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:pec_aQdbzphfp61Qsz-hq97BOrrwjddBKpSq6XwYQWQAx86-qwQJ3w>
    <xmx:pec_aUcQ53DB5bAyP9iVo_p7skD-0B2U0XeSPagVAXcQhs5avje2bA>
    <xmx:pec_aTyUuSmo59uplukyIafrb6yAodljIrY2MmR-Zlr3l2vfxrwmsg>
    <xmx:pec_ab9zMb3WHQCh91_Ro5-OiM9FB7dQx2zN2rszX7p0bdo1A_OXlw>
    <xmx:pec_afqsAqo2II064ahz7oppFPZSZ9I7ZxmA3XWNhlG4Cor9j1PxfI3H>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F1668C40071; Mon, 15 Dec 2025 05:49:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACnozhdV4x1g
Date: Mon, 15 Dec 2025 11:48:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenz Bauer" <lmb@isovalent.com>, "Amit Shah" <amit@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <568c03e9-b30d-4655-8771-f8995f5a4ed4@app.fastmail.com>
In-Reply-To: 
 <20251215-virtio-console-lost-wakeup-v1-1-79a5c57815e7@isovalent.com>
References: 
 <20251215-virtio-console-lost-wakeup-v1-1-79a5c57815e7@isovalent.com>
Subject: Re: [PATCH] virtio: console: fix lost wakeup when device is written and polled
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 15, 2025, at 11:40, Lorenz Bauer wrote:
> +	}
> +	if (freed) {
> +		/* We freed all used buffers. Issue a wake up so that other pending
> +		 * tasks do not get stuck. This is necessary because vring_interrupt()
> +		 * will drop wakeups from the host if there are no used buffers.
> +		 */
>  		port->outvq_full = false;
> +		wake_up_interruptible(&port->waitqueue);
>  	}

Is it always enough to wake up only one waiter? From your
description it sounds like it might need wake_up_interruptible_all()
instead, but I may be misunderstanding the issue.

       Arnd

