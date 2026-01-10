Return-Path: <stable+bounces-207964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 453E8D0D648
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 14:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4BF9300F1A9
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108953382F6;
	Sat, 10 Jan 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3IWCuZh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497613385BC
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768051220; cv=none; b=aNS5K7w3XtTQGDnH84Cp0Hl4XFQ1X+CNcuG9sk1ytnIGpIk8sqGSzVwUEhPiVq9qOVlQmJ4WPQWTygeRqtV6F8wC+hT2iJBOYAV1HEKNMx7E5xlD34J+i+lg5S0Ay0ImtShLQMJtyaPaRX2PRTLhKIGBi6KTmv6aaKUcEYj84AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768051220; c=relaxed/simple;
	bh=mcWwAQmDQrBxrpitpaStI5w0TayFDLq0q7csjwNorjg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=g5PtHblJlUiECfIZc4LgSGJwaZsOJbL93gKXllvkcgj+1Z0aQTNGIZL7Vj7OvzCIcmUut5OLs7WI8qd4ArBio0sPW69aLWNwVeGwMD6TaX2dihHHJOvRZn76zoBb/m966Hil1Vlg3HTW5ZSvTL2iKAG9cbCsIFIBwJRlqt6s4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3IWCuZh; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2627269d5so567845385a.2
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 05:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768051218; x=1768656018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvmFtpYq3AhGNwfLF6kPdeLfesgtuyHszNnUMDnYmVI=;
        b=D3IWCuZhRINoG6MG2WCLTXLZHHEz3mHRJUlrnzzIQUEtpApPnvT6vvNAF/XxXNgSEl
         NKOcHYCkQHpXSOnTpeFBjpxJc8D2G/bNaFjqC1LvBbr3nm7JA9v8ML8FZsZy0rmDYIW7
         1c0WCnbZpNYFeRqP/9cF5+5+mr5ikycCH2J7O9j+wsmzZejtciJHpSCpJJ+cP/1YWA7c
         7fuRRcIZ5zQZ9r3C3XSE17LpNg8ElnKX+K3Tgi+nfRbEx+5TftlSDfUJwL+0z4T5RkVl
         g4KN3XFZeiGa8lsa9yK2KyWh6b1UfwLW8Zh0XYAdrwmykR1dq5p/fSUge5/vE2UWpwxg
         65Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768051218; x=1768656018;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvmFtpYq3AhGNwfLF6kPdeLfesgtuyHszNnUMDnYmVI=;
        b=RwJYrwMgaFCfplEQ7YMzze3Jxqvt7L9xzGKGNgVea2W8/Wgab4dbpCiBlnLpQjqXZz
         nzcfoAL9LWPoEnz88dQkluDpzVA4tbhvmNnFfqtMAJQRwZdF+UbZGx6DJwE2fMX8kmaX
         Pq9vtimjL26eg0B/h1CXfxYT4iI/f3E02uE0DXW7WUbtKcgi6M6v0/iOu6UJ7MxV2P0s
         7tmR+CT8FLRiWrMlzx+5gwwtXj6yzbV8cfR5oo9P+NI2AzQq3bT8sc1TXz5kKF51u13X
         fokAvdDU+Kbobts9zFJREZr3N5yH0IPXC/fOzfbZtH54kTENbJMXivZc82ALvOx01vWN
         QQkg==
X-Forwarded-Encrypted: i=1; AJvYcCWBAY8yIpik9vzLvm5MzxMo+oLzeR+GGaeHAryA8uVnP+BhWhb9gI0paXtDCD4vc3/9R1zGyQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJ9zTf25fmbWf/Frsm08LZTkXeYgFFDKgXKj0ecrdHJsSunFV
	Ix2+FUQ/0VmpTuRF2XKwV8IWuDq7nSObmBFnAzD63QJnoiN1tWJofjA=
