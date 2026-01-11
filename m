Return-Path: <stable+bounces-207995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E8D0E148
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 06:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44921300A6E9
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5C221D00A;
	Sun, 11 Jan 2026 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtJ7Gpat"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264D217F31
	for <stable@vger.kernel.org>; Sun, 11 Jan 2026 05:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768109200; cv=none; b=qO8FyMOoboBgWR2qk7ZEmI/H+Ml5WLG/t3o8+rLBi8PdCSfA3ZmSo7cokzTBXcdVJHHJCSTMGRc/n/tKc1h+lxYxL2HpI5ocaMVa0sGnllxwrQhMnfZJSnIT5UJyPOefHm2hyqFZam0ZbUWCPybCqs2DRPKX3p0ZMqMMTDaiJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768109200; c=relaxed/simple;
	bh=eFp1JbwB6pwBFZFxmQ+ff8Ym07+vJLHCcyuxrD/iTFo=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OT0C6VAEFBvJLeTpGSF8lCAuh7AVKc9fh99JedNalGi0F58x6ehORG68Q9EdqqdSuKyC165YXFL3L3AIlCCtbFJcTagdRfhIsH0mfyacOIKQHtv4na1+PHtlSvDdtAVaq5FL/oFGEeOb8Sao4bVXZdXfTirlreAzn3isKKwChWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtJ7Gpat; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4eda6c385c0so42248991cf.3
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 21:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768109198; x=1768713998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:references:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnrpYrRIYSXlW2YfNWkieSaYgDrKbTtuKGx2OJu0pTM=;
        b=XtJ7GpatoPTh5rOZG+s4ARRquNzJAAiRmfbwqzNSM1mIn1CiLeKj2yRoKTwnwfmCaT
         T8IOTK67QU6HCzb86kF9N8tgFkP2rhhJyX63SrqfIm2dFTdEPPnuZGGOfWlLecovfcQS
         /3ecOqvv1Jj8yxXGZjMM8gW8+AOjg3nW/jP5ycvkX2+v3PEDlRLMJ3ZMI1DO2sbHP2fk
         76ux2/Gr5QbPsgONbi173E4LAhVySA8lydL72/wBrz+tqmm/Vgc0+iOCe6MEwkDgrfYz
         xTshKOB58JyAo2oBd+CmK4btvRtRuh8rqfza3OItQGkWiobY7b/ElaF5/Y/cixHHe2br
         t/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768109198; x=1768713998;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:references:cc:to:from:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnrpYrRIYSXlW2YfNWkieSaYgDrKbTtuKGx2OJu0pTM=;
        b=jrYLYqBnh4rk9ryE9dluHGLW2sMnu9puGMZ51LbqDn326NPki3ef6VgYnZsV2hsswP
         typXPceQub1fXuX2o6TLI3REyDV5DIe/VwBJ3073rCd8NskD9RSEmLMW4UkutA9KbkuE
         Vp4Kebk7OilTF5lVRwSIOXsaIYvcvAZwnaulVhE2+QivV+HMLBwkiRBMqJKB3k5cH5bX
         PiTEz7FDsmUbHyA8LxmPQgBW+uZiFHnHcFtTq+5dpRxVXRtoI4FfEDRuM8+71NNKFgzK
         tPofvwnDIqQawmVaBLr2SuvYEXPVTEINmlq3HHRdlxlHX6LREmWn1MmlbYM44KraQfN6
         Phzg==
X-Forwarded-Encrypted: i=1; AJvYcCWHi6zDJtzqGRlXhTVRl+BddDIS/l0Z65l/MSn6ZFS4O6j5Hw6LPNsrsAogJwUL1WdoDgT2wk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/Vb+5kWJXSmzq6X903n2ttXZ/MNs2iy/TNvLNeJEtKEMpBuG
	61dYLjYCC4vUohgcVs/zyDNhLM5nazWBuG2ZIDlI+kfQzgFe12qvEU4O6+w8
X-Gm-Gg: AY/fxX7vFw/3H9Eg2KUOt4BPAf2UG+zfbDrlQjaR2o3NjerkO8vctZ8n61vtS9lhzeD
	nSdr5yAVPzuUBOq0sW5pIbNqvfs1oWVIYcYSkHNrLCfNhS5CH25Z2I639ABOkKAC3tlKPnvzsUL
	Xktv+gKVPhGMlKgQL4kpU0Bi/9hu9MHHxCzts5I2q2Vn2KyTL5TAlU/Lu7BS72wxiZGECGbnZmk
	dCpHIGAcIRxsy4f3prVjrXi7AZ8B23nILS7N2UBuJJILetcLQFnCwqu1mBFW4WfRVaFPhSNueol
	9lXAN0HhCGjzHPXF/yyZqcYRxVcQDtdEhsYL3sjggS9oThvBjuhPQIQ3Sak73i8f1wNZ34MApMS
	M+M/54cFIU9PQkDSYfjiMGRR6AyX9ekbe9KF9U6Qfbc9viHNhQ7c8SPQwAhYXIqcIW68AAbrdIl
	7i70bwhIHqtZnfmJxfPxBG5o4KKU+v4d/MXM0tlUg=
