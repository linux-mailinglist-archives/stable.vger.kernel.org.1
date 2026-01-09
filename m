Return-Path: <stable+bounces-207910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2956BD0C1A3
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 20:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 368763032A8E
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 19:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991792E0413;
	Fri,  9 Jan 2026 19:47:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1D1339A4;
	Fri,  9 Jan 2026 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988041; cv=none; b=CAKEyLhRNDZ6E6T7PUhwjstaduuZECaEQg5osRgF41p0qxqXJ6DonszMtckNAu4MoRzSHWiKyAesdNn6CW83ORcidvRZwkjVrB9AynGYIGP4cywGXgvOwQAP+172ncwAN/7sOZOYe/CEFcaceeTj3KaHAy++bohhBw0QV2GyeeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988041; c=relaxed/simple;
	bh=3+G9HPXvnZjQghjiy8rA3xjq3Z2FEovFHz4a2z2sNH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KByP+2ZJI05XdtsOKrSbPAVBUN5XoOho1fi6IJ/tcHg5kujYl+YzJsgI4Kk4fV9wE+1jbrbhGI2KF4pJ8msorP2jSEBHXnSIp4dy0oe7FrsGYK3q765DetcOlA0dESsqr6zvuR9So0oLy3ZgAyJZFnKZl4NeYlB2iSMBplu40v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 78E1213BED1;
	Fri,  9 Jan 2026 19:47:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id B7B0330;
	Fri,  9 Jan 2026 19:47:14 +0000 (UTC)
Date: Fri, 9 Jan 2026 14:47:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Laura
 Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, puranjay@kernel.org,
 usamaarif642@gmail.com, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix annotated branch unbootable kernel
Message-ID: <20260109144746.4b86aff0@gandalf.local.home>
In-Reply-To: <aVwp_BJx84gXHPlD@willie-the-truck>
References: <20251231-annotated-v1-1-9db1c0d03062@debian.org>
	<aVwp_BJx84gXHPlD@willie-the-truck>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B7B0330
X-Stat-Signature: y1irfeaeo9r3qazg5i1ufgoowtmksn5x
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18aQfYKwLFjc+j1fBAjUkFY2tQx54zt9Ag=
X-HE-Tag: 1767988034-189395
X-HE-Meta: U2FsdGVkX18aSF6HsSAMAz6VNgb0vhA/XykPHWKINq6EKVrPtdLYvWkca/CTYzPz962OC0FHShZH6YI8a5V0BZu08PDbuO6zi2PCdYYg3XkjdEg4yGu9sG+ItQzMQ+COZxGcRyEppbC4oBmsakrHKsKgb0BzEOJ2gNlytKlsKvxTOARvTNCwdpr02i3oViBFBEtXUe536R3LDv7lHSA8qchlGSqV5PU74Wi5l6CwzZQdU1+6T1SQMz4F8FM9u3YJ0NcVkEoRm/Y8viZObsnvBSXnn9u10mjEw6ADZCArqJ+petiaq83Sy6DqJXPViXpfCEnAZ9F/2WTn67tnRftG9A/IbPmiQ49D

On Mon, 5 Jan 2026 21:15:40 +0000
Will Deacon <will@kernel.org> wrote:

> > Another approach is to disable profiling on all arch/arm64 code, similarly to
> > x86, where DISABLE_BRANCH_PROFILING is called for all arch/x86 code. See
> > commit 2cbb20b008dba ("tracing: Disable branch profiling in noinstr
> > code").  
> 
> Yes, let's start with arch/arm64/. We know that's safe and then if
> somebody wants to make it finer-grained, it's on them to figure out a
> way to do it without playing whack-a-mole.

OK, so by adding -DDISABLE_BRANCH_PROFILING to the Makefile configs and for
the files that were audited, could be opt-in?

CFLAGS_REMOVE_<autdit_file>.o = -DDISABLE_BRANCH_PROFILING

And add that for each file that has been fully audited?

-- Steve

