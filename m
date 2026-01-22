Return-Path: <stable+bounces-211200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uInjKqa8cWkmLwAAu9opvQ
	(envelope-from <stable+bounces-211200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 06:59:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA71D621AC
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 06:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C0664E0D53
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 05:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CFA42982A;
	Thu, 22 Jan 2026 05:58:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A6934A3CC
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 05:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061536; cv=none; b=hU+WzHURZ08/3YKngspB4IIlKZZKnW3SPmTiN05gm7/bxnHU35mFRR59O1US4ws+SVSZngkx+gd8FMALrzuWWzqiUOCUQRlhv69rvwhRa+jNfwz7tjWvc3MZzqhZGffp1g5PxwulPwmCBvGcucN6Q9AfGfkJnjdLA1Mg2Ds9iu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061536; c=relaxed/simple;
	bh=GhLGfc3BiVQPyat2zgtjUOB08OS0pwzLMiA/NSeiGQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgHZOBKtjK7UdVLyw1S0vn69zAT3ck0tnYUyicR0tJs59gWL3NomSDtCgUIyFlPwTyNZVTaEB4Hfuq24zoD4Q9vet3YToSuD/mLSFthfPl/0Fu/YFzqNJv7bloprK7FF6hkI8Bwbppv+77iqQi5+L9BxAyIRRkLGwzXV2hcZ420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 22 Jan 2026 14:58:50 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 86ADA2069FE9;
	Thu, 22 Jan 2026 14:58:50 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 22 Jan 2026 14:58:50 +0900
Received: from [10.212.247.110] (unknown [10.212.247.110])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id C1AF61071A3;
	Thu, 22 Jan 2026 14:58:49 +0900 (JST)
Message-ID: <a9b1a78a-8e3b-4f23-8594-e21f35b5a51d@socionext.com>
Date: Thu, 22 Jan 2026 14:58:54 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] v6.6.120: i3c crash caused by commit 82a09b9965ed
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
 Sasha Levin <sashal@kernel.org>
References: <d0a7accd-3d7d-41ec-b85e-469adf156a91@socionext.com>
 <2026012139-fidgeting-comic-916c@gregkh> <202601211657387e890711@mail.local>
 <2026012102-anyplace-moaner-3197@gregkh>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <2026012102-anyplace-moaner-3197@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[socionext.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,socionext.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hayashi.kunihiko@socionext.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-211200-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CA71D621AC
X-Rspamd-Action: no action

Hi Greg, Alexandre,

On 2026/01/22 2:20, Greg Kroah-Hartman wrote:
> On Wed, Jan 21, 2026 at 05:57:38PM +0100, Alexandre Belloni wrote:
>> On 21/01/2026 15:56:01+0100, Greg Kroah-Hartman wrote:
>>> On Wed, Jan 21, 2026 at 08:04:03PM +0900, Kunihiko Hayashi wrote:
>>>> Dear stable maintainers,
>>>>
>>>> After updating from v6.6.119 to v6.6.120, I noticed a kernel crash
>>>> when I3C was enabled.
>>>>
>>>> This regression is caused by:
>>>>
>>>>      commit 82a09b9965ed ("i3c: fix refcount inconsistency in
> i3c_master_register")
>>>>
>>>> The issue is resolved when the following upstream fix commit is
> applied:
>>>>
>>>>      commit 3502cea99c7c ("i3c: Move device name assignment after
> i3c_bus_init")
>>>
>>> That does not seem to be a valid git id, where did it come from?
>>>
>>
>> This has not yet been sent to Linus and my plan was to wait for the
>> merge window as the fix didn't make it clear this was actually happening
>> in the field.
> 
> So we are bug-compatible with Linus's tree right now?  Great, all should
> be fine :)

Thanks for the clarification.

I saw the commit in linux-next tree.
Understood that the fix hasn't yet landed in Linus's tree and
therefore cannot be picked up by stable at this point.

Sorry for the early report, and thank you for taking a look.

Thank you,

---
Best Regards
Kunihiko Hayashi

