Return-Path: <stable+bounces-208429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8529AD23397
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 09:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866E530B2929
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511BF33A9E2;
	Thu, 15 Jan 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TU4h+vlQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vMkaPtQU"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1933BBA3
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466477; cv=none; b=J7UB8hitSlgVXFH51hM+i4GFZgrgE9VL7awWjNrEqtg69nt5ORWMpQ8s1N7D/KREelCNcLXLG8+D+qyfIGmKnodKG0XPhmC9mYB5JLMvpCKMpzEUxIqiuXfIttd5mvboPo4mTbQCh60SEIh61ALwEyz1kiq75c48VL2zdioIb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466477; c=relaxed/simple;
	bh=J0SbLREqMNKDFYEtW+tkfTBrhu7+xYowSOCpL+9z2rY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SBmzKORkh0RyH4JeWQ0jOkbl64+ZicQmExukMx/S6e+/SyKRUJxn4D16IV+KOOrJTPAdisd3pOC97uaoUK4wZOC30p9zIvhb+gYW1xJyTbajftNhp2Hu8YRGWnRWamwFSq9W/c+cXpyzOs5mtyTznhVRvgwmY70V9a1czNJ1WJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TU4h+vlQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vMkaPtQU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 58C681D0004B;
	Thu, 15 Jan 2026 03:41:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 15 Jan 2026 03:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768466474;
	 x=1768552874; bh=Es9584jVOWmHdOtPWBSXR7urpyR5LY1KU3rO353x8OE=; b=
	TU4h+vlQm9uYZEnk5bWz8tqOSdCkxC3MVjmZs27h1fmMUzQ5NYUW1uE+3myxkkTr
	4SwFC9MSedlUkGhS1kfKk63JO4aZSvQTLANKQov5arwUFcnlKHCcS/2dJpyYWeIT
	vywVMAlWprXTA2eES4dY5KGeI2JXP+DtnLfCOu45UE81cgPNcEzhTW6+11QthVt0
	oVu/vrQfYsXq9uYEbsDu7IHz2UyoeMrb0BGdIUqGBEondMRQk1gf2wdtmbUUob6O
	lf3D7qmzqvGc8oNVWbEyfnwKOAcGPaTzzUSdBIt/vjs+zLR0Kx9/biVwbQM2h3zc
	We+/zuZ6xs9JjpUnrtmNAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768466474; x=
	1768552874; bh=Es9584jVOWmHdOtPWBSXR7urpyR5LY1KU3rO353x8OE=; b=v
	MkaPtQUVTP9rMlQ0L/a4zHcLU5VmdDiKpOMF136bRxq7G70znSSd5AC0XhP/BlEb
	SHeUACSZqa0olnZPuHeGwpsjrqtun6KaqDDSH/XxZJTICd66XpfPce4Ojru9Xxah
	xAN5StGjRkn4UxJC6739sZCoSQFXMLLpZwhqNI0CBzT2urdQ9yvASkuYX7SU813f
	f/xllrxojuHRGOlv9rqrYpmxOsR+cskI5oUWiPMYie94wlx4a3KiaZVhnadn0sV/
	/tcmsCRVd1njq+y/KD1O+aTv/YmiBOnKyf/q2Lyama4VUZJTNK69eJv6XXUg4UeC
	1HXySBf66/VhAUqeQUnuw==
X-ME-Sender: <xms:KKhoafoDfU2kBhiRIlm41-t3eBzNx6RSKFllM0hKYUGAwyZR4iRzKg>
    <xme:KKhoaRwfRPHJaFSECZOEZn9fb7M9izojqSLChErsvYK6KcjHD7zK4c-RUpLLvZWl0
    felr1kPk3zmWUhwwk8hH9ogZbPWfp42NR-KIQsW5xqjDfHsKcL6nDg>
X-ME-Received: <xmr:KKhoabt0Xa2rGRbfHd16l6dDXY5N8NoKqtHRX2bRdshhbfXwIGrHNbjfQscOjYhffsCdqPIri3VotkbBFVYJ7Qwk9HXCwtnF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfhffuvfevfhgjtgfgsehtjeertddtvdejnecuhfhrohhmpedfuegrrhhr
    hicumfdrucfprghthhgrnhdfuceosggrrhhrhihnsehpohgsohigrdgtohhmqeenucggtf
    frrghtthgvrhhnpeduvdeuheevffetfeegteeuieelvddvjedvteffhfeiffehhfehiedv
    gedukeekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsrghrrhihnhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopegsvghnseguvggtrgguvghnthdrohhrghdruhhk
    pdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtgh
    esmhhirhgsshgurdguvgdprhgtphhtthhopeguvghllhgvrheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhhunhhjihgvrdgtrghosehinhhtvghlrdgtohhmpdhrtghpthhtoh
    epghhirghnlhhutggrrhgvnhiiihesvghurhgvkhdrihhtpdhrtghpthhtohepnhhovghl
    rghmrggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfigskhgvrhhnvghlsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:KKhoaS00eeBBOD2a-EOlKwht4obk8JcvxpeIwaPGCp4eapObK_zC3g>
    <xmx:KKhoabDG5xSlHSVg1xD36q9m8iNMdM7G-445msMfDARJgxFEZt0KRw>
    <xmx:KKhoaYBY31Jhd1rwy0DOFEy5mdtSJ1gLtLoLDMs1y1Dbh-7LayNfdg>
    <xmx:KKhoaUm5hSHaXmfY6Ki2rpEhA7t7N361V8K184w1W4zoyD9U8dxBdw>
    <xmx:KqhoaQTdYSkGbagGGRUtd9gG1vJel-tZ8oIkY2TqAY5JRf1EOgnCkwmn>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 03:41:11 -0500 (EST)
