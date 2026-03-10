Return-Path: <stable+bounces-223736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Il/A1F1r2msZgIAu9opvQ
	(envelope-from <stable+bounces-223736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 02:35:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEF7243AA0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 02:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D05223070177
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 01:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752332C08AD;
	Tue, 10 Mar 2026 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kQiUTM4M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="khkW2XJM"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1279175A80
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106492; cv=none; b=DymIzauUIYXt8Tu7esXcMZUGu1xBgG+ncE2+g6bQeb1x9egoRDPf5QajTAdCOC9n2vHD9cAY5nkjA6INrg7btrHaSRAWvqnG4GX+UaCE7IC3+MJextc3EdS4a44ZNual6n5ki2znttcpv1iaKcUdr6doUbXiYwp/+It9bU+EyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106492; c=relaxed/simple;
	bh=npLr/+KtBIdVdX/FaQZtZI78AShY0HcYxKy9/wd1mSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggl00pG5yM/SDzEGYTkygmj2UJ2dy9TR4RR5NKgzsMzZ+ULD0/N2B/qOVO+qhsJt7AtN7+HRHE6qXm7l9MiqQTMYgjeDMK9a6jLXVWkyOuqzFOOw0prLREliRMDLj4dVfVGn1RA7K31iCXjS8a+71ppkY7bpy9nn6e+MDVsZThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kQiUTM4M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=khkW2XJM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D51B414000CE;
	Mon,  9 Mar 2026 21:34:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 09 Mar 2026 21:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773106489;
	 x=1773192889; bh=5Hr2YI+6++4i3Wyr4iJ0RdVsOlRFX1rtepCQTXchtlk=; b=
	kQiUTM4MZtVpSMqSRWsNFmIJ5D36xoj0TxDZN9mxTygAF/RSJhn84v6cdpslGbEH
	91ykQVv2n9eulRAGAZhu2kOdKLALEWIJG+kr60Sgnzh6VK5He78tz8L/bnaOha00
	C8Ud5qv36WckIWC0QNEzN7eiB4QbIqyyzhmn4JK3F8HwrXMdv3uoJpCN4XuqQjsD
	NRMLMXmX47Om1G6NER95G/RIpyrs1U03nEEoJmh1oB7fJiFhS0qavGlYT1eAC7r3
	qaNmyEbYRGFVHxsVIj1mmHs9G+ofHG9OqZa/RNuXqYD01JkEnXe6UkOkD1pTtVrv
	UON4YRWF/Xxlj1hO2fzfyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773106489; x=
	1773192889; bh=5Hr2YI+6++4i3Wyr4iJ0RdVsOlRFX1rtepCQTXchtlk=; b=k
	hkW2XJMvVNHWLDjX2V57zwX63UxhzqfstSjyLwsMcxSxGkD+NIu2FzfPdV9uej93
	TUKV1ScHHbua+Z6i/t6xMkpVELljGFAUrgA4Hh/aZ/SIXS/waLbfhNZTpVuVTM41
	g/fo6VkfqnzsvPnGqOAh61iZ2f4mu8A7ive3tIyzNMT0YHXg8vr8SyzJkdAQKVmU
	lcCxaFp1ioYZcHMDvWPUDcKB3OV6jDQlzYj3iIjPxIK3G0MklBXnv4LhzOL6TQI2
	Yw1XedzVvZZhTwHbaF1A7SRSt4U1X48lKaMk6s5AMOviedTqg4aRtlJLjGb4oQof
	YMvqbEuZkJ10kjSIUimjw==
X-ME-Sender: <xms:OXWvaeEzn5Pw_p8_2Kfj3PEUEEJKpoyqnYItSqTIkX5jyJfpfbuojw>
    <xme:OXWvaWX9_zd2c_D0IIyc7r15r3YR05o8qxinjJE4xUH5XiP6aV688-nFQZzT-8JxQ
    WC8gllSEaWr_aw3ShllXM1qrxkx9fatTYHJgS4yarCv-ktG_ieMZsM>
X-ME-Received: <xmr:OXWvadKvrXJ1xTgr9o-TgDwWDk2tRRO94ZirHz31v2F5hifK_ZY3DVMUmCa-au3wrjMVH9slgW3uOJ-wYCalZeIMcR-P4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeljeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpedfuegrrhhr
    hicumfdrucfprghthhgrnhdfuceosggrrhhrhihnsehpohgsohigrdgtohhmqeenucggtf
    frrghtthgvrhhnpeefleehkeehleekjeelffefhfdvleejteehledtieduffevteffleet
    gefgfefhjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggrrhhrhihnsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehs
    thgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghshhgrlh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighes
    phgvnhhguhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:OXWvaW-WouoGSO1eWYapynX5UDzbUxxjccXUqIGKJc6urAsoAaHqnA>
    <xmx:OXWvaQL99pe6y9UTZePvQrIpBVivTjiiT8e1yIovKiO-8f1G8uWbow>
    <xmx:OXWvabnT5-ODNlUPWndyuiksV3lV8MPnImvPnG3ZLz2teLx_dgb-cw>
    <xmx:OXWvaUNvZHYUXxnrPbDj0PynI5WFdFulri9eYknmN9hpm71uh49T4A>
    <xmx:OXWvaRcYVC39GBsDnr-UMz-p4uCMZw3OxGjMAFbipTwasJftGbid6VBX>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 21:34:48 -0400 (EDT)
Message-ID: <037126c3-d398-42aa-9883-e9eb74a0ad20@pobox.com>
Date: Mon, 9 Mar 2026 18:34:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [5.10.y] "driver core: platform: use bus_type functions" causes
 freeze on shutdown
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <f20634ac-f5e3-4b0e-a91c-d557d0f1aa39@pobox.com>
 <2026030930-iphone-pony-e8ef@gregkh>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <2026030930-iphone-pony-e8ef@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0BEF7243AA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-223736-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/9/26 07:43, Greg Kroah-Hartman wrote:
> On Mon, Mar 09, 2026 at 07:03:33AM -0700, Barry K. Nathan wrote:
>> To be very clear, I want to emphasize up front that this is regarding
>> the *current 5.10.y queue*, and not any 5.10.y release. This does not
>> affect any currently released 5.10.y kernel.
>>
>> When I apply the current 5.10.y queue on top of 5.10.252, the result
>> is a kernel that consistently freezes on shutdown, both when running
>> directly on my Lenovo ThinkPad T14 Gen 1 (Debian 12 bookworm running on
>> an Intel Core i5-10310U) and when running in a virt-manager VM (I didn't
>> put much thought into it and just happened to pick a Debian 13 trixie VM
>> for my testing).
>>
>> (Just once in my testing, there was a visible kernel panic, but there
>> was also screen corruption, and it looks to me like it might've frozen
>> up partway through the panic being printed on the screen, so I'm not
>> sure how useful it would be. I did take a photo so I guess I could
>> post it up somewhere if it might be useful, or maybe I'll try to type
>> it in from the photo later today or tomorrow.)
>>
>> I bisected manually, and it turned out to be this patch:
>> "driver core: platform: use bus_type functions"
>> (driver-core-platform-use-bus_type-functions.patch)
> 
> That patch has been dropped from the queue earlier this morning, so all
> should be fine.
> 
> thanks,
> 
> greg k-h

$ git pull
Already up to date.
$ fgrep bus_type queue-5.10/series
driver-core-platform-use-bus_type-functions.patch

It doesn't look like the patch has been dropped yet from the
5.10.y queue in the stable-queue git repo on kernel.org.

(At least as of this writing, around 6:30 PM PDT, you can go to
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.10
and see that the patch is still there.)


By the way, if dropping this patch turns out not to be the correct course
of action, I think backporting one additional patch will fix it.

I applied the following patch directly from mainline to test it; it
applied with an offset but no fuzz. I did some brief testing and it
seems to fix the problem (no more freezing on shutdown).

mainline commit 46e85af0cc53f35584e00bb5db7db6893d0e16e5
driver core: platform: don't oops in platform_shutdown() on unbound devices

-- 
-Barry K. Nathan  <barryn@pobox.com>

