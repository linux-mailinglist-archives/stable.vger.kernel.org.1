Return-Path: <stable+bounces-240981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCtNMfR762npNAAAu9opvQ
	(envelope-from <stable+bounces-240981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:19:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2900B4601A8
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4677E30125C2
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2313DC4A2;
	Fri, 24 Apr 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aujSue9d"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EC83C3439
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040242; cv=pass; b=MZ5bghY5myWsrwIui7GEjuEFLxX37uDs2j4wjVNEpjQyw3xx5qrGJzD84nRkvup7fdeVNhZH/dNmEuaujzKupZzD8L1YNKKXd6jbiGvjVF/DENVac4auNPymUMK9H3VRUnIiunUGhM51xYGk7hQH4bDACDoJXHQvixyd+oHgkXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040242; c=relaxed/simple;
	bh=JVJy+nXdugt4xD+J83pQi2aCdw7maFhtvnyAdoRkUro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCK3ygRMb8GTrr2xQfGEQm2aLmtKeTkra+YQCz2g0vd2Qrg3U65O40rPt4H4ediS0tzc0CFPcd7QJOCd/CMdZJCNfwQo9RtVEXJIPEWcfP/CH7iLgIBNWD9qiBnr/hDEif4ci93biEvU8sXh1neNhePTdKcQpMpQMBTESDLSzA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aujSue9d; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40423dbe98bso3464340fac.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 07:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777040240; cv=none;
        d=google.com; s=arc-20240605;
        b=D0nWv7BYj+doPmrpP5xw/fbDhxYYd8zvLGY9kWaQeSkwQcfwgNA9P3Wp8+0qgbDipf
         G/ZUeNYG/tzM3BZo7C/7nAPPCTSdIsest17II0aZFb8gtpnoYKfQFLaugiOiDmndicCC
         ARXedX7eUGImQ5n0IHB9SN8uTHeeFgk7dm626qUsU24toGl7XFXGHf4f7G6IoiAIGwAu
         cugy74m4zveXdEXSwvSU9JJzwXnHJ0KI+Y4F2Zpxc9TwUjqAZLRahofy1bJw3+zkZsBe
         2h80wowcrgJzug5acJChm5MgjXUxo2UYbMcvHWC3WYSrj+oKxVVMJJf2FHNVKFAs01Lq
         BV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JVJy+nXdugt4xD+J83pQi2aCdw7maFhtvnyAdoRkUro=;
        fh=AfGfhZaPv7kB9RUSPSZvMnvkwgoJDdQ3GSQroJ6TZZA=;
        b=Aw1SmzKZOGfcCqkWNnHJFh957znuIlBV/zCu/wBLFZSQL1hSdIYIlYSfNyWBEpE/uc
         MVcdMNz+WIUawRIM8AOoyaFjnOeIFQCxlsr2Wk742PclDiR1YVk/I1xIX7jph1svg5hg
         VJVZYSKXGLH4bdK2bQnuuM5reUep398XP68fhUV6gCT+dm3vXvXYflsCX/MUPE5JLZB6
         WNoOsJUQ9Xj3TNwBN3YJgGW7fShYqFKHkfmnoX8/DQuW2WAhQ1O7lMt95SZHKGW3HatV
         QGxMat7uf1obxlqyFAUn/D1Fnhibyf8Lvzdh+aa9KZstmZT75VHRwXPOtJWTGC1rMMSP
         1iuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777040240; x=1777645040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVJy+nXdugt4xD+J83pQi2aCdw7maFhtvnyAdoRkUro=;
        b=aujSue9do2S5FZgUPDfgY1kZNvlfaq/8utYXTtGnaX/z/rF7xUxxK+tgp29Y8Nk2Md
         BPGg6mTFjQmOLkw24OBuuoHFMmLhyyakDJb37jA5UN63Om1zfUbTSHStOrm5LSvDBq0P
         wSqeCnn7JvwxIMB1hCderLThLonb+unwKoLdUu1yczSSvZ+WLILKx/cyBm7At65A1s5m
         jeIfB0fYMJyRC+f5xzbR7f16tjIMHG2sCFN//De1/TDM/jpvhUjT8Me4vgdAFbzgV+uJ
         9iZg6gazsdyNdkfpZTy3eeXKHxulqflnbofstWdtv9Y036cS05+TEMMPvGaXuDwQh2E9
         kx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777040240; x=1777645040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVJy+nXdugt4xD+J83pQi2aCdw7maFhtvnyAdoRkUro=;
        b=IASWIE+RASuWJYvimDfmfGwL79BiJKxPx6+ShZqPpU7HRWR3piDItVBSLjOnJ6Oi4j
         Qq1OKWGkiTgdHkw4tOWs8R/pc6BHUiqQ3zAfPbvwHDwgKQx1JtgjBDgx7ZKekpUIqNwI
         LMfVINs1ovu05FHpdLUTzJ8QB21ArvoW3jSSYVN3aynkBopFAGJzIkVa0CfVXL+45oJf
         gdpV7RmoS33op82ItH5Obcroj8s6wL3oY+dUREGTlFJu9noO645xZaVwqvnAmMsDtwts
         Z9HEsQA7MoeHSGSdDMNAD/XJcXUpSHBdoKEUpWyiFghA9+Y5oFPCzYqKn/aDxTaTXr4V
         a4yg==
X-Forwarded-Encrypted: i=1; AFNElJ8G/RDDQSiF++3txK7t4mS52VJ5ROmk+dSoOlnnsJWT9gC7/+okYSabEDzBjOZD48YG+cl+vQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3PYHqXVxqk6Niisj/IMVNnmep25HUMq4d4z7EI+Q0xRGkRfUZ
	6sGxMW+Vp7lrC75HorvF4lhEYeYs+JPlIOiBt8+8zgS8BwVZHkJhD69EUc7UHT+tgVnb+PYmu2b
	C7F8aR5sD8md08HWfFQGDKPuYITjZlOM=
X-Gm-Gg: AeBDiesnCUq245PbUOXZsPfOrR9B/wHjZVxTmUShKAFe8upts4EFqOyaEsELgVz6FaI
	2DXbHw+qe19rSwvaw17Cy6pn2OWbID5F0aCxQKWd0niMFcOFa3mmF+ehrsA/RsOTTPtN2T0ZzLc
	+gayMbMXQhoVCtua61PMOpn57haHkKgrXJu/FZ6IHsWbFjmSu3e8ItTCzxfYHeJseKwRbaJpETA
	0ACbFYyxPQrzz55dmFXoUMgYu517WbYikrXuZKQ8jq0ZnaxTSFMet0+TXr3aRXaJSIMK/skuXiz
	4uPYbqXr8W4vzEcUjGc=
X-Received: by 2002:a05:6870:ec86:b0:42f:cd67:2b84 with SMTP id
 586e51a60fabf-42fcd675157mr6569859fac.9.1777040240077; Fri, 24 Apr 2026
 07:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com>
 <20260424120807.25005-1-brite.airgeddon@gmail.com> <9f7df38831598001ac6cd79ab4fb95b4b6e042fd.camel@sipsolutions.net>
In-Reply-To: <9f7df38831598001ac6cd79ab4fb95b4b6e042fd.camel@sipsolutions.net>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Fri, 24 Apr 2026 16:17:11 +0200
X-Gm-Features: AQROBzCiGQ9MNzvUQgmsOAF6TO5N4ZOZBZVCyKpjKoIGZJ9NhsHqPIW861F562o
Message-ID: <CA+bbHrUaOJgW0ZKjA5n8bnBE4wdynV9XXiyzXWxfX7NEmMZ0_g@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: restore monitor injection when coexisting
 with another VIF
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Brite <brite.airgeddon@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, fjhhz1997@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2900B4601A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240981-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Dropping? Do you mean it will not be taken into consideration?

I tested this patch thoroughly, and it works very well. I am well
aware that kernel developers are reluctant to accept anything created
by AI or LLMs, of course. But please, I think you should review the
approach and perhaps use the idea to implement it in the way you think
is most appropriate.

Brite has put a lot of effort and time into this, and both he and I
have spent a great deal of time testing everything. It has been tested
as he describes on kernel 7.0 and on the backported versions. Side
effects have been addressed, and everything is finally working well.

All we ask is that it be taken into consideration for adding a
solution upstream.

I already have a .deb package that works for me on the Linux
distribution I use, but it would be wonderful to provide a fix to the
whole community so it works for everyone. Please, I kindly ask that
you take some time to review it.

Thanks so much, as always. Kind regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El vie, 24 abr 2026 a las 15:55, Johannes Berg
(<johannes@sipsolutions.net>) escribi=C3=B3:
>
> On Sat, 2026-04-25 at 00:08 +1200, Brite wrote:
> >
> > Earlier attempts on this thread addressed the same bug but had side
> > effects - notably full VM freezes during the airgeddon evil-twin flow,
> > reported by =C3=93scar in the thread. This patch takes a different appr=
oach
> > and has not exhibited those side effects across the tested configuratio=
ns.
> >
>
> I don't believe that all this complexity is necessary, and the code
> changes have are fairly clearly LLM-created w/o such disclosures.
> Dropping.
>
> johannes

