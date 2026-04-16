Return-Path: <stable+bounces-238283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN0rHWCs4GkCkwAAu9opvQ
	(envelope-from <stable+bounces-238283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:31:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DA640C64E
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BEEC30480AD
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6F0396B8C;
	Thu, 16 Apr 2026 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="J4DulUyI"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DA3921D7;
	Thu, 16 Apr 2026 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331569; cv=none; b=ltMSP1sTwE1BBb6Ut3nnacc6ueUBmYFOtiH/KrQN+i/g5cIe8Jemy4UDbIn5U/ybQTrWjrIkMpGgwzP+gJvvfxItfiIBUq2HFY+bLIF8hPGQKYmkNCbA2VWcufeB4aKoJssejDozP3bCunkp//pzsmakS0F6Jh3nlenDXjZfUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331569; c=relaxed/simple;
	bh=Toi/ExDBfyTrjWM2U7MV0tQpQPeL2fa13Z+umrNeJ9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qmzwokinz8/4BZd+UBkKqTnuIzXgU2CS/lV4dZofouS8SgGn+CGGfqv3dZzX2crkGx1RoiAH9lz7tZpQem8EDlso5qTbZokv+WDKyGmYpzYavFhkq5l8Y8nCtXz6HWLwv2eHwpGQjLB/ahWQrJG/QH6VoBP+nOYGt8GDqnCfMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=J4DulUyI; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BC9E1134E5;
	Thu, 16 Apr 2026 11:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776331564;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=oIlLjStCPp+YGdDq1HhDSCSzp/k/RTMW/4RqUFAa/AQ=;
	b=J4DulUyIR6XJw1wn+SxuBkcPb/tn8epuU3yvkhDlh8N93t4h6S7ghIytknFyRiuxlPSC+s
	+x2YUJKQL5J8yeFBEyVlYuMYRZYKmttYi8DrjZ7VhBSxBcnRfAdd+zaSmqT9ThuIF80VFm
	dUMXBtq9uj023AGRnOB/iM2peMjJpxuPFO7jBRAxiJWrDvisBNJCyKtr+mOYsJeKpXbQhG
	S8I9yIlbMznbHRVUkdo1nAkVWcB/PdrpeDRlTWfcL+UcDuWXDRDQ7o6w8t8ovL+p+BpPMD
	oaUVABAbsCeuITZtO5q1CIBYqDKw5gl/u26/XiJ6qQ8Cs0JER3ZzNM2PlwTasA==
Message-ID: <afe7ed2c-4434-4394-9d87-a4bdf5a15ec1@nabladev.com>
Date: Thu, 16 Apr 2026 11:26:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>,
 Paolo Abeni <pabeni@redhat.com>, Ronald Wahl <ronald.wahl@raritan.com>,
 Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
References: <20260414103327.113500-1-marex@nabladev.com>
 <20260414125753.Im6GAIHn@linutronix.de>
 <2fcfb84f-69f6-493e-94d6-95d85d8000f6@nabladev.com>
 <20260414145218.lsNpdAJI@linutronix.de>
 <7734527a-d08b-49fa-b258-c37c5ae2da55@nabladev.com>
 <20260416062159.fPxqc52X@linutronix.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260416062159.fPxqc52X@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238283-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,tipi-net.de,redhat.com,raritan.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3DA640C64E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 8:21 AM, Sebastian Andrzej Siewior wrote:
> On 2026-04-16 01:14:35 [+0200], Marek Vasut wrote:
>>> spin_unlock_bh(&ks->statelock)? After that unlock, the softirq must be
>>> processed and __netdev_alloc_skb() _could_ observe pending softirqs but
>>> not from ks8851.
>> Because __netdev_alloc_skb() also enables/disables BH , see the "else"
> 
> Yes. But there is no softirq raised in that part. That softirq is raised
> by netif_wake_queue() within a bh disabled section. Therefore upon the
> unlock the softirq must be invoked.
> After that, rhe allocation later on may invoke softirqs which were
> raised but I don't see how ks8851 can be part of it.
> Before commit 0913ec336a6c0 ("net: ks8851: Fix deadlock with the SPI
> chip variant") there was no _bh around it meaning the softirq was raised
> but not invoked immediately. This happened on the bh unlock during
> memory allocation. Therefore I am saying this backtrace is from an older
> kernel.

I actually did update the backtrace in V3 with the one from next 
20260413 that contained b44596ffe1b4 ("ARM: Allow to enable RT") from 
stable-rt/v6.12-rt-rebase branch [1] .

I think I misunderstood the usage of "softirq is raised" vs. "softirq is 
invoked" above . Is it possible that there was an already raised softirq 
before the threaded IRQ handler was invoked, and __netdev_alloc_skb() is 
what invoked that softirq ?

> If there is a flaw in my the theory please explain _how_ you managed
> that get that backtrace. I am sure it must have from an older kernel and
> _now_ this lockup also happens on !RT kernels (except for the SPI
> platform).
I used [1] , with PREEMPT_RT enabled , on stm32mp157c SoC . I ran iperf3 
-s on the stm32 side, iperf3 -c 192.168.1.2 -t 0 --bidir on the hostpc 
side. The backtrace happened shortly after.

