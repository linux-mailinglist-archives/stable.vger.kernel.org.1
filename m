Return-Path: <stable+bounces-200972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6FCBBD59
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F5E3009559
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1D92DC32C;
	Sun, 14 Dec 2025 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLQRt1KN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EE2459FD
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765728859; cv=none; b=cMeM+QUrRTptqXDfX5ydJZBlPgOUz2oWTR4HSBafdJhTP1qiqzeK+M2LM4ZpH8/yJfjIB6qrgK0SgFWnnMD3gluzykxRtx3Tms9BF+EKj+DWxi1YERBxYpGMf0RelzBXrdQB3JEjUO5ZVWw/751AvxOZef0Dz92XTkmPdTp6dlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765728859; c=relaxed/simple;
	bh=GRpIF/d8/1fyo2bgcDG2clg18PiLNuT5jKrducENkQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Suuh5CzPHBX1F8iYOizGCNOt1VpYyVaz0fj1FWhqf27NoW8FHRG4QoCPpYv8b+EK62YErg7QRmf/E6FddlyZ+lagqlDg9lX0W1hEDCHWWC5UzKh5eO18qU8vs1j3YAgJb9wH1ra8O+cdIRfTGNl28xhdQEmJOA9g0Ozij/CEPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLQRt1KN; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78c38149f9fso20916597b3.2
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765728856; x=1766333656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRpIF/d8/1fyo2bgcDG2clg18PiLNuT5jKrducENkQI=;
        b=gLQRt1KNvaeUO9teGz0leapvPXjIzdpg9TUX/uxhJtEzqFuqvgmn1f+cBLsR9oopBL
         P85Q4c7o7yA2Z85bHUfaJut6mx5EGdIgqyNABDc6CpUYrOMnlPxl0l8Rf2uM0VNTZ1DT
         ZypynXxALUxYnf5Qn210UVAC9kSqr63OIrQ6JffuCdQRSp9carH8Iw+VYhBqaZRkzWsS
         ijEADSRkYty8jxZNluxkWV37cPfVTyyzRztEGIJGKdJNsHHl/Vbv63CuEeFFE0Wt9nZE
         FqcMkyldI9raWSNBbWMb1inJsUbjeooiHwUclO7avA0BN5vIYETJI+e4r46WXtIk3MKV
         97wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765728856; x=1766333656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GRpIF/d8/1fyo2bgcDG2clg18PiLNuT5jKrducENkQI=;
        b=CkRcuXUQeyieXnTSUez/zUQHnx4Zm8PUegrw21V1Tfs0Z5N1en3svcGIblSPJKQcGt
         T5j6O/xEXL3HcLsYpKX+cSrqChxJfPmi5OgPa5sJ4fQGUZBVhDpSwiovDoclTg8+EhOb
         sU2CgChC4KDhGnNWX7+fxN8/RFdDsKghfW9pjxYOOsBFLBja71uOU8CrwOtc91HKNn2O
         ygfbxj0PxaOxhvoLzzBYvZ0cHkeKqJ8Wq1mDEk7qv1dWxQ+OhPbB3VFi616vqg6KvNTi
         bBllSszCa4CR7D9omMcI4klfll5FS03wRzvd76HW8dta4ir2a2JLg7okRIb5xK2IUnFs
         Eq/g==
X-Forwarded-Encrypted: i=1; AJvYcCVdxUoMLHFBlz4FK3lGw1bnFpdhvLS6xZEjlaPQx5PW3YoNSNLS4GZNGrQ376Da6XxjkA+NXK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziSQ+CWoGPVoXJlJWveUGLAYa411z5RdfZdeIxPK8FBh2t3+SM
	Bb23paHC9aUL7n1FbTMEFZJ+dYKW2krwsf2yjwkxNeVFYuPq3UqhxF2g2ce2Ku1DBZW7bfqr5Um
	JuGI1fho8n+bp3DhkhMcCOLpLT5GT1sU=
X-Gm-Gg: AY/fxX5SR6voiAb0zFifWym0XMsE3gwfrvZ/hnOpygY0rCr1hV9QNFg2LqYSyQEc+Jf
	IqSCPK43rlhd938l3IIGHGk0LaisR10SX5OOqEfApYnJGeAT4PyO1+ERaNO9BhjnCeniDSCqoIX
	SIJhy0eyYnjtsQmtWqSnmE+Sh6oXk+9+FyhHqBs6/yewSmBvb9VcQxX/uJcdUMeDxhqHHkjZyvI
	SxxNReozMOTphVX/yyaywKYBTxa+vSAoUn3shAXYK6nVP1fSg6X6d4jCU3w1AduhLpCYg==
