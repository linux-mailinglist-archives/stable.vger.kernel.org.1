Return-Path: <stable+bounces-205055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 617C6CF7646
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 10:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07B9630C3145
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B74130AD10;
	Tue,  6 Jan 2026 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WteLVuoC"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F651E50E;
	Tue,  6 Jan 2026 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690256; cv=none; b=e3VblqC+q0K+z43/A6g4s17jfB7EVcRsk1yT1Uk7WkQPtVInvc3ZeiTPUNGtNq/s+gebtYhmbruh0nDaFwXysPPMCv9WLLomZ380iXYV5n+eM1BC+T40vWFk0e3btdMjjDQ53ZlfYoEn/2AA2P/el6/FC+RI8Ucxz435ao1R0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690256; c=relaxed/simple;
	bh=6QYI3zQJ0Tl2jVP8SQayMsYp7gq06LwHG0RQrX00PhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3onFboHDoR5P26H4oNIItrd1L2QARsISj8LShVRh7wwAyX6Vre3z4BgBeo7/fle7AZ8Goz9XWgiD9afFiszp8MLI2yXCt8xtNdY2GFG+RRuO+qLUjkW4Y/uZxgJhxnM98sQRZQkfhUpXygBGM6ZjFCfjm0vTVdHvr7c1DZHjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WteLVuoC; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=hZWhWS6u8qnxThFxrHymtByvkuCdMoLtOGR4+l86sSM=; t=1767690254;
	x=1768122254; b=WteLVuoCFa49xlGPGJNL0H6IFtIJ7IyhJj8FF2L1PVEiQYSL3CPXf7u/aIcLR
	3z75aY2ZRKk4R2XWLgXKSDP9FpljCGXh1jcx7g8NvVOLgT/xTp21KIoaXsUDob88O9NrdEwLCSJcM
	86xuvjXy7eQFt+TqKl2RxdnUXl4Jy5c7b1SaFnB2kNX8PiqifkjnlAP+YvdaL938azKgK0fWdVhKK
	MlZd9UA9nZIpjXCYtEQaTwQZLf9tvwjlifUYl52UbNTYuxWD92N9MUD7jTjSrMBa0clL5QvrqbiE7
	PQd4pwDir95eTZEXdb26maLe2l8dpK0AdENU72d/BLSGbf4tbg==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vd2z0-004AI7-0E;
	Tue, 06 Jan 2026 10:04:06 +0100
Message-ID: <785e9aa8-dbfa-4325-bbcd-0ab44a2feb46@leemhuis.info>
Date: Tue, 6 Jan 2026 10:04:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: bitblit: bound-check glyph index in bit_putcs*
To: "Barry K. Nathan" <barryn@pobox.com>, Vitaly Chikunov <vt@altlinux.org>,
 Junjie Cao <junjie.cao@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peilin Ye <yepeilin.cs@gmail.com>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Shigeru Yoshida <syoshida@redhat.com>,
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
 Zsolt Kajtar <soci@c64.rulez.org>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, Ben Hutchings <ben@decadent.org.uk>
References: <20251020134701.84082-1-junjie.cao@intel.com>
 <aU23brU4lZqIkw4Z@altlinux.org> <aU58SeZZPxScVPad@altlinux.org>
 <ccbbf777-cf4e-4c66-856e-282dd9d61970@pobox.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <ccbbf777-cf4e-4c66-856e-282dd9d61970@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1767690254;1b0531b9;
X-HE-SMSGID: 1vd2z0-004AI7-0E

[Top posting to make this easy processable]

TWIMC, Ben (now CCed) meanwhile reported the problem as well:

https://lore.kernel.org/all/c5a27a57597c78553bf121d09a1b45ed86dc02a8.camel@decadent.org.uk/

There he wrote
"""
This can be fixed by backporting the following commits from 5.11:

7a089ec7d77f console: Delete unused con_font_copy() callback implementations
259a252c1f4e console: Delete dummy con_font_set() and con_font_default()
callback implementations
4ee573086bd8 Fonts: Add charcount field to font_desc
4497364e5f61 parisc/sticore: Avoid hard-coding built-in font charcount
a1ac250a82a5 fbcon: Avoid using FNTCHARCNT() and hard-coded built-in
font charcount

These all apply without fuzz and builds cleanly for x86_64 and parisc64.
"""

Ciao, Thorsten

