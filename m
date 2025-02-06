Return-Path: <stable+bounces-114121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D8A2AC67
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E333A5F03
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0401EDA2E;
	Thu,  6 Feb 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFkn4ghC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF01EDA1D
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855467; cv=none; b=QfsPmQm4d+36c3e0+zyGHpUq1JL6q5r1tJyxiRma2skcqb8E6PyQ/bQxck+68mAqseGS6VLTImSUCcPieAsTb6WmKI3/gDoVJ+3/r3xtzoXTddeyVmcBEVC26+DVI/vq1XkDs5gngDFqAfBH2YBq0B7u9FXCwc39ncZEFIEGPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855467; c=relaxed/simple;
	bh=YPphV5G62CFL8KuQxZ3yO1XWPORZFgSc7KgvCiPN2mM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cetPVcGUgY7qRCXbTkqG7trgwgflFmulPW2UZH1SR6jEbDXmgJYFYhKUOokwBdvrVr59djGTjTTFO4+5CmS20kr319ZTkQeyFCdR6dj7Ym8qV52vvwO4J6xE8s0waMAunWQjkBzDFEFPhp/e71TRQ1HV3rsaGB8Ea6GMfcKODiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFkn4ghC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738855464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsSy0hAlezuKAgobid2coWCPgueOf9jZ3at11uhkyPc=;
	b=MFkn4ghCYo46XKoaJuWC5KubVLr6kKkH3rUL4IJPmnLpde9yXBQOrUL7UIdo/K9J2apUdC
	Yam3gxAc1ppJXZcRaHuRoQvXSLemG7josx2ZcODnwf3F27adPk3ptKDJbMz6jzL9jHk6Kx
	w4iRvrissDM3xKAxcSwvHGEcu0Ikl3I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-ha8f2_Y2PFmImgyKxLeUGw-1; Thu, 06 Feb 2025 10:24:23 -0500
X-MC-Unique: ha8f2_Y2PFmImgyKxLeUGw-1
X-Mimecast-MFC-AGG-ID: ha8f2_Y2PFmImgyKxLeUGw
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e4237b6cf0so15204556d6.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 07:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738855462; x=1739460262;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsSy0hAlezuKAgobid2coWCPgueOf9jZ3at11uhkyPc=;
        b=fvuNkFe+o0Ca1+kpEytdlda5oTbw2Lqntqf5eJiu08X9dULwa7zkEsgWQvURS+TIzL
         UcNQvzQRZ7t0ZiBux+zsFT7zlYSnI5OvoqUHvgV6WkyALqVtRXr7ry/wQuI4BEvGVumK
         IWm4l8B6kH6K25QIbX/JuInwBRRjTIzyX8dvDCHSRof42rkpsYPfXAg/7frfIC+uomFu
         4UiEQABgMjBHFW1ue6eJ3oWTGDWbyU0fUyes7T5bP5yKFUzLWx60H6TdeoneCmatiZTC
         /fcOG7XoVLkkfu8FoyMs35XurlVj7TbHdNeIz6sVHWvDuvvBIqVk2QGJ6qms8fe21oy+
         O9rg==
X-Forwarded-Encrypted: i=1; AJvYcCXIS7e2G4ryKpF+bZAEJfZ04GtMKG9f7QWzrJp1GoVsykcywpErOGvIhp9xqpo4InMxvn7amcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5JeGu8eyuDwynOSrlBQpHxqE3gdPxa1IiQBfiJfF86Y7BOGnT
	mNEMcPkOvGgShq1ftJbV8KaRpuNarli9lMep7hxw9drWrHbQWHRQWVLjoNgnt1J8VXp7tzeCRgR
	BCw6EzoARTxvux4rtVZvZYuiQaSCSh8VNBwZrT0dmH434KD2Z/YPc+Q==
X-Gm-Gg: ASbGnctCH8kwDLKXEJ/7059LzZHAljNungvDDAXGPv+AoliqtuVktmldcYoGeAWfc+3
	K0gnyKObVBWRNLTY51ehcuvJAmHwK71587Wml7gK4ujwCnapZ803MozrYowSGEHnHUCLQjwlTKn
	gOEvD434TQMgUrjtqtckgs192jH1Xmxk9vyEEYHLTrJG5NL1ZjCJ/UYXBxqrQmyOUZelHGPiB9e
	yg4vD4Z67/3UYNs+ka4ucXy2dbYj4SFH62Ns2c8c8nSzBuYwJFiB29BmFg9PGe/AHl4jJzXaQ0/
	xiacuQ3Rn+AxvqhRDTslgfOIUd4IB6e0GS8yX7h8IaoABdYN6o2CqLLX0eVrvbFj3Q==
