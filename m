Return-Path: <stable+bounces-165805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B23B18FD9
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 21:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C19178AF7
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 19:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FB21E5018;
	Sat,  2 Aug 2025 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="SDQKIYOX"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677B1519AC;
	Sat,  2 Aug 2025 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754164504; cv=none; b=c7/kxaB8Ke1s4rtsJzeHgNLd/p1Ac37TKinhUwTgVxTAUL4gGhwnGQyXfHYuJxr1ebR6jLWGbKSg64lQFCmz3Gm5Cuva3EimE2nmfY/R51UZbC3fBs5NJGZHyxKGaPNRjEsSFXgWxg3OQFCdZMCR2ZvBxgioepeG2aYBHXZBAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754164504; c=relaxed/simple;
	bh=f5d+HWO2OeRGLSke24mcKm3wUP9VYb4zwT+vKIL3Amo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELnjWiLpcO9GE5HrxjU6eHdW2iTFtXbLfSno7odRNHQUI8DWo7Oxg1oIbc09WfLke4Zur/zFNHD+OpqiQpuxSPGmRaKTxwdPCP9dIMyo+EK4mha0p8pST5BR2PdvjPDH4zTSLsEGesmoCaCHxAwEof9EdtOk105lVEFAGLZfV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=SDQKIYOX; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754164499; x=1754769299; i=deller@gmx.de;
	bh=yJu5E1zGZI7Y/w7MAV0AO1mUdc53M3FE5WJ+VED0xgk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SDQKIYOXbf3ZXInJr/5YSST8QwStb/m6xekIN58XfaNvlBPoxISd/YvdA1VA30fa
	 fd2EmDU2qM0C3mjmf8ZrRVrol2mYgJU4p4SkvxDT54F/B0GDFcgCxCAcv3nexPdQF
	 FH8Sx6SNqWKLgbkFhdKxE3swLSHJ1HUD9pTUvzABJN9VbGGWYD6IB0e4WZh4CBKWU
	 e5Y9YHRsD9BrZ1guD8L5OylXg3ajZUC0xblIBek/iedBV1Fk9wPr5hCSjrorrw6jJ
	 YFoZfrUAQDfA4hSTaJvgf5zs4VQfsOLzjZBOXefk0kCB47JMpd2lUrs2QeLX79nDU
	 r0s1ob73cFKlqjrosQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.22]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1uNj6E0XLp-00vCwS; Sat, 02
 Aug 2025 21:54:59 +0200
Message-ID: <77748e07-8411-4ec1-98d3-496fe6ebda38@gmx.de>
Date: Sat, 2 Aug 2025 21:54:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Text mode VGA-console scrolling is broken in upstream & stable
 trees
To: Jari Ruusu <jariruusu@protonmail.com>, Jiri Slaby <jirislaby@kernel.org>
Cc: Yi Yang <yiyang13@huawei.com>, GONG Ruiqi <gongruiqi1@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <C4_ogGo3eSdgo3wcbkdIXQDoGk2CShDfiQEjnwmgLUvd1cVp5kKguDC4M7KlWO4Tg9Ny3joveq7vH9K_zpBGvIA8-UkU2ogSE1T9Y6782js=@protonmail.com>
 <a1d0172f-5f3c-4f3e-9362-d9de0192e8b2@kernel.org>
 <7_oOa5sZXTsEK5rGL7HpT4HfjvhfpGa8r69NDAZWuKTxWP1ONLD9yDbrfJ3nzfducuK8TpC-fF1llnfVjpGHzdmhdzDq7FvvoOYU9eEX9Uc=@protonmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <7_oOa5sZXTsEK5rGL7HpT4HfjvhfpGa8r69NDAZWuKTxWP1ONLD9yDbrfJ3nzfducuK8TpC-fF1llnfVjpGHzdmhdzDq7FvvoOYU9eEX9Uc=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7SxSEXlCZeVQOwNyAThQGNOFKlg3Qnf18iNBjQXwAaxQ0dH065b
 kiVGkDx/LhEvIqmjP6iATf11wXA3L+o781C68HH41qatlZ+jpgmdm+CWgT6f9sYVvaE4jiz
 yOg6P2FfG7dVl27ey3tMYGh3cYJwWGWbX/FvxTeM5PrW63xHahZ4uny/ZxUiGo5EmbJ2vrV
 StaKgdMwcQYeuA2uSKJCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pher/Ur7vSg=;RZD13K51h7sxO5wc1lofRWHkAln
 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
 fw==

