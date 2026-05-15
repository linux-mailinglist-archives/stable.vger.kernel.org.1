Return-Path: <stable+bounces-247725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ4DCbsaB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:08:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D7C55033C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A47E305E020
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB947A0DB;
	Fri, 15 May 2026 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObRWGohN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6E3FB046
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846749; cv=pass; b=MJr0g2rqmN+9SPsJMukkTRiTGDFRlPQHllD++Gw49/wO4viwOpQnidE3BLKRHVlHwj/cKxVZ0oTHEnmXBVZhbToIZoQtVqGuSpDsB7Wh7n722u5T9h35Mxfr4W2gwfHPh2wnTjIJZ8UXso6KlQdK0QjOAA5cjUgYklKzgtXmsdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846749; c=relaxed/simple;
	bh=kW/9C30akUjzDwJkUoDa2H1DV7Pw0sHZs6bPnj1YUMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXeq89DNQLHi9UOSPcJRfZDa4pgD+jyocE13sivZmhTjZv0DFAqOK5XuNDkPr4UAm/L8XB/mUElPStljZQwEgFvYO5lv63XJ8IwbY3/MaZ3vrdk5Slw4oq8a/O3LE2RXrJAhIcy+XcvWZVM143vhqzaB0DFWt9+/cwgE0gQXKZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObRWGohN; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6563f83ae9fso12162881d50.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778846747; cv=none;
        d=google.com; s=arc-20240605;
        b=YdbHmR2QzNbGgs9qeeOH58haOaofCXxBM7FMGw9sM0CNe5ZKrcp4BUwXY/AJWrttSh
         iys3QM7q0PWY1InTt/7HPsltXAEfIplhZ5act7F1hWjiFBVde9f0Knu+3Vj1sdABF5c+
         stVGmk/8gcJH2nAGHT5W9ZmA0JKEgRiuopTYUNGz2TsGi3oBHknd/rIaATubD6YsCa8C
         YXkNBB9GUufqVEAKOttNsaYWZ/l6e4vMSO89w4Aq9X4Ka90depUc8hpyMv3qkg7GEELy
         LYukvdTLesvCszUn4ViW3aT0AylRJxFRdTpJdLi4Iwy1XAqE3/ahfsaKVV23EDhoHLMN
         h53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5kVosTkW8SNhxTSi2C8qw8i0G8BjP9k3uqUmOQ8n5rQ=;
        fh=CaBLDJj1+kGYebbrOKKiqb+cZhNNpoIp+yPewh0fmH4=;
        b=FzvgBGyIZoo0SWGrtLlKscwMrgPcsoYsTAI6DufU+9qMl+TwxX6+Fe5pwt0rfja3pP
         uTsaI0h3zDhHdm9GxICd68bis61VaWGkvQS9rj0B5gIgYXO0Og+c3M3Mc5UgaOwMPZfO
         AtJ/x5pdx0ehun+xjto09Oo1GlpZF32N3RGfYcYHPS3GICgzfzc5hNRNIakRYnJAGkss
         0/Hlqy6lm54saZ8YSaC0Ng9kZyVScy02/hAaK2AtAJ5jqfHu0DoTQ0p72RlUQHGEIiuL
         Al1LDG8ihciq60UIYU9IvHS2ww8IdEFVq/zHCrI/SIxY6Pf/5sKlrg4tT+HjLgkpWQh8
         PogA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778846747; x=1779451547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kVosTkW8SNhxTSi2C8qw8i0G8BjP9k3uqUmOQ8n5rQ=;
        b=ObRWGohNPKlEIwNYMDzlGOfDGrfA0/ChbEswY1kRthJJGcNomAK0xpDMuew4l0iLhr
         +MGUgLRQhLOGdUXc7C2xZ34+D0oC5mTRS14fw/8q+yWwoVLpzoZZZRdQrUSkn3xg8D7B
         SdCtX0BU4KJ4PlWy0Y7q73GXg/LsTukEJd2c2eiD6Y3CxdHMg3dQPz0hy1qiPSCZ7461
         0GwxtKhYgSYuWTQBy5dlc8BzBY71LPkuea4d9z/4jRKxP6knqbINdSx4Ui9MZrVz9isL
         WiPegBHtAO/W5c1jWEUzDyWwqmvnFCzcCRXFpm545Dl9b8dIRfUw2vJFph/4roNXxywC
         uA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778846747; x=1779451547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5kVosTkW8SNhxTSi2C8qw8i0G8BjP9k3uqUmOQ8n5rQ=;
        b=kV66ljFpRIpKbOyhqHZnNA43ngxpZ1l/kUvTUJQRyn+Z6G6wUOtTgHN+fatEf6DwtG
         tBP3KpfyjSK28QtoUAeGBW/XwAhkHbG1gRDyAuJwA3xPgiUrCr/Hr+w1mAglkl+zLbfK
         m6x5CJyskDKtLUJexMYz7cKFn0oLm8nbV+yW3Qjv9YYPDWwkiHqHfQZlzURLmluG8LSj
         +UbsNXV4hRleMZcg1VpSJE02WDiYbqzZgX3Bi+BNoT0PcuSFSJ7RypjUt/jV3eq4mMjQ
         vglyfDYMgqxwNHDOqPsBwcsSlW61Zx2mUGvSlkhrmf6U82T8P6HZnSiZMVhyDpCWPVr9
         26/w==
