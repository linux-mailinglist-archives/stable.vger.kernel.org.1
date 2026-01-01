Return-Path: <stable+bounces-204410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F942CECDE2
	for <lists+stable@lfdr.de>; Thu, 01 Jan 2026 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D0033002870
	for <lists+stable@lfdr.de>; Thu,  1 Jan 2026 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016132222BF;
	Thu,  1 Jan 2026 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3llcKuI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C317A303
	for <stable@vger.kernel.org>; Thu,  1 Jan 2026 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767256041; cv=none; b=qQfWeKNlJ98wtq+0HJ315xprw+zryjBFzNFXEUcqZQEd8qtlh2V2Wu4FJPd9yoxoj7gw15BRkSNua7cURRftvowffHM0hSVONstooSeeHNoYZAxCD2nbbqaQvvuibCbcQBcgzKy/irSPBZAijYxruCHJ5qL+KMQkPac7CSGVn0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767256041; c=relaxed/simple;
	bh=g1mMzgD2REYJsThm5iAh62mc8uScUvCP1p2CjKOd77g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjJRbObvXdAJpW2j54snnVX93nyWUUKr450W6ScZRuRaIKo+Kt5hYpx9MRn0++hsBiZBvNyOxzjupmCh+Qw77mM1ZhMFC+VsRwFpH9bwicqtwA2xODj6Y17HBLk0CrAeDI1BpZz/EUO2POcizpXEFDz17qHmOBdETMuwRhFHd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3llcKuI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so9639589b3a.3
        for <stable@vger.kernel.org>; Thu, 01 Jan 2026 00:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767256040; x=1767860840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=grqBbaE6YnOptD2H7gCSdhIM6A7QBPysLgSlWzZLLhY=;
        b=O3llcKuIlO6pwBCQR7JhpoSws6bzbbdDwMeuhPDpT/WeHwZ+yUhI3zdpndQvaPgP6u
         MAvFGThj7ftw8nZ9rSCAHP/zo8ZBpW0auIilbJNd2JRoBDqh0OEi0v496E+7Fn33nuHw
         BUzDxHwcurxcIyVdCPx6/SO7A5XHMDS4Y/ipJcdGWy3lSyjV7h+Mz9LcXRU2+7TzPT2/
         XNdwlMdxantQbaqAZZF8JGzJ2hzpOJGTmkm9GwJ9evKeOGNSba+gQqhQouNLiwRkUw0w
         2V2o1K8kxlDAfOQDIqwbiHLXzLrfpJzlaUoqI0ybuCyJ4rxv8wQ7JdtN9TYG18eTn1QY
         xQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767256040; x=1767860840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grqBbaE6YnOptD2H7gCSdhIM6A7QBPysLgSlWzZLLhY=;
        b=mMBvI7fi9NRiRwDfmNozOJin1+lFzAJpgD3X2KKo4lZ1M5nahpjPyHp1citv1fBvnA
         8On6rVxqi5uIyTP80W9NiEbkr68cyMJRrPCJIENwiTrnT1N4h+eSei57XM6KjaX3Xkec
         x2KKzSwjyjmHGzrdgKM1t1OAxq2rAhZrKuFnDO3Ethwhr0QFrYhpnhaqlqgUIGfp8pT9
         jABEUpuVcSFUOYK2MHRSMJtcBlePNyIBlmJaWO0dHtB/i8YCPdEpV0ufjKX8GeuYkRk5
         TEin90WBkYS4VTq9mHPtnDNZqL0YNChdjPFeA9/6i91nApG22+eC1E76pBqT9Ps0kZZc
         d5gg==
X-Forwarded-Encrypted: i=1; AJvYcCUV/Nb4+SeuX2QYsF31xTN3cbXrYluAVhhitDqnCQk1BhDY/6TeinJYMiTbeIFacETjO+wo+l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOxCaFrSZU89744Em9J4+D4Fzbu9sS2E5O8l/d54D0uQu3vdL7
	7AXI36T0r67t+igOpUuB+CcZCT8G5kk6v4OHSPl+acqflstoZ7FJxuiG
