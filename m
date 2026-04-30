Return-Path: <stable+bounces-241971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKGCJd6s8mn/tQEAu9opvQ
	(envelope-from <stable+bounces-241971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:14:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FF549BF50
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D426300B8C5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 01:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAB92475CF;
	Thu, 30 Apr 2026 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/PNwpQ5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D878B2367D3
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777511641; cv=pass; b=eG3P28PwvYt4hepTZIyko082MWw+H4rjjsuIIQHmfJ0VSB1DLE6NwJj5bz95exUJFfQc3houHpMv8TbZwi2sp8Z2zEP1qi9GqVvaFazDnWRP6zQcFeiulImMmvEwRuTCCDrV6tsqXiSsoYLexenDNUhVX0tK016oiGTjdkcSN4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777511641; c=relaxed/simple;
	bh=tqaDce29jr/G7DRTAEhFxC4N7p1PmHs0sEj/V7P6OGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdjW4/dLdQrbJgl2IS5Yx6egVbxwHiVlLGSAVqOBgYEGpL/GjBkGqcBBQ17U88+fOOJbKG/VjAp65JHUfzAFQXozKbU6xkJ2zYOHqUH8vzIYWCfu5CA4l7dnQEOURL0PTWMxiVIaIoVnSlkYmYDlTALF9h9eNu5tT9Rqm7QU58c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/PNwpQ5; arc=pass smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8eae9229110so64008085a.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 18:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777511638; cv=none;
        d=google.com; s=arc-20240605;
        b=EbMZiSky8rKzIYWHZQXkPHciUdhc3z5WGYeGB6QwlUOaMw07pisuN/owoQb174gq7L
         aoCeZF6a0Ea5R/YUM87gkuL8v4+VB478FCRrAw0MVijIdk9VQS8ONJvTyCsMpdEH1BlQ
         l42sriZ7v9HwgwVlFMQqp2MyZvIvaLtNlgiRXB3bVuK+AtDabvwzyhJ74ItBVsDhClp1
         XLHriTTJLHS/nn0u4Hvub4tjSH/t3zZo3TzYfUSpcrxHCHjqxR35tFbFPPoB0qDoDOAe
         szqEBnnLnZAKrGPnSgUy1knd45fBR27DjXqa2L2qW7o9/rCCT1DucOzvlhKKsvzbbdN/
         0eIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SHnfzzOQ26BJPTjQzYNGFTmRJ+Hsl70GArsyqS+Zp1U=;
        fh=HFpwh4JyAtUfur3ZupbuTJ5yyYTlrZBL89DSuBYBKDs=;
        b=ACYuWt6uN6JigQ/WST9eGo8Hro/LU+5rWxPkodU05y9IuFtvEaLW3N2eTKmgFU2H0g
         AK/OKMBO3CMjNlsBXhgPosjh8bJJ+5U/XrHOcs1G1EXJJQiKvxQWS0LlKeGYzAQT6xip
         0SEqImU8v4CABTSLMcDa8CkPIbpMtOGUfuEnIZo8Hw/YVIfhJotluWk7o+/7w/guzlKz
         MTW/AwFFqkgCKQ6k8V5jCNvpDTbf8/ATT/Uz21T0DADWYskHCQtgGFAVThm0pf4LtEse
         tsOwzu4MkNUsNmA1rOgqMxRwFKkFHz6gh3ccybAbYb5/XvpmjP7Judnn2ZRlq68znhfq
         C3+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777511638; x=1778116438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHnfzzOQ26BJPTjQzYNGFTmRJ+Hsl70GArsyqS+Zp1U=;
        b=O/PNwpQ5zrqHYinmxLZo6hYQ+Gt71tWCyga2F/pWkU/AKr/XVW9OXFyJwhcLhd7joG
         Q6pPyM2J9pl4SyWpa2an2h6aciEpTdg1fBvfdGrrJ+iozenF3jHnjk0zyZi1qyFkiq5O
         zuwxv13fwWgp4QIsGuarCy/BXgldahpj0F2ccjwnVg7i9RD6P8Dgsv7pn/AlMcPCpisW
         dz6buLQIUXtMpGkIBWaiXywyQtX5Z7qTuCBnnbhR6z5EUubyBvEM8Z5fSowY+a1jjCYM
         7hhNwLu8AO/oAKivm8k4p+gEkEW2xbB54FrgQX+Mu9TTtVk04orNOUxLSlwYB2p+YffH
         epbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777511638; x=1778116438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SHnfzzOQ26BJPTjQzYNGFTmRJ+Hsl70GArsyqS+Zp1U=;
        b=rEzh5GAby+labLTuNSfCRr89jQiuknWInXX7JPAomgDJ4Mnka7wsYnTG8YqFPhsbai
         4+KSg0k4h2wClAyy7lzPmoUoDeKVsSQXoADxH9wefBNjGjI+/nAFi6G0Ix4/v/q/Wacb
         JsVWJGS8UTeks8CrVXL0Ksgwr1Iab+qt0AzO+/7mvp7PdHgXmTP92LWFWlOjWnfzrY0f
         oNbuXGjkSO8Q/kWVXhxpgObd3rNL9uBjBqAAvHaWzuqTEWDNjc1OOrXFkNiTiiTPeGS1
         Si7eoQLFaHkukcLdD00oWduCPgP3zOEALVSqndT4dN9WdVVwQgFJfT6fC3eUVBiacsWQ
         Cgag==
X-Forwarded-Encrypted: i=1; AFNElJ++dmXCBkYxHGuYTFBfjB9qqdC4PuZV3JAD8rRXWTZYMRp+CrbAOOn8MDe8GDjYzT3QZb04t30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYSJRZtFel6bEXbS6tZ3UejH5OqSY/bBvJ2zaepEAM+nm6hgA
	tcnuCWHCnAK344c/BWTuI/um7K0nNR7v8Y7aobsQZ6q+3rB9PA5umg9HQJmZ8pHBDewWm/6dUiC
	JK2UI0P4uhn0KDYdE5wJ6awSHAtvZGjk=
X-Gm-Gg: AeBDieslvw/opetMJ9LrnohngIrg4bOrkHWrmprqDqAUVMdRNcNyLq0gXCVoNuCnxt1
	H9J9tOkFnV34a8SxFlwhRt/8l3bI7LO9TWwqwqYfodnTFRMZ7jf8StV+W+m1DCwoWRprSLhJ1iD
	8iKBmMsXHgniQK1/TDE9UfoOF0deexKwRtrFqV3j1RgQvPociOhA9VPiwpP5d6Mn7/EDjOY7Lz8
	9xzo9wivhNAUPKJmSJ+f02yEeCwWYJKd7iQnezzTPJq9qXLr4GFeKR2hOY3H1ZICN9pUUl+1JSU
	a1vjtVDMhy5Ug1iI3sCG1/L9QtuHCzNiTop0C9K8ZI0/YFfI6nPC/rrPgJtk/tcr1Xo570/mQY8
	h97U=
X-Received: by 2002:a05:620a:1786:b0:8ed:e1d4:1644 with SMTP id
 af79cd13be357-8fa863df4bcmr184203285a.3.1777511638380; Wed, 29 Apr 2026
 18:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428030826.47509-1-enelsonmoore@gmail.com> <20260429175421.014bb28f@kernel.org>
In-Reply-To: <20260429175421.014bb28f@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 29 Apr 2026 18:13:46 -0700
X-Gm-Features: AVHnY4J1jUYA03pvf-5_5V3JNJphmuZu7BwnIMTt_nc9cAvdILco119uAEfpHjU
Message-ID: <CADkSEUiRwto-14zkER30WJdiQa2b+OGOZ+2S50pq4doJ37X70Q@mail.gmail.com>
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
X-Rspamd-Queue-Id: 97FF549BF50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241971-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 5:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> I'm having second thoughts about this. I'm worried users will come to
> expect that drivers are marked as BROKEN until such time that they
> can be considered a sufficiently complete replacement for an OOT /
> vendor driver. This will be highly subjective.

Hi, Jakub,

I understand your concern, but there is precedent for doing this when
the driver doesn't work at all.

The ntsync driver was marked as broken in commit f5b335dc025c ("misc:
ntsync: mark driver as "broken" to prevent from building") until it
was fully merged. The BROKEN dependency was then removed in commit
c301e1fefc2d ("ntsync: No longer depend on BROKEN.")

If it were my decision, I would remove BROKEN from this driver once it
supports a stable network connection, and perhaps also once it
survives suspends and resumes, since that is expected in modern
desktop use cases. I think that is a fairly objective reading of the
word BROKEN.

It might also be a good idea to agree on expected uses of
CONFIG_BROKEN and document them in init/Kconfig.
Currently it says:
  This option allows you to choose whether you want to try to
  compile (and fix) old drivers that haven't been updated to
  new infrastructure.
which does not fully encompass what it is used for.

Ethan

