Return-Path: <stable+bounces-23909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FF28691A3
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BC81F2A73B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3528013B2A4;
	Tue, 27 Feb 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h92WxNvD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A413AA47;
	Tue, 27 Feb 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040041; cv=none; b=dTgJgdLfcGMVEjXMvMNNl5QaXpZMRiKmCgA+lCtH6W6iYxKCO50MAFFISgjtTbJ9VUpnaxo9tUO1JSWfVIxMtQ+Oxfc0wQGNqRKlMMNVhJc2MjgpsSO7C3DdCAhbjZKbcI2/Ia8DbcP7ldJV1iY3uMR5a9XQotSW6KrU4U5QxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040041; c=relaxed/simple;
	bh=IRenoZlmr8eM9lN5R+6kYA9ALqmckGPj1giVJuqIrNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3LgvLz43EsaAGEzXDhFxnUYfdoPa6hSnkdWb1tEO1iUV1DjTacNlpQBdXe70R+VtaJBWwGIkQw14npUwv5OtAVtWb82l1l+MV95ySdQeZS4Z6JAo9MWMPyRe3/ptgMrW5v4RDwBFYthHb7P/1KyTaZA3qLWfGblo7Edz51uWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h92WxNvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61394C433F1;
	Tue, 27 Feb 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709040040;
	bh=IRenoZlmr8eM9lN5R+6kYA9ALqmckGPj1giVJuqIrNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h92WxNvDmg3gAyU+1mg4PBOCFHfIPbWxmTTH3nNwQ03tngzGOvHolN1Kdqp3lch1o
	 L9+qt4nswbTVitGRPmzYzrK0t18HfdOxGym75J9wwk4pR0KndEGoObIh1I4Qs8VRU7
	 n9K/zXtHQu22ZNQymuZ9LCDJAnsVmJC3xXC9GuFncoA2C6yQeRPVIEPcem9LivCCe4
	 BU4YVR10mSlQaYXx2B3OQcYaA+jLu11CVJrecx3tE8ylpv9gHE7Y2Ao+H7UnZNMsX3
	 WJAAAEUGGWj7DqUhmW1wGGfsM1Hzx5xtmpnjOZGi7GEIYeMYPYruPytJBa23x59XSk
	 EdD3Iy1ABDsHg==
Message-ID: <e333302f-37e9-45d4-afb2-7e2885fa07c4@kernel.org>
Date: Tue, 27 Feb 2024 14:20:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] mptcp: add needs_id for netlink appending addr
Content-Language: en-GB, fr-BE
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
 Geliang Tang <tanggeliang@kylinos.cn>, Mat Martineau <martineau@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
References: <2024022654-senate-unleaded-7ae3@gregkh>
 <20240226215620.757784-2-matttbe@kernel.org>
 <2024022723-outshoot-unkind-734f@gregkh>
 <2c80d410-b480-4043-b17f-2aaa357e5d41@kernel.org>
 <2024022704-disjoin-nearby-7216@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2024022704-disjoin-nearby-7216@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2024 14:01, Greg KH wrote:
> On Tue, Feb 27, 2024 at 12:04:22PM +0100, Matthieu Baerts wrote:
>> Hi Greg,
>>
>> On 27/02/2024 11:22, Greg KH wrote:
>>> On Mon, Feb 26, 2024 at 10:56:21PM +0100, Matthieu Baerts (NGI0) wrote:
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> Just the same as userspace PM, a new parameter needs_id is added for
>>>> in-kernel PM mptcp_pm_nl_append_new_local_addr() too.
>>>>
>>>> Add a new helper mptcp_pm_has_addr_attr_id() to check whether an address
>>>> ID is set from PM or not.
>>>>
>>>> In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
>>>> mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
>>>> needs_it.
>>>>
>>>> Fixes: efd5a4c04e18 ("mptcp: add the address ID assignment bitmap")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> Signed-off-by: David S. Miller <davem@davemloft.net>
>>>> (cherry picked from commit 584f3894262634596532cf43a5e782e34a0ce374)
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>> Notes:
>>>>  - conflicts in pm_netlink.c because the new helper function expected to
>>>>    be on top of mptcp_pm_nl_add_addr_doit() which has been recently
>>>>    renamed in commit 1e07938e29c5 ("net: mptcp: rename netlink handlers
>>>>    to mptcp_pm_nl_<blah>_{doit,dumpit}").
>>>>  - use mptcp_pm_addr_policy instead of mptcp_pm_address_nl_policy, the
>>>>    new name after commit 1d0507f46843 ("net: mptcp: convert netlink from
>>>>    small_ops to ops").
>>>> ---
>>>>  net/mptcp/pm_netlink.c | 24 +++++++++++++++++++-----
>>>>  1 file changed, 19 insertions(+), 5 deletions(-)
>>>
>>> Don't we also need a 5.15.y version of this commit?
>>
>> Good point, yes, according to the 'Fixes' tag, we need it as well for
>> 5.15.y.
>>
>> It looks like no "FAILED: patch" notification has been sent for this
>> patch for the 5.15-stable tree. Is it normal?
> 
> Hm, odd, I don't know why I didn't send that out, that's a fault on my
> side, sorry about that.
> 
> So yes, we do need this, I've just now sent the email if you trigger off
> of that :)

All good, it happens! :)

I will check that one later. I'm currently tracking one (or two?)
regression(s) in v6.1. It looks like they were already present in the
last v6.1 tag (v6.1.79). Patches will follow.

>> I'm asking this because I rely on these notifications to know if I need
>> to help to fix conflicts. I don't regularly track if patches we sent
>> upstream with 'Cc: stable' & 'Fixes' tags have been backported. It is
>> just to know if we need to modify our way of working :)
> 
> No, your way of working is WONDERFUL from my side at least, I have no
> complaints at all!

Great! We will then continue to track 'FAILED: patch' notifications, and
rely on your excellent work selecting all patches that need to be
backported.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