X-Gm-Gg: AY/fxX49SR7PZyjSTPXpBDiyhxt/Nhnc0VQeIGWOPgGLDf+hsclkoq5JR0h1AECwkh+
	yB2rnfxYsYkiOQCeHvHMSlbDmeeTqGPOJGv7LVB+JFMEaG+IVTDbK4kNCMWHfExsFIsv/apppmx
	jD8jqaTUWiOgbwnQ2e07FwC3IsWRH53expDCydP9R3zWwYN2b7RMOPwMfuz/plNBLnfW565Bi8m
	DwduOvcVmk1e7etQFTW6/nKiTi36fx9pGPpj6sirvU1hWte2uPVHShzmUCVWzIX4DIgFqMzLFlz
	YCdZOPcpsUXDqzuYxPXMd8LOx6lGar8/adn1y9Cls/qUQcA3NEazUybooLoXYmGN+KzpGkmIhdl
	ySeZ0OT7KakT84SzFcoceOf/8o21J6CjJqvxEY/KJpxM8/RShWDujxku4WhBnv7Hh7dRwXBc7K8
	ceC5HsG3eCX5Sha36bR0okBulWenVFV/3Q80NKxmc=
X-Google-Smtp-Source: AGHT+IHYkrReK4yF4naTlaDor67swNTpLoEWAakzLr0Pf9Lu/+qdcpqgONPLVqMEeWigmof52e/WWw==
X-Received: by 2002:a05:620a:2910:b0:8a1:ac72:e3db with SMTP id af79cd13be357-8c389429138mr1637486585a.72.1768051218033;
        Sat, 10 Jan 2026 05:20:18 -0800 (PST)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51d06fsm1031114585a.32.2026.01.10.05.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 05:20:17 -0800 (PST)
Subject: Re: [PATCH v2] fbdev: bitblit: bound-check glyph index in bit_putcs*
To: Vitaly Chikunov <vt@altlinux.org>, Junjie Cao <junjie.cao@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Zsolt Kajtar <soci@c64.rulez.org>,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251020134701.84082-1-junjie.cao@intel.com>
 <aU23brU4lZqIkw4Z@altlinux.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <e6aac320-846d-eecf-0016-23b56d7cd854@gmail.com>
