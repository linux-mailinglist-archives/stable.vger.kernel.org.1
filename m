Return-Path: <stable+bounces-269927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bEcwIOiQQ2rUcAoAu9opvQ
	(envelope-from <stable+bounces-269927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:48:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D92016E26CE
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:48:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=r2ceabJY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269927-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269927-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 716CE3080B2E
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC88B387363;
	Tue, 30 Jun 2026 09:43:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6637F01B;
	Tue, 30 Jun 2026 09:43:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812602; cv=none; b=TKteSnyzJ5lrqIOUpU3buLdAgBlGCKUl4k7aC6n3VRtR8F0jK8zJ/JctXRMwm0+bTj+/g8HuCV2I/P+Gz1kxBCBuayd0tSego/Wx8BowP/0lisLk4IeY/uUEmfb3WVszicHTPeJ/WBM146vMo6BJQ0tsuR7aUJzSAvLjaXmGVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812602; c=relaxed/simple;
	bh=2CZ3IBM/SX7QrvokcEf2DjBZg7/wMx5sxrEESHTc7qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+trmzHceutEl8pgO6YwKJI+7fXAOiu2XVeb+M1PlJQpC65LQD2SKTN7ZlPcJ0YxtIEer3dO3krqb6r+CsOPSwHETW4gOqurvFUw9C3/XM/Myp+KRXfeDmSy8cDaU9UFM95enN+FTFKdkdbrDnanlMTACEsVkdQzOUnsbBzDBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r2ceabJY; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+KtGqf5qrj4n5Eu5jLie9nXpmZtOilkQd9anw89Ux9A=; b=r2ceabJYVvP/EszJ712Ba3hqal
	FshM/Pa21JdfJFUvMwZsUVpI0yEc+gSQkpgp6zkiVQF/C2sEqY4bOpWtMLoSFr8HrunrI3HH24D9B
	TdWAofRRcyMpjR8hxO/pVdbYCeOx5Vw/Q9bYWLAYURnpeThOiTv61e5t3VJjtJjh8kkBwdTvG5xMz
	vIRzsZwP0XFbi7Xaw1jfypiCCzSqobeM8mE8rllLoCzxbn0W7KgMwh6O7UJwGK/1+PMBlav+J3dRH
	di8U6IniwBRyui6uXc9T8VXU9ta14x0RUdX0lMK6DKlHALzPcEWoLo6mEoc7PBaLeHw5+BMdcqkEG
	z6bjjQ7A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weUzq-00000004jQv-03jb;
	Tue, 30 Jun 2026 09:43:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1AC16300339; Tue, 30 Jun 2026 11:43:13 +0200 (CEST)
Date: Tue, 30 Jun 2026 11:43:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
Subject: Re: [Patch v3 1/8] perf/x86/intel: Remove anythread_deprecated bit
 from perf_capabilities
Message-ID: <20260630094312.GA751831@noisy.programming.kicks-ass.net>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
 <20260612090114.3188886-2-dapeng1.mi@linux.intel.com>
 <20260612094648.GB42921@noisy.programming.kicks-ass.net>
 <96a18944-bc0d-47dd-b435-e9aa63b93c43@linux.intel.com>
 <20260616100202.GJ42921@noisy.programming.kicks-ass.net>
 <47a9642f-68ab-432c-a607-548995bd82fa@linux.intel.com>
 <27d77639-a948-4f0f-8cb5-1d06966bac0f@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27d77639-a948-4f0f-8cb5-1d06966bac0f@linux.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269927-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dapeng1.mi@linux.intel.com,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:alexander.shishkin@linux.intel.com,m:ak@linux.intel.com,m:eranian@google.com,m:linux-kernel@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:dapeng1.mi@intel.com,m:zide.chen@intel.com,m:thomas.falcon@intel.com,m:xudong.hao@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D92016E26CE

On Tue, Jun 30, 2026 at 05:14:41PM +0800, Mi, Dapeng wrote:
> Hi Peter,
> 
> Could you please queue above latest v4 patchset
> (https://lore.kernel.org/all/20260616044654.3468742-1-dapeng1.mi@linux.intel.com/)
> which fixes a defect in patch 5/8  "perf/x86/intel: Validate the return
> value of intel_pmu_init_hybrid()"? 
> 

Damn, I knew I was forgetting something :-(

Let me go fix that.

