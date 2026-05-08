Return-Path: <stable+bounces-244762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFTIGDnu/WlJkwAAu9opvQ
	(envelope-from <stable+bounces-244762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:07:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D14F790E
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52B28300C38A
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72763E0C79;
	Fri,  8 May 2026 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2AFC3lO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1563DDDA5
	for <stable@vger.kernel.org>; Fri,  8 May 2026 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249265; cv=pass; b=FGBsrwm40fdIypwLUyGNB6Hf8aqPMFOHRtk8rJeDIRzc+p1dxYNQgqW5MfXh1V7AgZ38jjBK06dZY37/EM9TaWbbEAoBvu2HsMAcwq3fjtIfwK4B7pTshqpusIzY77HFtNVWTrcE1EEGhwNaLUEAr18QbaG2DwKwZymK9C8m87o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249265; c=relaxed/simple;
	bh=ZjOFPz7e/LEHbjSFWttsKasNeVVUy9Ha7KJx81NGIeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuVwZ6uROOK51Dcz/Gyubejbs1eu5QRlcowNvuINPhqwRiEaPI1u26eOrMRVboq8XwJ6nj7AfTWgbfG6WN6g7P7WFTb8SWiuMhJan2QihdDe6rh4TpGMAw10iNllvaoILnr29f4gNi4oD1eKPFqV1zeVFpRV0R1eDHczk7HqWfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2AFC3lO; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b93698bb57aso369396466b.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 07:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778249262; cv=none;
        d=google.com; s=arc-20240605;
        b=Zi0U6uDo+oiaVi2i7u2AgOoL4e+k/I/GJ2MB5Ykh0p5YgDPQbmNtxHfCFgyUHtmZf2
         pv5XE9iof89eEA6DywBtmx4NRe1gYzLLYzi1Utn+fEuy45Z4zqPlRJmMdNcd29p+/Iac
         R+hU9CHtwt9p4UKDpFTVny9z75u1G4CrSHfV0ntwzR3NqVpVb57c7jpbNbQ1idKlAO7O
         Je0yjYdQSlHOvMfscquZnyImaYz2DB64S+hQ9DVFEtKkfzbK4Q+I+s3BOP+tvcJKdyay
         PhZE3dCpv0WOJCxnvLRNuXooWNBtCXOUX5hezfpgR9HL66XWkjkKT7MCMbzgUYGx5TY9
         xkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S2fSCdBTqGt7yz1Mwds2KMVp3ALUK2d0RpCAOcsH8SQ=;
        fh=5uaWbza8dw7WOAMOP1Y6ZIh/Dv5UzoVr2YlQY+3EWHE=;
        b=I1hi1t9zvIgIeDXzqvBxLXprs2m8WjDw4epF6XCkEmK1t0vOKCLT11sY2cJWQcjOtn
         /tNwQwUYg6QdgZxw0JWV4VCaT4/OJJuJ1rKq2h2b42FeTppGKh96YD/9J1dkgjLumRr9
         10HEDF7tR42AINj8GNNvZrY5d5JKzlQyi2kq3PLzoIWR34VSqMaOn+wIocegkY9D3P5u
         qoinZ+AciKeR5C8DSSi+6u3Ww7QH/IdK8raKk8ZGFWSfnryfg9DTRyvcCbKNp1hRwsuM
         78sxu9eiaGUZjjnrzqsmg96GnBIxh8Ekwr7zmTvJMVvL6Lki2It9tBPw/XeEBFTfxGa3
         GX3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778249262; x=1778854062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2fSCdBTqGt7yz1Mwds2KMVp3ALUK2d0RpCAOcsH8SQ=;
        b=S2AFC3lOH/yBWgbjA6VAFgD0eULkfW9glX1Ykm9J+/Xsv2/fu5TfCiurT6oBtcD03y
         OK5FLTkjO9fsQvfa5lGGun6nZrrszJ2wE91hKBYxsGb1jBjESnCE9np6K69YXCttH4TV
         OE+t/V+48j5z63RQXJH/RZ+BpI2Zw0d5C3TuCprK3F7OzTKBu26MlZ8HCfwZcBj/xG1E
         Ti/v5A5f9PawVe8okP1tAFB9M4+EmsOxvZ6SiWTklpmG8ZpoQp+UxUpqOGsdOGQ7WCk2
         YX7nhSEhiewtP0HRVOhGA/6ncng2DHKcfqYTxXyn00Rg3PPCMrL4BGRDdJ8jQIJ+Lb+n
         f0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778249262; x=1778854062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S2fSCdBTqGt7yz1Mwds2KMVp3ALUK2d0RpCAOcsH8SQ=;
        b=Gtznaby44huOaRzbJTom23gZ7SnnmF3A8PR25Nq3Vajp7h39IxQC/UFEJrZHbgVAgW
         11mSdiksdbkRGQ+Yh8Frxa5bvvj7LhH7tVPn5jh0VLbdrXIZSuC0FjD0pm6qCL+vXcdi
         iLMy8wh7XSPqkdGfZuOfSRbBHa3W0IvLngRsoF3AGu+sCbbobv5+CRDbwDKOGJtWN2RJ
         NS3RXKdlQJTNuyrpan39yDzXvfhS5GocfhMDWdkC0ZxYr4YhF3RgiZVBbLvKHydwjfZL
         tk1WUIhzN1pqYs0bAXt6FvR9S4yROaPVLHBifXpAY2xBwSnK5KJ9jB2d83QaMwZtlIgi
         4Isw==
X-Forwarded-Encrypted: i=1; AFNElJ/FjMmXe52qgh5OgswR0ZKZWoOXBfxA52Av+EK9c7b7u4ijUPPpVf2eaHD025cfSGy1p5osBSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpueB2WIazZ92DDUG1NbTVT9JaToI03kMuSX4Ok96Z2c0sde1k
	OgaURYwUexlfdx5DtgFoInkp/Wd1UQWnH8vNG6iTiW1vFMuuEqoWLaGTJhhf+cnO4AgJJ3aJeex
	VSE52KZY9nVFMaHch9VGuAmsEmy9vr6U=
X-Gm-Gg: Acq92OHJ9ULmjsWbagTTEtoj5v6uq5FHT25rZaOcmuWmqYXl4skeGLM72M/UW6LyjZ9
	/FlVIOaGVsh1SwpTvJuO0QlfT12ikgCSdB14rPZUnKumf6VaEVXnkomhBURPja+b5UCLd4m8dyM
	8n2H2E9mB75Uy86eO0Vk7xSrcn8sDI37NAI8WTv8z1/o2kV9pZcWnmeRfaJOKSuqlGFxmLAkQAQ
	vAGltmoQtD4rZJ5utp8ilHrMh4yHXNhaRx2y7dU0eT9E8WtNMsGzWMxhPLYR1zKsKqdNc6WYK/Y
	Nxoj0mylcAaKejd1
X-Received: by 2002:a17:906:ee84:b0:bc5:114c:956 with SMTP id
 a640c23a62f3a-bc84cc73483mr381449466b.1.1778249262182; Fri, 08 May 2026
 07:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026050835-appealing-stallion-a207@gregkh> <1b941a1353791ddd6fd75fb8e68b377367d689ff.camel@oracle.com>
 <2026050829-gladiator-displease-57af@gregkh> <CALUEkOdFEFJ_U1va62B=tWspd2YfLJ-qk72r380wrLRGYfYKPg@mail.gmail.com>
 <2026050855-valley-slashed-c382@gregkh>
In-Reply-To: <2026050855-valley-slashed-c382@gregkh>
From: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Date: Fri, 8 May 2026 16:07:31 +0200
X-Gm-Features: AVHnY4IVRjnMhpiZc7G5bh-tPB4zXyvsLEfUV_g34l8Ep0EOP0-NuDK-z_JRRUc
Message-ID: <CALUEkOfBS7qsN-7ERMS+2wcPEixXAGmquREu7uv8ecXn6d7haw@mail.gmail.com>
Subject: Re: Linux 5.15.205
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Dominik Grzegorzek <dominik.grzegorzek@oracle.com>, Ben Hutchings <benh@debian.org>, 
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "lwn@lwn.net" <lwn@lwn.net>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 535D14F790E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244762-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mpellizzerdev@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 3:50=E2=80=AFPM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 08, 2026 at 03:13:51PM +0200, Massimiliano Pellizzer wrote:
> > On Fri, May 8, 2026 at 2:44=E2=80=AFPM gregkh@linuxfoundation.org
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, May 08, 2026 at 12:05:02PM +0000, Dominik Grzegorzek wrote:
> > > > Hi,
> > > >
> > > > I may be mistaken, but I think there might be a small typo in this =
hunk in net/ipv4/ip_output.c:
> > > >
> > > > skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG;
> > > >
> > > > Would this need to be:
> > > >
> > > > skb_shinfo(skb)->flags |=3D SKBFL_SHARED_FRAG;
> > > >
> > > > My understanding is that SKBFL_SHARED_FRAG is a bit in skb_shared_i=
nfo->flags, and skb_has_shared_frag() checks skb_shinfo(skb)->flags.
> > >
> > > Adding Ben who did the 5.10 backport so he can comment on this.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> >
> > Hi,
> >
> > The new released kernel 5.15.205 is still vulnerable to CVE-2026-43284.
> >
> > ```
> > $ ./run.sh
> > =3D=3D=3D Stage 1 =E2=80=94 overwrite 'systemd-timesync' line (89 bytes=
) with
> > 'sick::0:0:<pad>:/:/bin/bash'
> > =3D=3D=3D Stage 2 =E2=80=94 verify
> > sick::0:0:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXX:/:/bin/bash
> > =3D=3D=3D Stage 3 =E2=80=94 su - sick (empty password via PAM nullok)
> > [i] state saved to /var/tmp/.cf2.state =E2=80=94 run './run.sh --clean'=
 to revert
> > # uname -r
> > 5.15.205
> > ```
> >
>
> Does the patch below fix this up?
>
> thanks,
>
> greg k-h
>
> ------------------
>
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 68509e1f89b5..5d8f8a5901bc 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1443,7 +1443,7 @@ ssize_t   ip_append_page(struct sock *sk, struct fl=
owi4 *fl4, struct page *page,
>                         goto error;
>                 }
>
> -               skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG;
> +               skb_shinfo(skb)->flags |=3D SKBFL_SHARED_FRAG;
>
>                 if (skb->ip_summed =3D=3D CHECKSUM_NONE) {
>                         __wsum csum;

Yes, this works.
Thanks

