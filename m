Return-Path: <stable+bounces-233434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LCyBpkC1GkwpQcAu9opvQ
	(envelope-from <stable+bounces-233434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:59:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7263A6750
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E90AF301C144
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D56D395DB7;
	Mon,  6 Apr 2026 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A4EuBPRA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44D38CFFF
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501974; cv=none; b=i0b3Bay00FDZ69Z9YpDcjHi/WMEA+i5rPYWMwKIR8Lz+8M5FXGA5hRta3CdnoSX9h8o3GPkZ8SodrEfpgmDDBNlKYf730vg2mNl7NDyxgD46WGWO7YisNtd9bJ23+es1xk+MhVMaM/rL9Rvr9nTL5krSA9I0uC4BGhx4BB/mrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501974; c=relaxed/simple;
	bh=MP5XJk9iCIod9KfOfPbBtryirQRyDqiT9ZotrAUZfnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Heca4Whws8XlDxuQ9z+VAZBPEATqWLQ4m8KMNcHjkWg+9Tfzi2h3NOzfhLSf9uSJaR2Db6vFW521GkdHFs5FNxLqF2EyMVM4loCY4MzSp8+Y0y9LPZ5cUKAXwBALyK/ZgWz8BOcEnwU1gNleVc+DPMj6w13m56kcSScmToHecWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A4EuBPRA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so720015366b.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775501970; x=1776106770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ca80400b16hxnkq4OIBWd5Qd7l94fMZC2WBMvwuhtRk=;
        b=A4EuBPRAxXOV5oDTV+grQzMSjF720ZX6oK47dkjTbQNgeA1YFCWaX65GLLqmxGJSb5
         h7QbISN5UdwQmz41ufQ8Z+g8WYnW277rV6zrH7VWFmg0c/043xbbS/7EiMgdU3CWegtS
         2ZzGP7S0R2+jE3yucb6GkHnD3xIGMpyz63dc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775501970; x=1776106770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ca80400b16hxnkq4OIBWd5Qd7l94fMZC2WBMvwuhtRk=;
        b=rcqZ2pcNU+I4w8PoyMlLonX5i1wi/KFJGGHlsFLb41buqYlNh0wBZrfMLTM+c9iA0G
         PQOIjccDhPVA4weh30CKVnSYcwtTpeMWIeD80a2AY6MqMHQRp+Kb0eG+cY3wGZ85IJZu
         Xn2PdhnzBNJQLXA8jAnVXeDzgnfmYBsqo71KVu3fkapfm1ku+ynDkuk/zFdGOJM4s6Xr
         Czp50k4XVUMo3+fZPv00p8VKkfNMSz1wszzBVVE4g9SpiS9UMx/K/DrG+oml840r3hDs
         o6zBayg5GwdiW9J8diaLR0zga3lOTzHV2qNT6O8SsLbdHRZIpr0wEvIUhSUxW695xJ4E
         ERGw==
X-Forwarded-Encrypted: i=1; AJvYcCVcttf2kqHq4xOfJ/PtTmUuF/iOVwtfW34qnGxl/f7jMaChBSANo3N4mEKt3urCVmzaBDC+Zd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPfmRtIGPPg1a260fgmAN8K6vEO5JNthdbxi6XuBrKPsa1aQsu
	OPH63e8NVEF6vuTA/AxMhh5gxqzvlPiZZu2Vj6/pE9/bHYDOZoWj2lMn5QCBoLUhz8sjOK8thmO
	1tJuPhyz0
X-Gm-Gg: AeBDieulOW4rZVzE4SmGDc+MQ+EWi5PvRkh4vway/4R2BvqYz9Pu36GtL3ZwrOMRps4
	chXtmNEMnEC4p0rdYCDz3A2xXXZLxmFWPZCagN1xA9uYSoy4LtsLq9gw96C3/FjyDFfo5l5tErT
	b9XwPPQr0pXiD+r1c+0TDeSgVUOUMUj+Rf90/uwlj/Iw2X1rJg6A4yMKfRRILDu58zNn7KhKHej
	F+AHP3STa285IVW7IYpb9ulyf38xFufnL0/YdSM/3kVQ1IvTxEx23CcbtboFLmPDa3lM5DZEs4M
	DifEXE3H6PbtOf6YIPl8oiuvB0XfSJ0znMIfIqgPjWJ/5GrjP/FgcyzFY3mH5tLGzEBhIGX32vB
	OekSL9DQlo7UxC/jXEk788kx7NL99/o2AHtjFzymGLnHH5RUfwt9MiwOYqDAjg29c1iDIRwBqyd
	/9t9YgjFlOVi9MMEZ4Ru5CB42y/pn6CxoyHcbmaraGE/mArLlr8HxaCLr2xaCJpw==
X-Received: by 2002:a17:907:c994:b0:b9c:4a6c:7dc7 with SMTP id a640c23a62f3a-b9c674473a4mr404599066b.6.1775501969476;
        Mon, 06 Apr 2026 11:59:29 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec5c16sm487619066b.40.2026.04.06.11.59.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:59:28 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cf7683a28so2468996f8f.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 11:59:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRuVr9fWwCRv/qXp23f648XiWsRlO33FfmPTh/OLQphCstn9V2Y3YIfNi2t7Im++E+0/wacWs=@vger.kernel.org
X-Received: by 2002:a05:6000:250f:b0:43c:ea2d:9c7a with SMTP id
 ffacd0b85a97d-43d292ff4f1mr22125257f8f.49.1775501967839; Mon, 06 Apr 2026
 11:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org>
 <20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <873418d2fz.wl-maz@kernel.org> <CAD=FV=WV2SJwiC7CHEzG=XQJ=tG0P7JSLzU16f0px4j1qmwxUw@mail.gmail.com>
 <871pgscaj0.wl-maz@kernel.org> <DHM80WWSJ2XX.Q2X67PU4K1KS@kernel.org>
 <87zf3gauid.wl-maz@kernel.org> <DHM9WIABIULA.VZ9HOKU62SC9@kernel.org>
In-Reply-To: <DHM9WIABIULA.VZ9HOKU62SC9@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 6 Apr 2026 11:59:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XcphmjoBLisoS+LjD+vq-dEaTvnKFstC_E42ETt4524w@mail.gmail.com>
X-Gm-Features: AQROBzDBBdWTpyX5KojtEtlJPvrjnYkYQBCqXgX8tzjjFkAPK1Blcxy5_IzuMmQ
Message-ID: <CAD=FV=XcphmjoBLisoS+LjD+vq-dEaTvnKFstC_E42ETt4524w@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] driver core: Don't let a device probe until it's ready
To: Danilo Krummrich <dakr@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Saravana Kannan <saravanak@kernel.org>, Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, 
	Johan Hovold <johan@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
	Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233434-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5F7263A6750
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Mon, Apr 6, 2026 at 11:11=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon Apr 6, 2026 at 7:06 PM CEST, Marc Zyngier wrote:
> > On Mon, 06 Apr 2026 17:43:22 +0100,
> > "Danilo Krummrich" <dakr@kernel.org> wrote:
> >>
> >> On Mon Apr 6, 2026 at 6:34 PM CEST, Marc Zyngier wrote:
> >> > On Mon, 06 Apr 2026 15:41:08 +0100,
> >> > Doug Anderson <dianders@chromium.org> wrote:
> >> >>
> >> >> Hi,
> >> >>
> >> >> On Sun, Apr 5, 2026 at 11:32=E2=80=AFPM Marc Zyngier <maz@kernel.or=
g> wrote:
> >> >> >
> >> >> > > +      * blocked those attempts. Now that all of the above init=
ialization has
> >> >> > > +      * happened, unblock probe. If probe happens through anot=
her thread
> >> >> > > +      * after this point but before bus_probe_device() runs th=
en it's fine.
> >> >> > > +      * bus_probe_device() -> device_initial_probe() -> __devi=
ce_attach()
> >> >> > > +      * will notice (under device_lock) that the device is alr=
eady bound.
> >> >> > > +      */
> >> >> > > +     dev_set_ready_to_probe(dev);
> >> >> >
> >> >> > I think this lacks some ordering properties that we should be all=
owed
> >> >> > to rely on. In this case, the 'ready_to_probe' flag being set sho=
uld
> >> >> > that all of the data structures are observable by another CPU.
> >> >> >
> >> >> > Unfortunately, this doesn't seem to be the case, see below.
> >> >>
> >> >> I agree. I think Danilo was proposing fixing this by just doing:
> >> >>
> >> >> device_lock(dev);
> >> >> dev_set_ready_to_probe(dev);
> >> >> device_unlock(dev);
> >> >>
> >> >> While that's a bit of an overkill, it also works I think. Do folks
> >> >> have a preference for what they'd like to see in v5?
> >> >
> >> > It would work, but I find the construct rather obscure, and it impli=
es
> >> > that there is a similar lock taken on the read path. Looking at the
> >> > code for a couple of minutes doesn't lead to an immediate clue that
> >> > such lock is indeed taken on all read paths.
> >>
> >> Why do you think this is obscure?
> >
> > Because you're not using the lock to protect any data. You're using
> > the lock for its release effect. Yes, it works. But the combination of
> > atomics *and* locking is just odd. You normally pick one model or the
> > other, not a combination of both.
>
> Yeah, the choice of bitops was purely because previously (in v2) this was=
 a C
