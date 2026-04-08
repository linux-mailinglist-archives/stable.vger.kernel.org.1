Return-Path: <stable+bounces-235272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEC7OWep1mlKHAgAu9opvQ
	(envelope-from <stable+bounces-235272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:15:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3205F3C2A67
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24634300461F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FAF3DA7CD;
	Wed,  8 Apr 2026 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="BdtkQo49"
X-Original-To: stable@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FD53B2FCD;
	Wed,  8 Apr 2026 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775675734; cv=none; b=r6tVwq6QhqdPwEpTBv6wG+z7kZfsBrmQE97dQQ+sVCWqEsVQxPYb2Jm633Rs1k8FzKGFQ97uwPP4Z6jQtKML3l72uF3kwGCvxVQ07wYJmuY9rvi3Hkfr48IcGae7qm+LsyLa3XTazgrVHEPpNyjVo8QbOMXZFWFwJRHCdZYxnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775675734; c=relaxed/simple;
	bh=JZpipuTa8f2r1rEwJmj1883sExcXgeGBZCPAzmjBpb0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IreVhHAGlV8z+17GWZQKj3VrnfchIANFCESRG2RejnC+21cJRFohaoxuK++1A128TVhxES65V9wgTgX9wHPqbvIyn1yRv1OQ0Bppt9AsjzByHb6ZGmtM2W3KiMz7oW70XNeFKjB+I2O3qNEKiteJF/gGGLDsrtsnOxRaCLX/HKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=BdtkQo49; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA1FBA588E;
	Wed,  8 Apr 2026 21:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775675725; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t1sBfATotgNvvEO2UQbvxW1BDDWsBRhyG+y/VKIZseU=;
	b=BdtkQo49Comz61CfOwiLZoWJ1NgI5L+PAbCuET6kfzX0ybqeNm7Z6rQhII6rsvH7TwbVb5
	hRwAeEmtB4BIv9TYwLZcDCEapMs1WiqJTasO+VLrlCc6LffoAkFiQzZ7+uUp8GsLwAPsif
	50b82FP+sgBX5qPaNovgXOgQxVlJDCQFKEz/aKz9EQcFvJ398pMEfcZ519xFjAFUbkATx7
	wYzl+IXATMVqcl2rREmsGVcB4jB+BFCxM5Rr0C4lyrqljdGjq3LEk3qaTCT50TPuWenfl7
	bwJWUNmmr6N61mojsqt5Vk3OLCYtmoaPjnBFRy5PQyZC/NSeAz8krEFBDwXwnw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 08 Apr 2026 21:15:22 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui
 <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH] net: ks8851: Reinstate disabling of BHs around IRQ
 handler
In-Reply-To: <a9845b8e-5d3f-472b-8f03-bba699ba3882@nabladev.com>
References: <20260407212344.80265-1-marex@nabladev.com>
 <f4010cedaa49afc1648a73775a987ee5@tipi-net.de>
 <a9845b8e-5d3f-472b-8f03-bba699ba3882@nabladev.com>
Message-ID: <215ad1cc5db3f352ac2a130c07dbd830@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,redhat.com,raritan.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:?];
	TAGGED_FROM(0.00)[bounces-235272-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	NEURAL_SPAM(0.00)[0.903];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[tipi-net.de:s=dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3205F3C2A67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 8.4.2026 17:41, Marek Vasut wrote:
> On 4/8/26 12:54 PM, Nicolai Buchwitz wrote:
> 
> Hello Nicolai,
> 
> thank you for testing on the SPI variant, that helped a lot.
> 
>> In order to make this work I would propose something like this (which 
>> works in my SPI setup):
>> 
>> --- a/drivers/net/ethernet/micrel/ks8851_par.c
>> +++ b/drivers/net/ethernet/micrel/ks8851_par.c
>> @@ -60,12 +60,14 @@ static void ks8851_lock_par(struct ks8851_net *ks, 
>> unsigned long *flags)
>>   {
>>       struct ks8851_net_par *ksp = to_ks8851_par(ks);
>> 
>> +    local_bh_disable();
>>       spin_lock_irqsave(&ksp->lock, *flags);
>>   }
>> 
>>   static void ks8851_unlock_par(struct ks8851_net *ks, unsigned long 
>> *flags)
>>   {
>>       struct ks8851_net_par *ksp = to_ks8851_par(ks);
>> 
>>       spin_unlock_irqrestore(&ksp->lock, *flags);
>> +    local_bh_enable();
>>   }
>> 
>> Tested-by: Nicolai Buchwitz <nb@tipi-net.de>  # KS8851 SPI, non-RT 
>> (regression + proposed fix)
> 
> Are you also able to test the KS8851 driver with PREEMPT_RT enabled and 
> heavy iperf3 traffic on the SPI variant ? Does that trigger any issues 
> ? I ran 'iperf3 -s' on the KS8851 end and 'iperf3 -c 192.168.1.300 -t 0 
> --bidir' on the host PC side.

Successfully tested with both PREEMPT_RT and non-RT kernels using the 
iperf3 command above - no issues observed. Both builds included the fix 
from my previous message.
If there is anything else worth testing on the KS8851 SPI variant, 
please let me know.

> 
> Let me prepare a slightly updated fix and send a V2.

Regards
Nicolai