On 12/27/25 03:04, Barry K. Nathan wrote:
> On 12/26/25 4:21 AM, Vitaly Chikunov wrote:
>> Dear linux-fbdev, stable,
>>
>> On Fri, Dec 26, 2025 at 01:29:13AM +0300, Vitaly Chikunov wrote:
>>>
>>> On Mon, Oct 20, 2025 at 09:47:01PM +0800, Junjie Cao wrote:
>>>> bit_putcs_aligned()/unaligned() derived the glyph pointer from the
>>>> character value masked by 0xff/0x1ff, which may exceed the actual
>>>> font's
>>>> glyph count and read past the end of the built-in font array.
>>>> Clamp the index to the actual glyph count before computing the address.
>>>>
>>>> This fixes a global out-of-bounds read reported by syzbot.
>>>>
>>>> Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
>>>> Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>>>> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
>>>
>>> This commit is applied to v5.10.247 and causes a regression: when
>>> switching VT with ctrl-alt-f2 the screen is blank or completely filled
>>> with angle characters, then new text is not appearing (or not visible).
>>>
>>> This commit is found with git bisect from v5.10.246 to v5.10.247:
>>>
>>>    0998a6cb232674408a03e8561dc15aa266b2f53b is the first bad commit
>>>    commit 0998a6cb232674408a03e8561dc15aa266b2f53b
>>>    Author:     Junjie Cao <junjie.cao@intel.com>
>>>    AuthorDate: 2025-10-20 21:47:01 +0800
>>>    Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>    CommitDate: 2025-12-07 06:08:07 +0900
>>>
>>>        fbdev: bitblit: bound-check glyph index in bit_putcs*
>>>
>>>        commit 18c4ef4e765a798b47980555ed665d78b71aeadf upstream.
>>>
>>>        bit_putcs_aligned()/unaligned() derived the glyph pointer from
>>> the
>>>        character value masked by 0xff/0x1ff, which may exceed the
>>> actual font's
>>>        glyph count and read past the end of the built-in font array.
>>>        Clamp the index to the actual glyph count before computing the
>>> address.
>>>
>>>        This fixes a global out-of-bounds read reported by syzbot.
>>>
>>>        Reported-by:
>>> syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>>>        Closes: https://syzkaller.appspot.com/bug?
>>> extid=793cf822d213be1a74f2
>>>        Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>>>        Signed-off-by: Junjie Cao <junjie.cao@intel.com>
>>>        Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>        Signed-off-by: Helge Deller <deller@gmx.de>
>>>        Cc: stable@vger.kernel.org
>>>        Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>>     drivers/video/fbdev/core/bitblit.c | 16 ++++++++++++----
>>>     1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> The minimal reproducer in cli, after kernel is booted:
>>>
>>>    date >/dev/tty2; chvt 2
>>>
>>> and the date does not appear.
>>>
>>> Thanks,
>>>
>>> #regzbot introduced: 0998a6cb232674408a03e8561dc15aa266b2f53b
>>>
>>>> ---
>>>> v1: https://lore.kernel.org/linux-fbdev/5d237d1a-a528-4205-
>>>> a4d8-71709134f1e1@suse.de/
>>>> v1 -> v2:
>>>>   - Fix indentation and add blank line after declarations with
>>>> the .pl helper
>>>>   - No functional changes
>>>>
>>>>   drivers/video/fbdev/core/bitblit.c | 16 ++++++++++++----
>>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/
>>>> fbdev/core/bitblit.c
>>>> index 9d2e59796c3e..085ffb44c51a 100644
>>>> --- a/drivers/video/fbdev/core/bitblit.c
>>>> +++ b/drivers/video/fbdev/core/bitblit.c
>>>> @@ -79,12 +79,16 @@ static inline void bit_putcs_aligned(struct
>>>> vc_data *vc, struct fb_info *info,
>>>>                        struct fb_image *image, u8 *buf, u8 *dst)
>>>>   {
>>>>       u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
>>>> +    unsigned int charcnt = vc->vc_font.charcount;
>>
>> Perhaps, vc->vc_font.charcount (which is relied upon in the following
>> comparison) is not always set correctly in v5.10.247. At least two
>> commits that set vc_font.charcount are missing from v5.10.247:
>>
>>    a1ac250a82a5 ("fbcon: Avoid using FNTCHARCNT() and hard-coded
>> built-in font charcount")
>>    a5a923038d70 ("fbdev: fbcon: Properly revert changes when
>> vc_resize() failed")
>>
>> Thanks,
> 
> I was just about to report this.
> 
> I found two ways to fix this bug. One is to revert this patch; the other
> is to apply the following 3 patches, which are already present in 5.11
> and later:
> 
> 7a089ec7d77fe7d50f6bb7b178fa25eec9fd822b
>     console: Delete unused con_font_copy() callback implementations
> 
> 4ee573086bd88ff3060dda07873bf755d332e9ba
>     Fonts: Add charcount field to font_desc
> 
> a1ac250a82a5e97db71f14101ff7468291a6aaef
>     fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font
>     charcount
> 
> (Oh, by the way, this same regression also affects 5.4.302, and the same
> 3 patches fix the regression on 5.4 as well, once you manually fix merge
> conflicts. Maybe it would be better to backport other additional commits
> instead of fixing the merge conflicts manually, but since 5.4 is now EOL
> I didn't dig that deep.)
> 
> Once these 3 patches are applied, I wonder if a5a923038d70 now becomes
> necessary for 5.10.y. For what it's worth, it applies fine and the
> resulting kernel seems to run OK in brief testing.
> 