> bitfield member in struct device protected with the device lock. But, not=
 all of
> the bitfield members were protected by the same lock or protected by a lo=
ck at
> all, which would have made this racy with the other bitfield members. I.e=
. the
> choice of bitops was independent; see also [2] for context.
>
> [2] https://lore.kernel.org/driver-core/DHH1PD0ASG8H.1K3KG9L658DYN@kernel=
.org/

I've changed the snippet in the commit description to now justify the
use of bitops like this:

Instead of adding another flag to the bitfields already in "struct
device", instead add a new "flags" field and use that. This allows us
to freely change the bit from different thread without worrying about
corrupting nearby bits (and means threads changing other bit won't
corrupt us).


> >> As I mentioned in [1], the whole purpose of
> >> dev_set_ready_to_probe() is to protect against a concurrent probe() at=
tempt of
> >> driver_attach() in __driver_probe_device(), while __driver_probe_devic=
e() is
> >> protected by the device lock is by design.
> >>
> >> [1] https://lore.kernel.org/driver-core/DHM5TCBT6GDE.EFG3IPRP99G7@kern=
el.org/
> >
> > I don't have much skin in this game, and you seem to have strong
> > opinions about how these things are supposed to work. So whatever
> > floats your boat, as long as it is correct.
>
> Not overly, it's more about calling out the fact that probe() paths are
> serialized through the device lock by design, so it seems natural to prot=
ect
> dev_set_ready_to_probe() with the device lock.
>
> The fact that dev_set_ready_to_probe() uses a bitop under the hood is an
> implementation detail, i.e. it could also be an independent boolean.
>
> That said, as I caught the issue in [3], I also mentioned the option of a=
n
> explicit memory barrier in device_add() and __driver_probe_device(). I.e.=
 I'm
> not entirely against it, but I think the device lock is a bit cleaner.
>
> [3] https://lore.kernel.org/driver-core/DHLITCTY913U.J59JSQOVL0NH@kernel.=
org/

I've got the series all prepped and it sounds as if the alignment is
on using device_lock(). I'll give it a few more hours in case there
are additional responses, then send a v5. ;-)

-Doug

