Return-Path: <stable+bounces-25881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC4286FF3E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1219F286027
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A7036B16;
	Mon,  4 Mar 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2PGBXHo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0736B02
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548853; cv=none; b=e7ukz6eR5oS6Igfg707tXy9yEp4GEkTpxwkEM5ODUZIa3slN4zrILkHpjnsxw2XpLBfSWVdj9jdHhlcr6NeVkaem1usC1dKsAALmxmBkadYOuQAk7B8yGjj26MGEECMLgWlTs+LET8Hsj76dd1X94espgEPvTGVUGoMAwiRBImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548853; c=relaxed/simple;
	bh=OoRCFPTb0u5llhWNchSxZeryxODkHB0zMlhb0wBAe2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6SgpGUin3lEO5VhgxAx6flmhNRGBZPGDv7t6YRf5vjifgTxPfFQZurFXW1wkgRIVAfLrHz/gXa/PnS9mwb6zTZljlZGqcdFEg2WmR8oK8Ik35OUpStucee0qpQS4GLLBbRQLwYXfMPMmu79VRc+mqfRuCQm9P+MWZ8/nMichM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2PGBXHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC03CC433F1;
	Mon,  4 Mar 2024 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709548853;
	bh=OoRCFPTb0u5llhWNchSxZeryxODkHB0zMlhb0wBAe2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b2PGBXHoz1+jI/Hw5PY2dAzUybEsVk9FmrF3UdhxshGmQ/iz1THztgwUwUU0YJctd
	 al2BzVSuGQSE0898lY4fkLp7tqFVURTGJEBCk0Fvbm+2GuMgIkF9BycciHENSUu2Hd
	 fO4dnejhxgtUe7Cv7sAIT2PB+PpQxShoWpAQRevYGLCBn9EXeRwv7xvXbZndMWEtw6
	 B/7qJ+L5UsynZP+yMU4Wjqy46OWxue+WbNSEmiAz+/nLEIbPj6LS3ek1Ar18ee7/fr
	 CWAbEhd8OjlR8Ftr/fxr/8E3BRRyYjhw//Fyk1GKRboKR8zjzSHUL1KAzXdYb6HpoX
	 7TS0H8BA17jHQ==
Message-ID: <79f149f6-e5aa-455e-832e-8ae3356cb690@kernel.org>
Date: Mon, 4 Mar 2024 11:40:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] selftests: mptcp: rm subflow with
 v4/v4mapped addr" failed to apply to 6.1-stable tree
Content-Language: en-GB, fr-BE
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tanggeliang@kylinos.cn, kuba@kernel.org, martineau@kernel.org,
 stable@vger.kernel.org
References: <2024030422-dinner-rotten-5ef3@gregkh>
 <0991a6b7-2d74-4f26-9959-68d745086902@kernel.org>
 <2024030430-pessimism-unveiling-715f@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2024030430-pessimism-unveiling-715f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 11:32, Greg KH wrote:
> On Mon, Mar 04, 2024 at 11:07:01AM +0100, Matthieu Baerts wrote:
>> On 04/03/2024 09:30, gregkh@linuxfoundation.org wrote:

(...)

>>> ------------------ original commit in Linus's tree ------------------
>>>
>>> From 7092dbee23282b6fcf1313fc64e2b92649ee16e8 Mon Sep 17 00:00:00 2001
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>> Date: Fri, 23 Feb 2024 17:14:12 +0100
>>> Subject: [PATCH] selftests: mptcp: rm subflow with v4/v4mapped addr
>>>
>>> Now both a v4 address and a v4-mapped address are supported when
>>> destroying a userspace pm subflow, this patch adds a second subflow
>>> to "userspace pm add & remove address" test, and two subflows could
>>> be removed two different ways, one with the v4mapped and one with v4.
>> I don't think it is worth having this patch backported to v6.1: there
>> are a lot of conflicts because this patch depends on many others. Also,
>> many CIs validating stable trees will use the selftests from the last
>> stable version, I suppose. So this new test will be validated on older
>> versions.
>>
>> For v6.6 and v6.7, I can help to fix conflicts. I will just wait for the
>> "queue/6.6" and "queue/6.7" branches to be updated with the latest
>> patches :)
> 
> Should all now be up to date,

Maybe we are not talking about the same thing: are the "queue/X.Y"
branches from the "linux-stable-rc" repo [1] not updated automatically
when patches are added to the "stable-queue" repo [2]?

It is just to know which base I use to resolve conflicts :)

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/

> I don't see any pending mptcp patches in
> my review mbox to process.

Thank you for having applied all these patches!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

