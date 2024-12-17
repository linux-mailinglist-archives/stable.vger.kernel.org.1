Return-Path: <stable+bounces-104527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B47559F507A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C73D7A944F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E875A1FA8F9;
	Tue, 17 Dec 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ieG6thxT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68C1F9F70
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450960; cv=none; b=Y9C9t3D9J+rYlBfR5RXNVviQNEc9jNaVXaj8/CzD7hLPV07ktvFkhn1MucLjYai/138HeEfgbikf/jPc6GGeXUw7ukQiGuznOKp4sP7XrfX86OObUn2biHZ1TVUHv4pOxv96YiPHUC6WbBChB0sfh92HG7IsCxxHOY4yRK0N1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450960; c=relaxed/simple;
	bh=81eOhisOkkiYMuz5aDENJ0L07ifA4nDOqPEi7hjwfco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMbTchygtT3hSQ4+6Rp1u9qU83V/Y16L9eTa5Y311tDSqqMPjtUsmoHR/V/xoaQ2zkgUVtr6KTgFevx3TzQWmU8YwwwG+cTzWGYGHkf8dbQgxcURvX38/pht6gVsjo8pEMtJP7mN+RNPrHEkfb8xeqIJYLTCvWnfsUHwA21SiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ieG6thxT; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467918c360aso63848801cf.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 07:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1734450957; x=1735055757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZPTMFYjgagD9vXUB8hfJV4lWIxsKDKRvleZqrPiixs=;
        b=ieG6thxTe91rRrrk8R1JMmlny+ThVY7I3nP8nAWfKKi2ThlBaqBLsAkAXef3KEbDI1
         aBh88ljUjBaAIM1Y4kZfcxTwhLLH3AQwdm8RS+A16V6Nsqfx1Z/ICUYHw0UlFfS0JJig
         OEmexAy8+h/ZX3QqvaUriUX+GPkPUbmKNcLLG2CeFZePbrriC8VYdmkDXUbz1VZD8E7H
         RZlrTlgZyFWrDVQRMWzyL4Xf/awdgF9xXuGRSK5y1uhpCWlgD9lOxl+SBeBU8u2zvzeU
         CVzm3R9kC5iOWgNVIPWlmtTqcxpkTc5WNkewbvFrbzJgIFvJETXGewEwvacZLknZUg46
         t1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734450957; x=1735055757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZPTMFYjgagD9vXUB8hfJV4lWIxsKDKRvleZqrPiixs=;
        b=ib11LTqAHMa6B3vFyA/CZQ5Qp6tr/4Bzuilbznwnyv7WCt9FI3MCS4pxTjJYiC3Rdv
         C6k6ft4HWeiMfQKpsLMu/XYmixHiRZOcFmNm2Xg6ssPRaUqnG8tyfl2zFepKORK/utaV
         HmknmWzMNmLLQXM0j2XWK5UttEdLETA+hIrWjQyNvS+rnovMIUuc+ugIdmOQJ30SUFDO
         iZEE2bIZtx0rf9cdyxWrQQHTRFgLpPnzZNwFNqOK+Z8JhI2OM+SiNkzZvimO58Jjkpdn
         AU3AMYDz3ALrFPds3EoODMG9dVVUqB5x4WfCzlN+gpkl7K/QbgyzpVIxO0iM6R4Akddm
         stpw==
X-Forwarded-Encrypted: i=1; AJvYcCWhxojfpa17Y9QeX7qcFHVz/26s23ns/pQ/YA2xAgaZAbxpJhk+yLuE5hsNFAx9OfE6Jmvl4KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhCiG6c4Ltz7m1mUdRJsgI1uvmR/b9X0Qh7rrYGRVL87yc/Q0s
	/2ZXPQu+772sEIDpsYRObmdS7CQLmHR7dlaucZqp4D0a1DxTFrSMDhKnbf8sjYM=