X-Google-Smtp-Source: AGHT+IHYP3T80/B8AfiG3uNoE6jS0f+vGFsH+W/e+KxgsbBRpSwjgogu0Rhw73C/8b1M9I+m+nUVxh3jqTRMteuSfU4=
X-Received: by 2002:a05:690c:4c08:b0:786:5789:57d1 with SMTP id
 00721157ae682-78e6841f484mr60894597b3.52.1765728856046; Sun, 14 Dec 2025
 08:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251214131204.4684-1-make24@iscas.ac.cn> <39ba16a9-9b7d-4c26-91b5-cf775a7f8169@gmail.com>
 <20251214161023.5qcyyifscu73b47u@skbuf>
In-Reply-To: <20251214161023.5qcyyifscu73b47u@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sun, 14 Dec 2025 17:14:04 +0100
X-Gm-Features: AQt7F2qFqUHDdXEIzkgvN0n3_WvlsoB3yN8yNhONS16laPmF4gsHsS86NfUQ6tM
Message-ID: <CAOiHx=kp-trJ6OVoC-Vc54=pquYa5wU5ZCSyLVkyNATbbadsVw@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: Fix error handling in dsa_port_parse_of
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ma Ke <make24@iscas.ac.cn>, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	tobias@waldekranz.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 5:10=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> Hi Jonas, Ma Ke,
>
> On Sun, Dec 14, 2025 at 05:02:33PM +0100, Jonas Gorski wrote:
> > Hi,
> >
> > On 12/14/25 14:12, Ma Ke wrote:
> > > When of_find_net_device_by_node() successfully acquires a reference t=
o
> >
> > Your subject is missing the () of dsa_port_parse_of()
> >
> > > a network device but the subsequent call to dsa_port_parse_cpu()
> > > fails, dsa_port_parse_of() returns without releasing the reference
> > > count on the network device.
> > >
> > > of_find_net_device_by_node() increments the reference count of the
> > > returned structure, which should be balanced with a corresponding
> > > put_device() when the reference is no longer needed.
> > >
> > > Found by code review.
> >
> > I agree with the reference not being properly released on failure,
> > but I don't think this fix is complete.
> >
> > I was trying to figure out where the put_device() would happen in
> > the success case (or on removal), and I failed to find it.
> >
> > Also if the (indirect) top caller of dsa_port_parse_of(),
> > dsa_switch_probe(), fails at a later place the reference won't be
> > released either.
> >
> > The only explicit put_device() that happens is in
> > dsa_dev_to_net_device(), which seems to convert a device
> > reference to a netdev reference via dev_hold().
> >
> > But the only caller of that, dsa_port_parse() immediately
> > calls dev_put() on it, essentially dropping all references, and
> > then continuing using it.
> >
> > dsa_switch_shutdown() talks about dropping references taken via
> > netdev_upper_dev_link(), but AFAICT this happens only after
> > dsa_port_parse{,_of}() setup the conduit, so it looks like there
> > could be a window without any reference held onto the conduit.
> >
> > So AFAICT the current state is:
> >
> > dsa_port_parse_of() keeps the device reference.
> > dsa_port_parse() drops the device reference, and shortly has a
> > dev_hold(), but it does not extend beyond the function.
> >
> > Therefore if my analysis is correct (which it may very well not
> > be), the correct fix(es) here could be:
> >
> > dsa_port_parse{,_of}() should keep a reference via e.g. dev_hold()
> > on success to the conduit.
> >
> > Or maybe they should unconditionally drop if *after* calling
> > dsa_port_parse_cpu(), and dsa_port_parse_cpu() should take one
> > when assigning dsa_port::conduit.
> >
> > Regardless, the end result should be that there is a reference on
> > the conduit stored in dsa_port::conduit.
> >
> > dsa_switch_release_ports() should drop the references, as this
> > seems to be called in all error paths of dsa_port_parse{,of} as
> > well by dsa_switch_remove().
> >
> > And maybe dsa_switch_shutdown() then also needs to drop the
> > reference? Though it may need to then retake the reference on
> > resume, and I don't know where that exactly should happen. Maybe
> > it should also lookup the conduit(s) again to be correct.
> >
> > But here I'm more doing educated guesses then actually knowing
> > what's correct.
> >
> > The alternative/quick "fix" would be to just drop the
> > reference unconditionally, which would align the behaviour
> > to that of dsa_port_parse(). Not sure if it should mirror the
> > dev_hold() / dev_put() spiel as well.
> >
> > Not that I think this would be the correct behaviour though.
> >
> > Sorry for the lengthy review/train of thought.
> >
> > Best regards,
> > Jonas
>
> Thank you for your thoughts on this topic. Indeed there is a problem,
> for which I managed to find a few hours today to investigate. I was
> going to just submit a patch directly and refer Ma Ke to it directly,
> but since you started looking into the situation as well, I just thought
> I'd reply "please standby". It's currently undergoing testing.

A patch already, that's even better! I'll gladly stand by :)

Best regards,
Jonas

