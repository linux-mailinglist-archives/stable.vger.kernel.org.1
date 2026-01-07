Return-Path: <stable+bounces-206179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C2CCFED1D
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 17:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 019E53009F6D
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2838538FEEA;
	Wed,  7 Jan 2026 16:10:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF643502B5;
	Wed,  7 Jan 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802219; cv=none; b=Hwjau43MbN1R8dEeaqU4OaNQLxxIOlYDcWE+c7DQZ+LZm6BrbHsWIaXZfdovjsyA0+mMFSwVnwrfZfsfPYZOMi3KlYxYCDU0v+92p03wGIJJdzt8qhjTWDJGwWiEsfd/DtrozUL0Fg/nur4u8/cUUxsCs8Tt77G92EVqGFV371g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802219; c=relaxed/simple;
	bh=v4xyIC/PxCWb8QaKeYiX/JdahNMf2rBuSomOIgoNSmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWWqqQ3Fd/U0r4ice5wF47JagfBImK9U5c7LTY+vj+FTg/w55GtXogVZx95yJWuYalzyVOZA64FCOuFbG/9+kYd5Z3TzltmKiA1AblBLdU5nDomAfhPHNZ368sdegNgp6ya+7D5gnH7KC/un59zR+uUPz9HNUqoYO7pXLkoLgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 65CB31AAD5F;
	Wed,  7 Jan 2026 16:10:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id DA1A12002D;
	Wed,  7 Jan 2026 16:10:02 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:10:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Laura Abbott
 <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, kernel-team@meta.com, puranjay@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Message-ID: <20260107111029.28e0c52b@gandalf.local.home>
In-Reply-To: <frfmxk2ifpf5shcws42q3eeykb3xyflxocbic6junm7mzvmqik@vktwefe2zmw7>
References: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
	<aVz-NHMG7rSJ9u1N@J2N7QTR9R3>
	<aVz-6WozGIxGiTUR@J2N7QTR9R3>
	<20260106111142.1c123f12@gandalf.local.home>
	<frfmxk2ifpf5shcws42q3eeykb3xyflxocbic6junm7mzvmqik@vktwefe2zmw7>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: khippqaiyx8cd5m1dse5kww4arzqhpxh
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: DA1A12002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186ZkSD32iPpRx5ow4Xmjt+UAgCjzMt04s=
X-HE-Tag: 1767802202-773670
X-HE-Meta: U2FsdGVkX19vKCXb5K+qpusqOqSjw8DJI3OWGz/LwzFg+F+VEV1dTBh8MA6eTmVsqAqy8P1lCIp7g8VSiwdNyXJjA4k+cwHYlU7CJMArTtnVhzZ3IS59JSgTxf/pcV2CD9mQ1DrzxMjnApWld23yV0xKpCfnvlZXe0bAskSnFshPdP05mS3lJ9ddA2RDCsU5Wx7+v/t84oEnQkGzpG1lAZ+yxThfxovX52OJgA6WTBBWjWgtq698VQxEcteo9G7Az+M19vhLRRv2bZvYgTPGqs1UPWdTP4oQGu2IXrCgTeWgUgCiQv4sevX86v+/U2CLaAKbrKzqDAaYwrGGd7UCLgp4R2muFF2gJuFDYEwHtDtmgQ/2a1TTbw==

On Wed, 7 Jan 2026 01:37:36 -0800
Breno Leitao <leitao@debian.org> wrote:

> I am starting to look and remove some of these likely/unlikely hint that
> are 100% wrong on some very sane configuration (arm64 baremetal hosts
> running a webserver).
> 
> So far, these are the fixes I have in flight now.
> 
>  * https://lore.kernel.org/all/20260105-dcache-v1-1-f0d904b4a7c2@debian.org/
>  * https://lore.kernel.org/all/20260106-blk_unlikely-v1-1-90fb556a6776@debian.org/
>  * https://lore.kernel.org/all/20260105-annotated_idle-v1-1-10ddf0771b58@debian.org/

Nice. Thanks for letting me know. I'm happy to see that someone besides me
is using the annotated branch profiler to fix real issues in the kernel.

I would love it if more people did the same. Anyway, please advertise this
as much as possible. If it shows that it is helping to fix real bugs, maybe
it would attract the interest of more developers, and more importantly, it
keeps the tooling in place. I'm constantly fighting to keep it from being
removed from the kernel :-p

-- Steve

