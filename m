Return-Path: <stable+bounces-233312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Oo/ONWz0WmVMgcAu9opvQ
	(envelope-from <stable+bounces-233312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 02:59:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3989539CFD7
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 02:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EFDB300E733
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 00:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D0D2F1FFC;
	Sun,  5 Apr 2026 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kha86hpp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4652EDD70
	for <stable@vger.kernel.org>; Sun,  5 Apr 2026 00:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775350735; cv=none; b=gGbk+3vmYIsePTJgfX2y+8mJlX9e4mzy5ZyD3S1EvHnB+qbCdU6G+rXrUOg2k0Vxn/FKP5wnyPvLzQxXkwItCHfTGTdvyADrAn64CYK+Cj5pegE/QGkxcX3O31cWLtcXGcicopld6cKUpNcQNTIr8L3eEvh8AmyVhcJn710Zwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775350735; c=relaxed/simple;
	bh=OUV8iYFcdaBNckohwit0b6YgnpM3gK0Lsy8t0bCd8sU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=IsvGsGj20lTROhIo7puGxtidjeGqOVX0TMLqbBRj3+pyhEODI23MfWTZ3VJGaKyfYo5/bqPydsvPpFDd5Or2MXS8kApn+of44NpVchGoOJyKsvIZ/uXD/Ie14UUOflZybMxq73Y06Tel+R/fcUftjhBGp3jXdxW6QU4ohfV+TCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kha86hpp; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35c206f0481so2786160a91.0
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 17:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775350734; x=1775955534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igv1X0Jh9R3lolDJfbtFzOBAbeGQ8wEXL4Lx+psSqc0=;
        b=Kha86hpp4XmoND8lLG/6SymqFmmEjyq1IS+Zc7FZX2gK4YNUa/bQGri94wkuaxUB82
         CLFcwi1Rx8luN5PbbIa5najuO+Y9qKk1Mol7h6/FH6Jbtn+Okzqp93Q00+X5RR7tr8EZ
         LhlL5vJaQi3iLKhzdPyQSAyXpS6wc5mxNrYsEG7p24C/Z0Z4jow6rSrfz+SFlNQ1/ekP
         X2YISGuCRDKsg+q09e5IQJVsboItmundrQUODDZ0IaMPxO5vs4hlBpYyWj2IvbkY2ImC
         TV+6uPqfgsVVWXFhVvKQTR+0oYIGBCOaT5g/Rs0wObt3cptkZNB2iBdr7Da0x7aYwULO
         pjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775350734; x=1775955534;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igv1X0Jh9R3lolDJfbtFzOBAbeGQ8wEXL4Lx+psSqc0=;
        b=GCnSbTwyICUWr5uDXZAfZd8+bA/tUF9cbCLtJ3qggQ1Mzya568QaEtvmHmE82tfkla
         901pW+YRYzZM5aGEJM8yFFiKskFxX2CG/Y685XS5rbgQeu1ftJsNnwH8XYPXQQIGwnoI
         o/6XyYSnHe4N8Z2NGcLV4FZRMf7bzKofQRAcb6wcgwjSJICG0GcdkH9PBHMTKEFQRg+2
         kBP4fUIolZsIoVT5qDk2jueoBlhIc8G7N6u/SKQHIxfCJWC33FQQi59JKeK/HZS1esf8
         jvGjR+gk4+riXNohF8KETK7yf7yIPWUPe0ViaXDtwPh9rxb/nasAXiPrOoQj7g+BvYuq
         sQoA==
X-Forwarded-Encrypted: i=1; AJvYcCXq1dGV0j8sdqHt3AdyQTzVfrlG9th9leqnT5kZnJWlKqBBfAJZN6FPqr+5BHup8oL2lypQfCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Ybn28UZOtTMILWkzhw4ThSBCcpjBrJmDhWfH5oYRslqFn6sB
	rUHD19vw8+SmxQhejAVYYflOfZfv5+R/Qjli8dfx7fMqpHqEtAxCk76C
X-Gm-Gg: AeBDiev0zHWi2UqJJa0VeMjwkM5ye1WFFiQ4C0GHZGnFAvcpZlrVLCaLg/QUrxSbu4N
	Z5arbb3jfWDrjjGisxEkFJR97BtoQ25nBeXaRExoIIo6jJNuHIl3gQhBlxT9iB/Du/F41DPLFwx
	+awZEkawHvnXlkgtu5z4ZdJMkhvF6bMyE6IwzkOgNNKOed44jMdtd218ZBOKIrMArdx1FjsPHxi
	fLLX3yWWOQ/NETUCG2nXWs8rXBe6e9zc1bVhzl6gNnhSx9pN8DWbgWR+J8zsBiA6fV5+gW0CK4f
	dwM9PmHA2/F5kjpQB0HPTANVG9H7HlOwgteWpx3A6rE1ZLidFogYhFLTRmG7s9WDYvNBUSeEXKx
	862SvzqdFBUlAKd6SSxjjn/AW4vXPUbrIkr3DhQt8DghDcxNC1MwhsDhgWfd751ewgFOXPcZe+Q
	jrwpeWU0Ztz0yVcdCAStk78bE=
X-Received: by 2002:a17:90b:3d4d:b0:35b:aca5:db39 with SMTP id 98e67ed59e1d1-35de67ee6bemr7012077a91.9.1775350734065;
        Sat, 04 Apr 2026 17:58:54 -0700 (PDT)
Received: from [127.0.0.1] ([142.91.102.47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de6860cfbsm2876078a91.6.2026.04.04.17.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 17:58:53 -0700 (PDT)
Date: Sun, 5 Apr 2026 08:58:41 +0800
From: zhang <zhangweize9@gmail.com>
To: joonwonkang@google.com
Cc: angelogioacchino.delregno@collabora.com, jassisinghbrar@gmail.com,
	jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org, matthias.bgg@gmail.com,
	stable@vger.kernel.org, thierry.reding@gmail.com
Message-ID: <8710cb76-78e7-4e7f-8be8-0f059b9cb0ac@gmail.com>
In-Reply-To: <20260404124428.3077670-1-joonwonkang@google.com>
Subject: Re: [PATCH v3 1/2] mailbox: Use per-thread completion to fix wrong
 completion order
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <8710cb76-78e7-4e7f-8be8-0f059b9cb0ac@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[collabora.com,gmail.com,nvidia.com,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233312-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangweize9@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3989539CFD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi! Joonwon Kang.

I just looked at the content of your email, and I think we can design a resource priority scheduling system with 70% and 30% priority allocation. The specific idea is as follows:

During task execution, each task can be tagged. Important tasks can be allocated to the 30% of resources, while the remaining 70% can be used to run low-load and repetitive pipeline tasks.

The specific algorithm can be written as follows: reserve 30% of the runtime space for the system's critical processes. For the remaining 70% of non-critical processes, a judgment can be made: if resource usage exceeds 70%, the excess processes are marked with a priority deferred tag and run only when resources are freed up.

-- 

the-essence-of-life

