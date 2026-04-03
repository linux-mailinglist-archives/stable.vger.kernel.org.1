Return-Path: <stable+bounces-233176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFF2BC+pz2lxywYAu9opvQ
	(envelope-from <stable+bounces-233176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:49:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AAF393CEE
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 096473037ED1
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98F73B7B69;
	Fri,  3 Apr 2026 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKa+m0+G"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469813B19C5
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216892; cv=pass; b=WeTd3JA14GBi0tyRY8U88pmlzinjBrbkHXqafwMClnYiFA4aOc7VIKmquTOpRFxRvLgWyhURdEEl/vRSy164WWpo+xR9X2771/Rx3i65oPXTw6keKATnqooE0PhVRaFg3siOMiDOg78ZS6rESZDG6U05jKBLdI9HS6ViiOmFkMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216892; c=relaxed/simple;
	bh=URfO4qXQmNwqn6yWmUmDTG0PuGd0UKqDBdiR0nFIs0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaJ1rWo3LI8YwLAwiQdeaZolQEJuqOeSyURgXqjBGiCsXkdlqjZFCwSCNNg1uD4x4azI06ka9cW9qLrYQ3EGduHHIl4uz03TcyDg5oPgtMlXPipWBB11kLZre2i9menAJMeU/D3nGn/0u3jY4Y6iYTnRv383pnJPr4mHeLLaJ0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKa+m0+G; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40429b1d8baso681524fac.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 04:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775216890; cv=none;
        d=google.com; s=arc-20240605;
        b=Uu7v1tH1XVpElu6R2QGl3lE1KuKf0f3EG+5CSsfuz9GGMpW6hPz4nArfNkbmP+Z3pX
         ddxlTQHICzAAOx0yP3t4vcSqC8Uxn3svUBvsV+NvtqvMMM9PA0S79TA/e7dKiPxcMBRC
         tqS6dEWMFIfkDXHyNbtE0n0xpt38CEAuiwnm9BCIEpJ4MWg3NUrf9VA3Dkwvgh3qbc5u
         BJl1IsboF9/ch0tJOTv/qiHQAtedK+7jRYqecd5xgP6XRpstr/RfVtN/d2iPWpbbJc//
         rOmfJXOJ99UVzkKQTBjwYDRzK8TW88/wBDoBGf5iCuewByqLFheI1zAjZ9qRSjavbg72
         YhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9zwNrIRDyDXomtxBsiInc7L3dN6ekhzZYrvMJHKrhcE=;
        fh=ClwabMB8uzJsa3bX46mpLQpsbC9Xhi7Jz1DfX+AMHhU=;
        b=NSV1axEeFMumcJLRJhzWxZG6qPY0YAuzN/NsOgyK1mLdqeEt664OL4HRd29nI+9PYY
         XryAqnUpeUxMS4BFOxYXOqEdktmI2OAMaCS+lGTJHjxS3YqJxfDXGmnk6QPSjyDLa2Xi
         cxwHbCc08cNPPjayh8L3hHhSDcxH4CopnDXLuACuKtoLrgAm0ovwJpiwj9AfD787kluI
         5JzUqpfWE7Qq1trMpECgAmjWQz5rjUbv5+BpkMo1Qx2O0IccSWKKzCW4BglT5xymCRHl
         HxB6L9uOPbqg8yNj3rQ2amh075PUimp4IZb92JPhVNaa0sArf0s6ZltUVFt9HGafC4vN
         iySw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775216890; x=1775821690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zwNrIRDyDXomtxBsiInc7L3dN6ekhzZYrvMJHKrhcE=;
        b=aKa+m0+GY2iLL9slBEtgLVhT7mFnRDVZm3O/5OnPDoB5g7V5CJNhQhYPgjNK8XhxOz
         hvlkHgJbKu+DlDr68MSK71jkYy4KAJLM+R2zJkaD8g/Rtfu/E+7SE/hTgOEqzMRkZ2Wy
         tYzws9CM7Fv2DWDBQnuLsV8oCX8HhVy881EgK4p13e8e8uDA01fPqCS0oSFwikYFgdB9
         +A0PloJv/LAmCswn4OFo3y7s58WN78fnl03YTMcATGbL82Gth9y+eS3OSjhwMpehga8J
         7Nb3+nQ50gDIlYWfe9tZqR35c89udzMUPFMkqwQ1/gufp5bkg3DDxhwMix97DoOMpxYA
         0D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775216890; x=1775821690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9zwNrIRDyDXomtxBsiInc7L3dN6ekhzZYrvMJHKrhcE=;
        b=Hr1qgGeAdkT202ZSw55eTJ3Z2zOvikd1jPeoWm2NjnfVKRkn2uylv/CI/VPkpEfFcQ
         uLlMMy3tQdQk/II33lfZjH6TNszh2j5FoxTzk5NAJGTFOTjlLdYarks0fwyXiU2G8hej
         vO9elpE70cLpMo2q7QeXnt3tzppwSo3taMItfQfrftjo+8Y+VJXB/0y4IjB63vUmBIEK
         8Tl/ND2vv47W2DMEt+WFbyriSALXtF5fAoi05SjZqZxx8ndtILC/gWHt4NbQeRIf++bZ
         ee/xVh7ayK8fLJWIiLS6DwG3cT6NTcjS3DBP2ymTniLZmri5PSlTcP5RLuqiQaOxZF2B
         HB0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvnsqV7S0w0GFBlT1crkEX7ChwZZExYZZWUSa10r7c8VEj8xE9uNOkgFxjRAVU0qikGXJzhx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyfRGDr2hz7bm3R3nWDbT/WCARJkfHLYfqIRbTmlyKUXbluEZk
	KEuyinn5Seyu5YQZh5s2VF9G7WuYWvfnSUNoI7XaYOgoYZxq66ZH+XN6G2HVOuxDHQeapoQncKu
	kenAQI7z4k7AezBdHJOqWtFXj6INjQ3k=
X-Gm-Gg: ATEYQzx46AFYAM0CZ66v6nUZIgSiKE4Z7qp2HS7lCrPyzBM70GZaPr3tMha2Lzo9HVo
	7DPnbePXhePpUrVVrMYqDuuIcHzXnnqs1s5erdmHSRnUg46YVlDLOWruwpvKaSgfJWW6JIsRQPC
	FIH3rkr3bRYeV19K2it7uazR/lZz5WnQNXgiuy0bMkYHJipofyyw6esFPlHlyjnYlpeoRBehBrF
	8wy5ZHvTMJcgxusuX729fjvO71bphf60S7joy7r2tONtlFODjm07ypRlGBIs1kVV5PcXkOBztN+
	jjo3T+/14QeCwR8mhMaWKwDUUvvfcZc+EQzo8Q==
X-Received: by 2002:a05:6871:79b:b0:423:1a33:c275 with SMTP id
 586e51a60fabf-4231a342d07mr837578fac.9.1775216890130; Fri, 03 Apr 2026
 04:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403110238.16596-1-devnexen@gmail.com> <CANn89iJiB6QQ6qPQSnXLOqG_NhsqV-5J5ndSyKcf27pN3EeiMw@mail.gmail.com>
In-Reply-To: <CANn89iJiB6QQ6qPQSnXLOqG_NhsqV-5J5ndSyKcf27pN3EeiMw@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 3 Apr 2026 12:47:58 +0100
X-Gm-Features: AQROBzAV-cZ7Lwo6cZ6k65vh0g1kAjYjcFfMc1jdULr6qoX4UM3ku51haJ1XjHk
Message-ID: <CA+XhMqyYo8WwCwRg2kUv=HNo0bGXe+kOTDFH8rg2keDFJmvxhg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_nat: fix inner IP header checksum in ICMP
 error packets
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233176-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 44AAF393CEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi eric,

On Fri, 3 Apr 2026 at 12:38, Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Apr 3, 2026 at 4:02=E2=80=AFAM David Carlier <devnexen@gmail.com>=
 wrote:
> >
> > Update the inner IP header checksum when rewriting addresses
> > inside ICMP error payloads, matching netfilter's nf_nat_ipv4_manip_pkt(=
)
> > behavior.
> >
> > Fixes: b4219952356b ("[PKT_SCHED]: Add stateless NAT")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  net/sched/act_nat.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> > index abb332dee836..cd1d299da57c 100644
> > --- a/net/sched/act_nat.c
> > +++ b/net/sched/act_nat.c
> > @@ -242,7 +242,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *s=
kb,
> >                 new_addr &=3D mask;
> >                 new_addr |=3D addr & ~mask;
> >
> > -               /* XXX Fix up the inner checksums. */
> > +               /* Update inner IP header checksum after address rewrit=
e */
> > +               csum_replace4(&iph->check, addr, new_addr);
> > +
>
> ~20 years old code, are we sure this fix is needed?
> How was this patch was tested?
>
> A selftest would be great.

Ok sounds fair

