Return-Path: <stable+bounces-199891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D92CA0FF0
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 044913338048
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0566730B512;
	Wed,  3 Dec 2025 17:16:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8AC30CDA9;
	Wed,  3 Dec 2025 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764782173; cv=none; b=c7VP7sFJAazOT8QV730T8AurXu5e1zxE6xtuUkKjY5VhrV66PPNjbTrm05xep9kFGBPMbdSC2D9qpCPDebZGsCopzxPX41hgbsJXuP8NYLHqF0UfZe+0x3fXl7cYt7r6NK3qYv6v9hu4DhFhSmGNolOgMET8yy2lqf7/8MXcAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764782173; c=relaxed/simple;
	bh=5uUHyVBab1IIK2THz/icU8D3tVumbHD3IyFhj+XwJqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1HR/2pYO5fc0b/SRy9vctOcCu1HIO9NYj+DlvQp+VDNApIW5NZmhBQVsp3LZPixjsz4JrphERKldII5HYXFQh68NhY4Xp3rOKbcTjuTu5WRCeo2KccM0DgHZ7n0A89ZstWT3MsO93ifXaE6YAXppte0K+harO37u58rUXYxTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id A0B1151C25;
	Wed,  3 Dec 2025 17:16:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id AEDFA80011;
	Wed,  3 Dec 2025 17:16:00 +0000 (UTC)
Date: Wed, 3 Dec 2025 12:17:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: jstultz@google.com, mhiramat@kernel.org, tglx@linutronix.de,
 clingutla@codeaurora.org, mingo@kernel.org, sashal@kernel.org,
 boqun.feng@gmail.com, gregkh@linuxfoundation.org, ryotkkr98@gmail.com,
 kprateek.nayak@amd.com, elavila@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH V2 6.1] softirq: Add trace points for tasklet entry/exit
Message-ID: <20251203121703.0c3a5ed6@gandalf.local.home>
In-Reply-To: <20251112031620.121107-1-sumanth.gavini@yahoo.com>
References: <CANDhNCq_11zO4SNWsYzxOeDuwN5Ogrq9s4B9PVJ=mkx_v8RT9Q@mail.gmail.com>
	<20251112031620.121107-1-sumanth.gavini@yahoo.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zo976ui93yj7i9fmwcdusdhzidtcr4tj
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: AEDFA80011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18zCd23UKDhSX9bMWSGYHH+za3w4eMchBU=
X-HE-Tag: 1764782160-895588
X-HE-Meta: U2FsdGVkX1/xT3xAAh8cPXJrKvilT1E4ovGvM8aFDMcl69FJxB1Scx5ilQAof7UH8L+zuWuOZ3Kt7WTQfAmh1ttWAhWZEkDGGHADkGKW/pxE+kFJVdVkYDh8CjjYBMMUAJiu2eJKvFZM3yJ6ofFwnLzx1S86fDwkkwNhXSakhGmBIaC0AfcbspeNukF71Dmx6xK2e6I31pIZKor87ZBbAceHhkQ0paTwp7kkt05sM/MEdcaFVqo3OhBQN/+NXMQfpv4LXqb5Qky4xEFzyLMhNUl4UPRyrU5nIws4W7RhGiNjt29rytgePfrfHC78EqIyHi+3lXrvyJO+p8HspiWe47eGAqL3iHWC

On Tue, 11 Nov 2025 21:16:20 -0600
Sumanth Gavini <sumanth.gavini@yahoo.com> wrote:

> [elavila: Port to android-mainline]
> [jstultz: Rebased to upstream, cut unused trace points, added
>  comments for the tracepoints, reworded commit]
> 
> The intention is to keep the stable branch in sync with upstream fixes
> and improve observability without introducing new functionality.
> 
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>

I just noticed that this is being pulled into 6.1.

I'm still not sure why this was added. Yes, it may improve observability,
but that's because it is adding new functionality. Adding a trace event, is
functionality and not a bug fix.

I'm not going to argue against this backport, but I do want to point out
that it is adding new functionality to a stable release.

-- Steve

