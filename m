Return-Path: <stable+bounces-244420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOdNLHtc+2mUaAMAu9opvQ
	(envelope-from <stable+bounces-244420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 17:21:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491C24DD155
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24DF03032A63
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D965447DD75;
	Wed,  6 May 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cr7AeDnq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949A47AF68
	for <stable@vger.kernel.org>; Wed,  6 May 2026 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080639; cv=none; b=Aj5DeJ5CvwM9t92DqUeWIDtD4a9r0UMqLA8mYUWnvE+B7o4+0hh2iVnEXgT/K3heUaycHPY/EATdp4VoyoCNWkr4PKxzZ7x6UlR1/sPRP6XHZhuuK/udFlj+LIcw7+kL9I/2/cNRW5c+R669WgqOq2x01xTanrStdFhKXFyhvEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080639; c=relaxed/simple;
	bh=CIHXvYkwT0jmkDtE417aEEPyKFHS+9YHa78p6P2MNXQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CG+9GZfFuZLF+/TNv+b1Jmu6IU5oE2TN/924R0m7bJ2qzgY7W12Hy4zBniLz5zVzheFHCyAj8MMLKoPQTHubBYLk5FG7ijlY3pUGKq8EQhyhYGRmnFthL6R7JskgewB5pT6LPEZSGCzh+58wcwUTIgO8nz4LUGXY2EEJ+Q2arSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cr7AeDnq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so101060245e9.2
        for <stable@vger.kernel.org>; Wed, 06 May 2026 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778080634; x=1778685434; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWneBoACYfMuiuSESr0/5daG1MHT/M5YTM3M8vS2pFA=;
        b=cr7AeDnqmkz/lL6GNhQX62OXzYXKqDOCq7Ej0QjJgFH0s7HGSRv6a5BnPjRw2aZf7X
         Q5UxAnSfeUpqWBIvvZn5w+ViBmUbUt1Tl26xnaIEy089lpMWa0/ewrV27PzSMjpB3AIH
         +sLUZhD/wFC+4IfexUCu+PDzcsAa+5rqBYM2FxSdW+DEGv/l4BqOM6kXxIVC8t3P2F9+
         zBUuVeb4xz2QP0khM5sOkcYCyxdCtTnIOm+nmq0J9XcUwxaSX+mdk8mijaz7CPOIJK7d
         c+G1O+pHq1qTmyvMbkG1hotAGe/BeRDLbsZlK501F1Qo+/zi0nz3nh7mTG4MGLRPImZR
         v2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080634; x=1778685434;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWneBoACYfMuiuSESr0/5daG1MHT/M5YTM3M8vS2pFA=;
        b=WTi0pfju4gMEgou7uVHEXBMpb8xMyAD/I9I7o0NFM2cm0OndyQgXQVCno9HIXPje9o
         ob2NMBCpi7RsLHNeUib+97reSkU89nftcPyzrJhhsHXnTibPibjykLuffCfKwS8xZXFd
         1mdgJKmswvrsncXl1QQN1/nu/x5b+qO4szie+pDd4Zao7ULY6zn0bU5fRkHS1uyLq8om
         GrAZmGj8A8aDZIgcMVGFOfzJu6mf3dF59ySz+LsTQrlYlhbFaZqOMsOKuJMJbS6Jho8/
         UdYG81oFLjpqXlYkSPLUg2woaxn4F0Rxn9wQPSBQYQPUjvaraoOjFqNWeZthQXzbx9Cm
         nSsA==
X-Forwarded-Encrypted: i=1; AFNElJ+Q2iiJvcn0LIkiCmr7Iyd+HsFy491BhaQk6m4fcVIovmBu5tk6qMCCizhuBK23UYl/ruc+TZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjqkSXnZ04nVVAzQtJMVaasGCA1AZyC0bjTRu/GkoxztOL9v7Q
	GKjNbn2+nm9eWcEP3glpdpiQezQQ5mlK+HrLd+Z15kgjKYs9FxbcgDX3kw9Vt+yM+Gs=
X-Gm-Gg: AeBDievtNMftsDzZSvZfPqksGeiUpTXOHXhae/EeJ3ZTZ6Sdzyh2+WWrFPkAVYp6FE3
	YlwJ2c+nGLaD1rYWsrgmBTHBKmQ3AnxPWk5OjDHvOVYeGt5UympNFzcf0/XSQ1voAos3Th23ied
	ftMOGaa8QCATeqxwL/IUOx9GW9IU7ugx0H1aTQmOmzYxD9spu05Ai4aJl2jDxTGjsSXDxiVXNwX
	2GpRHW0HgO3L2HnLQNSDOyG8zonIbCo9phqRI7XZWINut+MG3NFovQUfaKwfdA29pTYn6vBsfrN
	/02ZzvyoM7pF3QvBL9y54fAbkebegRF9bDhAwVsSnawi2KKbXNMolQIz91q8lW0+iXho+pMrAqM
	HVzowzMbUFJSJzWjBcOy4xsjhFhIkArkEVJcCzpfPjwQ1DtBOr1L45BXV8+0d+9OBcOz4IS7UNx
	9SlG4BMlBfZpWXBf5Yr3YHdCAXyXrhLIdo/YXMy7uE8KXqGA2usNhDBa2Yjx4uX4LznkGExyqp0
	BxzPTRb3iYILdrK75eh/Q4gcvv7
X-Received: by 2002:a05:600c:c094:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-48e51e1a7c4mr49435305e9.9.1778080633868;
        Wed, 06 May 2026 08:17:13 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:da69:ce01:65af:7871])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53895effsm51990165e9.3.2026.05.06.08.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 08:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 16:17:12 +0100
