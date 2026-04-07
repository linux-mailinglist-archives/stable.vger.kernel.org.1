Return-Path: <stable+bounces-233692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKpHD9w31WmP2wcAu9opvQ
	(envelope-from <stable+bounces-233692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:59:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D51533B223A
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DC04301DA7B
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489763CCFAB;
	Tue,  7 Apr 2026 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUQYB/jY"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3273CFF69
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581143; cv=pass; b=FXT5MF9zYQ0vEugnc0tMPZmsuXsfflVODNLW1vaHLX6z2R2Hup2SS3+9W2VjjqkzDarcyRUnxtZ/HvcwsdbHlvQXzWpT1WFHCuK/9CU1VZtt6hr/XQO7ORwe8cK2UqtrpHjR24QAUjHSao4wS5CHDIcgqv9+zKXKtVThYvrQAug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581143; c=relaxed/simple;
	bh=tPpgFwDwEPR9VZlW4uVSoXwllNxxfcqOh1vOHIRPAF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkhHzUQUPCjssWKdfvuBheDsu6tW8VIcJxcr636UPnZcOFtDkA2cD4JrnlDTqcMnxGxO1HkpruKw3TOiusDwpvgsKclSRKAy/mJzjY+DYg1SbgU2OfSlQNYO6bvuUTa1F/uxZsDuJcZnLY7Izx2MFG9shJoMd9UJ5tau9WDjzos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUQYB/jY; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-604f1bfecf1so3568481137.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 09:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775581140; cv=none;
        d=google.com; s=arc-20240605;
        b=cKGQfiX5uZQ7NSmNRKsQ86xvE5IMvWaiLfguuaBxxpOa6ENEzGTjSqTAhv9pwf4pqp
         16hDo2ocUwZcNECnunEqJk2VNa1Aw4ZCiVwIAboXDdJwtOxR1AnFMLST+qZNv+ZRKlfe
         J496NsECnKy/yeli/+u7WQ+m8k7e2s9vfLtFgnHcCmta4hqvzBhYVxXcfeDlaD35i2UO
         IV5Ldo0mRUJD0VOnm17JOlVvm9XILwp+u2jM2uzHq9HpWq5nmUwGHvRC3fowUhfe9RdR
         ziM5jUQhUQQY0ZI9XC5Ok2Lr6p3cdoywKUUrvjmZUMo5VYQEaOaF3xT33b3QTtDAPdjM
         u2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zpGhqXfBdulE4mZnpZhuVgVxc6xmIgwZa9dFw+bhogo=;
        fh=k5ESaS7zevuWQh8y0dx+z9Tf5MWHDB8KZGMOppujHN0=;
        b=RO3CucfpeasCzlrS7w6wI+mO6Ua3JjlaDQC4SR6p34+DyPzCki5zq2ShlVILZjxdbx
         X316Qi/qpnQP5Wqf+EXVNyKcO4M7P1zhS+8i9N6eqC26roTe64bZLvCVhoTIVhZFDZoT
         ViIST7r/mj7PMfNtCEwhPPEG1eA1KQegEbyY8CMAqwkf7xEAVWxskzd530HeG4CPMHrO
         y+vVj7c0fvF7xckgmm/1SFjuGy4zwHR4iWekn0tVfxdc5vbbNqqtSLMv4cSed4bktzj9
         advwH8JAn0UlYhPNkeZ7FBXcJbKCwZ27C3zX+LWVGsTnUvZFQUO0POD3vfNRfmcF/OOc
         RRMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775581140; x=1776185940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpGhqXfBdulE4mZnpZhuVgVxc6xmIgwZa9dFw+bhogo=;
        b=ZUQYB/jYO+OzI12WDPzJUFt7jJZs6qMQTkwzA+RPqfM11NbDygfAUqROqnSywqfNDm
         4OY5hgvXM56v3upWt1bTnOHQDc5vfKmY3Mj2YyceA8LFjAl3KoLSUlTXFw7NAfU7E+pK
         4cGxMip4oz/qoRRAfDnlxwNnH4dzAwV6iI/7v+3PNy3k4W+DAomuZM0geZQiO8HknsVt
         +mGCtLg278P6jBB9TAS1+hs0r6Qq6i99cV9YP+TdTzzvfsKrRhjZ+E7HVyUE3t+zDAeM
         nmMyRZHjOnPyxBS4kuNpyHjSliEL8mYsFQ1yB/o7K06tSfZWTk0DLiAAyHuO6zvIoBGb
         qfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775581140; x=1776185940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zpGhqXfBdulE4mZnpZhuVgVxc6xmIgwZa9dFw+bhogo=;
        b=sB551Z7hH3+++lrVZ1Of+g9V0mdPZbvPQDHbiKI+xqfqn+feZgVlgihq9ab38xTb0+
         ZR0lXCBw6Pddykw0/lfJ4ZEzg3EQNBvG7XFC6IrKthqj7K2U7zqo/lNw7TA3ch70XtZf
         YLH1GmzojG7k+UHt6RWGrOIIZ/nqGi3uvo3ldynRf7CUjcqo4BNBNFUhTztMeaTv3AU5
         +x+S5JXn/1IeO2qJ4cIFhvwx+oHL1djgCZTG7ggNbLWFY7cKDT8aTUvSd1JwqR4B3p0I
         MAh6lUyOhMmjxg3djWY23PmRrIMhgoUqcpasDr5epl2BwGvE5hUS9ETBPvGjf9DiFtb/
         q4KA==
X-Forwarded-Encrypted: i=1; AJvYcCV3o1hLp+0vPOnI+7M2xOJCcLiB8tOug+2+n1R9Ul6eWX8HXUsCR1C/QR97wUpxMNFFPj6yXsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdD9pfrYlZtpIyXh1AtWtw5p7szPEdDmBhR4MDVm3qtF0XBof
	KwTmF5eZKORcfz1uJ+IEXeI9Rf1Jpp6dQqsRo+BsExfN5elnLa0krqn6qq7FWCy2S8DBagS7AXR
	V2EEDdfou7E3kxk1JasngeJ+G1OnZTrw=
X-Gm-Gg: AeBDiev7nOyU/acUG9bQNOeYj+fG1Y49nJiEZ6xl+SVWa+b+oniFcQ34t4SAFwwOmtq
	7UAsVw/U46IFqgqpEgrEfMk9GImd41wT9YzFOb9Y82gXbqYrprANeAhhRAlR/Q9XyflAI3lRm5e
	BHqLV187TIRJBzxmkN5svzSGfSnB0xUZOmh1l6ClcFuU1q71WpiZxqjmu/nY/8fJl4NzDeY8Ci5
	6lWkHYAgT6l7uNNFcJ5+RvFX9kbp3eOGm7CtrHGDIOhlebTF4U6Zi6D4BvZH+Jjs0J7jjS5jcKc
	C59NqKhAlGdFJ5ErabUMeOfZY6p0kLM7sZVR3qzz
X-Received: by 2002:a05:6102:c02:b0:605:109e:a3d0 with SMTP id
 ada2fe7eead31-605a502d07dmr7189157137.22.1775581140562; Tue, 07 Apr 2026
 09:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
 <20260406234739.29926-5-joshuaklinesmith@gmail.com> <d4622e31-4012-4c05-9288-529b0bb0aebd@candelatech.com>
 <CANs=ypgdgB_3stm5bCvO8RTat-sxs0N6SAaeYSQ-dyq43U-ZBg@mail.gmail.com> <ddc4ccfe-27e0-7558-9b5b-27b4c4fe54b3@candelatech.com>
In-Reply-To: <ddc4ccfe-27e0-7558-9b5b-27b4c4fe54b3@candelatech.com>
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
Date: Tue, 7 Apr 2026 12:58:48 -0400
X-Gm-Features: AQROBzAC6bOHKKfWVRG9wTIWvucUZxOT13jtei-vp-8U2bQyptgRLlZFzZ2L7Do
Message-ID: <CANs=ypgceH4NL5xOr2C1FPp8KvDCcUWTu10i+DiXntuOmAfJVA@mail.gmail.com>
Subject: Re: [PATCH wireless 4/4] wifi: mt76: mt7925: fix RCPI chain 3 mask in
 sta_poll RSSI extraction
To: Ben Greear <greearb@candelatech.com>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233692-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D51533B223A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 12:31, Ben Greear wrote:
> I am more concerned about the trickier patches that you have been posting
> that is utilizing work from upstream vendor code.  How much of that is pu=
re
> AI driven?  How much testing has been done to see if there are actual sta=
bility
> or performance improvements when testing actual hardware?

Hi Ben,

To be straightforward: my workflow involves pulling GitHub issues into
AI prompts along with firmware analysis tooling to identify potential
fixes. I have an MT6000 available, but I have not been doing thorough
on-hardware testing before submitting. That is a gap I need to close.

I will hold off on submitting further patches to the mt76 driver until
I have a proper test workflow in place and can verify changes on real
hardware.

I appreciate you raising this directly.

Joshua

On Tue, Apr 7, 2026 at 12:31=E2=80=AFPM Ben Greear <greearb@candelatech.com=
> wrote:
>
> On 4/7/26 09:00, Joshua Klinesmith wrote:
> > On 4/7/26 11:25, Ben Greear wrote:
> >> How much of this is AI driven?  As far as I know, mt7925 is a 2x2 chip=
set
> >> at max.  So while the patch may be correct, it may also not matter in =
practice
> >> and at least may not need to be backported into stable.
> >
> > Hi Ben,
> >
> > Please accept my apologies. You are correct that the mt7925 is a 2x2
> > chipset, so this does not have a practical impact and should not have
> > been tagged for stable. I did not read the documentation in its
> > entirety before submitting, and that is on me.
> >
> > I will be much more careful and diligent with testing and review going =
forward.
> >
> > Thanks for the feedback.
> >
> > Joshua
>
> I am more concerned about the trickier patches that you have been posting
> that is utilizing work from upstream vendor code.  How much of that is pu=
re
> AI driven?  How much testing has been done to see if there are actual sta=
bility
> or performance improvements when testing actual hardware?
>
> Thanks,
> Ben
>
> > On Tue, Apr 7, 2026 at 11:25=E2=80=AFAM Ben Greear <greearb@candelatech=
.com> wrote:
> >>
> >> On 4/6/26 16:47, Joshua Klinesmith wrote:
> >>> The fourth receive chain RCPI uses GENMASK(31, 14), an 18-bit mask
> >>> spanning bits 14-31. It should be GENMASK(31, 24), an 8-bit mask
> >>> for the fourth byte, consistent with the other three chains and
> >>> with the RCPI3 definitions used elsewhere in the driver
> >>> (MT_PRXV_RCPI3 and MT_TXS7_F0_RCPI_3 both use GENMASK(31, 24)).
> >>
> >> Hello Joshua,
> >>
> >> How much of this is AI driven?  As far as I know, mt7925 is a 2x2 chip=
set
> >> at max.  So while the patch may be correct, it may also not matter in =
practice
> >> and at least may not need to be backported into stable.  If it is a mi=
nor
> >> cleanup that doesn't actually matter, that should be described more cl=
early
> >> in the commit message?
> >>
> >> Some of your patches are touching tricky parts of the code and making
> >> subtle comparisons against how the vendor's driver is written.  How we=
ll has
> >> this been tested and reviewed by a knowledgeable human in general?
> >>
> >> Thanks,
> >> Ben
>
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>

