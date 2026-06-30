Return-Path: <stable+bounces-269980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7eDbGfXOQ2ptiwoAu9opvQ
	(envelope-from <stable+bounces-269980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:13:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C71136E5477
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:13:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ssx8+8uZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269980-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269980-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF69308BE8A
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE336BCC9;
	Tue, 30 Jun 2026 14:06:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771C367F58
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:06:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828366; cv=none; b=O0NnxIbULMdDwWQKC30+LpcgcX10+YPUa4kz8KWYDwUza1iEsJ141l2QbpbeZXoxUVXQuFgxSP1djol8iO2AazQSaz/5ddJBisRiDVKLlH1z711DYNOHA2V40ZkG+t0ihP2gmoBmxjN77X/qFT0prKTybf8mjhNBwyqL+vYxkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828366; c=relaxed/simple;
	bh=KZE8PERg9mDPVZNcBjLhSl+mypn89lWn+zelpMIYuqc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nI291T9cxSR71ycDBlBmPhYOhHwrdX1o1KqInII/zBB6+76sc1hTPhue37zianywu1ApKkw8vyIpP+MRYuWY0jzSq+j4x9IMCKcdHVQDvfvjRTxBVvWjB44aJAenH9bv2UmV/aFH8XwvlDyti8NgAgoQsTvMW6r8MX5F+3eTV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ssx8+8uZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8251F00A3A
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782828365;
	bh=KZE8PERg9mDPVZNcBjLhSl+mypn89lWn+zelpMIYuqc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Ssx8+8uZ0Y4OP+CEnjvqnXDa84ZyQPh7l9SD9BcsSqMV0Zn3PeIuTYVZs+Ncgw41m
	 /QOYTZlR8mmQue/AJ3/+7cs++45c7/f7YmtcL5Ys75rkpHAVJbQwRoL1pXK2RnGo7V
	 /5SFOSuQWXc/4AKwMNr426Owcb3SqgnE1NSxCq6sajfVUtuKjS6Wuo+FodGrBLawBj
	 TI2y6d6sxOxaCWtXpVkVWZq5WcIA7vxiGkMWxM3rqATwliZGTqszxsIu5JEuFaet1r
	 Cp5o4J0dSIMhyxPNv+lS1p7wKOhAfx/i2/fBvu/jmsSSMxLse4KDar47lCau+537vC
	 h7HhJ/TKQG66g==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39b030e889aso21629451fa.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:06:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrRaAo+k55hXR0etrf7Inm1b1JrU6kAhWHe1VZOXX1bDAIxndLbHSLxS2mTCqarhbRKq0W/q7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXQYETcV2vebv1FuaoR5yQ1zK2ogf9KtXJqAYoqmr1Y4q32dK
	4ZRbyhxVyv9F2v5YxLhiZRNqKM87JjqwASZyebuUgTnMgLRLGeO9u/KqoQSwhgaj+n3SCUF4neF
	EuxbCwtPK3FPs1EErJTjHdotclHMUGE3m9nAH5MdwfQ==
X-Received: by 2002:a05:651c:890:b0:396:7fa2:e090 with SMTP id
 38308e7fff4ca-39b1dfa89a6mr9139571fa.29.1782828364161; Tue, 30 Jun 2026
 07:06:04 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 07:06:03 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 07:06:03 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260626060112.2498324-4-sergio.paracuellos@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626060112.2498324-1-sergio.paracuellos@gmail.com> <20260626060112.2498324-4-sergio.paracuellos@gmail.com>
Date: Tue, 30 Jun 2026 07:06:03 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfiSePgA+Vc2GHz_5QUGZWFhnPrXPZoCV+32b9RJos5xg@mail.gmail.com>
X-Gm-Features: AVVi8CfCtJrxZdB_aayhUMnyKmkOqnmeYDZ9Pam7vPg_2SWx29HyVqbCNBbdF9M
Message-ID: <CAMRc=MfiSePgA+Vc2GHz_5QUGZWFhnPrXPZoCV+32b9RJos5xg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: mt7621: be sure IRQ domain is created before
 exposing GPIO chips
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: linusw@kernel.org, brgl@kernel.org, vicencb@gmail.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269980-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sergio.paracuellos@gmail.com,m:linusw@kernel.org,m:brgl@kernel.org,m:vicencb@gmail.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,m:linux-gpio@vger.kernel.org,m:sergioparacuellos@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C71136E5477

On Fri, 26 Jun 2026 08:01:11 +0200, Sergio Paracuellos
<sergio.paracuellos@gmail.com> said:
> Function 'mediatek_gpio_bank_probe()' registers three GPIO chips using
> 'devm_gpiochip_add_data()'. At this point, the chips become live and visible
> to consumers. However, the IRQ domain isn't allocated and set up until
> 'mt7621_gpio_irq_setup()' is called after the GPIO chips setup finishes.
> If a consumer requests a GPIO IRQ concurrently 'mt7621_gpio_to_irq()' can
> be called and pass a NULL irq domain pointer irq_create_mapping(), that can
> corrupt the mappings or cause a crash. Fix this possible problem seting up
> irq domain before GPIO chips setup is performed.
>
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: a46f2e5720f5 ("gpio: mt7621: fix interrupt banks mapping on gpio chips")
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---

Seems like sashiko still complains about this one. I'm not overly worried about
this path but since the commit's purpose was to address this very issue, do you
want to rework it further?

Bart

