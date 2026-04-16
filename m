Return-Path: <stable+bounces-238298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCumJcy34GmIlAAAu9opvQ
	(envelope-from <stable+bounces-238298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:19:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AF340CD68
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08253300EF79
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5872C39EF2C;
	Thu, 16 Apr 2026 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyq6HP5N"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A939DBE6
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334762; cv=pass; b=nKNiEYabDPuyjezdkI/IRiQomfbEyx/w73kBE9EBg/i5bIadvTtDjwGfnueQts0q3UmPrE+WB+oQUOFl1P2X5cg6VPD2/xoG8HC76nRI+xWUNjHmy4pYaeiKBiOZplh6QOpKiSLWi7HyD0XM6a4mYa+MDtuS35I/knPkr7f6Ep8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334762; c=relaxed/simple;
	bh=FmTw8wBXe89Pltt8tgV0n8gbhghogNAb+gjvdMos5/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IevaRzGG9+dXZVrlv0c9cJY/3SStfmkz/0bskUkiHn2fiZ8+xbb0R/qwzGS0MBZsYp9OV8mqdioGM/ivEt4c1+b8Unz1w1LvM1y4U/2DGXC0rjbtx6GZwb+PfUvx3S5v5MQ/wHli7qkTFjqA5eNrTbTGLrPhz5LqImfASUJ2DdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fyq6HP5N; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64eaf8aa893so6558260d50.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 03:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776334760; cv=none;
        d=google.com; s=arc-20240605;
        b=DCkYG452QSli/9Ak2HMKAJMEMfwRHJgJcirmshz7uItYBM6lSWUOJpnbWZg/6BYDVI
         Gxa/BUUPdElOj/I11lJ5G/6pbe4Qt9CLIeEPSrDYSILLBF1aiAqPGJx25OLepuJUuw/D
         58vLs9w6ZWf1xKCkK9s0T8T3FHMNwiLrKYJ2eUsfvt1ksft6f2YJyXhezKPmyh3ahKJt
         g4g9ZKfU/gV1WxVXGMlbGGyTqzFVANdF0MVw8CsL3rn3c0xbTq95b7N1LSRH+o55LS7r
         AwGBtDarb5ZlQoZYYYlSOgSwzjcTIQL0Y5ylu3NIAS3FPsRB9NODO76aWY/j/CWRsjMR
         CRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FmTw8wBXe89Pltt8tgV0n8gbhghogNAb+gjvdMos5/k=;
        fh=EjhOSPYWiA5OhnYFyWWHmM9eWfknrIeEnUIXiu2iW8c=;
        b=aD4RFDz3D3CwJGUhLLh5SfYIfAOE1XDy0hzvqd0nc8Al94mftH0Y0laRAtgh4ceMrJ
         T5eZaPL8pPy/Hg0rViVxsBWDWAK9o+At1t0crijvO5QlppFyvbO+lFZpvVU3OLqRrGqm
         HqBRipr97cvOQed31FYwxc1/rCyzqop4hjP7rxACofIcuEPX0CRK1ljcZ5OmB1uKO8R1
         lqZL7ISCcSU7/T4vujKXamEwfbCz1v1n+BF20lwHNRFqXADmTpZmRScQVGzeEfs781Qg
         ADlC0FfKMdfMwc99O4O21O0RfiuHzc8I6NQJFF1cv/v6mp8HOc+uH3MIdO/Cr8qSX9kl
         i/5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776334760; x=1776939560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FmTw8wBXe89Pltt8tgV0n8gbhghogNAb+gjvdMos5/k=;
        b=Fyq6HP5NS4a9D1E0xI++inqdcQKfES5aqKnBrpIiJkra8fPxM3I96OvlAe7dGIBmkH
         CDdaCCoEJeVBEd3pO94okEgrBnxUpvI/RDAWyxVogyVfP/cqzFkuzCqXSdH/H9oITU7A
         8QYEPTkSapcDAg/QA6fNnvVw3lgBvjx7Z8xcS3yH300LRoIKAW7Lwt/fM+zv2iV/g1Ty
         Qd8bTe0eu7mRM3QcJ+121vr+FHWpaBXHzDF4lu2rCVUWOcKDFZI/W96cQ4UnYQdOAmxE
         UJTwWmrdftYywi9pupEIh2r9Nko9wyuwW34FufTVNkaH/xfIpwQg/UBLSCMZTYX36JxA
         nucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776334760; x=1776939560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmTw8wBXe89Pltt8tgV0n8gbhghogNAb+gjvdMos5/k=;
        b=hqKLYclWBbY3rC4yBfZlqL1dp8exCWF0kLlZ7q75fKHmHBS745/HfGeewHNXnwBWCZ
         zPjjbxoy4R+qLgLxsW0HzP/J2FsHCwR5Bxr1shN9+REu0RT2C8xRRwxllpTIypK2cAgE
         JdjuDU4AxrcztpjX4wCJmz64QK0Jsv4Rc/ZBHPmF6m1QClcTdUPB1hApPoqcQnRKXMbC
         +HNnyeyeM+2iknl5EeAqFKasbI7KQuqqJNk4bDk6af2jXpCL7uFuc1foMt/HdtWRQwbB
         Uler1nq0jc47mmM/Qk9bhf0NhMR+q5wiM8MBh9Oq9unejVMfR/aQl8M5mRNAxjlsHS84
         Vohw==
X-Forwarded-Encrypted: i=1; AFNElJ8PdnI2LZ1/41sMfr2LApqTVhDh6ySfF0TOmMbzRuQUZbV6X0zvNJMHkYtf1s00oSh691bR1so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8DYnaoeL3t+zzivlpZtRY966Eh1dbmoAs4ATsIejrdck3iMxK
	azN2ZqrUwswP+5mXZ3VXvD5IOG6Zea3IbVT9NQ8KrlJ3JW0npeIaguHXv4qNrMRCWR1/lF3rxoA
	qUQaqoE2xVzynYy4vhoT9nf77mqLKkw8=
X-Gm-Gg: AeBDiesp5Zbmng7zwMLlzaUEK+R9skqOSKt9+/tONpCuwmfZCuXpxKWcI8MjnOyHMlB
	lFrGZ6qJHjB+Zu/rqgWEwiSCC6JE22tiV2I3AeMqE3+iVniX0JgX496hyf3NgyUmaeiblTZdkDs
	a+2a+hI/uUK3FTH8B8vxeZh0X0Al0JfN84oUWGpn6QsozdIB2x2t/KgcfTyMc4SBCWCNuY0PAYG
	blfQBqRP0noqQHqV7UMKRbToBDnP9tTBgiKlN7p4fyQFbysyjBnNBJjkTfAuJj4lpi7klX5qN5l
	3TScbtzwGpBPXSkqsVuD
X-Received: by 2002:a05:690e:4082:b0:651:cf77:f7cd with SMTP id
 956f58d0204a3-651cf780af2mr15598150d50.13.1776334759713; Thu, 16 Apr 2026
 03:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415151449.3387235-1-lgs201920130244@gmail.com> <20260416094932.GA1768243@killaraus.ideasonboard.com>
In-Reply-To: <20260416094932.GA1768243@killaraus.ideasonboard.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 18:19:06 +0800
X-Gm-Features: AQROBzDBn8q_l_a8hLjbowv1jbUe-5CaUu2DD5ZrJHPxsnOT3n-XM-B0E_Nm5y8
Message-ID: <CANUHTR9w7ca8gw5XdpxKG7kpbdrii4t_e3xJ_eaUQ5RBk2PnxQ@mail.gmail.com>
Subject: Re: [PATCH] media: vim2m: fix reference leak on failed device registration
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Matthew Majewski <mattwmajewski@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Kees Cook <kees@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238298-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,pengutronix.de,linux.intel.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchew.org:url,ideasonboard.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 02AF340CD68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Laurent,

Thanks for the review.

On Thu, 16 Apr 2026 at 17:49, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>

> Functions that don't clean after themselves on failure are not a very
> good practice. It indeed seems that platform_device_register() will
> leave a dangling kref. Most callers don't seem to be aware of this
> though, even platform_add_devices() doesn't call platform_device_put() !
> This makes me think that this patch just works around the problem. A
> better solution is needed. Have you investigated if
> platform_device_register() can drop the reference on failure ? What
> problems would that cause ?
>
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: 1f923a42033ad ("[media] mem2mem_testdev: rename to vim2m")
>
> Quote unlikely.
>


You are right, this may be a workaround rather than the best fix if the
underlying issue is really in the platform_device_register() failure
semantics.

There is also discussion along the same lines in another patch caused by
the same API pattern:
https://patchew.org/linux/20260415174159.3625777-1-lgs201920130244@gmail.com/

We are discussing there whether there is a better fix at the API/core
level instead of handling individual callers one by one.

Thanks,
Guangshuo

