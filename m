Return-Path: <stable+bounces-223734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNGrLc9Or2noTgIAu9opvQ
	(envelope-from <stable+bounces-223734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 23:50:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C05242630
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 23:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D2FA3034B09
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 22:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32EC279346;
	Mon,  9 Mar 2026 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aZnVk3Nn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C70A2741C9
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096651; cv=none; b=Swf6NGQP/4tiY/yT7meqkt7u/YZyEKUmpaQQxwWUwVgewE7OM3Hv4kIHfrBkD6jk3ASeegb9MPvXy5VHcQTTzYfgbAmEjMNVn4aBHhYmzz/XcN6c3fnlC/2Jt8VrjmNa+IBqhpu1LUBUb+oL5kAt8fY54R8En+AejxZrOlavHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096651; c=relaxed/simple;
	bh=8TKJPFGyMz6x6reUXbWF6dFcrVYrlsdWTfD22LmvrrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehNMRewD2EJ/WJ3x3pon3fW3NlXyr8uOlWdv+l6enqUFHCqPuEz/ht8zRLBNGHKBK1nslLO+2sEsgXozUEGyYtLxi+Q94oGN2x5r5J4Rr6+kVciloIPZF+LQXMSGLxrPkwd49W9FH2xvfKDQidNA6vxaRG7OZYPzxOL9Szvi+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aZnVk3Nn; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b966a7b1908so319661966b.1
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 15:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773096646; x=1773701446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TKJPFGyMz6x6reUXbWF6dFcrVYrlsdWTfD22LmvrrQ=;
        b=aZnVk3Nn5YwzfnUwUflsBzaENoIGWhOkXjiUdmRfW0HCRZl4D6bdnN0XvGeynohcI5
         39cbTEA+eIEwpB0PxwEDl64zCQJFnl5eiddN0g7EU1sprwFwbGwx6YSaOhyN5TaM87pI
         F2QDDvd7YFkNOGb1J5VS4o9ClDP5tnBhMPQog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773096646; x=1773701446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8TKJPFGyMz6x6reUXbWF6dFcrVYrlsdWTfD22LmvrrQ=;
        b=V5pcCaC6v2n6A6mYcBFLSYoHs7ke3A9HrkAiYSTXNObcmBRl0N7Pf5Wa81RkBFHY6X
         f+iC4uAS+D522h38YDAlXYmmWb9yUtBN9S0DuVlzwTfCzxKb/GnEULOP0DRWYiSTMzkw
         R9aXFQSGBz8RecND9essNJkPk9Nn3uEbMHHVcJKa6tx6nbeoIm+3kFT0dXbOxMfw37/c
         NxW4YjRZSst1xK8JR6aBsE018ogWMPUQP2pa0Uq2T0w+4dZ63/8LIWcGrQMUBRK3wayO
         +Z3izJpderS7oiQBpR8JU1qBsOVW/2bNc0iLkp9IWcBQ8v3vPGkCQPQel+1aZpuvwleV
         HX3w==
X-Gm-Message-State: AOJu0YzWM4Nj3i1DmyL5BcHGYiQemSBxg0ZaNBxXtojI0VQ+0bwVgn4D
	ViZ2XKXFVJADuwEZqFquvwL9wHxcLrAaQB1NGX7XW0RcC3UXCN7md1H6iL59BJizB2+eiZzr3Kq
	+KTlqxrvu
X-Gm-Gg: ATEYQzykFGC8gIrekHBjS3Mpn7jqFK2PSvlegkSLt54BlO9CSwzSx9HvqIV7z6Q2uov
	6A+n0DTlZJvmJOfRFb/+pFbd+A6/80+0WoK447AGLXHhgxjzsB1RogqHKLW6eaWJObCCZ/lEoA7
	dDfQgA/27zBRmDyQj2iAT1DdocIMc2egxE8yM5n0V7fX1P2tTsx82EZ0n7dID8TH01rlQYvcN9K
	f/1UHLeTNlVdoi0pvHsZsIgEWU72Apl34vsDwVxmKi2VhjYU5Jts+hvcvSEsDNQIxNCR8KEwqa5
	PxKlfPHsMnU9M11K8STGfYRPqEqSSRjU7P1pFdNkPZuXDic4FJHyChRFB31eq+mB6inOKt6v1ym
	qd5fSer+9+rLoGMtkTisXguKNFYwB9Ye2hz96yvD1+l+byf4RPpq3jOGk25+08oMF9jLMD+YTPl
	lyuzzhDp58WeBKmBaF7zM5HmLNzyI9vBi+0gZU7flpiId0Bfk4sLoHrLjLd7Ls9g==
X-Received: by 2002:a17:907:2daa:b0:b92:7cc:2776 with SMTP id a640c23a62f3a-b942df7e327mr765763566b.31.1773096646337;
        Mon, 09 Mar 2026 15:50:46 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-661a3c66f17sm3704657a12.5.2026.03.09.15.50.45
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 15:50:45 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b2965d4bso7115900f8f.2
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 15:50:45 -0700 (PDT)
X-Received: by 2002:a05:6000:2204:b0:439:ae3a:cf52 with SMTP id
 ffacd0b85a97d-439da35c0a1mr22006048f8f.22.1773096644662; Mon, 09 Mar 2026
 15:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301012249.1679321-1-sashal@kernel.org> <CAD=FV=XAGzoRaA2bFT3X=eqiMR93pSUkXyTQk6euzhUR+fUY9w@mail.gmail.com>
In-Reply-To: <CAD=FV=XAGzoRaA2bFT3X=eqiMR93pSUkXyTQk6euzhUR+fUY9w@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 9 Mar 2026 15:50:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XpJE-UkJEH9QrKA3P10h70=+vDuF6gc9xmZroyYKzx9g@mail.gmail.com>
X-Gm-Features: AaiRm527l2RjswF_v6m-_kV1JUPC04GvbqMpV6XbhaDVDv6Ic-DwwvP5_zGPrOA
Message-ID: <CAD=FV=XpJE-UkJEH9QrKA3P10h70=+vDuF6gc9xmZroyYKzx9g@mail.gmail.com>
Subject: Re: FAILED: Patch "mfd: core: Add locking around 'mfd_of_node_list'"
 failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 09C05242630
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-223734-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,chromium.org:dkim,chromium.org:email]
X-Rspamd-Action: no action

