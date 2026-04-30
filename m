Return-Path: <stable+bounces-241977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2InCCCK18mmUtgEAu9opvQ
	(envelope-from <stable+bounces-241977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:49:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B558D49C18D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94218302E31D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8D279917;
	Thu, 30 Apr 2026 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDUnci1J"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24112274FD0
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513736; cv=pass; b=LFdYqXNjhqx5RUbTQBWSmVBZpA9T28I4tbX3UWL46EV9elYlk2y95ZhAoRH/tAf+Th3OO5IxSDha4ayPSTM+qN4rIf1GJgHlTHKF4cZGnShA8oKBsn0wEPc3HCozHLO3iZEqzgLRY4uzn161k9qB7ctfCjWO35shKd+jJcVIDh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513736; c=relaxed/simple;
	bh=Cpy4HtVc4TDj/lkwt4Oo2cs+X4zrx+JeYqCu8ESQ9f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rddMeSQEDOCvwcXs9Tijvvf5rhvrMq9Smge/L9TEP3jCVPvCMrAZOcfmZDjpkDo0hKes8iAcGqbHEHZDvp5SHFsFQtQcdibhLdVBLJ+e7b43ADANyI1VxNc0g6UjYrCOqFWAVod1/1xKxojB+HoNW1N3aLjGoPp6AX8nXelxhMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDUnci1J; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8b038a00370so3939206d6.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 18:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777513734; cv=none;
        d=google.com; s=arc-20240605;
        b=FWscVVXxQmklovXZnDbfqwZilisbjULK840c6bfa3rYmWHuO7kx7tPF8qyN6veMr9O
         euyq2khQB+UPrKeh2fSMs2PdAp6Lql4bsHvxz0sEOllUU5h+k5/j+bWyQyR1jFxVbcn2
         WhTrgGSYP96xkvy2HE1GiYuXDJGXtGLv77wcDNir8G+ibTVMmK2m9tgtO+8ONJRUcD4Y
         PGHthpnGFR5rVDD0wIet7Pic5zanar1lP+t26mYrunSi8jerbIeNcTtiohS20FhH3ySR
         PbHrp1/yn9pC5qqeoJJi7IoprmGoE9kHG9hXTNlDYWUX958Yr49hyqFBkN/qaabhuUaP
         OHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cpy4HtVc4TDj/lkwt4Oo2cs+X4zrx+JeYqCu8ESQ9f0=;
        fh=lo/My9WoLSuqbBMiilmYogi8nivRrWbJxngYB4afVus=;
        b=T+/nC6AXuQIkV1qudjPmbOUS6lQvh7VvEgP6qdAaipxVEg142b0cg/ehmjW4dE7tQD
         MF8beBD1QnFu0/woJc6t/gE+V8T3zuPCJWwfcBP36SjCWGt9EdaEZL+YqZnTvATa1JPv
         m26mZG5UQhUVKmHcJ+4XpMq1/2hUG0Mqn+QoB8BTlbYApeVz2+UH42892xt+7YD1Qt1P
         x6SDB/rxZY1gTbByKtkvoA68L2sIP0tJb7rG8OcEffLvKKh5NFG6J3e/25QiD1DMI7G3
         SLFD7lm2o6doAmO7DBUrT6LWtqncnSVqDDSHcuRV8H+zsWtkZUbqHXHo/LEZPe8/XTZ2
         W4VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777513734; x=1778118534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cpy4HtVc4TDj/lkwt4Oo2cs+X4zrx+JeYqCu8ESQ9f0=;
        b=rDUnci1JgHxQSDhZfk9wGYqdUKCeE41E1Z6ulxH+PRJE+u3zPlkL5255OKnQp89giO
         9wp3twjquQqjFmycL207huBV0z4+tE0A5CpC956c9Nz+y4c/P+pwlAQD6qUH7zuUMBkR
         5UhzGa6Kba9EsDvjZHQSmgS9tbsFnssMuIgHgaJX/gUmBOv76Cpu4sl8upP7edZDLwN1
         TlmOEOtbuSyEofB/gL7T8lb2LB/DNeKj8TRPcFz0jJK8P8mS2QKeWC7HchKSYS/3vHqO
         +96svf2s9bjHL+s+HhGzb22YsmmwNOV5d7Zgi4a4LPyUVANo/k6ISxl45aJ8weKl9L1Z
         eoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777513734; x=1778118534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cpy4HtVc4TDj/lkwt4Oo2cs+X4zrx+JeYqCu8ESQ9f0=;
        b=s1I9IvRmXn+yqZjNnteKvrKXT/GbGoY4pa5wOoi3k1z2XNunc8SgrSdekqSJem0Ug4
         JGmC771t3udQ+YL6Nm83wPsZlEQ1ftxeQIeVEy0ffv4w5R2AsoUJ7ebp0tnjnyKk1I0z
         Y3rAIkk5V+Hqler4rNzeeWWE1aG3WZTGoRBsbV/vtdOUz6+IW8JVKiCa3m3Rpl4oNlQn
         3p5VnSPDPdhSco617ey2wl2ux7GSCaoKqupSLk/5SVgikDP3JzhAMMjURkK+zvySLStR
         33yRMhdsICScTFJ5i+cVqyKhFjW6h9GZCfhpVRdaP6nuUolUFfHXY4Z5souZjcuir4uu
         A4lg==
X-Forwarded-Encrypted: i=1; AFNElJ/KWSIx+1Sj/d3kCfq+cYu9bqBZXBCOkH9EGOURdJ2cTnGWgIxv/uc2SYxJZkpGkbPH7+4kCWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3tVzBH9LkezQna3TDy7y4CL6YZvKN58si0cm5gUECt5xNawDA
	880t6X30VBmYSoUr+S7ErYnGw+aojfvNuENVUEh0rd8IVdyLM/tw01m5v2loAq7Y+BgPozGZhyy
	KmV0Rpawkq+vq8xUGOqWGcMOeDQjXF8k=
X-Gm-Gg: AeBDievJcQoFzXKv80HhDQzM6YEXDY8cFuc7kcblPlHF+ibFKoaF2eVag/maw2QQxuC
	d7VuWjcBiyV+eoaDzJoeJD0Sw793VfH6G6tM9+c7kgms9u1e64ljh8615O/9x7rKae76ppy3aus
	zeM+VmV1ELZFg8Y3n2kkNR7IEDBQWhKTCtsbh9FUyIhgR4KBelHFDB4yiY5vE8YIkD40qWW/gvj
	mmpSaXLrNpmJoFIH3G3Q6eW5/8oOaX/PCe11tewNjg3Yo+/SgFae/IMSf2qF/BBVTHphxXBjyfl
	L9gURM2t1jxQrTNiHaW2OcUjgXai40fplZX6403Kj8oZCkBeOVxaoXsYoLUS8DK6g53bug7cAng
	m+8c=
X-Received: by 2002:ac8:5dcf:0:b0:50d:4601:e335 with SMTP id
 d75a77b69052e-5102ae5de21mr13700191cf.54.1777513733882; Wed, 29 Apr 2026
 18:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428030826.47509-1-enelsonmoore@gmail.com>
 <20260429175421.014bb28f@kernel.org> <CADkSEUiRwto-14zkER30WJdiQa2b+OGOZ+2S50pq4doJ37X70Q@mail.gmail.com>
 <20260429182701.28edde72@kernel.org>
In-Reply-To: <20260429182701.28edde72@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 29 Apr 2026 18:48:43 -0700
X-Gm-Features: AVHnY4JzAmcEdxPyItkj_q8Wxw9A4aKJfDhdvIkOsOY2k8ahbWf25THMCYHvnm0
Message-ID: <CADkSEUgYtyoGNAyVJQNUPvpaGZdn-L6OzE9qP+T-rDt8AVmgQA@mail.gmail.com>
Subject: Re: [PATCH v2] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Yibo Dong <dong100@mucse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B558D49C18D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241977-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi, Jakub,

On Wed, Apr 29, 2026 at 6:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> That'd require us to know if the device is going to be used on
> desktop because for datacenter NICs suspend/resume does not matter.

Good point - I was thinking about that myself. I would be fine with
only marking it as broken until it can actually transmit and receive
packets. What do you think about that? Of course, as a maintainer, the
decision is up to you in the end.

> Maybe it was written in simpler times, maybe the help message was
> aspirational to begin with..
Probably both. On a related note, I think something needs to be done
about some drivers staying in staging indefinitely without being moved
out of it or removed. The most obvious example is rtl8723bs. Eager new
contributors have spent an inordinate amount of time cleaning it up,
yet it is nowhere near ready to be taken out of staging. One major
blocker is that it doesn't use mac80211, but changing it to do so
would be nearly impossible in its current state. I think it makes the
most sense now to either remove the driver entirely if no one is using
it or add SDIO support to rtl8xxxu (some work has already done on this
out-of-tree).

Ethan

