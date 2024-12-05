Return-Path: <stable+bounces-98763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A69E513D
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA891881F1A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8BF1D5AA5;
	Thu,  5 Dec 2024 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzD77ljE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D51D3566;
	Thu,  5 Dec 2024 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390666; cv=none; b=O8OdXc77MpWBH2kLRuqnBO4H3pm5br7XM8jKrC61QQ+KbV8mWuc/0uI6smZRpeHm6m567qBRY6rLaOoBmpdH13ASj/9N8ELUqc/sr/Txuh+ARYQ7RciwA32JKJdqkLocNNIDL3zvXkLIWUEDYeLIysfSK1KeyDikcFrXA+7Pd94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390666; c=relaxed/simple;
	bh=cxFYSQQ5LcnRKyXdrDH1BoaRM9MtIMnb4DyaV45f1Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/M8Q/AN4yaJGL2UAuou5tc2apxPWEpvpAj41Eb1BRT8mnTiyx4GTjR8M3r71eK3Yx4PuvB/2f9U8rS/cq9LBEuudwyKHsWQAyP7mo03rHpYTLShp4Ffn3CBgwTbS9aMUb7L92UUFrC19WMmq2vUOaysiKQlJotEswbhgl4MIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzD77ljE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA971C4CED6;
	Thu,  5 Dec 2024 09:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733390665;
	bh=cxFYSQQ5LcnRKyXdrDH1BoaRM9MtIMnb4DyaV45f1Bc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FzD77ljENiZ+ljuA89DGZ4YEL0purKsI+Ut5BV2BeTJoj1TdLCMjQ1BnBHEILfPO2
	 rOtuNGQaSqSz/+nZEcQFHb0uYJ2vxBksDCxN9kHAbfpjhxePSQaLqwvfPcAn5n7WOu
	 MWqsudJR6pmiF97rZIwOpdRvXiKBhM7kc7sOP+wbZP3Ecg4+N+MtklOXNll27VOBVF
	 7ONCEioOfv8Wy3Eqjt4HSV9jSuOOCa8ECOrBNwLCXbUCifV9l2f65fRGoXAmnQCcHL
	 XIWdVGNYqe17nJqu4RyybxB3sR8Op3aWh7JodcXbe1HDOa28M/bRqslrS+0F7mKy7M
	 /9bqEBrngQT/w==
Message-ID: <0f07b584-1013-4932-b155-cc0883ca7061@kernel.org>
Date: Thu, 5 Dec 2024 10:24:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] tcp: Check space before adding MPTCP options
Content-Language: en-GB
To: Mo Yuanhao <moyuanhao3676@163.com>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>
References: <20241204085801.11563-1-moyuanhao3676@163.com>
 <80b6603d-ed52-43b7-a434-0253e5de784a@kernel.org>
 <dcdeaf17-c3ce-4677-a0c0-c391d8bd951f@163.com>
 <CANn89iLjhnxkOY7p3zQsyupGowjMt0beWE3=WHTVC2NSM_-2hw@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iLjhnxkOY7p3zQsyupGowjMt0beWE3=WHTVC2NSM_-2hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi MoYuanhao,

On 05/12/2024 08:54, Eric Dumazet wrote:
> On Thu, Dec 5, 2024 at 8:31 AM Mo Yuanhao <moyuanhao3676@163.com> wrote:
>>
>> 在 2024/12/4 19:01, Matthieu Baerts 写道:
>>> Hi MoYuanhao,
>>>
>>> +Cc MPTCP mailing list.
>>>
>>> (Please cc the MPTCP list next time)
>>>
>>> On 04/12/2024 09:58, MoYuanhao wrote:
>>>> Ensure enough space before adding MPTCP options in tcp_syn_options()
>>>> Added a check to verify sufficient remaining space
>>>> before inserting MPTCP options in SYN packets.
>>>> This prevents issues when space is insufficient.
>>>
>>> Thank you for this patch. I'm surprised we all missed this check, but
>>> yes it is missing.
>>>
>>> As mentioned by Eric in his previous email, please add a 'Fixes' tag.
>>> For bug-fixes, you should also Cc stable and target 'net', not 'net-next':
>>>
>>> Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing
>>> connections")
>>> Cc: stable@vger.kernel.org
>>>
>>>
>>> Regarding the code, it looks OK to me, as we did exactly that with
>>> mptcp_synack_options(). In mptcp_established_options(), we pass
>>> 'remaining' because many MPTCP options can be set, but not here. So I
>>> guess that's fine to keep the code like that, especially for the 'net' tree.
>>>
>>>
>>> Also, and linked to Eric's email, did you have an issue with that, or is
>>> it to prevent issues in the future?
>>>
>>>
>>> One last thing, please don’t repost your patches within one 24h period, see:
>>>
>>>    https://docs.kernel.org/process/maintainer-netdev.html
>>>
>>>
>>> Because the code is OK to me, and the same patch has already been sent
>>> twice to the netdev ML within a few hours, I'm going to apply this patch
>>> in our MPTCP tree with the suggested modifications. Later on, we will
>>> send it for inclusion in the net tree.
>>>
>>> pw-bot: awaiting-upstream
>>>
>>> (Not sure this pw-bot instruction will work as no net/mptcp/* files have
>>> been modified)
>>>
>>> Cheers,
>>> Matt
>> Hi Matt,
>>
>> Thank you for your feedback!
>>
>> I have made the suggested updates to the patch (version 2):
>>
>> I’ve added the Fixes tag and Cc'd the stable@vger.kernel.org list.
>> The target branch has been adjusted to net as per your suggestion.
>> I will make sure to Cc the MPTCP list in future submissions.
>>
>> Regarding your question, this patch was created to prevent potential
>> issues related to insufficient space for MPTCP options in the future. I
>> didn't encounter a specific issue, but it seemed like a necessary
>> safeguard to ensure robustness when handling SYN packets with MPTCP options.
>>
>> Additionally, I have made further optimizations to the patch, which are
>> included in the attached version. I believe it would be more elegant to
>> introduce a new function, mptcp_set_option(), similar to
>> mptcp_set_option_cond(), to handle MPTCP options.
>>
>> This is my first time replying to a message in a Linux mailing list, so
>> if there are any formatting issues or mistakes, please point them out
>> and I will make sure to correct them in future submissions.
>>
>> Thanks again for your review and suggestions. Looking forward to seeing
>> the patch applied to the MPTCP tree and later inclusion in the net tree.
> 
> We usually do not refactor for a patch targeting a net tree.

Indeed, I agree with Eric. Even if the code looks good, more lines have
been modified, maybe more risks, but also harder to backport to stable.

Also, I already applied your previous patches with the modifications I
suggested -- the code is the same as in v1, only the commit message has
been modified -- in the MPTCP tree:

New patches for t/upstream-net and t/upstream:
- 06dcf123ebe0: tcp: check space before adding MPTCP SYN options
- Results: 4fdf39fbfdb4..05c0ade28862 (export-net)
- Results: 0de5663a2d56..993a44eee93f (export)

Tests have been running too:

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/12158569520

Is this patch not OK for you?

https://github.com/multipath-tcp/mptcp_net-next/commit/06dcf123ebe0

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


