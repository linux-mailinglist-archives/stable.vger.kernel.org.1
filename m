Return-Path: <stable+bounces-253979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OxQCY4lEmoNvwYAu9opvQ
	(envelope-from <stable+bounces-253979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 00:09:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ECC5C0D7F
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 00:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BA733007223
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A488C2C15B0;
	Sat, 23 May 2026 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT6oQzUd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196D222580
	for <stable@vger.kernel.org>; Sat, 23 May 2026 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779574151; cv=none; b=oFenNfEL5gK4VI+5aWITFoMG75pg1+wmNqV0KZhWGUhDlNm/lkIOksmCL4y9hNrrkQZQsIA/0TcdwnVhZmblfC6713eeiqK9KjBADgXhtgGquSpQ+de/YggR1rlDE7jWqnRPPfzFW11kEuoGDsC+q7bESH0jq7aDrnQM8D6uBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779574151; c=relaxed/simple;
	bh=FauhWCHdm3QbqR41TxQKQTmbT4QL2fekNcK4Edjc/jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYhgSsSEDIfF/S+DHJSxY0LKNUCFP7TSE+6da3kOlAHtqPIMyPKp2FxcQPNSRJ9+ZnKA3YRlZB3QOQTL3OWT0+u4xd0Qpw9E1QsBe7CROejPr3xCRgJvRxjhtRSM4OdYX+/1N+hY8JE8Lq/HV+PN2BtcLqBdFOWM8QFyIy3chrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT6oQzUd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E2C1F00A3D
	for <stable@vger.kernel.org>; Sat, 23 May 2026 22:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779574150;
	bh=UFdUeExBEjH5ijJ0zDmAfHWE+UBuwNzNMUtP3mLlz8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oT6oQzUdr5AeK/JN4DJQB/dziTq4R37qKQ5/9WM+ZEYiQgbaJPhk1h5xWwy6YbS0A
	 CKOVpY1BL79O9+ExzbeiqsLxsWdpuBm1Y7pEivSN4Z8zNm5ekXFKN9MXAxoj80BwX7
	 MMjIYznN6VPzFQbnQ0zYN5seExllUAFy6pWlYuM/Ft3ie+XC3DgW6yEA+l3vhdBgmA
	 RgojvXdOi13P024d4gJS5LjNZ4PuHwJhQ8mpv6ZsfAAAGsxE07Zs1yxVu4wSuwECkd
	 tX9z2qjhqvZUrTdJLQ7U74Y0wKumGBH5vNejSWk0/tSMAajS2rfuL0fGHbE35GHINe
	 GrdMu5pc93w9w==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a8891f0c51so8726528e87.1
        for <stable@vger.kernel.org>; Sat, 23 May 2026 15:09:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9g9EsudCDXSWHUoiNt3PROPOu370P1bHsvYn08FG6kHy2LCgFh0j+GbFeTOyjKoB0/Y271gz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3v5fRD7G5ppKEklhOx90Dj38I/ZeQQ0Rkb2i7/dxv69UE065H
	9PymxRRWamk74ke7H67bKy0IhxGWmvpxDxLC8TUeF422Df1J7jghSP4mxtHtFEC38/jVzO8g7Bs
	FQi5aEAP43Ml7tGhc9elCXtV47fkwriE=
X-Received: by 2002:a05:6512:3ca8:b0:5aa:36cf:50dc with SMTP id
 2adb3069b0e04-5aa36cf52cemr1235604e87.3.1779574148955; Sat, 23 May 2026
 15:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522211503.25219-1-kmehltretter@gmail.com>
In-Reply-To: <20260522211503.25219-1-kmehltretter@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 24 May 2026 00:08:57 +0200
X-Gmail-Original-Message-ID: <CAD++jLnhONOMn=7hG-EC_uB80nxXfAnRMuZC2xoJjf2Xzcaiuw@mail.gmail.com>
X-Gm-Features: AVHnY4Lm8j4LfVLse8nnW32OdEBydMEMB1TPyp8J7ez8zpJEa_9lBm3aqPnEUR8
Message-ID: <CAD++jLnhONOMn=7hG-EC_uB80nxXfAnRMuZC2xoJjf2Xzcaiuw@mail.gmail.com>
Subject: Re: [PATCH] ARM: entry: use byte load for KASAN VMAP stack shadow
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253979-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 14ECC5C0D7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:15=E2=80=AFPM Karl Mehltretter
<kmehltretter@gmail.com> wrote:

> Commit 44e9a3bb76e5 ("ARM: 9430/1: entry: Do a dummy read from
> VMAP shadow") added a dummy read from the KASAN VMAP stack shadow in
> __switch_to(). The read uses ldr, but KASAN shadow memory is
> byte-granular and the computed shadow address is not guaranteed to be
> word aligned.
>
> Booting the QEMU versatilepb machine with an ARM926EJ-S CPU and
> CONFIG_KASAN=3Dy, CONFIG_KASAN_VMALLOC=3Dy and CONFIG_VMAP_STACK=3Dy faul=
ts
> before init:
>
>   Unhandled fault: alignment exception (0x001) at 0xb91037f6
>   PC is at __switch_to+0x64/0x88
>
> Use ldrb for the dummy shadow access. The code only needs to fault if
> the shadow mapping is missing, so a byte load is sufficient and matches
> the granularity of KASAN shadow memory.
>
> Fixes: 44e9a3bb76e5 ("ARM: 9430/1: entry: Do a dummy read from VMAP shado=
w")
> Cc: stable@vger.kernel.org # v6.13+
> Assisted-by: Codex:gpt-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Good catch!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Please put this patch into Russell's patch tracker.

Yours,
Linus Walleij

