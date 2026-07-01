Return-Path: <stable+bounces-270199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qy7+CAU0RWqM8goAu9opvQ
	(envelope-from <stable+bounces-270199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 17:36:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7542E6EF4FC
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 17:36:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="S/RC+3rd";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270199-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270199-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30FD530C633C
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016E448C405;
	Wed,  1 Jul 2026 15:31:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308A5480968
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 15:31:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919878; cv=pass; b=bnoeCq6f76Oiy88CMe7WxQEh3y7p5sefwKtrTLBqrMlBll/rVC/E3afWm5KTxiY5UXQhnmp7gQ+6YaLs7WLRK3CROqXrolW2iJlqo6uFwpAgi3v24i9sm13H0ezbnm+1GulD51Ejw/1y9qQ50t/Cjn+Z8b5m2Khix5P5Y6KKUOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919878; c=relaxed/simple;
	bh=55lo0aofODQs02uG9VovT0wfddIORdq11yOlKOcVWUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFWyPL32al71mPXxbMqEXQptV40QZUjJm1wfoncZexYSiRXKxrquFrVRBYAqQYx0J4RX5VlwtTF1sGOQ7yOFyR2lCmtaR4jNDJgzj4QqMNnWX1fbViZr56YqJVYC+MBM8zWW/zPuaoou74l8u3WCdK+rexiwlUCavSTtV6FevDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/RC+3rd; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c15a5b265so296121cf.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 08:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782919876; cv=none;
        d=google.com; s=arc-20260327;
        b=VG23Jggi8yq34APleOX77UslAfEt+j0IvqtSEdEcLZRs7Ey1KOxB1iMLZ9NLTgm1t3
         VGmNDklP08LbTmR/5cTf0kN/2w0B9H6qPvkvIvwii38Antw/7FuC8K+/NkSY8Wcf2SHD
         884+YP9ysUDFX0C1prDC3kk8+Jk48LtHVnq8VWEtLNGhb7wOK0t7TJn/n3h47qcR4b7F
         17Pn//vSxukkKb9RWmer8pObH8QaN3gksJpI9mgjhlYNvJfte+cwGrl50vhTMF6e/25Q
         aW0m/UOach3SkiAXDTtaYGYIteaKHrYwwburypH5VDTgyrh2VjHvtP4GzGpe/SqkfNFa
         G6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=55lo0aofODQs02uG9VovT0wfddIORdq11yOlKOcVWUc=;
        fh=xpgwH7mvUYk9no5FYZDxt3AJsgXTYvs/8ngf95St7ps=;
        b=cw6TIBFF6gG4Id36yxJc5txWSA0Ag5eHX/jJCt6pP5kHL3V23N4hHtvhnZJMn0S34v
         IWWOgfmsLlH8Z9GA7DnBbrMMOStGFUaRcEI5LxWuAenZDgi3G98VG/oyGfHoqukGQ7mv
         T/sZC+3vka0jQ4AOiNalQv2GoFFJ9cMHMpdK561MFwbCh6z6G20llodu0ALKuR8SYUiK
         PEl/vg/Y9743JUl0lMRGNanXF4ZZk08XfCDmCh1B/M8bGzcvA5KrxCTrZEyfOruIAKvH
         4wl9fXEhAve0hDxwQiWn8vZpe8icx0dTt5Sick186B9tkjhnRg2DpnWQamgTdbuFlaPA
         RW6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782919876; x=1783524676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=55lo0aofODQs02uG9VovT0wfddIORdq11yOlKOcVWUc=;
        b=S/RC+3rdOTz5ony3l/rAMxYRD2clYoAWWjtHoQnE1y4h2S9/GkKY5sjpwHwvFxJbmE
         VfTQrfGLspEXTDlZDwjA3smJDccuJ/nz9itI2ZRTmgrhEOehhu5bxvsICoe7FYx283Tn
         7IFz1EBIjyHu6OVnu+AkXPi8Wc0AByr9o6TLCLogQ0TiAYl9ezgar1OL3UgTF4h41ac/
         M0U5TXnOruhQG06yPqWVwlmdkG+BdhYkXyvxQOP5zklS9fefbTbKj0/lO6mK6dERyUpg
         jmLpQwEa7Z4Wqi4Wl66I6UHgpemDjXZUNAndRW6ELxeaACKawpAJpNBUjNJb3ytibMkg
         oXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782919876; x=1783524676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=55lo0aofODQs02uG9VovT0wfddIORdq11yOlKOcVWUc=;
        b=ozrRvSQgh/uPCyJCzR2Aboyp5jWMmfB+Sr7TUVokt6KFLJ9SrEhwyJRKDxTaAa2SQ1
         o5hJG2cQtVs1QoTjwhsUQDaRuk7Ie13CeYDgMIkB29W3b1jhdolFvx/6X0xKo1vjgpA0
         VpTZ/yKvbLhi0LquzfFvAeSCZQd9rZcDSY3sXzj+knzAKnzHbyZh9zTpOQxg61h/gcYb
         jMUifuq3OfsyLpsqYKAf1hF/u2GsQeZYzn5C5yZL93wzoGMNwwb9926KZnNvlRx8CFzH
         Mew8DIhw45FrvOB9hZgJFKvjdxZPOHJ/ZVVdyv9Dsc/M5gEjZFqZR0bXw7vhG3IgkRfa
         DaRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dO0pKDINdaH72Jw8wnEbXATYTNz7XNiS5fzELD37kXzl26UEm661ds6L/sIgbAEyv8svDJsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExsTECXAKlpymC/GN3bYgLxCRledHZpZsew1Y+pVKKLJBzeiQ
	hSlV3FDN+lgnI1rCHrw0FBiT3zkXDMjWbmvnz2f/knYM8YBYcHwfDp8h7hpeBqyn7890RHxR+8B
	BboEJOpRpJDTz77+Zegt3eqT1Zvj7t3AISGhYZyrg
X-Gm-Gg: AfdE7cmvhZtK3ypRpYdVx49dwJRcyAqNntcjusd2Rbel1n4Fplu3rPVxSgk6k7Gd1U6
	XfVAKvLQpN5UcXINOgbNZEwP0NKSCO4fIynsROiI03VjkROoR0NJm5M+nkRf7cMXJRJwUASWiIV
	a43pSv1siRUZhg8AeK/etIuACf9Q0d5NFrD/ARK9YT1ywcTfyxIhaieu4GXS/C779xDcmw/N3hc
	BFTqKPDnh6YLx0joEvMB2Oos5COsAfJasVfHz7OdZXYJ/bdOTTvGPjWVfc+HI6gjPfkRUPc/hmR
	g4R7
X-Received: by 2002:a05:622a:1489:b0:51c:289:6979 with SMTP id
 d75a77b69052e-51c24ad22dbmr7660531cf.21.1782919875291; Wed, 01 Jul 2026
 08:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-arm32-cfi-bug-v3-1-e3c37e2b80a4@kernel.org>
 <akT1lr2iNzbnGEzH@shell.armlinux.org.uk> <CAD++jL=_j69pFuM+vv-8Q7x4VA=PUX8iV1Yfw4YkdxGDFo9D1g@mail.gmail.com>
In-Reply-To: <CAD++jL=_j69pFuM+vv-8Q7x4VA=PUX8iV1Yfw4YkdxGDFo9D1g@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 1 Jul 2026 08:30:38 -0700
X-Gm-Features: AVVi8CccdFxYQjLQCTfyDOXy92KNPnmhAMyQo3FP3svHlBkgrYYSxYCe2kFFN_Q
Message-ID: <CABCJKufpj8LiSYtkSS=oCJqt+gW=tY5yFTyWr7KP4iLUzxiO4g@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: breakpoint: CFI breakpoints only on demand
To: Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <kees@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	slipher <slipher@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270199-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:linux@armlinux.org.uk,m:nathan@kernel.org,m:kees@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:slipher@protonmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[samitolvanen@google.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,kernel.org,lists.infradead.org,vger.kernel.org,protonmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samitolvanen@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,armlinux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7542E6EF4FC

On Wed, Jul 1, 2026 at 5:50=E2=80=AFAM Linus Walleij <linusw@kernel.org> wr=
ote:
>
> On Wed, Jul 1, 2026 at 1:10=E2=80=AFPM Russell King <linux@armlinux.org.u=
k> wrote:
>
> > Have the LLVM compiler people responded to this bug yet? What is their
> > plan with the silly choice of BKPT usage for CFI failure?
>
> Haven't heard anything.

LLVM's generic KCFI pass uses a debug trap as an architecture-agnostic
way to trap on failure. It shouldn't be a problem to switch to
something else now that we have an ARM back-end implementation thanks
to Kees.

> My tentative plan is to follow this up with a patch to LLVM (and I guess
> then later also GCC...) to enable handling CFI faults with a read
> to the guard region at 0xffc00000 instead of using BKPT so we get a
> good old predictable segfault instead. I was thinking something like
>
> -fsanitize-kcfi-guard-region-address=3D0xffc00000
>
> My idea is that the unwinder can then see that this is caused by KCFI
> and act accordingly, but already the existing stack trace should make
> it pretty obvious what happened.
>
> It's the best I can think of at least, haven't seen any other ideas.

Note that for X86 and RISC-V the compiler emits a list of CFI trap
locations in the .kcfi_traps section (see CONFIG_ARCH_USES_CFI_TRAPS),
which the kernel uses to figure out if an exception was caused by a
CFI failure. I'm not sure if this is useful in your case, but the
plumbing is already in the compiler and could also be enabled in the
ARM implementation if needed.

Sami

