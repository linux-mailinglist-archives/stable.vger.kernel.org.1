Return-Path: <stable+bounces-233336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6SAVK2iW0mlKZAcAu9opvQ
	(envelope-from <stable+bounces-233336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 19:05:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385439F1AE
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 19:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7CE430071EE
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE9F314B73;
	Sun,  5 Apr 2026 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rW0Ze3Dc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pysYr8aA"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC002D4816;
	Sun,  5 Apr 2026 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775408740; cv=none; b=Va4nQajlxdSQVTA7rCYv76Wukw63LERgSltbzFcbiaGqSR8HO+Nf65FNhM17pZLXyglmKHDB3PeTvHGJcHt0G3+/uYHu0glGaKg28r9lwBIABC8mCTg9Q8qzSkrfue/cqPrFBWFzwATRinkCsxCOTJw3cqrxoKHcJBgbralBFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775408740; c=relaxed/simple;
	bh=KUTDRpKXu1qzyR66Tdf+Xqwj7Eo+bHgf3KoNcyZVwSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMjeGr5hYGRVdej2WsLFgngpbJ9P469uQLsW3wj7iQllVwPXLLAC6GkJbhTx7cAfpoKMfbs5d60xQ2N7vUpHWZtebyeBtdosO5XE16alqmpmrv+KXizhu++ciiyLNgZ8w7sRkbOrabtbgVuV70Yao6kIvyrzFWzTzshMRVLkgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rW0Ze3Dc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pysYr8aA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 29E16EC0022;
	Sun,  5 Apr 2026 13:05:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 05 Apr 2026 13:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775408738;
	 x=1775495138; bh=DkFv7NiVxZ75fED9VjTy1smI+uxt/AWq4k6gjOkay3U=; b=
	rW0Ze3DcfD0fTuS+Ur0VoNgxXUcYOJiBqShGSjqzBoTPdss1MNp2u5sIyJLQSL4U
	i0FotyKK6IYjRA9r6ar6pCwmzTfyextI4GIDF5Nie2pL4DGXvSJTY4Ssz7xRqoLK
	TiAsgquRsxUMIBN9VwFh+lPqx7sJbmlJTrDUvABpIMhxpGWs2zH/veCjBYdnJYWe
	9BGAdJe31ZozzEmN5+kGdFQ39phJVB6WU7GrlxrgbFm/ZaxVMpQWnGCcNWUyKXUl
	KxcEkcZTQoho7AlpWW7Zz6GqvdAPlU8K/Cj9CcL22zGdQayc5karBVJ6ChzJ9qLY
	R38tF9JoekvgndIGY9sShQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775408738; x=
	1775495138; bh=DkFv7NiVxZ75fED9VjTy1smI+uxt/AWq4k6gjOkay3U=; b=p
	ysYr8aAaMjAccDOqoISy0KokqN+zvxNUT9bXuh7UDGOflmuMck3Y3+3H52mJbxPv
	EIapXVk4rmDGUC/TcUgqpQyLLd1aYY6wgUT/c7cAIgo6S74md3qht9Npq2Q8xACR
	a9JUeyZGbeMmjzxtL2ei46Ckl9rKE13b2mhW8k9BlDJf5yctoJaqQX3bqWLBELXz
	OA7FwbwNvYzrB4cHMNKcczfhymJMSm0hbAk/kawx/jJVkmKyyfe/5FFMdTzkL49U
	5Si2q761EYoISrXaKfS2WlLTjMsQBYwdNO+cLJGKLsAk7OFZzaK1V8JONGMDrjlw
	FVFeMkMPaWl/542VqewPQ==
X-ME-Sender: <xms:YZbSadfqhWWzsJqiJ4OiArd6qHotzMAHBN9buY3ndSfp8GZHqlk9bQ>
    <xme:YZbSadcrBHpPafCM9wsQ5mgJ1cy6EWyHIYX0ZROwTqbbF3NR5FR3eCAewwAU3STfn
    rZBNb6zjkgpBNs8uVtvS9k_2NUOMG1tv9dmYX0mTkqZBW7BM16FLYE>
X-ME-Received: <xmr:YZbSaYywoXogAL_CR2Vjv3wMduzrPjr8WAZi6TfKbS7dC-DWLd5O4Y2zOx_MY-5HM7Pv52aCgPfyzDOfuzBsJ9coKQs11inJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepfdeurghrrhih
    ucfmrdcupfgrthhhrghnfdcuoegsrghrrhihnhesphhosghogidrtghomheqnecuggftrf
    grthhtvghrnhepheejvddufeehheeglefffedtueegvddvhfduueffheeviefgveeihfel
    hfeluedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpd
    igrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsggrrhhrhihnsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehtohhmrghsiieskhhrrghmkhhofidrshhkihdp
    rhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrrg
    hunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YZbSac9hNTMy04tZM2ed7_OP7lY-jZcy9pG-0gCvXCf8s914K6qKaQ>
    <xmx:YZbSaYhzI7iAimSKgTD9VcluTqs-hPCb_H9BsZ325nQAZV8Vh3qIZg>
    <xmx:YZbSabHAkQSsvSt_oQjzYpS_avzztCHo3HXSa2-iP4KmJlnx9M7zOw>
    <xmx:YZbSaf9sNHrq6zbxV0c_34WtOGrt8L-3HlTowJ2Qzss9VCDHjy0Leg>
    <xmx:YpbSaZcfb56S96tGzKgdWUu7zLGuuTuHM58YpWc4pghCxZdCJLpflpTv>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Apr 2026 13:05:36 -0400 (EDT)
Message-ID: <7ab3b184-8d9f-465d-b678-4def48cc2a9f@pobox.com>
Date: Sun, 5 Apr 2026 10:05:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y v2 0/2] Fix `fremovexattr` missing `fdput`
To: Tomasz Kramkowski <tomasz@kramkow.ski>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20260405114505.568530-1-tomasz@kramkow.ski>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260405114505.568530-1-tomasz@kramkow.ski>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-233336-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9385439F1AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/5/26 04:45, Tomasz Kramkowski wrote:
> As discussed, a v2 which includes the revert from the previous version
> [0] and a new attempt at backporiting the upstream change which doesn't
> cause the regression introduced in the first attempt[1].
> 
> In total, this fixes the missing `fdput` in the `fremovexattr`
> `copy_from_user` error path that the backport was intended for.
> 
> I tested both the error case and the happy case in qemu.
> 
> [0]: https://lore.kernel.org/stable/20260404112219.389495-1-tomasz@kramkow.ski/
> [1]: https://lore.kernel.org/stable/tencent_72B5370E2D4C4AC319ED4F0DCB479CA4B406@qq.com/
> 
> Al Viro (1):
>    xattr: switch to CLASS(fd)
> 
> Tomasz Kramkowski (1):
>    Revert "xattr: switch to CLASS(fd)"
> 
>   fs/xattr.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 

