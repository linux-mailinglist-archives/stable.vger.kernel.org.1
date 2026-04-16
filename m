Return-Path: <stable+bounces-238317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIJOBB/s4GnWnQAAu9opvQ
	(envelope-from <stable+bounces-238317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:03:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D9940F538
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FEE43025D1F
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9F3CBE69;
	Thu, 16 Apr 2026 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTdrg36j"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD66438F95D
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347901; cv=pass; b=AsUCcSZuv5hn+2/SvMlz0mOeHr8gbvqMi81im8putUXOR/k10ajrtYj1ibTbrUibfEx9RdnwUbpkrVo6UkL/Ijd3yxkKIAuN6E+dscooPinaiTmyl44j5PelzxBoVnKtGM5KfWig2qs2PszIFAHWOPsQtvTpS7XP8OVIb1BM4dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347901; c=relaxed/simple;
	bh=D/Nc5YMiTmxVH423yJSK4twcVGR8UYrJ+EqrXHBG/ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VL0RfGQYbixa2QD/jz/8sB3MKo7mhywBhpmWfvJAZ/j+qowEKg017+Sp6FOF2zH58giNpvrGkzCPUmt8hxwIuXIXGhVzkrQ6BGhznMjIGsyeruy4/K8RXFH/0kMwnMpF19y6lNC4ObuPGoJTb5NMwKQeWpOhL78H3ugkgQ13dic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTdrg36j; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651c8371ed5so2808284d50.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 06:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776347897; cv=none;
        d=google.com; s=arc-20240605;
        b=PW4eYkkNpvkOWtbP7g/ylo6anhIz7yRi8FF0E451a9VG321r3ziJM1bLnyvjYlog4b
         m7WkczT+fRzSEjPbjcRXPr9tndU8rfTE4OjwNT6jX9BfznQ5h6GAb7G/Wzd4El/a0dhO
         3G3ABSpYhVtfsP429ApDoAgQiAIBd4/0kzR2Zq7wCjGU7Z4iVg9B6Qse+GrIKmj1WhyO
         hD0w7Yk5QokGVQZVklhdqJ5fIJWft5mozCgQEJR6bSJaN284vm3Dw1OACyinxyUWT9R6
         PwAVeeIA4VZ9ejVKyNwLnzJuyj6WrNncsj0GZhssIIEoPcDqzEtPWOQuhDQLYk7UxhD+
         8y8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bkcqnzcdGwh533gIx3Rxb25n/lc97a/7GxLLYQuAYoo=;
        fh=ca7hoVb2tGt5KlL134TA6Kj01TRa+jMmLKm7cHH7nM4=;
        b=PHzrQymtmw6R1LqPIDF8cA9LwC8xyugitgMZ1PEXWRHv7mQg+Rgc6SUDnS0LElkOD5
         aaTb1MQsn2okWLqR3QA766wCcaeSNbo27DdTCbedJApZNJ4wfJoY+mmcd+KnuMCRdp4j
         au677D3IcXzOINF4iODtE1saEZyoNivMp/RhZFyL9Cvn8Wdsp0zYBnsNNLcKTg4c7P0v
         E7FURwd7wiuK3WgtJFKC9u3afUiCIDacIUVJV7PmpiXk3zLtBEFSuZ/H5c+HGI+o4/tY
         71tMPEpYvyhGFjUhJz3QCOFIjI6Bu1hAVPJAgAASY1Ck4MDkc1Vd/h8ZaMAjBqJlCnhI
         UAvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776347897; x=1776952697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bkcqnzcdGwh533gIx3Rxb25n/lc97a/7GxLLYQuAYoo=;
        b=JTdrg36jee0wFuQJ+//9ufdZd420c0IqsOadxg5KAexpIvUnSD4iZWLy+lHrUXnMrg
         +S5jQ88VI0ZFz77XWx9N0us5B8/3iu74W4LA8j+q0z/g6QV3qwIyG0zxCV4Wo8zidFAu
         ccgbzFQ/RYf+QnQCPs0EdBTzyTcWvBz1qMOWd63RyOy8CqIbZgKyN9dqsCeYO4zGh2vA
         s+KSOaDqETSQeysDHZbayjP4YDnAD+MyG76Kee5PPv2K/LOF30H3/nxn55FYWrsFofre
         AGJuMrLi7Qb6xf+NjS7eJHdwyFde82sE2FWgA0XTWzVeO/hBeZVlB+XI9QnAR2P8+WpQ
         P7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776347897; x=1776952697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkcqnzcdGwh533gIx3Rxb25n/lc97a/7GxLLYQuAYoo=;
        b=ZEeI8SADwEUvv6gnc1pcvqNYLpj5mNNGu+RfTmJ1gP2FH7AG3c1267JDfl7NzpSuXo
         2c2iemZaKUFM/g84Krg9azV9AcLrQR4QPdjKy4C5IaEUdHqozfzFTNL4vUNeUAAqLK6k
         EJohqtRWqZ7PbVX5TYd4bg4NkxjlKdNbVeQddCFlo35MjuoYnS/720SNsb6YSHb4jg4I
         lLs4h5cgFRI5NDkG43ZuDXzkl5NePABRo6rOhMhukG5oFKojy/MzVeYOxW7USRf0AxS3
         FkMj3lbssouLURxCIeWvhWNRJZjf0/3bZyea4GUg8GF4iK8geuT7vEDhnzUCGOrSj/xA
         8bRg==
X-Forwarded-Encrypted: i=1; AFNElJ+JTTgCqpenK+cg+6U+DNHQYZY8nuuYt1Qt5rW13ACHFdD9U6yyoI4uCFelV7J+OlkfKVpZ5a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtPhZ7CIdCfyhspcxX6RFZxbtFdio93XZNbe2+ieRx75zI/HT
	/deZSGALB5EsxecQYGy4NB2yM/qFR6gZ3xFTUz5qMREZ1XTu5xCgJvHSU4p2Uxh4iYqC5lXdurW
	7KmFZywsGBrKMnb353TjaCAKIQkdmjEk=
X-Gm-Gg: AeBDieuSVONLLjRMA2N5RXUC06/mdmR3H0ak4TKmgMDdOma24I3X+zKPQ0bMQ1KZ0ZN
	g1/4cUX3X/3MCTQ/isHSD1hwWjpaqo6aTRSzlpauij7JjrhuG5fF49ScLFdyweMvgDrklCQgLse
	qDUReIbJ1MTnX+BCWwR3JCnNGh8XYcwF7WZHc3GmeOy6rEdo9JK/QE1a2UAHz8IqXFQf2y5P8wU
	pdJ70ER85daf7uQYJ6pIoIcyR/uKONWGB+E7HHGldZBnn1uFqI/pzlSVA1ZR1T/7Z81+YLnkMy5
	MEgzyz/Q//hW+xkh1+VT
X-Received: by 2002:a05:690e:144c:b0:651:d199:51f4 with SMTP id
 956f58d0204a3-651d1995791mr13902937d50.22.1776347897133; Thu, 16 Apr 2026
 06:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415181635.3699592-1-lgs201920130244@gmail.com> <20260416-wish-impatient-f69a28478f89@spud>
In-Reply-To: <20260416-wish-impatient-f69a28478f89@spud>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 21:58:05 +0800
X-Gm-Features: AQROBzBcT5nRWC-Jqyb1EIHvUGQB4_h3eHLixuZBdXDLrz4V_7cc1gf7Qn5s7o4
Message-ID: <CANUHTR_d8NjkX8HkvnL4GAC1rb3yGB_vKtvw4u2Nezxz5=2S0A@mail.gmail.com>
Subject: Re: [PATCH] soc: microchip: mpfs-sys-controller: fix reference leak
 on failed device registration
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238317-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,patchew.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1D9940F538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Conor,

Thanks for the review.

On Thu, 16 Apr 2026 at 21:32, Conor Dooley <conor@kernel.org> wrote:
>

> Patch looks reasonable, but not urgent so I will pick it up after -rc1.
> Looking around it doesn't look like this will be a unique patch, so for
> other I would suggest that...
>
> >   mpfs_sys_controller_probe()
> >     -> platform_device_register(&subdevs[i])
> >        -> device_initialize(&subdevs[i].dev)
> >        -> setup_pdev_dma_masks(&subdevs[i])
> >        -> platform_device_add(&subdevs[i])
>
> ...you redo this section, as it's not clear to me what this actually
> is trying to communicate. AFAIU, what's wrong here is that
> device_initialize() calls kobject_init(), which needs a kobject_put()
> to clean up after it on failure. But this code snippet doesn't tell me
> that, I had to go look for where the reference count was actually
> incremented.
>

I also think your point makes sense. While this patch may look
reasonable at the caller side, the correct fix may not be to handle
individual callers one by one. It may be better to address this in
platform_device_register() itself if the failure semantics there are
the real issue.

We are currently discussing that possibility in another patch of the
same kind, to see whether fixing the API/core code would be a better
approach than patching each caller separately:

https://patchew.org/linux/20260415174159.3625777-1-lgs201920130244@gmail.com/

Thanks,
Guangshuo

