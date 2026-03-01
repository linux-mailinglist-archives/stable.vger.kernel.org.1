Return-Path: <stable+bounces-222465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJc1LsA7pGlnawUAu9opvQ
	(envelope-from <stable+bounces-222465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:14:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC7E1CFD22
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2BD0300DE2E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB05325727;
	Sun,  1 Mar 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cS02p6f1"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D82D97BA
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370852; cv=none; b=E9vx3LgvFt80ASRSyCrasoZOE5XudoRU60WIL3T5jbdC7wxv9mmYlEPItjb9wbKrHywBM2KoiJdjJ4SCUXUIwBtK4zoE7JAb6Q0Pi26e1bKhEceKLJ0DittV8bJUlQZV8R6KMF5jXbSfe3ocYOdvvnVPaLrTdXzBt5RQ1GukfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370852; c=relaxed/simple;
	bh=oYK/7bNbjgndx7LFMDmcovzWIRhAdGMyJR8FdeIR5zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8YqCi5iWHacAOqV1Pyn5mspe/rC18c+jZxP2jQda6m8tqqtnSO6LhiGGIa3HVVgXh2LO+wf2gPDOobHpH6CJinVND3hVv7FBxXKfKfK7G5ZQ4HQEPiGRyDvuxtL2TFgI/Gjcz335A1rXllHiyCmUOaTlq87bhL3siZk6ErWbxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cS02p6f1; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45f015a3259so1405580b6e.2
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 05:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772370850; x=1772975650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hz+96hR5uMS8gx9rZ/1JEYUugqVK4LUQ/kv2vuzjV2s=;
        b=cS02p6f1zra1QlVOaPDTiHTJfS1t7CM/D5k1NqUIC9aGdQ2jt6u/M/KH4EPunHaXDc
         7rjBlf6N2wJt5KreLFv6w6yzxHhF06CnDAm++o+H26Ru+2wuWBbX1xl9azNudg31aASr
         95TZfrMvJBxlWoyfY1lW1c1ekNrSNONmml1v2bveHfdXcueE96Pj18Fsk4W2pkDlizkr
         DSFnLZ/okOMrM7K5g54FT4D8uvIhn/Dh/2R7PW12guCqJkWfYNhtRWeOxVGOnBFTaAos
         yyykbP17c4JPthiwhRHpRZ0xOw0BUbJ4GjBa0hsSEXYs/zPKAH4pZRtKopkRvyybk3ec
         WK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772370850; x=1772975650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz+96hR5uMS8gx9rZ/1JEYUugqVK4LUQ/kv2vuzjV2s=;
        b=BeVD/3u/z3BXjpCKlsligut1NiQnnCK8jN4s4vQbfb5lmOWN+LMGFT2iQMnEwSG75H
         TmmoOGlZfcuMQ4UboHY0+kn/8S/cMHmEIxcEGZO6lWOXSYaJBstwI1yA7cohzsSXehKS
         1KSnrQaq94k33WYGWlSQQw5c0NsdCa0K6yzTfYZhUug2vtDLXZLXWX8yGWh3V7fNXECH
         xmquEfIXoZtzW9oydTVhfbZ93wPrSWK7cYnrOVkIYbLzVgdgFSjv45SrTlLpDmPeHQRh
         SKAFwob2Y7MEU6PhCphOgtpgSH72WzfaDHT9tPRezkIzbeV+/WNny/DRf57nwtKnoTrM
         WIJA==
X-Forwarded-Encrypted: i=1; AJvYcCVWNTH15pXK8QCb09ugPauLZgXwsNl5qZbbQg+clrFAbuAWUCahSqyNUXnp4Mmzm53fuufEyn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVC6MXLunYyEGPppGrtwXHpJ4m1fjRPsYZTvBHzGXYfySc2ljG
	TciAkfPsrm3DFZIEPq1ghEGoYW4M/Tnj506E2Gt7nb1U7ghftz9TWYmMxu65sDZg6Gs=
X-Gm-Gg: ATEYQzxVp+U48hrKZGLu11oKxltqA/7G+89/jZZjdpqmLRp3v1wirWkzcF1R8j+TUE0
	XQTaPrun1f104iX1/UEaiRrfs3Gze0PIlcDjuZETBPTF8QXXF8N2zDqZ1QwOGjC/GO6qVpMbUT9
	cZziDFNEeeEwzzdO7P4N6ul49DDbkOxZL8F1hTeaVGZCSTzqQZquVmuGLkqLHtfqJD1TOWwGKSi
	nifbvt1GcroQcfXS0zicpMsPvQFU1VMhWZ1rSaECWcZFg9S6q+dgENT7DGWRgee9bO9B3EfcPDH
	VI5dhgf7EmEklxyFuV41ppsCbQL1jdOtqlQF/Nz81/WF/r4DwjvcaQn2K7TQVrgVQEytDYFn8fM
	AN4v5/DSzuWv3SUK8cXE7LpOzukL4vdsOi3yB9nIYo2bWH9LftHIt1cw29SAIRYmOhZECKWkDGk
	5bghdZOSDLS5b82LKgmSEml88OvsidFY+HH6IKJ8tJqAsXSWulJiFgFxNpuK53PsODRfKzSC2F/
	8c42JjIdg==
X-Received: by 2002:a05:6808:1b2c:b0:45c:925b:5848 with SMTP id 5614622812f47-464bef47bb9mr5580674b6e.45.1772370849693;
        Sun, 01 Mar 2026 05:14:09 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf2572bsm8886542fac.2.2026.03.01.05.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 05:14:08 -0800 (PST)
Message-ID: <cb521900-5eac-4408-901f-ef102f04c0ff@kernel.dk>
Date: Sun, 1 Mar 2026 06:14:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "io_uring/filetable: clamp alloc_hint to the
 configured alloc range" failed to apply to 6.6-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: io-uring@vger.kernel.org
References: <20260301013828.1698919-1-sashal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260301013828.1698919-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-222465-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EC7E1CFD22
X-Rspamd-Action: no action

On 2/28/26 6:38 PM, Sasha Levin wrote:
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This too picks cleanly into the current 6.6-stable branch...

-- 
Jens Axboe