X-Forwarded-Encrypted: i=1; AFNElJ8x2JQ0t8/WAsbBkVBygWf1t45OxJ5oZNLqb3bYaUlP8VNXkFyV71j3f1aK5/lwq8UJJQ+I1Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUV7P7Jb64LFPJ5zW4iZAKu6lGOSmmPIJHoaQ6ihi4v/qufZGu
	x/ISxEFSZmrYJEnmuX56a50a8l+hVo1XWTZksXAIr5B/OBjnRpwX3qaJjhFnId1I5e3PkM11ZB7
	E4l746LmiIo/UGhJHx4CtU0jJh2KAqVg=
X-Gm-Gg: Acq92OGIzn6f3HnOiL38z7cufYmd+T2UhjVvKRflJkCqN113X+QTkm+MT6p8G7rY0M9
	ikSPaUneP0L7rxj/w3Ayg6DaNXUbjs9+OZrI4xoMJ8P89B2z7QckB49UozMW5Zztg5duTpSUCYh
	I1niD4uT2LEt+d9lFxRn2eooo6/4ZoLsKtbckG29lJ/1TaoUghFR0MLhCB+r/TYwln0tovLsH21
	fiTuLbNMNaRpcDVR9sqOMAue+UcN6HCrggpsjhIZ/acOAaU8L/oULLDjQDCJehM96TN3JZEbqal
	gNYQHTQ+6kDBgXtuNfCxjFviX0/K+l9fHlLm
X-Received: by 2002:a05:690e:686:b0:65c:5bfd:b205 with SMTP id
 956f58d0204a3-65e2290ca0amr2685003d50.62.1778846746950; Fri, 15 May 2026
 05:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502132506.1936358-1-michael.bommarito@gmail.com>
 <20260510232455.2245650-1-michael.bommarito@gmail.com> <2632015.1778845625@warthog.procyon.org.uk>
In-Reply-To: <2632015.1778845625@warthog.procyon.org.uk>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 15 May 2026 08:05:33 -0400
X-Gm-Features: AVHnY4I29IMk4pfB2O_u4c2IAaqwMg7WHsEKDsh2DM4cK4qrbnRcwgxc05ExzdQ
Message-ID: <CAJJ9bXy2Kor7mn=KYGvN0UnAwN2=oibsyrqLZ9Aq9rTRV-fukg@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: krb5 - filter out async aead implementations
 at alloc
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, 
	Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 39D7C55033C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247725-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,vger.kernel.org,kernel.org,auristor.com,lists.infradead.org,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 7:47=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Michael Bommarito <michael.bommarito@gmail.com> wrote:
>
> > -     ci =3D crypto_alloc_aead(krb5->encrypt_name, 0, 0);
> > +     ci =3D crypto_alloc_aead(krb5->encrypt_name, 0, CRYPTO_ALG_ASYNC)=
;
>
> Apologies, but doesn't that do the opposite of what we want?
>
> Documentation/crypto/architecture.rst says:
>
>         The mask flag restricts the type of cipher. The only allowed flag=
 is
>         CRYPTO_ALG_ASYNC to restrict the cipher lookup function to
>         asynchronous ciphers. Usually, a caller provides a 0 for the mask
>         flag.
>
> Don't we want only synchronous ciphers?

This suggestion originally came from Herbert, but when I checked it, I
missed that note and just looked at the code at crypto/api.c:71:

71         if ((q->cra_flags ^ type) & mask)
  1             continue;

crypto_alloc_sync_aead does the same thing at L212 in aead.c.

So the bit mask should filter the way we want, despite the
documentation's implication.  Perhaps we should separately update that
line in the docs to be more clear about filter and how to properly use
it.

Thanks,
Mike

