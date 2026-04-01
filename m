Return-Path: <stable+bounces-232700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMnCLJu6zGmcWAYAu9opvQ
	(envelope-from <stable+bounces-232700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:26:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FCA375279
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFD9830A94B6
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 06:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7664B32E757;
	Wed,  1 Apr 2026 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iafV/uxO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE233260F
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024595; cv=none; b=D12M3a2Y4LUyfBj2P8hWrt35+Chx5itynFpwZ5A3OG9LwLxT2UjMDjqcw/2XcAxGIkYVuCjK3K+JmEnb4JRJ2bSTNbe3C8ZY3YdrIXFZR8jiiiUoIZo0PtW0OISrG3Y1zvq4/YRV1SweYbDPUEN6H1XffUnyjYyYcqO3f9z4YV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024595; c=relaxed/simple;
	bh=LeyqNpA5ssTPwsvKghroEuvcUmBk6n+tD8cQ8ghC0+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVbY9mwcpXjr9Feoj9LPW1f8TuyYNOh7gAN+pz+7+tc0zYV59fB58uVW0iHR/dN5X4u2lRzesveSGr5K16R5rJevqHUPeeWHgo0CJ44EI9E0iyyNz2xoVAE/nG0tB0KrIZxo3WFgBmVrhBRGWrubLtMmx1f1DycE2eYwYM8S4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iafV/uxO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d9827661bso2045857a91.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 23:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775024593; x=1775629393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DC+k6uIWVW8fAT/cjzx0lUKNsx6vDrO9typRxG9SNSQ=;
        b=iafV/uxONhR+X5W+Gqk09/rYFFS3fBwgEr6To7OBHzIRrCrhb/tOqx6hfCPq/niPLQ
         gC0XdumsJAqmfed64ZXQTS3LwwlIYf7mRDqeTmVxpEn6FhdxNLGurfsgEBPOwM/ar2RR
         nKq6BIqV3WNYcTrQ/I63KHdBmMFcU7jYHwJzzgekxe0zsFIB13IUxHkNjmbcmll1cWPS
         82cQXJMFGz315OzhtYdUjHe2cTkbGCQUgwhmChn/4QJrLEhgxvSWiuaKknMzl6rZfe3M
         fbT/ZkSvR/56TXSLWuYm4UANiLfZk+qrYG1gEiAmvkkJZ/cb19L62FWaK1Ef1fT4Iep+
         16lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775024593; x=1775629393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC+k6uIWVW8fAT/cjzx0lUKNsx6vDrO9typRxG9SNSQ=;
        b=ItrICy1vfRJmDePtllo4cgQjns5LeZusgoRKLJMHLb6s1mi5KRcOBbBiZMikBC6o7D
         FDkglD8jKcQlkcM9mEENKc8LA7hToQBUbhUfMHay2f1au0r+4Ef+9WoB0dirguxu9KFf
         O279W4xgKphiQksCv6tydLwbXIhf+gZLpyNZYqrF9nQo1KI2HgBQoleycyJJTGFqI0pb
         WWkz21tW2G+fO7Yf0ypUk3dzyb9CkGVJcrYQiRpuLZR0TsmEjH+SC2GPVKgeja84/26M
         6JRvUkiyq8W1ApVBRI+f7EX7dKGUNX0+0RG3YaHMEFMl3hJit/ff4456+amukTYceVW9
         ghmA==
X-Forwarded-Encrypted: i=1; AJvYcCVzflHi0t4czgZKkCj84ccVBDIcm5bRZ4nvP/UF8EDG4JVxUEPuUkWy1DKwj+0iYSVrXFepX0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4YbGScb0k5M/y8S1T0VwUWgElM/dNdhCOMWzcoZ9I6TMjLF6
	DsJxNPcXlW1855DSyyMs9ZOKjCikMSC7Knz8a1zAhQhtrli17Fs+CKGut5vr3w3ECVw=
X-Gm-Gg: ATEYQzxEeDVZMmtwfIErwXkT63EI9eukA6pb2fOg1MrBHXtEN++YkyUGgThcriqrOrU
	pkOw3je1NOkTbkjmZMsn2LIY+qugkzej/20TQxegDctHy3A+Hzw9eh8tUhSUqMg5OeNZ0t2Rr1Q
	ddDHzuy03fwkdBJ/3Ubh9aKFaqgWNdKQ4xYLuItuau5ApAGUGVQkMtlrOQ7XwVijSqoGL7KwN0d
	4QwysaarTlCLmpYckOQ38t7pC9UwVflT3cwNlCl8tUvioQ+qlBNRCpS0i3Yj5tHr0jUkU1kUa4h
	QsQ2QADrEQEIR3nG9omKTg6JWtD1GFxdcF6jKSI/DpEi9VdGc3R9UkNz8U7dYSz5pfRNt9xMxvI
	h74/Ldl8VYmVCAUaNHz5GJ1lYoCKTk+gzVfala9/WVsYVmMRNHAEdHnvVaBZGCR9Zb/UX04swbY
	Q3gb3OsBxqHFkyW8xsUUaHFyJG
X-Received: by 2002:a17:90b:384e:b0:35b:929f:7e8f with SMTP id 98e67ed59e1d1-35dc6f1a0d9mr2202122a91.13.1775024593274;
        Tue, 31 Mar 2026 23:23:13 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dcafd004fsm920812a91.12.2026.03.31.23.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 23:23:12 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:53:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Tobin C. Harding" <tobin@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: governor: fix double free in
 cpufreq_dbs_governor_init() error path
Message-ID: <aziv3yszmqef3amj3wgnutif7eop5slnmf5eqrg6rl7sk5ghf3@7et2qcnti2y2>
References: <20260401024535.1395801-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401024535.1395801-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232700-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10FCA375279
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01-04-26, 10:45, Guangshuo Li wrote:
> When kobject_init_and_add() fails, cpufreq_dbs_governor_init() calls
> kobject_put(&dbs_data->attr_set.kobj).
> 
> The kobject release callback cpufreq_dbs_data_release() calls
> gov->exit(dbs_data) and kfree(dbs_data), but the current error path
> then calls gov->exit(dbs_data) and kfree(dbs_data) again, causing a
> double free.
> 
> Keep the direct kfree(dbs_data) for the gov->init() failure path, but
> after kobject_init_and_add() has been called, let kobject_put() handle
> the cleanup through cpufreq_dbs_data_release().
> 
> Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

