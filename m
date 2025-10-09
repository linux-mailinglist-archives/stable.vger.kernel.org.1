Return-Path: <stable+bounces-183675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AFDBC82B6
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 11:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1567B348025
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8C92D63E2;
	Thu,  9 Oct 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2RB7pUD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077672D5944
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000740; cv=none; b=rrjw2q12IlJq3ShlX2J/gUuBTwybY4JwevuIQj5OOhEj67dd9uU+Xbt2oef13CMB0vqAjv8Kp/XKB3fVrF8P05w44Hj1LpwDmit16garK1lfGl2gL7SoKr49ezOW0DRl0LdEkuwkkYRjEevBOKkZZKBGMlZZ13f86nPm/299E9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000740; c=relaxed/simple;
	bh=VEKWxVUe/tnNvlLhoBnBBDaH0OhNaEJWHRAMuAoTH98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUzbGuTIDKLAEdwzy8eLKmWiV53w0/vxd9E0jsFQZHrxG4b5RqpKPFC1vrbz6g4KqOLhLEjbSbBbn0fA7YAJNg0C33puC8QCWxfSl1XuZs6E/Z2weafcSzEVhiXl4aDH0JQ4h34QK/Z+V+4ETYUDvA4gxoB1+Yg0ZLvS4O79GD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2RB7pUD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so440433a91.1
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 02:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760000737; x=1760605537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1TU7MfYzP9/dysH1d26eBKhbqRPLF+RftNgfSNIzQw=;
        b=L2RB7pUDn8k6GgbryTExOKml2C/KIRl2yJ1UGHoFawVLTI8BNT/x+EsSRQi3+s5JgN
         rDq2RYBwwtrWegNxjSiPdGxD5E84pJRlYQhXHjkP6ptHQECEuHNr/dwzAnSaYkfEMxr4
         iDYEhePxOjUA2C5B94Jg21Vos0/r6qphnl8t49MDM6XVF3a1Z27tG9+9UQ0pY2lFg4Fn
         L6EM/5Nr+WZN2cxogeJRICRI/y3v0QB1CpBJkheVbNiWv455Tz9MZQorADIkHqgStwuS
         0BZhV0k4KH7xoDxdUiSRIWY5FEMlqRPRvwSCDCx5DtSA5AheReiiw9UjrTMj3pidYwBN
         BOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000737; x=1760605537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1TU7MfYzP9/dysH1d26eBKhbqRPLF+RftNgfSNIzQw=;
        b=KeeySDcH6jJ3BgO4tNNZFvCHLP5YOk7KDD32+7APQecLjH+CK1+reSbqkDY5Iy80R7
         u8Zbt0Ni1cpUfGIwe4/e8/dmZAcg8DkOw6WJyZ2n4mrOKP70n/aUO5BMn5SzhaHY9bKZ
         LJYQcfCQDwwfzEUetwx9AjgOnyPWEUVCZzltiUEyOCeylMoirgB8HmAy9+cPJ1yuhAuk
         6Yyid9NBKcV668zQxqf5NbAkxwqvHNhov9dc9GPJNzNEf8JiBeBidbSiGU2T8hd7fzT+
         tN/FQtv6lgI71SgoD2PaoszbW95GF26Osc8JOyCkEkDmquKhUJ4JiFV6ePNE0AnaNeUR
         8TSA==
X-Forwarded-Encrypted: i=1; AJvYcCWFy9mg4PpfDuIwwlmIHo/66oiiBT6G4ZFJ2zgEASV1nYnQgzhEKDAZcRvvuDpQZjzMGQ57IsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaPPVH3GLqtsFgM+3hAYyXYd0pfZId1EusVjuZ2F7VwPJjzLS
	NQrnurDY3maSjDkGzpMoJZcSgeB2UjmLO/Ook5fxJXUOE9LM1+UXj3uQkzZcHPh7KyMpCCxFLx9
	sfgdRNxhgRFkb8C8zkCoKe9tyJtzIqqc=