X-Gm-Gg: ASbGnctUEcFBPT7B+1zXXTUzRLxzAS/cMcyIT1g41Ikdr39DNnxK3GpHU0887zygfq1
	Wjv1pPaT39DTXKp4N9mL5wRVeHlyoBX2C67m7Jb4S83Dy98062Q8G3LWihAtYUh9gTS1XxLfXWe
	YPdDZlJh3dx6+0TsQ+VOPsbhYj/hqi87FFAc2kcumL1gM5p0R0yx7Ji1grvky9/mDoOcDTLQY5T
	h0e1vm+n2/QMOylWBvq1HoLcjnRt69d+qMOU8jm+79QMXLG8FsXuCc=
X-Google-Smtp-Source: AGHT+IEaT2Pv15sPRiFkxD6+c3DIkhwkYwdNFL+CjC45Xpa4bv6O8SA2c0O3In5fD1t0Mm3JFoucOw==
X-Received: by 2002:ac8:57c2:0:b0:467:7295:b75f with SMTP id d75a77b69052e-467a581ac95mr339540231cf.38.1734450957097;
        Tue, 17 Dec 2024 07:55:57 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2c69b10sm40454121cf.18.2024.12.17.07.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 07:55:56 -0800 (PST)
Date: Tue, 17 Dec 2024 10:55:51 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
	vbabka@suse.cz, liuzixing@hygon.cn
Subject: Re: [PATCH V7] mm, compaction: don't use ALLOC_CMA for unmovable
 allocations
Message-ID: <20241217155551.GA37530@cmpxchg.org>
References: <1734436004-1212-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1734436004-1212-1-git-send-email-yangge1116@126.com>

Hello Yangge,

On Tue, Dec 17, 2024 at 07:46:44PM +0800, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
> in __compaction_suitable()") allow compaction to proceed when free
> pages required for compaction reside in the CMA pageblocks, it's
> possible that __compaction_suitable() always returns true, and in
> some cases, it's not acceptable.
> 
> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
> of memory. I have configured 16GB of CMA memory on each NUMA node,
> and starting a 32GB virtual machine with device passthrough is
> extremely slow, taking almost an hour.
> 
> During the start-up of the virtual machine, it will call
> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
> Long term GUP cannot allocate memory from CMA area, so a maximum
> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
> machine memory. Since there is 16G of free CMA memory on the NUMA
> node, watermark for order-0 always be met for compaction, so
> __compaction_suitable() always returns true, even if the node is
> unable to allocate non-CMA memory for the virtual machine.
> 
> For costly allocations, because __compaction_suitable() always
> returns true, __alloc_pages_slowpath() can't exit at the appropriate
> place, resulting in excessively long virtual machine startup times.
> Call trace:
> __alloc_pages_slowpath
>     if (compact_result == COMPACT_SKIPPED ||
>         compact_result == COMPACT_DEFERRED)
>         goto nopage; // should exit __alloc_pages_slowpath() from here
> 
> Other unmovable alloctions, like dma_buf, which can be large in a
> Linux system, are also unable to allocate memory from CMA, and these
> allocations suffer from the same problems described above. In order
> to quickly fall back to remote node, we should remove ALLOC_CMA both
> in __compaction_suitable() and __isolate_free_page() for unmovable
> alloctions. After this fix, starting a 32GB virtual machine with
> device passthrough takes only a few seconds.

The symptom is obviously bad, but I don't understand this fix.

The reason we do ALLOC_CMA is that, even for unmovable allocations,
you can create space in non-CMA space by moving migratable pages over
to CMA space. This is not a property we want to lose. But I also don't
see how it would interfere with your scenario.

There is the compaction_suitable() check in should_compact_retry(),
but that only applies when COMPACT_SKIPPED. IOW, it should only happen
when compaction_suitable() just now returned false. IOW, a race
condition. Which is why it's also not subject to limited retries.

What's the exact condition that traps the allocator inside the loop?