X-Google-Smtp-Source: AGHT+IHQl6yFzxp8o7DLX3rtK4HUBNR2DuuHigCF0nkzFaedMhsnKWOHtdCDrOaqoDZhFhU2TS5YvQ==
X-Received: by 2002:ac8:5f48:0:b0:4e7:2dac:95b7 with SMTP id d75a77b69052e-4ffb491045cmr213358841cf.37.1768109197681;
        Sat, 10 Jan 2026 21:26:37 -0800 (PST)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa926a9d9sm102307371cf.25.2026.01.10.21.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 21:26:37 -0800 (PST)
Subject: Re: [PATCH v2] fbdev: bitblit: bound-check glyph index in bit_putcs*
From: Woody Suwalski <terraluna977@gmail.com>
To: Vitaly Chikunov <vt@altlinux.org>, Junjie Cao <junjie.cao@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Zsolt Kajtar <soci@c64.rulez.org>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251020134701.84082-1-junjie.cao@intel.com>
 <aU23brU4lZqIkw4Z@altlinux.org>
 <e6aac320-846d-eecf-0016-23b56d7cd854@gmail.com>
Message-ID: <b3672ea8-ec45-b5d1-cb08-b83eb8697904@gmail.com>
Date: Sun, 11 Jan 2026 00:26:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e6aac320-846d-eecf-0016-23b56d7cd854@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Woody Suwalski wrote:
> Vitaly Chikunov wrote:
>> Dear linux-fbdev, stable,
>>
>> On Mon, Oct 20, 2025 at 09:47:01PM +0800, Junjie Cao wrote:
>>> bit_putcs_aligned()/unaligned() derived the glyph pointer from the
>>> character value masked by 0xff/0x1ff, which may exceed the actual 
>>> font's
>>> glyph count and read past the end of the built-in font array.
>>> Clamp the index to the actual glyph count before computing the address.
>>>
>>> This fixes a global out-of-bounds read reported by syzbot.
>>>
>>> Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
>>> Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>>> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
>> This commit is applied to v5.10.247 and causes a regression: when
>> switching VT with ctrl-alt-f2 the screen is blank or completely filled
>> with angle characters, then new text is not appearing (or not visible).
>>
>> This commit is found with git bisect from v5.10.246 to v5.10.247:
>>
>>    0998a6cb232674408a03e8561dc15aa266b2f53b is the first bad commit
>>    commit 0998a6cb232674408a03e8561dc15aa266b2f53b
>>    Author:     Junjie Cao <junjie.cao@intel.com>
>>    AuthorDate: 2025-10-20 21:47:01 +0800
>>    Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>    CommitDate: 2025-12-07 06:08:07 +0900
>>
>>        fbdev: bitblit: bound-check glyph index in bit_putcs*
>>
>>        commit 18c4ef4e765a798b47980555ed665d78b71aeadf upstream.
>>
>>        bit_putcs_aligned()/unaligned() derived the glyph pointer from 
>> the
>>        character value masked by 0xff/0x1ff, which may exceed the 
>> actual font's
>>        glyph count and read past the end of the built-in font array.
>>        Clamp the index to the actual glyph count before computing the 
>> address.
>>
>>        This fixes a global out-of-bounds read reported by syzbot.
>>
>>        Reported-by: 
>> syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>>        Closes: 
>> https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
>>        Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>>        Signed-off-by: Junjie Cao <junjie.cao@intel.com>
>>        Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>        Signed-off-by: Helge Deller <deller@gmx.de>
>>        Cc: stable@vger.kernel.org
>>        Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>>     drivers/video/fbdev/core/bitblit.c | 16 ++++++++++++----
>>     1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> The minimal reproducer in cli, after kernel is booted:
>>
>>    date >/dev/tty2; chvt 2
>>
>> and the date does not appear.
>>
>> Thanks,
>>
>> #regzbot introduced: 0998a6cb232674408a03e8561dc15aa266b2f53b
>>
>>> ---
>>> v1: 
>>> https://lore.kernel.org/linux-fbdev/5d237d1a-a528-4205-a4d8-71709134f1e1@suse.de/
>>> v1 -> v2:
>>>   - Fix indentation and add blank line after declarations with the 
>>> .pl helper
>>>   - No functional changes
>>>
>>>   drivers/video/fbdev/core/bitblit.c | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/core/bitblit.c 
>>> b/drivers/video/fbdev/core/bitblit.c
>>> index 9d2e59796c3e..085ffb44c51a 100644
>>> --- a/drivers/video/fbdev/core/bitblit.c
>>> +++ b/drivers/video/fbdev/core/bitblit.c
>>> @@ -79,12 +79,16 @@ static inline void bit_putcs_aligned(struct 
>>> vc_data *vc, struct fb_info *info,
>>>                        struct fb_image *image, u8 *buf, u8 *dst)
>>>   {
>>>       u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
>>> +    unsigned int charcnt = vc->vc_font.charcount;
>>>       u32 idx = vc->vc_font.width >> 3;
>>>       u8 *src;
>>>         while (cnt--) {
>>> -        src = vc->vc_font.data + (scr_readw(s++)&
>>> -                      charmask)*cellsize;
>>> +        u16 ch = scr_readw(s++) & charmask;
>>> +
>>> +        if (ch >= charcnt)
>>> +            ch = 0;
>>> +        src = vc->vc_font.data + (unsigned int)ch * cellsize;
>>>             if (attr) {
>>>               update_attr(buf, src, attr, vc);
>>> @@ -112,14 +116,18 @@ static inline void bit_putcs_unaligned(struct 
>>> vc_data *vc,
>>>                          u8 *dst)
>>>   {
>>>       u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
>>> +    unsigned int charcnt = vc->vc_font.charcount;
>>>       u32 shift_low = 0, mod = vc->vc_font.width % 8;
>>>       u32 shift_high = 8;
>>>       u32 idx = vc->vc_font.width >> 3;
>>>       u8 *src;
>>>         while (cnt--) {
>>> -        src = vc->vc_font.data + (scr_readw(s++)&
>>> -                      charmask)*cellsize;
>>> +        u16 ch = scr_readw(s++) & charmask;
>>> +
>>> +        if (ch >= charcnt)
>>> +            ch = 0;
>>> +        src = vc->vc_font.data + (unsigned int)ch * cellsize;
>>>             if (attr) {
>>>               update_attr(buf, src, attr, vc);
>>> -- 
>>> 2.48.1
>>>
> I have done the same bisecting work, too bad I did not notice Vitaly's 
> work earlier :-(
>
> There is a "cheap" workaround for systems before 5.11, (not addressing 
> the root issue but) working:
>
> diff --git a/drivers/video/fbdev/core/bitblit.c 
> b/drivers/video/fbdev/core/bitblit.c
> index 7c2fc9f..c5a1a9d 100644
> --- a/drivers/video/fbdev/core/bitblit.c
> +++ b/drivers/video/fbdev/core/bitblit.c
> @@ -86,7 +86,7 @@ static inline void bit_putcs_aligned(struct vc_data 
> *vc, struct fb_info *info,
>      while (cnt--) {
>          u16 ch = scr_readw(s++) & charmask;
>
> -        if (ch >= charcnt)
> +        if (charcnt && ch >= charcnt)
>              ch = 0;
>          src = vc->vc_font.data + (unsigned int)ch * cellsize;
>
> @@ -125,7 +125,7 @@ static inline void bit_putcs_unaligned(struct 
> vc_data *vc,
>      while (cnt--) {
>          u16 ch = scr_readw(s++) & charmask;
>
> -        if (ch >= charcnt)
> +        if (charcnt && ch >= charcnt)
>              ch = 0;
>          src = vc->vc_font.data + (unsigned int)ch * cellsize;
>
> I will try next to go full backport from 5.11 as Thorsten has suggested.
>
> However the bigger problem is that the fbdev patch has landed in the 
> 5.4.302 EOL, and essentially the 5.4 EOL kernel is now hanging broken :-(
>
> Thanks, Woody
>
I have tested the solution of backporting the series of patches from 
5.11, it seems to be working OK.
However for the soon-to-be-EOL 5.10 and already EOL'ed 5.4 I would 
suggest a simpler solution where we replace  most of the logic from 5.11 
with a hardcoded charcnt=256, if charcnt not set. This would take 
advantage of the bugfix from Junjie, and be a minimal change for the 
5.10 kernel (works on 5.4 as well)

--- a/drivers/video/fbdev/core/bitblit.c    2026-01-10 
16:28:37.438569812 -0500
+++ b/drivers/video/fbdev/core/bitblit.c    2026-01-10 
16:32:51.356236549 -0500
@@ -86,6 +86,8 @@ static inline void bit_putcs_aligned(str
      while (cnt--) {
          u16 ch = scr_readw(s++) & charmask;

+        if (charcnt == 0)
+            charcnt = 256;
          if (ch >= charcnt)
              ch = 0;
          src = vc->vc_font.data + (unsigned int)ch * cellsize;
@@ -125,6 +127,8 @@ static inline void bit_putcs_unaligned(s
      while (cnt--) {
          u16 ch = scr_readw(s++) & charmask;

+        if (charcnt == 0)
+            charcnt = 256;
          if (ch >= charcnt)
              ch = 0;
          src = vc->vc_font.data + (unsigned int)ch * cellsize;

Thanks, Woody