Message-Id: <DIBOZA3G83XE.13MZJF4AJQAOU@linaro.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, <linux-kernel@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <peter.griffin@linaro.org>,
 <andre.draszik@linaro.org>, <jyescas@google.com>,
 <kernel-team@android.com>, <stable@vger.kernel.org>, "Titouan Ameline"
 <titouan.ameline@gmail.com>
Subject: Re: [PATCH v5 1/7] firmware: samsung: acpm: Fix cross-thread RX
 length corruption
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>
X-Mailer: aerc 0.20.0
References: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org> <20260505-acpm-fixes-sashiko-reports-v5-1-43b5ee7f1674@linaro.org>
In-Reply-To: <20260505-acpm-fixes-sashiko-reports-v5-1-43b5ee7f1674@linaro.org>
X-Rspamd-Queue-Id: 491C24DD155
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244420-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,vger.kernel.org,lists.infradead.org,linaro.org,google.com,android.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexey.klimov@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue May 5, 2026 at 2:12 PM BST, Tudor Ambarus wrote:
> Sashiko identified a cross-thread RX length corruption bug when
> reviewing the thermal addition to ACPM [1].
>
> When multiple threads concurrently send IPC requests, the ACPM polling
> mechanism can encounter responses belonging to other threads. To drain
> the queue, the driver saves these concurrent responses into an internal
> cache (`rx_data->cmd`) to be retrieved later by the owning thread.
>
> Previously, the driver incorrectly used `xfer->rxcnt` (the expected
> receive length of the *current* polling thread) when copying data for
> *other* threads into this cache. If the threads expected responses of
> different lengths, this resulted in buffer underflows (leading to reads
> of uninitialized memory) or potential buffer overflows.
>
> Fix this by replacing the boolean `response` flag in
> `struct acpm_rx_data` with `rxcnt`, caching the exact expected receive
> length for each specific transaction during transfer preparation. Use
> this cached length when saving concurrent responses.
>
> Consequently, ensure that `xfer->rxcnt` is explicitly zeroed in driver
> helpers (e.g., `acpm_dvfs_set_xfer`) for fire-and-forget messages to
> prevent uninitialized stack garbage from being interpreted as a massive
> expected receive length.
>
> Cc: stable@vger.kernel.org
> Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
> Reported-by: Titouan Ameline <titouan.ameline@gmail.com>

As far as I can see, the name in this tag should be
Titouan Ameline de Cadeville.

> Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b2=
6%40linaro.org [1]
> Closes: https://lore.kernel.org/r/20260426210255.73674-1-titouan.ameline@=
gmail.com/
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/firmware/samsung/exynos-acpm-dvfs.c |  3 +++
>  drivers/firmware/samsung/exynos-acpm.c      | 15 ++++++++-------
>  2 files changed, 11 insertions(+), 7 deletions(-)

[..]

Best regards,
Alexey

