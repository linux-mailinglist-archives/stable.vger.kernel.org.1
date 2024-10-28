Return-Path: <stable+bounces-89077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0DD9B320F
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 14:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EA31F22A90
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4291DDA39;
	Mon, 28 Oct 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OWkfzVl/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XYRcD20A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OWkfzVl/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XYRcD20A"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D921D88B1;
	Mon, 28 Oct 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123106; cv=none; b=Xr/QwqmGQspKR8ZSJ3m5wP8t+m3fY+0cEG4BGh8VuYT2AFP787BZExPcIAJKrZyeGzUo+hNqiSsZGKDNWyLlHx2oGYuVxxlqHtqMqxfkHzjh9RIdCfkkDEMeDFBJWhAEOEvSgyW+AsLPxDBqjLFRMw+D3dbM9YFbFTLLWRTjqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123106; c=relaxed/simple;
	bh=cQW9V8JSZ1/2Nku45b9zhXjZpKnX1PdrIvNy2+t7gaE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NKHSRiZ6ZBZsnClOFitfrmBg4gEqBo+70DUCt1V/qb27zQQFo21lhXOtcbW3atlVv1toOi2MgmND6IPG5wnKRnWRZjoKt491q+ROihtv77F0DIbw96JE6uKEYWg6arMM184GIT08/VDnC/DqFdOil+4vCpUYoKKrNeNMXdVbtYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OWkfzVl/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XYRcD20A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OWkfzVl/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XYRcD20A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from knuth.suse.de (unknown [IPv6:2a07:de40:a101:3:9249:faff:fe06:959])
	by smtp-out2.suse.de (Postfix) with ESMTP id EDE7E1FD93;
	Mon, 28 Oct 2024 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730123102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iR/AN4/y0s+RfThiBPrdliRlimEX/iA9QxHItnJi1QM=;
	b=OWkfzVl/Fadez7L7yLlro93ZMyoT1WoW3wMDHMn2Tqg7tWdM8iTYQcadZAA70ad/mycRcF
	sUj8y6BYW2n0sJTI3MxcAQ9Cl1+eXAruZXSwsXQE5GwBruaXz0ANRL3ExEEaIlPXcPCCHq
	hkBm2yt9yLaVNGO59EZ+SEWn7fGvLhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730123102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iR/AN4/y0s+RfThiBPrdliRlimEX/iA9QxHItnJi1QM=;
	b=XYRcD20AAWLrV7Fh6k8oNLsmQkPaw2PMQHhWUvHnUHd8Cs1l4w0drRPH9e8PhOnOQFTNK+
	jvzhreVeb2GdJODw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="OWkfzVl/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XYRcD20A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730123102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iR/AN4/y0s+RfThiBPrdliRlimEX/iA9QxHItnJi1QM=;
	b=OWkfzVl/Fadez7L7yLlro93ZMyoT1WoW3wMDHMn2Tqg7tWdM8iTYQcadZAA70ad/mycRcF
	sUj8y6BYW2n0sJTI3MxcAQ9Cl1+eXAruZXSwsXQE5GwBruaXz0ANRL3ExEEaIlPXcPCCHq
	hkBm2yt9yLaVNGO59EZ+SEWn7fGvLhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730123102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iR/AN4/y0s+RfThiBPrdliRlimEX/iA9QxHItnJi1QM=;
	b=XYRcD20AAWLrV7Fh6k8oNLsmQkPaw2PMQHhWUvHnUHd8Cs1l4w0drRPH9e8PhOnOQFTNK+
	jvzhreVeb2GdJODw==
Received: by knuth.suse.de (Postfix, from userid 10510)
	id D5EFD53D6F9; Mon, 28 Oct 2024 14:45:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by knuth.suse.de (Postfix) with ESMTP id C2FBC53D6F8;
	Mon, 28 Oct 2024 14:45:01 +0100 (CET)
Date: Mon, 28 Oct 2024 14:45:01 +0100 (CET)
From: Michael Matz <matz@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Vlastimil Babka <vbabka@suse.cz>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>, 
    Thorsten Leemhuis <regressions@leemhuis.info>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Petr Tesarik <ptesarik@suse.com>, 
    Gabriel Krisman Bertazi <gabriel@krisman.be>, 
    Matthias Bodenbinder <matthias@bodenbinder.de>, stable@vger.kernel.org, 
    Rik van Riel <riel@surriel.com>, Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH hotfix 6.12] mm, mmap: limit THP aligment of anonymous
 mappings to PMD-aligned sizes
In-Reply-To: <2b89811b-5957-4fad-8979-86744678d296@lucifer.local>
Message-ID: <fe231f2d-fcb1-05c9-49c3-405c533a0200@suse.de>
References: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info> <20241024151228.101841-2-vbabka@suse.cz> <2b89811b-5957-4fad-8979-86744678d296@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [1.39 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_IP_A(1.00)[knuth.suse.de];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[knuth.suse.de];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[from(RLrb5sztbum4xna9a5)];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 1.39
X-Rspamd-Queue-Id: EDE7E1FD93
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: +
X-Spam-Level: *

Hello,

On Thu, 24 Oct 2024, Lorenzo Stoakes wrote:

> > benchmark seems to create many mappings of 4632kB, which would have
> > merged to a large THP-backed area before commit efa7df3e3bb5 and now
> > they are fragmented to multiple areas each aligned to PMD boundary with
> > gaps between. The regression then seems to be caused mainly due to the
> > benchmark's memory access pattern suffering from TLB or cache aliasing
> > due to the aligned boundaries of the individual areas.
> 
> Any more details on precisely why?

Anything we found out and theorized about is in the suse bugreport.  I 
think the best theory is TLB aliasing when the mixing^Whash function in 
the given hardware uses too few bits, and most of them in the low 21-12 
bits of an address.  Of course that then still depends on the particular 
access pattern.  cactuBSSN has about 20 memory streams in the hot loops, 
and the accesses are fairly regular from step to step (plus/minus certain 
strides in 3D arrays).  When their start addresses all differ only in the 
upper bits, you will hit TLB aliasing from time to time, and when the 
dimensions/strides are just right it occurs often, the N-way associativity 
doesn't save you anymore and you will hit it very very hard.

It was interesting to see how broad the range of CPUs and vendors was that 
exhibited the problem (in various degrees of severity, from 50% to 600% 
slowdown), and how more recent CPUs don't show the symptom anymore.  I 
guess the micro-arch guys eventually convinced P&R management that hashing 
another bit or two is worthwhile the silicon :-)


Ciao,
Michael.

