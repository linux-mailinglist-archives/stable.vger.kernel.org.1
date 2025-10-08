Return-Path: <stable+bounces-183593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79253BC3F1F
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 10:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2D719E33EF
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F82F49FC;
	Wed,  8 Oct 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7m4j1ko"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4903B2F361E
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913580; cv=none; b=cPk8N2UXVpAv1HNPW+xP1LOTSmBZCjVdbIU4+n9oHo6zolMWrpuYIrym0kOp0SHEURPAjbxghUvKuTP+1wmjnogLBCIZaCzbMcZIkyX/mBUAYlKH0K13HJiFJGNSaLAJ6bHFuY2CKFqfgOTgiengW0Yc6n6D3HE3HTfJmoqJclE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913580; c=relaxed/simple;
	bh=AYlPlEYnalDPu3mU+G9COpLgD9gYXaXXBqfIzZI0NhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjUBWidnpHZ3oZYHpyzHidIspfH/F7sLHLZTteAEg0xEYT/JP58Q5k+wCHxqHb4sRnaCEuvMynVWd64MQm67aOR7NuvCoeoj/hkTG0sQhV3VMy93NQtkT5n/F+BKdzfw3gX9t+b4SlTnEGac+oVbhN5T31fyOU6IsllJ64d1ddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7m4j1ko; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-271d1305ad7so113095205ad.2
        for <stable@vger.kernel.org>; Wed, 08 Oct 2025 01:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759913578; x=1760518378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JRe+Ysw3ed28Q5I6fD0FZJYvYHKIT6y/Zbw+MVV2NU=;
        b=X7m4j1ko+GpgLoWu+E+qXVENFgOVjCRRloSPKiko6o29gjI+idBHM/4+NvTbmMKc4S
         wrFJXQH9CUiYZvRRlTyolb+oCtzCgDKGB7S+9C9WLiAbT7D7eaebtGfECTSV1MPosw/x
         2eMtxarrphPZdU7R3Dc8+laGMb1KIcYliI6dprrV3QeP6GBrCSieQPFgBL0oqTGwI/ub
         7FciQBAG9qJf8ldOY8p4XfO+AvwUmE5IF39m+qW+D8/xnES9N6x5udqZu//0b/iF1p9k
         8ryrlxJ0kRVxGRokOTkH+zjIO8cedVeApFs6zGM4eGB3Pwjj6tWILyMMEbR3DKCNd9mD
         ZT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913578; x=1760518378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JRe+Ysw3ed28Q5I6fD0FZJYvYHKIT6y/Zbw+MVV2NU=;
        b=oUBOUSpqvskLrlJEC0YECulrCsewVVsggDxbyqB2RMqoS4rchD37BG9OWY2S7bDGJp
         E7c7iqZOYVnmOwlDlJLoCNSO2hctS93U2r1CX7lBkFY1aXotmF/Nlcb/Ljd994RAt6NG
         Ey8uJXIU5aRYL3z0JBGNutbggPO4lZyBxe+przhqKhyArpIFDMF17UsHEut08WUu+ckf
         YhDXVdBUs0pgEdU13LNB1iSvY9l0Scb0JRYBP2sBBR59etdY3KXQjmWfZlUhh9ryB/zh
         j/kUCHWJEeH/irF88lo+zQbbKDn69s1/v4lQX36owlG79K8+hX/aZJfvPp5CbJhv6kja
         Lu8A==
X-Forwarded-Encrypted: i=1; AJvYcCXqifq8gyMedUrIgJr87+WVIruamU+kUn6v4NH/NOutvUHOxMQCDAunsBOT6U3IHN1Ym2U6IIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4OFHS+kCRPqsBhiWF/4b/RCgicpJ7Lh0Tbodj8GhzmD9/ozJV
	H/R3x5LwCIYOI1OGAjHaPK69o7E2sy6sSntAJAgGR3OTp8/+G+rYlCQokG1IOmcNUDllvbZVQA5
	iMiVefO7SwIbTMCCXGHcFA3tUPtwRa7k=
X-Gm-Gg: ASbGncuoP2zms82PJ/rdurc89sBu7jpb7Wd1TcOcQEs1pz9S5I43wepm7uDEy1JYYJE
	s56QwsfXLfO/7JDnp62WQgh3KnqhETuo9V7oMZ9Z2QZETstUm+/v3GDBYyBOKFZ2PzlJyqxO6eq
	LZOREGPSOF69NvKGNzmdlR8S4WNH/F0N/tToZ4uKv7mRux2XWTb/rK57ieys0qqewC3qPxKVn1u
	eEQTq6i3BKsRxdqCRhhelWtXv32E9ePFmaEEEbZis9O
X-Google-Smtp-Source: AGHT+IFKCMDzVKeMBL64zSYDRpRFM0H2rB7wq31qh9YFT8+du8n/p0Y5R8iH/2zbH4uxiGTK7bY6Wyb/b/TqjnRgSmI=
X-Received: by 2002:a17:902:f607:b0:25c:7434:1c03 with SMTP id
 d9443c01a7336-290273568e4mr34433325ad.10.1759913578515; Wed, 08 Oct 2025
 01:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006114507.371788-1-aha310510@gmail.com> <CAKYAXd8pyEBm6cOBLQ_yKaoeb2QDkofprMK1Hq1c_r_pumRnxQ@mail.gmail.com>
In-Reply-To: <CAKYAXd8pyEBm6cOBLQ_yKaoeb2QDkofprMK1Hq1c_r_pumRnxQ@mail.gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 8 Oct 2025 17:52:47 +0900
X-Gm-Features: AS18NWC61Zud4JgwiWJjoS2O6q9aZLnXpBR98-miFbKRgAfyGTqcKi4hwMhR8L4
Message-ID: <CAO9qdTHx-EYBeo1mfgVzcwQT5M6iwtVsBZTjAEVQugcfTsVtjA@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, viro@zeniv.linux.org.uk, 
	pali@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae,

Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> On Mon, Oct 6, 2025 at 8:45=E2=80=AFPM Jeongjun Park <aha310510@gmail.com=
> wrote:
> >
> Hi Jeongjun,
> > After the loop that converts characters to ucs2 ends, the variable i
> > may be greater than or equal to len. However, when checking whether the
> > last byte of p_cstring is NULL, the variable i is used as is, resulting
> > in an out-of-bounds read if i >=3D len.
> >
> > Therefore, to prevent this, we need to modify the function to check
> > whether i is less than len, and if i is greater than or equal to len,
> > to check p_cstring[len - 1] byte.
> I think we need to pass FSLABEL_MAX - 1 to exfat_nls_to_utf16, not FSLABE=
L_MAX.
> Can you check it and update the patch?

If the only reason to change len to FSLABEL_MAX - 1 is to prevent
out-of-bounds, this isn't a very appropriate solution.

Because the return value of exfat_convert_char_to_ucs2() can be greater
than 1, even if len is set to FSLABEL_MAX - 1, i may still be FSLABEL_MAX
when the loop ends. Therefore, checking the last byte of p_cstring with
the min() function is essential to ensure out-of-bounds prevention.

> Thanks.
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
> >                 unilen++;
> >         }
> >
> > -       if (p_cstring[i] !=3D '\0')
> > +       if (p_cstring[min(i, len - 1)] !=3D '\0')
> >                 lossy |=3D NLS_NAME_OVERLEN;
> >
> >         *uniname =3D '\0';
> > --

Regards,
Jeongjun Park

