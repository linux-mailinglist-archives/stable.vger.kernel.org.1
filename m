Return-Path: <stable+bounces-242618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAaNH5g69mnFTAIAu9opvQ
	(envelope-from <stable+bounces-242618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 19:55:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A3D4B31E4
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 19:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2651E3002F5A
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9B38758A;
	Sat,  2 May 2026 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIgwAhY/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981933F38A
	for <stable@vger.kernel.org>; Sat,  2 May 2026 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777744521; cv=pass; b=dioaFxYhSXzm6IYutF1oB1RcHftBT8c3eOxF/UKH+3WcgwkevPzrnAEnKuzQFAXNrUb5Mtvwxx7Rjk6haBGra3GyY1zZqDY8Gqby0qrnj//dzYKfaaoIt/9NlIy9k/gDZg2z1d57qADJbAxJzRsgSlFUyXV1bV2ZTN5CfiMS3s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777744521; c=relaxed/simple;
	bh=P4J4SDo4bzmgeVa6s8Us9qEytCzNnqhMvTPTIrQiETs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdKjUck+Lz++kwoIkuyWaSadSZq7MnubqM3W3kcQl22YgtSR10vhJdD4TID5ULi47LKV6DySNaRHvVFigeaaOK1iVrO2N/K92Hx0s+DX+Z45tkVEFZ1Rr27HE6Qrk3zrIqgWr8ACwHM4ltF238IT3IF8kUe3blEmmMjgCh2rKYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIgwAhY/; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-799001d73bdso26742757b3.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 10:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777744519; cv=none;
        d=google.com; s=arc-20240605;
        b=TOUmEQZgyFSEhK7eqxSt9Nf7qDhbKFISFMKtlZmOXMle72J9p9qYuJrCoOrjnqTDK3
         WCqjrdws3jTkAlf8Nf84wuUrE8/SzRKPWvGrUpqoQbnKdxvZIJkoDmcMfPkmYWCsrUCv
         BnQ7XwLnZ6UeFPcLqfEAQJs3gBBwf4cXzl4hXiLXKsDGVeI8NWP52QjXjMeP5ZhHz92X
         GUTm0Anc0KMJKeuQSWzb9RvzlJRcmmsT26BLqqdq6GF7uxT7TyBDHjFi78llHSNl46x2
         lA5HjuWdTTWp+4sActz8IjpF+AQ2As6GwiJufmj+uZfCZYVUDawNJHtXQjiTMkJD2Db1
         W6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ev8IyTTMLXaZuuXCFyPzvb/PhlVdfC1G8D4cNo2j91Q=;
        fh=QxF/KhJFNZccjRVemiIk6B3onRiUARnia5Ci7DIYhbI=;
        b=OrsN2Y3ouyxiGbbbXKCsRucoxRvZTg1SsYi0wh+hoEZp4mtU3RHuOmzpFMaiwOlEH5
         8ySsfz9GeLh+QVHhRn4BkmViQN47IOTGrHXN98U56pckeTWMr/Q8vjNgBRz7/Apjp5DX
         +hBePVzWQaWw1obuSrwCnS3o5+IEXy5O2kOnkdEtydEeq/e/xH1QQ9JqKhUf7udX23/T
         qvhnGZmezFWoVt+nbb39ZkaxpPf0xRaSzvP+qNU4YEaoXvS+rmfkfdoMePS9atxfiatd
         aU0Xn48RXlyKQebIcFqoSr7qZn0N6P/uoDAUh652r4Od+mexWcnP4CvEFbEqYji4bgtP
         CtOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777744519; x=1778349319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev8IyTTMLXaZuuXCFyPzvb/PhlVdfC1G8D4cNo2j91Q=;
        b=eIgwAhY/WzgzBkB1p7AgOtAnL4n3I/skKY9cCMgXx43iBKzDNzcoqoE+wVkJCKmLF5
         dBWlpGyHGFhsbOAzkujQyoEj2Ip7Pket30ocwsXwN9VHS3IqX1X3WWqeBzUgUnTccWhI
         54SWktZVVsQrU6cofGMwqjjlymRQkPXSSMbWU0z3D/LJMRX27Hxt+Ka1ncdvD/ocxP0p
         F5tlFhE2EUxWsFIOCimrZF5gzZdcmfVew+5X3fi6di8Hgk5C39Vxk/MPcKiAZI4FC67m
         1DzaN4BL1OKBX+TCenZHCJb2sn2KCR+xWdxZgVSZ8PGKhr24HcZ5/XSKTC6A4Vy/nRkN
         zwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777744519; x=1778349319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ev8IyTTMLXaZuuXCFyPzvb/PhlVdfC1G8D4cNo2j91Q=;
        b=Uo9j28hwnRKfWXQWr6W9p2rUksNJY+mHQBTs5lC4pHkHZSX4GihVfrC0ofT8YeG9u9
         Eo+OaAuB5xUipAvPWc9zplLk0ddmiOqWoLqbMnRfCNEffkVOWQg0VcxoDcm2yXSTxBRG
         Ye1kDwkoinGNVe/+5XxRWRGUWW4J8bAYHefybAyRiZsCZGjYqqjAnsMV/nv9m0lfzLLx
         Yr9jCBH6rNiT3m7iidLW0+PrUJlSSmcaZNXQkXm4k/GHwwSpHmjYaqeH0U+SDsuaJtgm
         UuVtMmFubjRz4929nD9UxurZWhCC45DJo7fN/Jw40hMPHZixm6eT6cYbs68f+yT4R3gb
         oBSA==
X-Forwarded-Encrypted: i=1; AFNElJ+Qq+8t9gUtASGJXTK/krYeR1FrKH00Gef2rAKRYL5/JnE/Rue8Ary3Kz6NoYCA8a8anPFEMcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2vPgiDBZ4Gffflr5a/abZQJchpb66XXlfX7FYGrX7WC0CsGK
	EmJpuJXs14v5pHjXppH7Y5WZkrBzkuCjBZPmt9SQSMq6DPO6vBBP1ie0k7sCDls9NDe2iLWIkXp
	wgKb/PXjP4h5iNdGczxuo1ZbQ9ZI9BYw=
X-Gm-Gg: AeBDiespHKrxJbUvqyHn7dbe0Mp8k+LtpmaMuMy1/hYbRm6Kpi6deZRiq52BLATMfG2
	24vzLutwAbq0Ug4Xmuq5Fq2y54lx0DBCmT6N2i+C9P2u1Icx+ZcxDOQgIFy5Aypu6CbX3Rbbr5U
	PQHCYDG6I2/aqzDrLHqbzWwb7yYV1C5RWvTOOMfYnCIfm/BJE1gM/cz7qAhfhRjLDueGVLhzkQ5
	BlZCvjbydpTu8ZCLEvo3jZToNtodAVLK32H2sT9ZV+wNRxEW3QB9CdW1wp85hOriUrnsPPCRWBz
	WPH8mD3bJjTcnElB6574IIj1ZicFXVciGjA42+nMwaxU6YilUqjV6WIBGQ==
X-Received: by 2002:a05:690c:dd3:b0:7af:6904:3f3f with SMTP id
 00721157ae682-7bd77170409mr36446997b3.45.1777744519382; Sat, 02 May 2026
 10:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415032335.2826412-1-michael.bommarito@gmail.com>
 <20260415045246.GR3552@black.igk.intel.com> <20260415123221.225149-1-michael.bommarito@gmail.com>
 <20260415123221.225149-2-michael.bommarito@gmail.com> <20260427053537.GK557136@black.igk.intel.com>
In-Reply-To: <20260427053537.GK557136@black.igk.intel.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 2 May 2026 13:55:08 -0400
X-Gm-Features: AVHnY4L_1u4kS3SyeJ9fEQk3Eh0AKAKdWXFllmXlsTxskd_CuDXnT1HZk0Q5VCs
Message-ID: <CAJJ9bXy1PaWs_x=8sbFUR+MPCrctPhCM8kLjftRNHy2Scb8Mhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] thunderbolt: property: reject u32 wrap in tb_property_entry_valid()
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Mika Westerberg <westeri@kernel.org>, 
	Andreas Noever <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 70A3D4B31E4
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
	TAGGED_FROM(0.00)[bounces-242618-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 1:35=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> I was about to apply these but noticed few stylistic issues so can you fi=
x
> those and send v3?
>
> On Wed, Apr 15, 2026 at 08:32:17AM -0400, Michael Bommarito wrote:
> > entry->value is u32 and entry->length is u16; the sum is performed in
> > u32 and wraps.  A malicious XDomain peer can pick
> > value =3D 0xFFFFFF00, length =3D 0x100 so the sum 0x100000000 wraps to =
0
>
> It's 0xffffff00 (e.g lower case).
>
> Ditto everywhere.

Sure, sorry for the slow turnaround.  Coming shortly.

Thanks,
Mike Bommarito

