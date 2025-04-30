Return-Path: <stable+bounces-139125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C2AA46F3
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 11:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04713B4BB2
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 09:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE2D231833;
	Wed, 30 Apr 2025 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fNHWhPow"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF4231830;
	Wed, 30 Apr 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005128; cv=none; b=l7jgXSiFhJvu+uI9SyGx6toNg89RwAnn2UubIHIg1RjLJg8/HkbHdR0Fskntwr0IzrPXgm5uKKJSem6VAQ4BXPOQt5LcPOAaOj+F7L+IlEYSVxHT71G/u51ROUDLP8p58KjG74+r4R1def+fSbOl6pbo4FX4qfc5WiLB/JtmAek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005128; c=relaxed/simple;
	bh=kM42SKktj2dNOf8NBJOfjLlyuoqhDcyMQafUNOjcJ2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfy9SRMeOWcgIUq2TUK9PTTUAZKNiJe536QkQFDlkisEpEZVR2l5AJS8vVM/EKVnDOg2FX05synOSBJAPg742NrIKKFk5DuaOiJngpvHfynAroKBzJKft3ZTXysLzNtWKITbRw/MRNDnMCEbUlzxGZVGwrPRurdpphSbWexgUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fNHWhPow; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VAVPiUaHOhMsQmm4unIngcxM+UowNmfVEzLvUrtDK6o=; b=fNHWhPowS2BP6NxIKeLPVNmaGP
	kSeThhyowLUFeenbgk5mMmyhdKRU36jwAMj6OHWVtEvitS5VJCTpcVm2mLuI6kVjYxO5NusXqsDGM
	aghdecZvFL+dUTUktvkYo4U714PqlLGkKl3IBRcmWGVxJtEOk4c7AEWcvmKGmeu2//lBg7rSKpofk
	ZuLbtIF9f1KzAfD8t9DDQKpfRFW8vXlfjaTwXb71sqzwvR5Cc0Ljlp3g7VPxaPcp4z8OI31+mrCQ3
	wIb+hNsg/fLF67l7N8L/YEV12s/dGJkzpCCymt9bjmE0zG15imy1zMp5B+DR+QWFBI1G4SyncODgi
	K8cW93wA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uA3gr-0000000Dl1E-2qXN;
	Wed, 30 Apr 2025 09:25:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F1155300642; Wed, 30 Apr 2025 11:25:16 +0200 (CEST)
Date: Wed, 30 Apr 2025 11:25:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Jean-Baptiste Roquefere <jb.roquefere@ateme.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: IPC drop down on AMD epyc 7702P
Message-ID: <20250430092516.GJ4439@noisy.programming.kicks-ass.net>
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com>
 <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
 <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>

On Wed, Apr 30, 2025 at 02:43:00PM +0530, K Prateek Nayak wrote:
> (+ more scheduler folks)
> 
> tl;dr
> 
> JB has a workload that hates aggressive migration on the 2nd Generation
> EPYC platform that has a small LLC domain (4C/8T) and very noticeable
> C2C latency.

Seems like the kind of chip the cache aware scheduling crud should be
good for. Of course, it's still early days on that, so it might not be
in good enough shape to help yet.

But long term, that should definitely be the goal, rather than finding
ways to make relax_domain hacks available again.