Message-ID: <64874115-dcc0-4f3d-9a82-2ad2abf86fbb@pobox.com>
Date: Thu, 15 Jan 2026 00:41:10 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: [5.10] regression: virtual consoles 2-12 unusable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Sasha Levin <sashal@kernel.org>,
 Thorsten Glaser <tg@mirbsd.de>, Helge Deller <deller@kernel.org>,
 Junjie Cao <junjie.cao@intel.com>, Gianluca Renzi <gianlucarenzi@eurek.it>,
 =?UTF-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>,
 William Burrow <wbkernel@gmail.com>, 1123750@bugs.debian.org,
 Salvatore Bonaccorso <carnil@debian.org>, stable <stable@vger.kernel.org>
References: <aUeSb_SicXsVpmHn@eldamar.lan>
 <176626831842.2137.9290349746475307418.reportbug@x61p.mirbsd.org>
 <Pine.BSM.4.64L.2512211617050.3154@herc.mirbsd.org>
 <aU68arLtS1_wZiMj@eldamar.lan>
 <176626831842.2137.9290349746475307418.reportbug@x61p.mirbsd.org>
 <CAN2UaigCW-BZTifuo-ADCw=uDq85A_KwOHcceyaXDnVo8OQZiQ@mail.gmail.com>
 <c5a27a57597c78553bf121d09a1b45ed86dc02a8.camel@decadent.org.uk>
 <2026010803-gem-puzzle-640d@gregkh>
Content-Language: en-US
In-Reply-To: <2026010803-gem-puzzle-640d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 5:23 AM, Greg Kroah-Hartman wrote:
> On Fri, Jan 02, 2026 at 05:26:22PM +0100, Ben Hutchings wrote:
>> Hello stable maintainers,
>>
>> Several Debian users reported a regression after updating to kernel
>> version 5.10.247.
>>
>> Commit f0982400648a ("fbdev: Add bounds checking in bit_putcs to fix
>> vmalloc-out-of-bounds"), a backport of upstream commit 3637d34b35b2,
>> depends on vc_data::vc_font.charcount being initialised correctly.
>>
>> However, before commit a1ac250a82a5 ("fbcon: Avoid using FNTCHARCNT()
>> and hard-coded built-in font charcount") in 5.11, this member was set
>> to 256 for VTs initially created with a built-in font and 0 for VTs
>> initially created with a user font.
>>
>> Since Debian normally sets a user font before creating VTs 2 and up,
>> those additional VTs became unusable.  VT 1 also doesn't work correctly
>> if the user font has > 256 characters, and the bounds check is
>> ineffective if it has < 256 characters.
>>
>> This can be fixed by backporting the following commits from 5.11:
>>
>> 7a089ec7d77f console: Delete unused con_font_copy() callback implementations
>> 259a252c1f4e console: Delete dummy con_font_set() and con_font_default() callback implementations
>> 4ee573086bd8 Fonts: Add charcount field to font_desc
>> 4497364e5f61 parisc/sticore: Avoid hard-coding built-in font charcount
>> a1ac250a82a5 fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcount
>>
>> These all apply without fuzz and builds cleanly for x86_64 and parisc64.
>>
>> I tested on x86_64 that:
>>
>> - VT 2 works again
>> - bit_putcs_aligned() is setting charcnt = 256
>> - After loading a font with 512 characters, bit_putcs_aligned() sets
>>    charcnt = 512 and is able to display characters at positions >= 256
> 
> All now queued up, thanks!
> 
> greg k-h

For what it's worth, now that the above commits are queued up for 
5.10.y: There are two more commits, which were previously applied to 
5.15.y, that now apply to 5.10.y without merge conflicts (also without 
fuzz, if you apply the 5.15.y versions of the patches):


a5a923038d70
fbdev: fbcon: Properly revert changes when vc_resize() failed
(previously applied to 5.15.64 and 5.19.6)

3c3bfb8586f8
fbdev: fbcon: release buffer when fbcon_do_set_font() failed
(previously applied to 5.15.86, 6.0.16, and 6.1.2)


After looking at these two commits, it seems to me that they are now 
applicable to 5.10.y, and I think they probably should be applied 
(unless I'm overlooking or missing something).

By the way, for the past few days I have been running 5.10.247 + the 
latest 5.10.y queue + a5a923038d70 + 3c3bfb8586f8 (updating as new 
patches have been added to the queue). It seems to be running fine, and 
the virtual consoles seem to be working fine; it's also what I'm running 
now as I write and send this email.

(To be clear, 5.10.247 + the 5.10.y queue, without the two additional 
commits, also fixes the original 5.10.247 virtual console regression for 
me. However, applying commits a5a923038d70 and 3c3bfb8586f8 on top of 
5.10.y doesn't appear to create any new regressions in my testing so far.)

-- 
-Barry K. Nathan  <barryn@pobox.com>

