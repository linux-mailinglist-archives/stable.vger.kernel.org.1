Return-Path: <stable+bounces-204759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2ECF3EE4
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F053D315E734
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4FA346ADD;
	Mon,  5 Jan 2026 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PLzJYIml"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD6346A02;
	Mon,  5 Jan 2026 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617219; cv=none; b=LRvDduoK+8QdjpIBLiJt9w0x3JgVlD3rWg2A6EVdJYa5Bs+XTxsNamQ3vGKFyG67ahSfgH6G/Ji2SRJwf1bp88aUtT6UGiJKVJcm7tIiEm5kbi9VG1KVSkt7zqhSoVgPJdzWRqOATY5J7OUqrKW0CnqQmGaDQ1UeefV4I0fcxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617219; c=relaxed/simple;
	bh=321yEr8YVsmjW3bML0bGo3Vdw9hbGBArRwRU7u8cNo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tE5H+5z7aLZHZ2jVlbgOaXwiHjFRbCu5NlvtmsCy47DrdbgdNVqv/31VRVoSmg9w87h2gIONFavsCAvHxtjG3jLK28i+BVuvefH/cd9cLl8QMAlB97c0Eyt6IoW5xMy1EBRVwSVPRWyE1qWOQlJqdqCqpzYNxSaUIJvkm7r9BXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PLzJYIml; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Dvm+kvJHyY1KKCJtfQp8EPX7C/3KH3OKeCdRxBCMWeY=; t=1767617217;
	x=1768049217; b=PLzJYImlfCTEI7mQXQ7prJGSMDoN8oXs1p+C9EDUvpXeMC3VmPdent9PtEwwZ
	MQ75cDikmkQ2l0V1ykYP67PlQQ8/P7h694uhBfPPwF3RXz2rnr/zE3vLa7xhrWnaatNbSaXJs7CHc
	ysdF8WU6f9694OvVFm7Rj9WmhR/Kz/gi2dpQHTL2lvc8CMw1+0PzNg56wrnTLVi8EWg1J3EMMRTE9
	CrDLSA5l1i+k7j10w+kny5yplPt7x/BazTGVygX1N2xIucT5RuGXfwqdj7X1Ob2Z9kbMC5MnFM1+c
	hHGPxQB8S3/Z+uRQcbVTde3pKwfXvpozoYWH6lLyElxZOHC6Vw==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vcjjg-001TXb-2m;
	Mon, 05 Jan 2026 13:31:00 +0100
Message-ID: <6498cffd-5bf9-490a-910d-f64ab9b7f330@leemhuis.info>
Date: Mon, 5 Jan 2026 13:30:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression 5.10.y] Libvirt can no longer delete macvtap devices
 after backport of a6cec0bcd342 ("net: rtnetlink: add bulk delete support
 flag") to 5.10.y series (Debian 11)
To: Ben Hutchings <benh@debian.org>,
 Roland Schwarzkopf <rschwarzkopf@mathematik.uni-marburg.de>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>,
 debian-kernel@lists.debian.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev, 1124549@bugs.debian.org
References: <0b06eb09-b1a9-41f9-8655-67397be72b22@mathematik.uni-marburg.de>
 <aUMEVm1vb7bdhlcK@eldamar.lan>
 <e8bcfe99-5522-4430-9826-ed013f529403@mathematik.uni-marburg.de>
 <176608738558.457059.16166844651150713799@eldamar.lan>
 <d4b4a22e-c0cb-4e1f-8125-11e7a4f44562@leemhuis.info>
 <27c249d80c346a258cfbf32f1d131ad4fe64e77c.camel@debian.org>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <27c249d80c346a258cfbf32f1d131ad4fe64e77c.camel@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1767617217;2151dd91;
X-HE-SMSGID: 1vcjjg-001TXb-2m

@stable team and/or @net maintainers: this imho needs a judgement call
from your side. See below for details.

On 1/2/26 21:18, Ben Hutchings wrote:
> On Fri, 2025-12-19 at 10:19 +0100, Thorsten Leemhuis wrote:
>> On 12/18/25 20:50, Salvatore Bonaccorso wrote:
>>>
>>> Is there soemthing missing?
>>>
>>> Roland I think it would be helpful if you can test as well more recent
>>> stable series versions to confirm if the issue is present there as
>>> well or not, which might indicate a 5.10.y specific backporting
>>> problem.
>>
>> FWIW, it (as usual) would be very important to know if this happens with
>> mainline as well, as that determines if it's a general problem or a
>> backporting problem
> [...]
> 
> The bug is this:
> 
> - libvirtd wrongly used to use NLM_F_CREATE (0x400) and NLM_F_EXCL
>   (0x200) flags on an RTM_DELLINK operation.  These flags are only
>   semantically valid for NEW-type operations.
> 
> - rtnetlink is rather lax about checking the flags on operations, so
>   these unsupported flags had no effect.
> 
> - rtnetlink can now support NLM_F_BULK (0x200) on some DEL-type
>   operations.  If the flag is used but is not valid for the specific
>   operation then the operation now fails with EOPNOTSUPP.  Since
>   NLM_F_EXCL == NLM_F_BULK and RTM_DELLINK does not support bulk
>   operations, libvirtd now hits this error case.
> 
> I have not tested with mainline, but in principle the same issue should
> occur with any other kernel version that has commit a6cec0bcd342 "net:
> rtnetlink: add bulk delete support flag"

FWIW, merged for v5.19-rc1 and backported to v5.10.246 as 1550f3673972c5
End of October 2025 in parallel with 5b22f62724a0a0 ("net: rtnetlink:
fix module reference count leak issue in rtnetlink_rcv_msg") [v6.0-rc2],
which is a fix for the former.

> together with an older version of libvirt.
> 
> This was fixed in libvirt commit 1334002340b, which appears to have gone
> into version 7.1.0,

Could not find that commit when looking briefly, but that version was
released 2021-03-01.

> but Debian 11 "bullseye" has 7.0.0.
> 
> We can certainly fix the libvirt side of this in Debian, but this also
> sounds like a case where the kernel should work around known buggy user-
> space.  On the other hand, this has been upstream for over 3 years so
> maybe it doesn't make sense now.

Yeah, I tend to the latter as well (the @net maintainers can speak up if
the disagree). But we have one more middle-ground option here maybe the
@stable team could do: revert the backports of 1550f3673972c5 and
5b22f62724a0a0 from 5.10.y, unless they are strongly needed there.

> Please let me know whether I (or anyone) should try to implement a
> workaround for this in the kernel.

Ciao, Thorsten

