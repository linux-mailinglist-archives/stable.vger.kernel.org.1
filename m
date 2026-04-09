Return-Path: <stable+bounces-235552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hukeBdNQ2GkhbwgAu9opvQ
	(envelope-from <stable+bounces-235552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 03:22:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5B33D1120
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 03:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38AE83013AB2
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D75E3264E9;
	Fri, 10 Apr 2026 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="T4Ia0eYl"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C829BDBB;
	Fri, 10 Apr 2026 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775784141; cv=none; b=u544YynQ5PCMcz+UNcP2/81ODrQEi4gdsbaprauIEJZtE572zednLlaSJiske52WP0v3Us0Xdi+JzaJj8JgV8nY2YZBaw2SdSDw+AIEpb8VBMpA1xhiVfA2eN1m/mFlJI3XWQ4PAxI73iQxRrl+DMxXOYbzscWfeNs9FNnzu2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775784141; c=relaxed/simple;
	bh=OtdwFEyEb8se/ithYk2UGLo+hYsxtwasy+75+RvYfiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSsd1rsviBCyWsY/gsR96Ce9Re8n4d+v6Y7oVtDlfn9+1L0TPUOjwmV+Ip0gCavZB3b/EyYCpx30pDwiOPD/nsEjKWItj0tJ5T7nXAMjDOJ/zGLwJdxQ3MtHmACOdldyBU7KtmJ84yWIJpjli4gCaA+eHXtOwkShGCexcrP8pzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=T4Ia0eYl; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D305B113855;
	Fri, 10 Apr 2026 03:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775784136;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xpNGb4YWB4vk5Fw9+AtiAS5mIPWhtfd3tfy+j6rlEZM=;
	b=T4Ia0eYl5boquXW4npr40FUzcytcAIKE9lyrtAdx3591Gky2aF40mU8Af3gv8NpgEvKgsN
	lAbBE1viTgoH/4YBwzufngSIc86vujOxg+mCyzFYxl8/pbhgTXTJb4Jcd0ea0hYVLaI8XF
	vSNPpIekHTKkG04pQRUpb4S7G6R6JLE80XSSJpCqUbtLJJW+jAZCeIBx18NySBQXTLVITx
	lh3cZUZs5ukSFjFhgK3EwX6CS4ntZYCZAhNWA6J7jo2A1twBJjmyf8EfcpR9uGpzcJmhR4
	Gc6bo/dVicGoP6cBoe7zCNkkSMwJkQCBHrxqUkIK8wJRI2Owk7rV083dgkG2Sg==
Message-ID: <1665242a-2298-4e76-9618-effdb88c2ad4@nabladev.com>
Date: Thu, 9 Apr 2026 17:26:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around IRQ
 handler
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260408162535.98108-1-marex@nabladev.com>
 <6391ee36b7d9c66d33c734650ebfb7fe@tipi-net.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <6391ee36b7d9c66d33c734650ebfb7fe@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,redhat.com,raritan.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235552-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nabladev.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5E5B33D1120
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 8:52 AM, Nicolai Buchwitz wrote:

Hello Nicolai,

>> @@ -408,7 +426,9 @@ static int ks8851_net_open(struct net_device *dev)
>>      unsigned long flags;
>>      int ret;
>>
>> -    ret = request_threaded_irq(dev->irq, NULL, ks8851_irq,
>> +    ret = request_threaded_irq(dev->irq, NULL,
>> +                   ks->no_bh_in_irq_handler ?
>> +                   ks8851_irq_nobh : ks8851_irq,
> 
> This works, but wouldn't it be simpler to put the BH disable
> into the PAR lock/unlock directly?
> 
>    static void ks8851_lock_par(...)
>    {
>        local_bh_disable();
>        spin_lock_irqsave(&ksp->lock, *flags);
>    }
> 
>    static void ks8851_unlock_par(...)
>    {
>        spin_unlock_irqrestore(&ksp->lock, *flags);
>        local_bh_enable();
>    }
> 
> No flag, no wrapper, no conditional in request_threaded_irq.
> And it protects all PAR lock/unlock callsites, not just the
> IRQ handler.
That is exactly why I wrapped the IRQ handler, because the BH should be 
disabled ONLY around the IRQ handler, not around the other call sites.

