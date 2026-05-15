Return-Path: <stable+bounces-247307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LW/BQh/BmrnkAIAu9opvQ
	(envelope-from <stable+bounces-247307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:03:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A80435489F2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B811306F1AD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 02:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A2D25B08F;
	Fri, 15 May 2026 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZG1bB9vW"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB720CCDC
	for <stable@vger.kernel.org>; Fri, 15 May 2026 02:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778810524; cv=none; b=Xw/zHR1peRuWnVBMm1SMGV4RYB9a8+JToAc3cb4xtZxhnc1BISqAUYnxIsOWCqQ8NnxBf67KGnIsDgwVbdwx4/g7Nf7vUE9cK8KKvuZwKp2SFaogPlk/gwzuwh6QPkp9DrMG5fCov10KCuhf8slwfVKOsF6+NoiWEjT1BcUaNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778810524; c=relaxed/simple;
	bh=RUo9Zm+kUTt1LGVjRvStOWi2h5sS3Kp5xF+lxLh+nAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPYzptVYajsyepNoBurr+dk6b0Wq/5Azt/He54/PKb7Pft7D8UNifhlP8SHH2J7V/aVzfOzvbVvYduqOIyg+cSCWy+sjbchnYME0cLSPuxc4xUxRR1RVO74VWRb9soGcJoAx+BYeVv5ZAc1VRhA8r2HLMCytEo8y5IwKLPnP4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZG1bB9vW; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f747602d-8208-4b3a-9e16-78632ec7b919@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778810520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RUo9Zm+kUTt1LGVjRvStOWi2h5sS3Kp5xF+lxLh+nAY=;
	b=ZG1bB9vW3JbbWw2abv0cdjKWVGchRM2mxJxYJVOtO3E/MhLDrIXzLtWMiN7VRFB7gTQ0Md
	doMpnNghSNeAXXVK0nSQLAqkDg0aT4Z7BvE0i4JuCAeyAkKHqJe8so0l2mKgkh4f151pO/
	OIkqipzKm8yYmd2nKpiS0lxpl6jCvQA=
Date: Fri, 15 May 2026 10:01:50 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
To: Hyunwoo Kim <imv4bel@gmail.com>, Sultan Alsawaf <sultan@kerneltoast.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
 kuniyu@google.com, mhal@rbox.co, steffen.klassert@secunet.com,
 vakzz@zellic.io, ben@decadent.org.uk, herbert@gondor.apana.org.au,
 dsahern@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
References: <agToIEDI4TaTNLRb@v4bel> <agVpIsaSherjHTYg@sultan-box>
 <agWUdie1xBvBu22I@v4bel>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <agWUdie1xBvBu22I@v4bel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: A80435489F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247307-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kerneltoast.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,secunet.com,zellic.io,decadent.org.uk,gondor.apana.org.au,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/14/26 5:23 PM, Hyunwoo Kim wrote:
> On Wed, May 13, 2026 at 11:18:10PM -0700, Sultan Alsawaf wrote:
>> On Thu, May 14, 2026 at 06:07:44AM +0900, Hyunwoo Kim wrote:
>>> Changes in v2:
>>> - Also propagate SHARED_FRAG in skb_shift()
>>> - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
>> Hi Hyunwoo,
>>
>> I've been working on mitigating this vulnerability as a member of the kernel
>> team at CIQ, a distro vendor. In particular, we wanted to make sure that there
>> weren't any lingering places missing SHARED_FRAG propagation.
>>
>> To that end, I used Claude to discover that skb_gro_receive() remained unpatched
>> (as you pointed out in the v1 thread). And then I generated a PoC exploiting the
>> vulnerable skb_gro_receive() path.
>>
>> The PoC is a modified version of the original fragnesia PoC. It works 100% of
>> the time, just like the original fragnesia PoC.
>>
>> I have attached the PoC and a patch that fixes skb_gro_receive(). Please take a
>> look at them.
>>
>> Thanks,
>> Sultan
> Nice catch. Thank you.
>
> After testing, I plan to merge your patch with v2 into a single patch (not a
> series) and submit it as v3. I would appreciate it if you could then add an
> appropriate credit tag of your own.

When sending v3, remember to rebase net tree first then generate the patch.

https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=f84eca5817390257cef78013d0112481c503b4a3


Thanks

> Also, I would appreciate it if you could use AI to explore additional
> propagation variant paths. From my own analysis, no further ones have been
> identified.
>
>
> Best regards,
> Hyunwoo Kim
>
>