Hi,

On Sun, Mar 1, 2026 at 7:01=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Sasha,
>
> On Sat, Feb 28, 2026 at 5:22=E2=80=AFPM Sasha Levin <sashal@kernel.org> w=
rote:
> >
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > Thanks,
> > Sasha
> >
> > ------------------ original commit in Linus's tree ------------------
> >
> > From 20117c92bcf9c11afd64d7481d8f94fdf410726e Mon Sep 17 00:00:00 2001
> > From: Douglas Anderson <dianders@chromium.org>
> > Date: Wed, 10 Dec 2025 11:30:03 -0800
> > Subject: [PATCH] mfd: core: Add locking around 'mfd_of_node_list'
>
> Can you give any more details? I tried:
>
> git checkout v6.12.74
> git cherry-pick 20117c92bcf9 # ("mfd: core: Add locking around
> 'mfd_of_node_list'")
>
> It seems to apply all the way back to 6.1 cleanly. NOTE: I didn't try
> building with those older kernels. I can try if need be.
>
> -Doug

FWIW, I checked and v6.12.76 has the patch. So does the top of the 6.6
and 6.1 stable trees. So I guess this was a false positive report?
...or maybe you tried to apply it twice?

If someone wants this on 5.15, I think it's as easy as picking up
commit 8e88c61d6f34 ("mfd: core: Delete corresponding OF node entries
from list on MFD removal") as a stable dep.

If someone wants this on 5.10, we might need some extra backporting...
If someone is truly interested, let me know.

-Doug

