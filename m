Return-Path: <stable+bounces-237781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I5FJygZ3mmFnAkAu9opvQ
	(envelope-from <stable+bounces-237781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:38:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4F53F8D28
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67C17301ECE0
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D3A3D3CF2;
	Tue, 14 Apr 2026 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="WkHVGH+j"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35743D5258;
	Tue, 14 Apr 2026 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162415; cv=none; b=rn7bW8ybLWpEjV6tYnGb05xvk5klfevPcFpc99ufo2EG+otBG/AL/MUfyK5GinBatyQCXpRdJNe2a+HrLMZqtictGRc1+5ecnhM92vWJy68KEOeYjHnFLuzja91CseoWi/kxYWG4CdeejnUxP2uE9uGKE0c+RN3NnKVznvUMj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162415; c=relaxed/simple;
	bh=ZfFf+Xb9PptclsHbGofHnbDruAIXwhUSQ+T+mgmk3Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYOdicx91ZebKe9z0wEQznAhqEBN+i8AWxULbruGIhFnolGbSUC6xhj4Dk3sjhS7o0Aoq60aS8Rn+KnZ2rkgjckeG75EGMxmz0HeVA6FdkUHpTEauWZ4vfuBLYzvQJGPc5RsvVLNIiu1fNK1s+JguHajAR2QBi5IAfCpkLmtCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=WkHVGH+j; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9296510CE86;
	Tue, 14 Apr 2026 12:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776162404;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QUw1GVmNa8Tm46eOKkaFDELo/gPbvua9u5RkS9ks50Q=;
	b=WkHVGH+jj8fht7LcddhRDZghm6vajSldF7jCuPPld8XaJDmTaavEKLjPoyAyiSo++KUoeB
	yY6lRuBcEQxo02s6xWZd2oP88iW/C9ZeUYfQElpKoQq6jIbpSGEJXAWXpZUsVll3RdYw/K
	z6BusZnCnsxCW3891oKe2Dv+Yo02pJL3mhCPPQiCtgjPYkXCJ0sl/vWA8DNsQohqqACxN9
	fAg1LL7BanNxdvRBXbnxQ3L2cfOENpERevQTsStSd+PtfepD8mRGDARaXkuRlCQjNkqjot
	j+m+QXBfJXMu5IQox2zqitdZoPEG+Xwzgp6Icb9hjcr2WZJ6fzL5Pm9hwanYjQ==
Message-ID: <a3a1333b-5b08-4f18-8bce-6d83408d915e@nabladev.com>
Date: Tue, 14 Apr 2026 12:26:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around IRQ
 handler
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>,
 Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>
References: <20260408162535.98108-1-marex@nabladev.com>
 <20260412090141.21bf1534@kernel.org>
 <2558832d-c821-436d-898d-b708c5e0a228@nabladev.com>
 <20260412105125.48f0c58f@kernel.org> <20260413125744.TVKkZcEK@linutronix.de>
 <16fdeec9-9208-4c9b-b228-d6c6e045e116@nabladev.com>
 <20260413160336.GQCaw-1d@linutronix.de>
 <20260414085556.SJSDwbpW@linutronix.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260414085556.SJSDwbpW@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237781-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F4F53F8D28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 10:55 AM, Sebastian Andrzej Siewior wrote:
> On 2026-04-13 18:03:38 [+0200], To Marek Vasut wrote:
>> On 2026-04-13 17:31:34 [+0200], Marek Vasut wrote:
>>>> I don't see why it needs to disable interrupts.
>>>
>>> Because when the lock is held, the PAR code shouldn't be interrupted by an
>>> interrupt, otherwise it would completely mess up the state of the KS8851
>>> MAC. The spinlock does not protect only the IRQ handler, it protects also
>>> ks8851_start_xmit_par() and ks8851_write_mac_addr() and
>>> ks8851_read_mac_addr() and ks8851_net_open() and ks8851_net_stop() and other
>>> sites which call ks8851_lock()/ks8851_unlock() which cannot be executed
>>> concurrently, but where BHs can be enabled.
>>
>> I need check this once brain is at full power again. But which
>> interrupt? Your interrupt is threaded. So that should be okay.
> 
> I don't understand. There is no point in using spin_lock_irqsave() in
> ks8851_lock_par(). You don't protect against interrupts because none of
> the user actually run in an interrupt. As far as I can see, the
> interrupt is threaded and the mdio phy link checks should come from the
> workqueue.

Ha, now that the IRQ handler is indeed only threaded, I can use 
spin_lock_bh() indeed. I will send a V3 like that.

> What is wrong is that the ndo_start_xmit callback can be invoked from a
> softirq and such you must disable BHs while acquiring a lock which can
> be accessed from both contexts. Therefore spin_lock() is not sufficient,
> it needs the _bh() and _irq() brings no additional value here.

