Return-Path: <stable+bounces-219718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMduBd9un2mZbwQAu9opvQ
	(envelope-from <stable+bounces-219718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:51:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CF19E0A2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D27193033BDE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB089304BB8;
	Wed, 25 Feb 2026 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P43otrSv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1B3164A5
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056284; cv=pass; b=VdS7HwAOpS8YOWW2OHdY1HVC/jfCyK5LZurcCPmeem5jwGFlksJoO5uwGtZvlLP7u05EcPNtSp91q2Tok9fN+Kx1QXekKZ+JWYA250r6NRcZdSM2YRgUGL/4+ExJP3T16J8MOLCdxZB6tuFM8kLTxdeKVvsiwS1QhhMX3BR6zMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056284; c=relaxed/simple;
	bh=9wmdx/Cbf+zEgxaJBqjHZqb6Npzxn97ZXSNHZYWGgIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHVDFKcEspLbWwpr4erMrcgzi3fPWFJIosG2Q24D+fbB38y9XCy/KZxpkpxyxEaWbqqnjTI1CBubdQJUpU9S9osfogN3oGrV+AA7m0yONudJUihmcLQ9jFW3zWnU0/E7Idxb30faAenOxTGMbuPhsxwB7Igbvi8up/9HyNCieRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P43otrSv; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1270f10a774so763c88.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:51:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772056282; cv=none;
        d=google.com; s=arc-20240605;
        b=G6CNCStuiqhOu79qyExWUOJ2H7gbxXPJXWvzVaz6DwcKZA2xulFuUnaijgQ4DSLcYf
         7XgZsbv1TiBfx+fWY63svdhJyFtduWptUnO/6e3u+L1i9zI1C+5w1IxumK6prSVbDFyh
         /1zZWBW3Dx3UDulZm+eoO+Ds8kqs/+nwfdbpVxdZqJLJ41OJ2m1g5cF2QiZCNTeYKBgr
         vu3XH16vpIzkqOAjqnZDirkhhNExZSypTgENUyvZpT3V5l8X61dimQjsLSfAeSIDl6hZ
         p9SsMZ/INDpNphiKhFwh11z+6nCG9+FF+XmJjt33+M/Ns58hOxFT1V3ZTjLGtqAXtNJJ
         KlDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9wmdx/Cbf+zEgxaJBqjHZqb6Npzxn97ZXSNHZYWGgIk=;
        fh=mgV6e3CGk6Kp2bnSwS+nWpFnApI4T+1ZWf2jVKp2kLo=;
        b=OZ5Pcax9ZwxlybsGRzFnVzXFR/Qgz70frGxFGfa3vB46wggvO333XHjJMbfZb/AqKG
         lTjtETtDjr2YFGm+R5/AuJT/wo9oIuTXM8rVk+nDT2bIk9zVxEeo/hQTuwZH3BJA6GcL
         wI2L1Yvx9l/oAXm9C1ItdWdc9yQvdSpvWAh38WqfD7eORTEWdlDrRDcTemX7aND8SRtA
         i511YCL6OYT0ppiuUVlVwl0D8IJkH4TErUJR0VyjBGdpjigcdhUJEIL4ClepqRHEhg+3
         NiqS/JeBiOP4GqDDGaqVG4VbscaE4IR8/imB1mN54RlbkPuJ98N98Cr1eZFTu9xwzB7d
         8zrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772056282; x=1772661082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wmdx/Cbf+zEgxaJBqjHZqb6Npzxn97ZXSNHZYWGgIk=;
        b=P43otrSvKxXtd5vcd7JrcW/gkGwLgDXN5pNyKKZynBw+8p50gDy34m6MpXkqtahGUy
         ziJ/IbIDx6a9zPEO8MnbjySapRsEikdtL69AXGaWAy46REYHHSWIHupXhi1BzEmNSpdu
         geLZCruCib0GPm7qaWlw5DR1T4+OPfZo8d6uqPD1wbRsAlQF8A6LCdAYV6Y+flS792sp
         UByfgznJ/x59LNmBhWTCfrgdGH1zPx9gfbwji+Ro9VrPVH7nDrj8Ds7+OQBdHlmdkw7J
         d9cGGdwjMCO9Ovo+YX/UdlCDbJlOlREIQyLaOnAA13weWyILARWmN09Ry4WgkEXQQ9Tp
         91cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772056282; x=1772661082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9wmdx/Cbf+zEgxaJBqjHZqb6Npzxn97ZXSNHZYWGgIk=;
        b=ZKizgGvLRtaZ1Q8dVovqx/eE9mRabgXdzSTIEMlB9DHfrUxR89gevcDge51PHJkul8
         VxIugSTxUr36w3t/7dLw515/uOqOGbtmN23C1+OLqsffkjIRqdi4UfKYYAA46MH5ACD3
         7HddR345QnmDqfrXYMRj/l4vEXa+IGGa7fmvMyF1e+oPiHerepIhde50ubYHNDn6Epgu
         PJKhdD+1q+w2P7q092FgGH0H3Nm06PmM65gC4wddfCNRWBdGvLlH7PtpX9Gkb7Xehpg4
         jhLnI42SIVuXJqKlKuzRoIEkpz6eVthMpKSptdtEfu7HBAJclZMNrfkEqJ1pcegGmfCZ
         kisQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0y8x0OBawZFF8VAeWcDF8/0NcignFL5+TPDRJa3WzzR6kIpxUwmZmTutrtxNoB5r1AZRuR9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdUtcfhghPKQi9U3uAMNyXyur/j0O9WcSVy4C4LRPuoxLv9N+
	9nxoJ+zacOfp5hEqgujsDhzBSFhLNDBffGykDonbwpx2y1hOhssfiPnJvRyhLgBiyXcJmq2Wt0u
	uLDdh+4Kc2HShG0k1cMYKt6huYiuPKQOKhcpUBfyh
X-Gm-Gg: ATEYQzyBbhibCOb2wMjzGo97RewWfOeUuB29QtYdwHp078xClVxZQX6Xgj5jZ4jtthR
	UIWtoB1G0P7hvwpekXCjgRC5GTaonB1kYIyYwS9l1uEo3R8psa5V+RCHJN7tz5cyk1rXzCEVECp
	Jk9xVHoSwQ+qKJN5TH6D2bUGavopcQiPgl1uJzeZAMe1ez/+BpyxD0aEQKl2spl2RlyvQnRfn0u
	eiiOiRb+if3ADbH0YXSPgiaN2KyoKb+z1e+Pa6ATKH+uy6kaiMOaI9t4fqRCZNQQdN+EUIXbIbl
	F5/KE0IA
X-Received: by 2002:a05:7022:ec8:b0:119:e56b:c1e1 with SMTP id
 a92af1059eb24-12788f977c9mr37575c88.12.1772056281815; Wed, 25 Feb 2026
 13:51:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225002434.2953895-1-axelrasmussen@google.com> <aZ9OEAzENzeFYDB2@cmpxchg.org>
In-Reply-To: <aZ9OEAzENzeFYDB2@cmpxchg.org>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Wed, 25 Feb 2026 13:50:45 -0800
X-Gm-Features: AaiRm518g2bV4iY9cTGSGtmK5Kp_ChUfHNXuOPyWbieDNcE5Q59_QUJZq_8Lm6Y
Message-ID: <CAJHvVcjnSc16wtYrCt8i+UFUmGzoAwKXoB8CGMLwz4NEG32QnQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "ptdesc: remove references to folios from
 __pagetable_ctor() and pagetable_dtor()"
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219718-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axelrasmussen@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Queue-Id: AE6CF19E0A2
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:31=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Feb 24, 2026 at 04:24:34PM -0800, Axel Rasmussen wrote:
> > This change swapped out mod_node_page_state for lruvec_stat_add_folio.
> > But, these two APIs are not interchangeable: the lruvec version also
> > increments memcg stats, in addition to "global" pgdat stats.
> >
> > So after this change, the "pagetables" memcg stat in memory.stat always
> > yields "0", which is a userspace visible regression.
> >
> > I tried to look for a refactor where we add a variant of
> > lruvec_stat_mod_folio which takes a pgdat and a memcg instead of a
> > folio, to try to adhere to the spirit of the original patch. But at the
> > end of the day this just means we have to call
> > folio_memcg(ptdesc_folio(ptdesc)) anyway, which doesn't really
> > accomplish much.
> >
> > This regression is visible in master as well as 6.18 stable, so CC
> > stable too.
> >
> > Fixes: f0c92726e89f ("ptdesc: remove references to folios from __pageta=
ble_ctor() and pagetable_dtor()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Willy's cleanup proposal looks good to me too, but this is more
> straight forward to backport to stable.

Thanks all for taking a look! I feel similarly, the other series looks
reasonable (modulo a couple of fixups pointed out in the other
thread), but at least for 6.18 / stable I would mildly prefer to just
do the simpler thing and put the status quo back. (Especially since
the other approach needs a bit more tweaking.)