I tested the following two (groups of) proof-of-concept exploits
against 6.6.130, 6.6.132, and 6.6.132 + this patch series:


1. "CVE-2024-14027 - SlopSploit" proof-of-concept exploit for the bug
fixed by the original mainline commit. This only works on i386 kernels,
so I tested with i386 kernels on amd64 hardware.

https://github.com/lcfr-eth/CVE-2024-14027_slop

(I used exploit.c. For me, the exploit never reached its intended goal
of allowing a normal user to read /etc/shadow, but as far as I can tell
it still causes a parade of oopses on vulnerable i386 kernels but no
oopses on invulnerable i386 kernels. So it's still a good test of whether
this patch series works.)


2. Brad Spengler's proof-of-concept exploits for the 6.6.132 regression,
posted on Twitter (I tested on i386 and amd64 kernels, on amd64 hardware):

https://x.com/spendergrsec/status/2040049852793450561

(Note that one of these has a missing parameter, but it's easy enough
to fix.)


Test results:
6.6.130: #1 causes oopses (but not #2)
6.6.132: #2 causes oopses (but not #1)
6.6.132 + this patch series: Neither #1 nor #2 cause oopses

So, at least in my testing, this patch series successfully fixes both
the old and new bugs (both CVE-2024-14027 and the 6.6.132 regression).

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

