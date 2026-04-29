Return-Path: <stable+bounces-241865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JCTIRXm8WlZlAEAu9opvQ
	(envelope-from <stable+bounces-241865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:05:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC66549353F
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAE453013A7C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EA137CD2E;
	Wed, 29 Apr 2026 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWYufu1s"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107F01A6800
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460752; cv=none; b=jROm6EGZKpUBUzWEiCxRFki/EJu8vhunWJdX1WVc4NBQfNWGFXUIp4K+kNbk8PbvVtv5G7grN93PRnKA0Q+67ceXNtI5339gsOQGpZQJAm9N4HVgpWrjFbTufKHGQSFzSrcP5DOr/4USt8vY35+B1jcjJYJ8jFgrXpNZ4NGlwRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460752; c=relaxed/simple;
	bh=4XwGRnQC1kznCkI3mzdzwu79hRIMT1AKu7AFKtwugjw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LDHAlDMHKtPwC5UL9YFAO5Tqg9R0nnHkdi2YA4823aYH/rpSQKf09+6J4Lzxjt2HSasF7mmaAHDHepHL6jRygid451zUtPPOlu0VHcr29rBxKcMZ7upI1fgcO5ivuKegUEy31vy8SZEuSVuiW9393EsWwYa24LZnuIBn8tv3jFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VWYufu1s; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso95244945e9.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777460749; x=1778065549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4XwGRnQC1kznCkI3mzdzwu79hRIMT1AKu7AFKtwugjw=;
        b=VWYufu1swCOBuEEd05vaIFO4jenyEWf5BPjkF3Vu7DA3spFRBvDjBSYwSVsdtLShc5
         tNOCcPZV+TOgDFrfcPjMIIPl+XIlo7D5l1hJ2KKyi3rN5+wih8P1Lnn6/Eb/UR1v8xoM
         7g4JYR4qIkH138hsr3+i+IJrtffSpYF8lCMsUyLviblNPytasDBKOAOKW/cPe35DJUAI
         afMqxck7ZhFycnsJdgf43cs2MIpgIRLbTa36CGcvM+llLIL/tpMu3PAMkO3tJrtw300S
         5ngBvoon63E/wFl8Ead53JBukYSEu6C85wd3O3/7GB0Rr2zYvkDeZXQ6zXhx+6F/SUdD
         J2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777460749; x=1778065549;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XwGRnQC1kznCkI3mzdzwu79hRIMT1AKu7AFKtwugjw=;
        b=LR0jNMb7uCS4KN4utrg2p2/MPopHEmP0CWu7aVa5pXEfT5iYWGJBu/fFeZ8HBUjhSl
         RFTkHgkYAJUveKjmZtLTO+E1Lc5dknp42cp/tR/lKqAxvQnFHcqnVuYUmRLqiLfiOUlN
         WaQs80rcWBacvgixfVS+6ExoH2faQKn68CqDqCkDAISdgxPui2gCLeSeLxZ53kPM6dLD
         ebpVcFPkND5tDXxPXjjhEp6XCndlKkGy/2NG+OuEJ21AEOcYVsk/kn0FdtYA+eQUOsdM
         Ei1or1nX0rHyzKdMVIOVxMO3zsLUkZnF6JNSaqkf81aOJcuKpMC1JmKkMaNiZ6HPWNYG
         QzqA==
X-Forwarded-Encrypted: i=1; AFNElJ/3PBFzNu6XhJKmMpEeScopQes1BRXY3cMg6Z6sL05wL2Z5pVZ6sB2a2wh7AzLZ0HmqcFZ9zVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6Wh8h5S5tJwkIVwFRwF1bAWTOUFAtvet4/RnJMzvBhqOqShC
	pbAZTcrSILj5hk3WruxcUyqLC08vCUpiRh2iAwcDYNKRqS4aq8V/BLXAESAUA52Ir6o=
X-Gm-Gg: AeBDietzdSH/rXmlww5R8JqWWMSX57H9SYGIrSblA9LpKRv7BjMpjstGwE1WDyg2Cjt
	oQSxfehr43SUFgeRDS0uOYBsFL0LQKF8tLDNjDkD6X5tbgj+YSoTTDiNwS90Ufn3oPKioTb5/k8
	wAAqZMw2nKUMtpmZnyb0QjninlCv8IGWyb6jefEhl6zCcyncyk2VLdVphzTYZ938UcIHVB5sj+7
	R7jAaDzJGfqDOlcIFqn0xuerTYoU/aQyxos0RYUKpZ3ZrmCtCUZQqdPJLmwgQiWinYgpmOiG+2L
	6/8E0iOG2ABwoRDFXy+9UHqgnLx8dhhXsRkxFi0mTHV8guUubJsL7pNDTj4WIXi/4vpzD+AIoS8
	7kooe4isQpZBy/YQNZ2QXOXv3qcRqgfCiBkGy5TofbAjlXUcy76BgHuU8wGDRh/nFHFVKuLYic0
	ic6b4ZWCIVgxbVwE8CUPGB25TVIsqqr4jAFKjJ3tJxBDg=
X-Received: by 2002:a05:600c:4f92:b0:489:1ff1:74df with SMTP id 5b1f17b1804b1-48a77ae5430mr109685855e9.1.1777460749283;
        Wed, 29 Apr 2026 04:05:49 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2fb999sm23367655e9.6.2026.04.29.04.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 04:05:48 -0700 (PDT)
Message-ID: <6d21cfc8-4686-43f2-a320-1b9505d38338@linaro.org>
Date: Wed, 29 Apr 2026 14:05:45 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] firmware: samsung: acpm: Fix memory ordering race
 in RX path
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com,
 stable@vger.kernel.org
