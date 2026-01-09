Return-Path: <stable+bounces-207912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1852D0C1B2
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 20:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 001273032719
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 19:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949B935C1BB;
	Fri,  9 Jan 2026 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqhRI0+v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532C35A932;
	Fri,  9 Jan 2026 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988193; cv=none; b=Igp+A7SI/L7rMGuAhNZjxB50S9WuaRAlzFYU2G7xUg34Eh4Ie2aZITmRCvAPptuDsxQ31FpGis4nsr4uIPCJjlOhgceJj2TXAhlinMrMjsrYyM5BGV+M1xL7NC78yJEzo640Dcynj1joADZvcM0jIo/YYfhD+QDLy03qcGuEp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988193; c=relaxed/simple;
	bh=gxptkWFKGqjGUpnowhws6x+yALAnQviMH3p9X5YSQtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHnCny5f7n9kto8FxYrhOh/2xUKczrVagbepn9du4fw4GbE54tr20rgVfzZv+m2AD8Rar8rybOb2hl9B5qSy4tAikbcNoyvNfnD8NKom3RXvER98sf6qCcikTStqKP7JsencpQqBj56kRJujs0Gke6OJYHDEHjLqlDKKvpD+Wck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqhRI0+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819F0C19422;
	Fri,  9 Jan 2026 19:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767988192;
	bh=gxptkWFKGqjGUpnowhws6x+yALAnQviMH3p9X5YSQtY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EqhRI0+vJQyE3ayoQmpkAO9dmShbp5UzdpE6/LGmkPGBF24H02ae3Gr0OOJRgHQyC
	 u8kwUzOOngJPL23yMF7DZ6g6wpUI3T0RzsRoEjqTuFT7EzmUSCtiRgsYR1TP75kByJ
	 SOGLynvhVAI9qKrmnWNx1dJBkPjyqDNab6dACNchYyD1kQ7NaCqdVyLr6Bc6KGJCED
	 5SHyQ33zL+xxf5QiTHdXKwnMCg78RBHAzY7qWNe71xrfmkGTcqLKTmIBRXeMyMOhYA
	 YxCmdEC9Mgu3O6DBoe6cf0MOnZVeJByjApUjBXam4P3KAM7ct5RjNdZeJ3l/1SXvg8
	 Ou+lpLZ4tAukg==
Date: Fri, 9 Jan 2026 14:50:22 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Laura
 Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, puranjay@kernel.org,
 usamaarif642@gmail.com, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix annotated branch unbootable kernel
Message-ID: <20260109145022.35da01a3@gandalf.local.home>
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

[ Resending with my kernel.org email, as I received a bunch of messages from gmail saying it's blocking me :-p ]

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