X-Received: by 2002:a0c:fd87:0:b0:6e4:3478:b55a with SMTP id 6a1803df08f44-6e43478b75bmr57603366d6.35.1738855462430;
        Thu, 06 Feb 2025 07:24:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAzIP3FPchsTGksDad8A1HROFqTYUizQO7jsonTZtU1t1mZ2sva4db+JAsMgyMPkDZ4m50qA==
X-Received: by 2002:a0c:fd87:0:b0:6e4:3478:b55a with SMTP id 6a1803df08f44-6e43478b75bmr57603066d6.35.1738855462057;
        Thu, 06 Feb 2025 07:24:22 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacac6sm6602286d6.87.2025.02.06.07.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 07:24:20 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>, Saurabh
 Singh Sengar <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
In-Reply-To: <e0774ea1-27ac-4aa1-9a96-5e27aa8328e6@amd.com>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
 <20250205095506.GB7145@noisy.programming.kicks-ass.net>
 <0835864f-6dc5-430d-91c0-b5605007d9d2@amd.com>
 <20250205101600.GC7145@noisy.programming.kicks-ass.net>
 <e0774ea1-27ac-4aa1-9a96-5e27aa8328e6@amd.com>
Date: Thu, 06 Feb 2025 16:24:17 +0100
Message-ID: <xhsmhed0bjdum.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/02/25 14:40, K Prateek Nayak wrote:
> What topology_span_sane() does is, it iterates over all the CPUs at a
> given topology level and makes sure that the cpumask for a CPU at
> that domain is same as the cpumask of every other CPU set on that mask
> for that topology level.
>
> If two CPUs are set on a mask, they should have the same mask. If CPUs
> are not set on each other's mask, the masks should be disjoint.
>
> On x86, the way set_cpu_sibling_map() works, CPUs are set on each other's
> shared masks iff match_*() returns true:
>
> o For SMT, this means:
>
>    - If X86_FEATURE_TOPOEXT is set:
>      - pkg_id must match.
>      - die_id must match.
>      - amd_node_id must match.
>      - llc_id must match.
>      - Either core_id or cu_id must match. (*)
>      - NUMA nodes must match.
>
>    - If !X86_FEATURE_TOPOEXT:
>      - pkg_id must match.
>      - die_id must match.
>      - core_id must match.
>      - NUMA nodes must match.
>
> o For CLUSTER this means:
>
>    - If l2c_id is not populated (== BAD_APICID)
>      - Same conditions as SMT.
>
>    - If l2c_id is populated (!= BAD_APICID)
>      - l2c_id must match.
>      - NUMA nodes must match.
>
> o For MC it means:
>
>    - llc_id must be populated (!= BAD_APICID) and must match.
>    - If INTEL_SNC: pkg_id must match.
>    - If !INTEL_SNC: NUMA nodes must match.
>
> o For PKG domain:
>
>    - Inserted only if !x86_has_numa_in_package.
>    - CPUs should be in same NUMA node.
>
> All in all, other that the one (*) decision point, everything else has
> to strictly match for CPUs to be set in each other's CPU mask. And if
> they match with one CPU, they should match will all other CPUs in mask
> and it they mismatch with one, they should mismatch with all leading
> to link_mask() never being called.
>

Nice summary, thanks for that - I'm not that familiar with the x86 topology
faff.


> This is why I think that the topology_span_sane() check is redundant
> when the x86 bits have already ensured masks cannot overlap in all
> cases except for potentially in the (*) case.
>
> So circling back to my original question around "SDTL_ARCH_VERIFIED",
> would folks be okay to an early bailout from topology_span_sane() on:
>
>      if (!sched_debug() && (tl->flags & SDTL_ARCH_VERIFIED))
>       return;
>
> and more importantly, do folks care enough about topology_span_sane()
> to have it run on other architectures and not just have it guarded
> behind just "sched_debug()" which starts off as false by default?
>

If/when possible I prefer to have sanity checks run unconditionally, as
long as they don't noticeably impact runtime. Unfortunately this does show
up in the boot time, though Steve had a promising improvement for that.

Anyway, if someone gets one of those hangs on a

  do { } while (group != sd->groups)

they'll quickly turn on sched_verbose (or be told to) and the sanity check
will holler at them, so I'm not entirely against it.

> (Sorry for the long answer explaining my thought process.)
>
>>
>> That I can't remember, sorry :/
>
> --
> Thanks and Regards,
> Prateek


