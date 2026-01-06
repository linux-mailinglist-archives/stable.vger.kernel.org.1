Return-Path: <stable+bounces-205123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF18CF94D0
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286A53013ECD
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF344240604;
	Tue,  6 Jan 2026 16:11:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D32367AC;
	Tue,  6 Jan 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715884; cv=none; b=L1tG4Qv+jBF/SL99MK2LHEB0vdjjQ1/ADXRMR9oRmCpYRy0Ml/aYEwtF/36Ls/c3bJ+BSzlb/mLG2umHznCPCqs7EAu5LJTm2N+g00kQYa2QwoZcZ7bnWEDLkXD/Ix8sCrcTiTDi0hc+kgYWmJlpE/bRuWJ4+pAOqaXdhqPoPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715884; c=relaxed/simple;
	bh=COoezE+UR5NmrYGrnBk8fvvrlSdW6ofEXOny5bNBzRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXUv6ne7INT5s2MXGy9mz0yBceMXa2MPNvWtypWtnm4U16XlbJ2RqycyamU4Ebaw+pRLhAzN0qSsgT0dAWZHnfahsrxVixSg9RBACDyEoRgv71wr3CFN5nSPcj/sUytVFp89rXT6n51/dt581u7ftcpFZd8VpJ03gg/hkApiqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 8FEA01A0448;
	Tue,  6 Jan 2026 16:11:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 116C12E;
	Tue,  6 Jan 2026 16:11:17 +0000 (UTC)
Date: Tue, 6 Jan 2026 11:11:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Breno Leitao <leitao@debian.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Laura Abbott
 <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, kernel-team@meta.com, puranjay@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Message-ID: <20260106111142.1c123f12@gandalf.local.home>
In-Reply-To: <aVz-6WozGIxGiTUR@J2N7QTR9R3>
References: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
	<aVz-NHMG7rSJ9u1N@J2N7QTR9R3>
	<aVz-6WozGIxGiTUR@J2N7QTR9R3>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5frgoyscigx4z31rwt79z9asah1swst1
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 116C12E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19aqk1VEwjvwODk6X1+zCgl3U2uFvAxYoY=
X-HE-Tag: 1767715877-848853
X-HE-Meta: U2FsdGVkX1+ONV73ZDOr3t6sUAMyVZ7qm6Lb1s+RwQ0nN2WCWtlSUJo4v4y1iXVQcMd4kBU8MbWXC6SUWuAOnfBiTl/yO4QKJIc7g+XwLRXQi6UqM90FGf5v0+Hxuoifaxo9VE7ngpPe+LYhUG/s7/dFRsrJ9nwIm4nhHw7gX0xlS+PeLbs44jSLfmBvZ2toHk1sh5qMGe65b9ydF75/CE88LH/pTWuUQ86EzBp4p3KH8kRSA4GssbWIQJc5MkqlorQ9BmekkCDNYQlld9Rwibgc21qhN1Kfq64y5eRgEnNms85TEEOeCCUbHtRyrC0sz5GfMfZEnz6yBd2zy+wI9fxdx5vBoD/KqGnYe6s2f0ukI6t4zTviCVvSKJ1uWRlVB8dl3nFJgIBkxJuuQ07ASluxfuvFaQss3NPT6UlB2lqz39LVgCjjc/Ef5RYXXuQW

On Tue, 6 Jan 2026 12:24:09 +0000
Mark Rutland <mark.rutland@arm.com> wrote:


> Whoops; s/CONFIG_DEBUG_VIRTUAL/PROFILE_ANNOTATED_BRANCHES/ in both
> places in my reply.

Note, it could still be useful ;-) 

I've been running my yearly branch profiling build on both my main
workstation and my server. I post the results from my server publicly (this
is updated every night):

   https://rostedt.org/branches/current

If you check out the branch_annotated file, you can see there's still quite
a bit that gets it wrong. Some of these is because of bad assumptions by
the developer, others is because the code moved around causing new branches
to make later annotated branches go the opposite way.

Note, its still slow to download, not only because my internet is 20mbs up,
but also because that web server is running on a machine with this
profiling still enabled. I'll rebuild the kernel and disable it this weekend.

-- Steve

