Return-Path: <stable+bounces-249793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLGEGy6EDWoTygUAu9opvQ
	(envelope-from <stable+bounces-249793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:51:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E0458B1D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB6B53030EA9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C53D2FFC;
	Wed, 20 May 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5pZCmDG"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4A3D16F9
	for <stable@vger.kernel.org>; Wed, 20 May 2026 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270676; cv=pass; b=NY9CbhCJgAzDJMwOe+OExBKKF1Mv5s/ddiKkJv1yX1LTUrkhraC2Jw7ZNmBF/ftZ2j4E6y2n9ufT3Q2ZY58LZL6JrbfgleUxE4pAcFNWYHYXHfddnnh81kVhRyboKNz3Amu3tCi6yMK0/LxazT6RzmNiIuYXJcf6mShCUSfojXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270676; c=relaxed/simple;
	bh=2Eft/LCNyTaq855jfgYvAJS34v9zNa2hjVZWhbopFbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjJRBXE+M2x2Dji/wyC/hE10gJ+fFuqpBDAX5wttJc7t42jidqA9NW6cDgckthO/LJ911QllB4cjiikeoVZt8kJN523VCy8n5/woBHnp2mgHa0eBcw3yJcxvcYBUnfBOEa1oYMQz9Z5Sz3CjkMotqJkOlWcshx0TmL7PmDyCvu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5pZCmDG; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-47c35be031dso3302345b6e.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 02:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779270674; cv=none;
        d=google.com; s=arc-20240605;
        b=fp/zqmhxmFtLQmFtpMFtBdyag5l//j8mF9EweW53GofJw0PnNUje+euRPZTVi9XQ18
         Zk6bYz9pc4R9mc1ur+ra9e5Y931z+YSjVgVBlbzzFbor+hkbzTtF7ILhXYG4hnWTtMGA
         ClC+BQe+CCkooxKEBEjrmDXHY2Of/89yh+AJQCdsNKhopLIuIdoc07hoUl/4K1P8Kl7w
         urk1zpD7t0oli59oOjnUCg8yC7vRe+CEWYoAhlSPYWOawHoQmi1jG1hPVb7Vl4kD7toE
         g1X9fTepgd9PFlhqT56eojFJCVTnJ2LgKBnAqFOycucEnNSmHuzY+Z/JyKXEVcLjqyGZ
         dAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MZlXLFzzeId8tlIqW5oSoFq5M2aS9QNPvTSGjdbnVzw=;
        fh=HiIM5VrfA9adDQCXG5RhvpFRBpQ6q3tVqa6nbNF+jAc=;
        b=JH3KOKA6S4705vc41SPMZXLopA5Z2XyaXISIC2iivvLtyi1hZEZvV0IJcDW9EWLeBN
         VwL2RzoJRFFT9oG2Jyv5/sEMu4Epn0CF5jK5ZnyqYOUZ00m/uzHqyGEsHPqDMghpUZFq
         si+mPWivZZ5sdVL/dOZ+NFMvseZFKAjf4i8ziRCCS92scnYT89NdkoZXVtUosEgdTIgi
         L46qwgP7mjIaKOL50iraZ1k7NAoKbDr3bkOF4zjU1qZl6l+aW3ccy+49GF0WalSxm+a0
         ZYTpSCzbu9zyHGnS2cRyl5P+e2Eb0zkZBFELUrySAWDcRWrkulxdl162zrFnyLtNTX3Q
         HiTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779270674; x=1779875474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZlXLFzzeId8tlIqW5oSoFq5M2aS9QNPvTSGjdbnVzw=;
        b=a5pZCmDG3sM5KQzvnDCbhPwbrRoNdIEZpAsldNL9N8ymI0mJHAvZO++lM9ag2QjKWq
         Y/mpAvZ+Wg4Y5HqOA0ScdpahfU80hONu22jV3u7c+bwcu7p29ctvwmR1E8a+do9Dwwdg
         1oELqIizPqyMQU+dJAyzWHYeU1vgRYeLXuFEGKuXNYVryphtZBYB491lduCg4SweOF8v
         jlHJ72PA/trt9dT88isqHhKd8Miou2bd/aPIkeVKEigu5CRKcXZ+kyjrSEUBH/yRF1kS
         KjscsXgPKLT7piRCv3XAR/tLjqaeSRNpjcVC++ydr5Z2QcmBuQ3Of42ZbewLQFP7gSgn
         7hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779270674; x=1779875474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MZlXLFzzeId8tlIqW5oSoFq5M2aS9QNPvTSGjdbnVzw=;
        b=LgN/J9qg1Hs8NJimWgsUbepquYD5UgrFyF+3zwvJeGvxq6EKA6B+dC1g4iltG9D6ae
         wLmXj25f7b/J5cJ9NH94Ju1p3oG5XYNHkqjehMupJ89+NxC+0itu04ef7SmyEzn+2bfv
         o57ML/xGXkHjiJNwW3429TT4crWl9J/YzLgE0z11iprikaO60bXeLG9R4uMsffkjXCo+
         H6z0K98YYi0PpAo1LpQi/t+0HW75wz1oeHRpv+/DlMriHpgMeoPN4BnjXhT9vNGAhZwp
         2b1RRqkAuFh09hYiQC286QF33+E8n9m15dVPU4aqx/H6qNsXaGv7PM106A419rpuNiBv
         q7SQ==
X-Forwarded-Encrypted: i=1; AFNElJ/R0EI4szORTMlCbSeJA/HnuxYBVmn7z2HcK9VcObKIDxk/QsuB1OaLuCNJdLLBcm0uq+Qtnkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4bWpBd4BemCGhU98fxIlwbUkKGOrStI1thh5RrqIhTzXSZd5
	3LUiJ/8DmDb8ZyOJRl2LSCtW3CFBZSDY5Wulb0zwBn7WIrD1ceuTjjy/kKdzubY9ORr1vR2faOn
	7jB96vk9rxUDtbnd1zYNWXxLj05/C/GNpVIHZNElR/g==
X-Gm-Gg: Acq92OGHD4IZhgxMndJspvh2CBMmuFfiaxQExSxTgmqyDORQo1SNg6VAjgm6w4hNWJ4
	LLfY/Tf95XqndpnZrIP7qhulUxoY6FNcqXixi9IAWhIrudgsU5an9uSskq424pOg9ffdQ+BGAi/
	SR3GnPN0gjqbA3vnFSooVyxmMBxZFhrbAfVrqV9pfUbsVbRaHgotMaAr5SdaN+vE/wBCposVOnq
	yMu2Do9w6RQXpMX9wlrSe3HAsQYRVp1g10uAXRTeaSMJASP1lYB0YZab0HfFcEDkHepwWaH2Y4X
	7XTkXm+b
X-Received: by 2002:a05:6808:3029:b0:462:aa0f:4375 with SMTP id
 5614622812f47-482e5789699mr14575015b6e.39.1779270673811; Wed, 20 May 2026
 02:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
 <20260519235713.49109-1-lucid_duck@justthetip.ca> <20260519235713.49109-2-lucid_duck@justthetip.ca>
 <CA+bbHrUcwtNhatzV+ufa8O3Wrku2_W4-UL=3XMy4-kg9qiOdXw@mail.gmail.com>
 <a36b5712dd420da4090bfa8868e78b1b2b90c916.camel@sipsolutions.net>
 <CA+bbHrV3fFHWevyDGPtAS=2M2mc+LxP6=xA-5fXaiTKTD=R31g@mail.gmail.com> <739ba20fa3c88e92bf034d80383015b8bc78ebfe.camel@sipsolutions.net>
In-Reply-To: <739ba20fa3c88e92bf034d80383015b8bc78ebfe.camel@sipsolutions.net>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Wed, 20 May 2026 11:51:03 +0200
X-Gm-Features: AVHnY4KURUo3g9b9wuzddRfCmeBmlTt3UJPt-BOHJwYs63Ib6XGnntkDentAHQQ
Message-ID: <CA+bbHrUqh+nu_eKBMVaPH6Q8YxuKS=S0kON2Zsb+gRZHU=SBPA@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, fjhhz1997@gmail.com, 
	Brite <brite.airgeddon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249793-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[justthetip.ca,vger.kernel.org,nbd.name,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 15E0458B1D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ok, let me do one final test using Johannes=E2=80=99 v2 patch. The expected
behavior is as follows:

6.18 or lower: no need to test, it will not work. It=E2=80=99s clear now th=
at
this does not matter, since the goal is only to fix newer kernel
versions.

6.19: some versions of the 6.19 will crash and others will not. The
crash was fixed at some point between 6.18.12 and 6.19.12. No need to
test.

7.0, or 7.1: the expected result is that there will be no crash, and
VIF + deauth will work only on 2.4 GHz. It will not work on 5 GHz
(I'll test both, normal DoS and VIF+DoS). There should be no crash,
but it will not work.

So I'll focus my testing on 7.0 and 7.1 and I'll get back to you with
the results. I'll be testing this patch (v2):
https://patchwork.kernel.org/project/linux-wireless/patch/20251216111909.25=
076-2-johannes@sipsolutions.net/

Give me some time to do these tests. I'll test it on both 7.0 and 7.1 kerne=
ls.

Thanks and regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El mi=C3=A9, 20 may 2026 a las 10:58, Johannes Berg
(<johannes@sipsolutions.net>) escribi=C3=B3:
>
> On Wed, 2026-05-20 at 10:02 +0200, =C3=93scar Alfonso D=C3=ADaz wrote:
> > I tested it on 6.18.12
> >
> > Let me know if you need me to test it again or whatever. I remember
> > during my testing with the Brite's different patches that is not the
> > same testing it on 6.18.x than 6.19 . Some stuff changed and the patch
> > needed to be different. I've added Brite to the thread, he can add
> > more useful data for you.
>
> I guess I don't really care about 6.18.x or 6.19.x, only about 7.1-rcX
> at this point. We'll want to explicitly _not_ backport this fix to older
> kernel versions since it caused driver crashes.
>
> > Regarding the approach of fixing the bug on the driver side... I've
> > emailed and contacted by IRC to Lorenzo explaining the problem... but
> > I got no response. So if we feel yet like this is something that needs
> > to be fixed from the "driver side"... how to say it softly... we are
> > f***ed up :) . Maybe the "hack" way dealing with the vif null var is
> > not bad idea after all as it seems the only way to move forward.
>
> I feel I've tried to say this before, but maybe it helps if I summarise:
>
> There's one feature and one (possible) bug here.
>
> The feature is:
>  - monitor mode injection works for chanctx drivers.
>
> The bug is:
>  - monitor mode injection with the feature patch crashes at least some
>    mt76 devices, which you reported, which I consider to be a bug in the
>    driver that needs to be fixed there.
>
> To me, the trade-off is crystal clear - as long as the bug exists, I'm
> not going to apply this or a similar patch to enable the feature.
>
> I'm also not going to apply a patch like proposed before that hacks it
> by redirecting the vif pointer to a (more or less random) other vif,
> that's a lazy hack that happens to fix the problem in your _specific_
> use case, but will almost certainly still expose the crash in other use
> cases.
>
> I do think there's a chance that between 6.18/6.19 and 7.1-rcX the bug
> in the driver has already been fixed, that's why I keep asking about
> versions etc. But I also think there's a chance you're just testing
> different subdrivers of mt76 with different devices, so I'm also asking
> you to compare the specific devices.
>
> I'm happy to apply this patch if the people who previously reported it
> to crash (i.e. mostly you, not sure about others) are saying that
> against a more recent kernel it no longer causes the test to crash
> (rather than just not work, which is clearly better than crashing.)
>
> You could always just claim you've tested this patch without the crash
> and I'll apply it, but then if someone still finds a crash I'm just
> going to have to revert it, and we'd be back to square one.
>
> I hope this explains what I'm thinking and going to do (and not do),
> make of it what you will.
>
> johannes