X-Gm-Gg: ASbGnctbvbon/wTg/v2IapiwOoa4GDU/i8oD9qTroFznSP+GNSgDw7FwtX30tQJwQQi
	/Ut4nDS5bmGtbBD1JlirvjWBICi516Bwyx+FCVNyiH4i8aB2ee2ZlJsJIQNQ9e8/34HRR9E0tX8
	slfN2O3oKfBi37f9Lnh1UwmZkUPGsAwITWCGbB8y7sNcsa5BwZ4RtYY2ualP2d/EqmMOymrux8Q
	XE7ODFyaBt9nveqA0OZr3UFJczyEsGlnyi2AAjlQ+4l
X-Google-Smtp-Source: AGHT+IH2GX8bEk4r+hR0p6Q8BVGAccvpb8Z43LxRJ+PRTrW6XFN+OBi7YUZTF1aXK8kHV5VFN+DBONnEIiVmO5qoAbs=
X-Received: by 2002:a17:90b:3c09:b0:31f:ecf:36f with SMTP id
 98e67ed59e1d1-339eda48b06mr15014058a91.1.1760000737140; Thu, 09 Oct 2025
 02:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006114507.371788-1-aha310510@gmail.com> <20251008173935.4skifawm57zqpsai@pali>
In-Reply-To: <20251008173935.4skifawm57zqpsai@pali>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 9 Oct 2025 18:05:26 +0900
X-Gm-Features: AS18NWCMN2fHRdD8EN6xDD1OrTWxPjBo90ZkWO_xScRehILrRLDTEGSKJK0VrA4
Message-ID: <CAO9qdTFk94yDCMAuTkx5yW9VXYExWuhgpi0X15C5F7e5DQgibA@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pali

Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello!
>
> On Monday 06 October 2025 20:45:07 Jeongjun Park wrote:
> > After the loop that converts characters to ucs2 ends, the variable i
> > may be greater than or equal to len.
>
> It is really possible to have "i" greater than len? Because I do not see
> from the code how such thing could happen.
>
> I see only a case when i is equal to len (which is also overflow).
>
> My understanding:
> while-loop condition ensures that i cannot be greater than len and i is
> increased by exfat_convert_char_to_ucs2() function which has upper bound
> of "len-i". So value of i can be increased maximally by (len-i) which
> could lead to maximal value of i to be just "len".
>
> > However, when checking whether the
> > last byte of p_cstring is NULL, the variable i is used as is, resulting
> > in an out-of-bounds read if i >=3D len.
> >
> > Therefore, to prevent this, we need to modify the function to check
> > whether i is less than len, and if i is greater than or equal to len,
> > to check p_cstring[len - 1] byte.
> >
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D98cc76a76de46b3714d4
> > Fixes: 370e812b3ec1 ("exfat: add nls operations")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  fs/exfat/nls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> > index 8243d94ceaf4..a52f3494eb20 100644
> > --- a/fs/exfat/nls.c
> > +++ b/fs/exfat/nls.c
> > @@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb=
,
> >               unilen++;
> >       }
> >
> > -     if (p_cstring[i] !=3D '\0')
> > +     if (p_cstring[min(i, len - 1)] !=3D '\0')
>
> What about "if (i < len)" condition instead?
>
> The p_cstring is the nul term string and my understanding is that the
> "p_cstring[i] !=3D '\0'" is checking that i is at position of strlen()+1.
> So should not be "if (i < len)" the same check without need to
> dereference the p_cstring?
>

Thank you for the detailed explanation! I misunderstood.

In summary, since the variable i can never be greater than len, we don't
need to consider this case. Therefore, if i is less than len, we can
determine that an nls loss has occurred.

I think that under normal nls conditions, i should be equal to len
immediately after the while loop terminates, so changing the condition
here to "if (i !=3D len)" would be a better way to make this clear.

This way, we can check for an nls loss without dereferencing p_cstring,
and we can clearly indicate that i should be equal to len when the while
loop terminates. What do you think?

Regards,
Jeongjun Park