References: <20260427-acpm-fixes-sashiko-reports-v2-0-1ff8de94a997@linaro.org>
 <20260427-acpm-fixes-sashiko-reports-v2-4-1ff8de94a997@linaro.org>
 <6bba950c-5527-4613-8c16-b52534bc75a5@kernel.org>
 <4421c95f-3ee7-40ac-b239-d877709b498a@linaro.org>
Content-Language: en-US
In-Reply-To: <4421c95f-3ee7-40ac-b239-d877709b498a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC66549353F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241865-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



On 4/28/26 3:57 PM, Tudor Ambarus wrote:
> Another thing that I thought about was about the reordering of memset
> and set_bit in acpm_prepare_xfer(), but even there, the internal
> execution order doesn't matter. Both are guaranteed to be completed
> before writel (wmb).

I need to correct myself here. While the wmb() inside writel() does
prevent the hardware from seeing incomplete state, my previous
statement was slightly misleading regarding the local CPU pipeline.

The wmb() alone does not prevent the CPU from speculatively trying
to wipe the memory before it actually finds the first zero bit in
the bitmap.

What truly prevents speculative execution here is a strict
Address Dependency (implicit barrier). The CPU mathematically cannot
calculate the destination pointer for the memset() until the bit in
the bitmap is identified. I will add a comment in the code describing
this dependency.

In what concerns that set_bit() in acpm_prepare_xfer(), we only need
to ensure it is visible before the next TX thread tries to allocate
a sequence number. That is completely protected by the tx_lock
boundaries. The RX thread does not care about set_bit() at all — it
only blind-clears bits based on the rx_seqnum it gets back from the
firmware. I'll add a comment documenting the set_bit() safety as well.

Finally, regarding test_bit() and find_next_zero_bit() in
acpm_prepare_xfer(), they are functionally equivalent. Both are
relaxed, barrier-less reads. The non-atomic find_next_zero_bit()
introduces zero concurrency problems because this phase is strictly
a read-only search (if we read the bitmap just before the RX thread
frees a bit, we simply skip to the next available one).

I'll reorder the patches and put this one as last in the set, I want
to have the find_next_zero_bit() before it, to not touch the same
code twice.

Thanks,
ta

