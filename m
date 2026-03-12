Return-Path: <stable+bounces-224814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ae8NOxtsmkpMgAAu9opvQ
	(envelope-from <stable+bounces-224814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:40:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1BF26E664
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01438306147D
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E82D2381;
	Thu, 12 Mar 2026 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ozKA/ywK"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F732874E3;
	Thu, 12 Mar 2026 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301224; cv=none; b=MvGPq3Ui7AQXLPXTqrGhDkOzMjzYG+B4vOntf8KIV+1SKdk8i3qE0QhQWdcWtfg44F/bONvyDW8JuDs+XSDxvpBvPrgsUBwxPcujvlmCGTiGbmFC+hxDS8rZqPP/F0Bpv7bofZFtdCym7W/rqebAUV1Vxz9OlcviYfLGbhyxkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301224; c=relaxed/simple;
	bh=aKj2Org/E5VO5qL3REWrhMeoL6HDqLJVeRv5GP0VDgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGtmHXYFIxIeysZ9h/YY2mTLf1IatQvDpAMUobJ/i2e/9eX3s7Jq22PjQ4netJlssnInIk/LEODR5bGp+A5KqaGordqeJQPCycE5JGJ2Mpaf3wNfegYKTAoBlY56edB1Odx6XhLCOSp1u79M0Ut0Jlp8a/WBfIcqsJBHMT3MQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ozKA/ywK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kwQVT9sbBkJ9n5/ZZxISyyif8zRikfHtdtupM6rsnR0=; b=ozKA/ywKCeCxxRsRkKE5N8/x4N
	lwtOvu38T1Ag0W3eKrTSgFMr9gRKHI1NRqyygKz5ODaFczbSjXQhTlHO8ajCpXomnKZe698PxGNEY
	aoxRGYqijHeDtaojxJ00zLjkEmNZd9isVzU3YgaWOE4u6rlmS8G3S2X2FJpFLuvmIMuw0RSTE6frN
	7bqZ1RQ1oLCYPuQXIDtSxPUk+23oIkIud6n4QCuRHocvqlwDLdzrB4W3S4nb9xheyEsgIaH8mX9mc
	fEiNnZfqwhPWEP568hRVpkcwRd9MEgclJpf1qcM4AXv0pGz2z3HsavZA6PZRtYX5VNyFsYB90il7o
	mTIy9G8A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0aeV-0000000AzPq-0lSN;
	Thu, 12 Mar 2026 07:40:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E6051301150; Thu, 12 Mar 2026 08:40:13 +0100 (CET)
Date: Thu, 12 Mar 2026 08:40:13 +0100
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
Subject: Re: [RESEND Patch 2/2] perf/x86/intel: Add missing branch counters
 constraint apply
Message-ID: <20260312074013.GB606826@noisy.programming.kicks-ass.net>
References: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
 <20260228053320.140406-2-dapeng1.mi@linux.intel.com>
 <20260311201625.GW606826@noisy.programming.kicks-ass.net>
 <0a720411-0b24-42eb-9897-856b1175aa82@linux.intel.com>
 <20260312064145.GA606826@noisy.programming.kicks-ass.net>
 <a856792a-89ee-4de5-9923-106a23c31206@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a856792a-89ee-4de5-9923-106a23c31206@linux.intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224814-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Queue-Id: 3A1BF26E664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 02:52:43PM +0800, Mi, Dapeng wrote:
> 
> Peter, As Ian points out, the patch "perf/x86: Update cap_user_rdpmc base
> on rdpmc user disable state" has a bug
> (https://lore.kernel.org/all/CAP-5=fWr2L6miiFZ6Km3HYEdmqp3T0NBL=WY3buKdKztW+HvmA@mail.gmail.com/).
> I would posted a patch to fix the issue. Thanks.
> 

Yep, saw that, its gone :-)

