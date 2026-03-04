Return-Path: <stable+bounces-223022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOXQCL/5p2mtmwAAu9opvQ
	(envelope-from <stable+bounces-223022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:22:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C311FD809
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EEC0307E0AC
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C9337269D;
	Wed,  4 Mar 2026 09:19:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5633372693
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615998; cv=none; b=MHZ/GCdPGCzgFmixLGSvBdPYTRmB4H4EdhTq48pAz/0JeqR8VpWehjgLTjfc74Cb9XWfVcOPnYGy+GKjHELOWJlZHNvRpVpmI5iXaAjHljF+wKKi/vV8HXQaZttSPnUDXcf0/yknjdM48E03L52MKuBEp3whRRa/4lbmog/aIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615998; c=relaxed/simple;
	bh=Qtuzol1v95nvpciKvJHF1dw3Gq0LaWj9Dtrw1HrvnEI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TACTrfYQqJz22MRdXlnTddZ5jD9VEyTI5rZEqlnIzhYHwjtq7aWyWyv5QRPji82g2vfA/SCXpuTkgfIpboLeiByi2l8GCN0gDXWeWMLvX3oftQXE31fluBuGCEfb+WXvL7yCYnPsukaQcejS30nrKJRFoMnz8wMU2q8CZPQ8TUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 04 Mar 2026 18:19:55 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id 3F3082080BF0;
	Wed,  4 Mar 2026 18:19:55 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Wed, 4 Mar 2026 18:19:54 +0900
Received: from [10.212.247.202] (unknown [10.212.247.202])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 9073510A016;
	Wed,  4 Mar 2026 18:19:54 +0900 (JST)
Message-ID: <c97385e8-6a28-4d02-9094-8713432f8ac1@socionext.com>
Date: Wed, 4 Mar 2026 18:19:53 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] v6.6.120: i3c crash caused by commit 82a09b9965ed
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
 Sasha Levin <sashal@kernel.org>
References: <d0a7accd-3d7d-41ec-b85e-469adf156a91@socionext.com>
 <2026012139-fidgeting-comic-916c@gregkh> <202601211657387e890711@mail.local>
 <2026012102-anyplace-moaner-3197@gregkh>
 <a9b1a78a-8e3b-4f23-8594-e21f35b5a51d@socionext.com>
Content-Language: en-US
In-Reply-To: <a9b1a78a-8e3b-4f23-8594-e21f35b5a51d@socionext.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 81C311FD809
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[socionext.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.974];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hayashi.kunihiko@socionext.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223022-lists,stable=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi,

On 2026/01/22 14:58, Kunihiko Hayashi wrote:
> Hi Greg, Alexandre,
> 
> On 2026/01/22 2:20, Greg Kroah-Hartman wrote:
>> On Wed, Jan 21, 2026 at 05:57:38PM +0100, Alexandre Belloni wrote:
>>> On 21/01/2026 15:56:01+0100, Greg Kroah-Hartman wrote:
>>>> On Wed, Jan 21, 2026 at 08:04:03PM +0900, Kunihiko Hayashi wrote:
>>>>> Dear stable maintainers,
>>>>>
>>>>> After updating from v6.6.119 to v6.6.120, I noticed a kernel crash
>>>>> when I3C was enabled.
>>>>>
>>>>> This regression is caused by:
>>>>>
>>>>>      commit 82a09b9965ed ("i3c: fix refcount inconsistency in
>> i3c_master_register")
>>>>>
>>>>> The issue is resolved when the following upstream fix commit is
>> applied:
>>>>>
>>>>>      commit 3502cea99c7c ("i3c: Move device name assignment after
>> i3c_bus_init")
>>>>
>>>> That does not seem to be a valid git id, where did it come from?
>>>>
>>>
>>> This has not yet been sent to Linus and my plan was to wait for the
>>> merge window as the fix didn't make it clear this was actually happening
>>> in the field.
>>
>> So we are bug-compatible with Linus's tree right now?  Great, all should
>> be fine :)
> 
> Thanks for the clarification.
> 
> I saw the commit in linux-next tree.
> Understood that the fix hasn't yet landed in Linus's tree and
> therefore cannot be picked up by stable at this point.

The upstream commit
   3502cea99c7c ("i3c: Move device name assignment after i3c_bus_init")
has now been merged into Linus's tree.

As far as I've checked, v6.12 and older versions are still affected.
Could you please consider this for stable?

Thank you,

---
Best Regards
Kunihiko Hayashi

