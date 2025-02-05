Return-Path: <stable+bounces-112289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331CCA28717
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 10:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBFC1882DB4
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC2A22A7FA;
	Wed,  5 Feb 2025 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iBixuYjG"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599AD22A7F7;
	Wed,  5 Feb 2025 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749319; cv=none; b=EMVcvQycenCGoi5UNMJJZYRyGiJXld1tbWBCp40q/m2yMyO1l6LHGGOpfc4O42ipN6JNH5zQKC+6Wt3O17sS+XP6vWvvtAUfQ1tAnVXbZPo1szDpIDvhmgWRBFPdOT+YPNObL/doVg5ROLUvgJnP+ZKFEpy6bGe4zojz8+RwzrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749319; c=relaxed/simple;
	bh=dKlRgSGRbfw6+c39prvzrTOluy47PorwLsxuzZbjYpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=og1NS9EBI3QVrTFVd1w6OvYndz/6+fndny/wZeyVE42MejSpw07iLfUdagDP4a6KVxM6RWlGnIbfW2ly/f4ACMX3tVIMuMq+hhcx6H5sUOY30AO6kX2c7SyRZfGynKZccFQWUCifGzS0Ne+4/c8RkqJdYuJ6BjBdXoVt+kNG4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iBixuYjG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lC9d8s8ZotVqoLxPT4Hp7XGqQ+UR9JIuOgr+9Vb/G9M=; b=iBixuYjGdgIxyzsfsQ7hOrnlcx
	HvKEGlCNtQQEQ7IwKY9MzmpeFXf8XT9uaTtQn3z60Wa+oZqVAOz5Uft69JZg9FicmtnteCB69Qn7q
	ut6J49AVDPezcsNc570A19zhT306iUQPI54mB3sKxaexrVtkseBith810YnMEMZIUpsHHPMJUp1ce
	EGIE6sVoe/pK4QDBhwzEIf4lomECj1Tu4WGVwuZHhSrnG9iAgW5vZTgQ4VcszRFWpL+alc45AIrTM
	lw5nSkfXdWzzxdel9jqsaDL6KwPi+uATDkLXjzfAb6O7wMnUXFHEu9Uybl/278vYQbcTLR0N3so+k
	46DDf29g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfc7f-00000004Dgc-2eFc;
	Wed, 05 Feb 2025 09:55:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C021A3002F0; Wed,  5 Feb 2025 10:55:06 +0100 (CET)
Date: Wed, 5 Feb 2025 10:55:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	srivatsa@csail.mit.edu, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v3] sched/topology: Enable topology_span_sane check only
 for debug builds
Message-ID: <20250205095506.GB7145@noisy.programming.kicks-ass.net>
References: <20250203114738.3109-1-namjain@linux.microsoft.com>
 <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6bf04e8-3007-4a44-86d8-2cc671c85247@amd.com>

On Wed, Feb 05, 2025 at 03:18:24PM +0530, K Prateek Nayak wrote:

> Have there been any reports on an x86 system / VM where
> topology_span_sane() was tripped? 

At the very least Intel SNC 'feature' tripped it at some point. They
figured it made sense to have the LLC span two nodes.

But I think there were some really dodgy VMs too.

But yeah, its not been often. But basically dodgy BIOS/VM data can mess
up things badly enough for it to trip.