X-Gm-Gg: AY/fxX7AC2P2JZxrLgSSmGckIWp2cARt1k/eGyCNBHvutv6SyDLbfX82RUwNQ3KxNes
	EzOkoSJDQ3LEdUzChyqphLF2/sGPVWHsI+LzOtBKp78+KEzhCFuNJBRrc4TlfgOf8Jq3RckTeub
	CRu8O+hvY5YFLsAlnjgQRVbMvERSHRUnKSWuFsc9D/1XkOGYrF1Kk29XcW372RFZcftglhVrCeH
	YVLf3H+MVUu+vuR2Vx+Ao368F0IVjNqjuxdsDXoc2ygyCMYPWYPdYjIQvD85Xkd+buuDHg7BVNs
	CZ/M+HR0YcMQYxpH3raK28lwKFv9+Mk/e3KH97bSSRVS72kwfpz/qDoicNq8UWvyXKaSGmQuDTW
	53SNvXfUMugjLn5OTlpZGbmaPbJnenTbCOzDhFzvhmWLIIAb8/Ut1znJmVqAKOA4MqwxXwLNqES
	7bd/urr1lUar3Hos4HQ9JuYnk=
X-Google-Smtp-Source: AGHT+IHhkA3a5smj1iEMSa2b7GI5Q9tU3FN8KidSwq7FxEo8bwOhmjGkB12B1a/5qh/4kK54JlHQYQ==
X-Received: by 2002:a05:6a21:32a7:b0:35f:68d:4314 with SMTP id adf61e73a8af0-376a7afae04mr34883862637.24.1767256039592;
        Thu, 01 Jan 2026 00:27:19 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:df89:9172:9a1d:16f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7ca0baf3sm33118003a12.34.2026.01.01.00.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 00:27:18 -0800 (PST)
Date: Thu, 1 Jan 2026 16:27:13 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Lucas Wei <lucaswei@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	sjadavani@google.com, kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, visitorckw@google.com,
	marscheng@google.com
Subject: Re: [PATCH v2] arm64: errata: Workaround for SI L1 downstream
 coherency issue
Message-ID: <aVYv4bf8BVW8b-Sf@google.com>
References: <20251229033621.996546-1-lucaswei@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229033621.996546-1-lucaswei@google.com>

Hi Lucas,

On Mon, Dec 29, 2025 at 03:36:19AM +0000, Lucas Wei wrote:
> When software issues a Cache Maintenance Operation (CMO) targeting a
> dirty cache line, the CPU and DSU cluster may optimize the operation by
> combining the CopyBack Write and CMO into a single combined CopyBack
> Write plus CMO transaction presented to the interconnect (MCN).
> For these combined transactions, the MCN splits the operation into two
> separate transactions, one Write and one CMO, and then propagates the
> write and optionally the CMO to the downstream memory system or external
> Point of Serialization (PoS).
> However, the MCN may return an early CompCMO response to the DSU cluster
> before the corresponding Write and CMO transactions have completed at
> the external PoS or downstream memory. As a result, stale data may be
> observed by external observers that are directly connected to the
> external PoS or downstream memory.
> 
> This erratum affects any system topology in which the following
> conditions apply:
>  - The Point of Serialization (PoS) is located downstream of the
>    interconnect.
>  - A downstream observer accesses memory directly, bypassing the
>    interconnect.
> 
> Conditions:
> This erratum occurs only when all of the following conditions are met:
>  1. Software executes a data cache maintenance operation, specifically,
>     a clean or invalidate by virtual address (DC CVAC, DC CIVAC, or DC
>     IVAC), that hits on unique dirty data in the CPU or DSU cache. This
>     results in a combined CopyBack and CMO being issued to the
>     interconnect.
>  2. The interconnect splits the combined transaction into separate Write
>     and CMO transactions and returns an early completion response to the
>     CPU or DSU before the write has completed at the downstream memory
>     or PoS.
>  3. A downstream observer accesses the affected memory address after the
>     early completion response is issued but before the actual memory
>     write has completed. This allows the observer to read stale data
>     that has not yet been updated at the PoS or downstream memory.
> 
> The implementation of workaround put a second loop of CMOs at the same
> virtual address whose operation meet erratum conditions to wait until
> cache data be cleaned to PoC.. This way of implementation mitigates
> performance panalty compared to purly duplicate orignial CMO.
> 
> Reported-by: kernel test robot <lkp@intel.com>

I assume the Reported-by tag was added due to the sparse warning in v1?
Since this patch fixes a hardware erratum rather than an issue reported
by the robot, I don't think we need this tag here.

Generally, we don't add Reported-by for fixing robot warnings across
patch versions.

Regards,
Kuan-Wei