On 7/31/25 18:12, Jari Ruusu wrote:
> On Thursday, July 31st, 2025 at 10:22, Jiri Slaby <jirislaby@kernel.org>=
 wrote:
>> At the time this was posted (privately and on security@), I commented:
>> =3D=3D=3D=3D=3D
>>   > --- a/drivers/video/console/vgacon.c
>>   > +++ b/drivers/video/console/vgacon.c
>>   > @@ -1168,7 +1168,7 @@ static bool vgacon_scroll(struct vc_data *c, =
unsigned int t, unsigned int b,
>>   >                                    c->vc_screenbuf_size - delta);
>>   >                       c->vc_origin =3D vga_vram_end - c->vc_screenb=
uf_size;
>>   >                       vga_rolled_over =3D 0;
>>   > -             } else
>>   > +             } else if (oldo - delta >=3D (unsigned long)c->vc_scr=
eenbuf)
>>   >                       c->vc_origin -=3D delta;
>>
>> IMO you should also add:
>>      else
>>        c->vc_origin =3D c->vc_screenbuf;
>>
>> Or clamp 'delta' beforehand and don't add the 'if'.
>> =3D=3D=3D=3D=3D
>> That did not happen, AFAICS. Care to test the above suggestion?
>=20
> My reading of the code in vgacon_scroll() is that it directly
> bit-bangs video-RAM and checks that scroll read/write accesses
> stay in range vga_vram_base...vga_vram_end-1.
>=20
> Checking that c->vc_origin end up being >=3D c->vc_screenbuf is
> wrong because in text mode it should be index to video-RAM.

Yes, correct.

 =20
> Quote from original "messed up" patch, fix for CVE-2025-38213:
>> By analyzing the vmcore, we found that vc->vc_origin was somehow placed
>> one line prior to vc->vc_screenbuf when vc was in KD_TEXT mode, and
>> further writings to /dev/vcs caused out-of-bounds reads (and writes
>> right after) in vcs_write_buf_noattr().
>>
>> Our further experiments show that in most cases, vc->vc_origin equals t=
o
>> vga_vram_base when the console is in KD_TEXT mode, and it's around
>> vc->vc_screenbuf for the KD_GRAPHICS mode. But via triggerring a
>> TIOCL_SETVESABLANK ioctl beforehand, we can make vc->vc_origin be aroun=
d
>> vc->vc_screenbuf while the console is in KD_TEXT mode, and then by
>> writing the special 'ESC M' control sequence to the tty certain times
>> (depends on the value of `vc->state.y - vc->vc_top`), we can eventually
>> move vc->vc_origin prior to vc->vc_screenbuf. Here's the PoC, tested on
>> QEMU:
>=20
> To me that sounds like the bug is in TIOCL_SETVESABLANK ioctl().
> It should not be changing c->vc_origin to point elsewhere
> other than video-RAM when the console is in text mode.

Yes, agreed.
 =20
> How about adding a check to begining of vgacon_scroll() that
> bails out early if c->vc_origin is not a valid index to video-RAM?

Possible, but that's more of a work-around.
It would be nice to find and fix the real problem.

I tried to reproduce the issue with the provided testcase from
the original patch, but so far I failed.

For now I've added a Revert of the original patch to the fbdev git tree,
so that VGA backward scrolling works again. This gives some time to
fix the KASAN report.

Helge