Date: Sat, 10 Jan 2026 08:20:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aU23brU4lZqIkw4Z@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Vitaly Chikunov wrote:
> Dear linux-fbdev, stable,
>
> On Mon, Oct 20, 2025 at 09:47:01PM +0800, Junjie Cao wrote:
>> bit_putcs_aligned()/unaligned() derived the glyph pointer from the
>> character value masked by 0xff/0x1ff, which may exceed the actual font's
>> glyph count and read past the end of the built-in font array.
>> Clamp the index to the actual glyph count before computing the address.
>>
>> This fixes a global out-of-bounds read reported by syzbot.
>>
>> Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
>> Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> This commit is applied to v5.10.247 and causes a regression: when
> switching VT with ctrl-alt-f2 the screen is blank or completely filled
> with angle characters, then new text is not appearing (or not visible).
>
> This commit is found with git bisect from v5.10.246 to v5.10.247:
>
>    0998a6cb232674408a03e8561dc15aa266b2f53b is the first bad commit
>    commit 0998a6cb232674408a03e8561dc15aa266b2f53b
>    Author:     Junjie Cao <junjie.cao@intel.com>
>    AuthorDate: 2025-10-20 21:47:01 +0800
>    Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>    CommitDate: 2025-12-07 06:08:07 +0900
>
>        fbdev: bitblit: bound-check glyph index in bit_putcs*
>
>        commit 18c4ef4e765a798b47980555ed665d78b71aeadf upstream.
>
>        bit_putcs_aligned()/unaligned() derived the glyph pointer from the
>        character value masked by 0xff/0x1ff, which may exceed the actual font's
>        glyph count and read past the end of the built-in font array.
>        Clamp the index to the actual glyph count before computing the address.
>
>        This fixes a global out-of-bounds read reported by syzbot.
>
>        Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>        Closes: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
>        Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>        Signed-off-by: Junjie Cao <junjie.cao@intel.com>
>        Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>        Signed-off-by: Helge Deller <deller@gmx.de>
>        Cc: stable@vger.kernel.org
>        Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>     drivers/video/fbdev/core/bitblit.c | 16 ++++++++++++----
>     1 file changed, 12 insertions(+), 4 deletions(-)
>
> The minimal reproducer in cli, after kernel is booted:
>
>    date >/dev/tty2; chvt 2
>
> and the date does not appear.
>
> Thanks,
>
> #regzbot introduced: 0998a6cb232674408a03e8561dc15aa266b2f53b
>
>> ---
>> v1: https://lore.kernel.org/linux-fbdev/5d237d1a-a528-4205-a4d8-71709134f1e1@suse.de/
>> v1 -> v2:
>>   - Fix indentation and add blank line after declarations with the .pl helper
>>   - No functional changes
>>
>>   drivers/video/fbdev/core/bitblit.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
>> index 9d2e59796c3e..085ffb44c51a 100644
>> --- a/drivers/video/fbdev/core/bitblit.c
>> +++ b/drivers/video/fbdev/core/bitblit.c
>> @@ -79,12 +79,16 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
>>   				     struct fb_image *image, u8 *buf, u8 *dst)
>>   {
>>   	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
>> +	unsigned int charcnt = vc->vc_font.charcount;
>>   	u32 idx = vc->vc_font.width >> 3;
>>   	u8 *src;
>>   
>>   	while (cnt--) {
>> -		src = vc->vc_font.data + (scr_readw(s++)&
>> -					  charmask)*cellsize;
>> +		u16 ch = scr_readw(s++) & charmask;
>> +
>> +		if (ch >= charcnt)
>> +			ch = 0;
>> +		src = vc->vc_font.data + (unsigned int)ch * cellsize;
>>   
>>   		if (attr) {
>>   			update_attr(buf, src, attr, vc);
>> @@ -112,14 +116,18 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
>>   				       u8 *dst)
>>   {
>>   	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
>> +	unsigned int charcnt = vc->vc_font.charcount;
>>   	u32 shift_low = 0, mod = vc->vc_font.width % 8;
>>   	u32 shift_high = 8;
>>   	u32 idx = vc->vc_font.width >> 3;
>>   	u8 *src;
>>   
>>   	while (cnt--) {
>> -		src = vc->vc_font.data + (scr_readw(s++)&
>> -					  charmask)*cellsize;
>> +		u16 ch = scr_readw(s++) & charmask;
>> +
>> +		if (ch >= charcnt)
>> +			ch = 0;
>> +		src = vc->vc_font.data + (unsigned int)ch * cellsize;
>>   
>>   		if (attr) {
>>   			update_attr(buf, src, attr, vc);
>> -- 
>> 2.48.1
>>
I have done the same bisecting work, too bad I did not notice Vitaly's 
work earlier :-(

There is a "cheap" workaround for systems before 5.11, (not addressing 
the root issue but) working:

diff --git a/drivers/video/fbdev/core/bitblit.c 
b/drivers/video/fbdev/core/bitblit.c
index 7c2fc9f..c5a1a9d 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -86,7 +86,7 @@ static inline void bit_putcs_aligned(struct vc_data 
*vc, struct fb_info *info,
      while (cnt--) {
          u16 ch = scr_readw(s++) & charmask;

-        if (ch >= charcnt)
+        if (charcnt && ch >= charcnt)
              ch = 0;
          src = vc->vc_font.data + (unsigned int)ch * cellsize;

@@ -125,7 +125,7 @@ static inline void bit_putcs_unaligned(struct 
vc_data *vc,
      while (cnt--) {
          u16 ch = scr_readw(s++) & charmask;

-        if (ch >= charcnt)
+        if (charcnt && ch >= charcnt)
              ch = 0;
          src = vc->vc_font.data + (unsigned int)ch * cellsize;

I will try next to go full backport from 5.11 as Thorsten has suggested.

However the bigger problem is that the fbdev patch has landed in the 
5.4.302 EOL, and essentially the 5.4 EOL kernel is now hanging broken :-(

Thanks, Woody


