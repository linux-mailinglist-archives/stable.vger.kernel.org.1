Return-Path: <stable+bounces-132424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC50FA87D9D
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 12:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AD63A7EFD
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EF1269AF5;
	Mon, 14 Apr 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eWGLZUdQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ON52rTej";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eWGLZUdQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ON52rTej"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E90269891
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744626252; cv=none; b=DksbFWYQEHXvFx8rxyIgSCjNrsy81KRak5y3dCaJZ52tcZgZgsWL18228cLDlrY5b4RjoqbTEYbyEI3d9ZFFcJd3Mx6Pto5Ig9csHtxNfzMf8MCMDPgEG34Ge99or2uehuhGTnT5r2xgWa02tXMdsTLG3IIVYUBwogLv68sVhEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744626252; c=relaxed/simple;
	bh=bJkS8pdoPhOHbmv5878hnOxd7DhNaFYFet884RM0XGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPXqFKaqcW4vCWEeMRthQ1Awkxb4ybuvq0GmIh7A1qe3Qu79N8hExbfhKwEWELBCkAtdgumBNUcCZaFiCPTTbFcfEXT3HOySTAJ792O4TaSjpnk/kLcBDwnn4r9qodoPfYpuEgsa/KDLlH+uSrm0R9cPFZvJGwwz4cj0e9y46Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eWGLZUdQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ON52rTej; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eWGLZUdQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ON52rTej; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A138C2122D;
	Mon, 14 Apr 2025 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744626248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8pZ1ekNSuzCGbf1/ozGBr9ns5MGwbJ9vX66mbbuzuI=;
	b=eWGLZUdQkN8rhGHJPhiETdEf0Xyn3osto9P+8QnsVnyaAxmy2nm4l9NF0kYp/UmxfZzysI
	+wW727D9Dy+g8vf2Dx1y0yRqXbqamXQ7ZvU/zVpRCAM9x7yqTFpzI7js71bu2U2MYLoH9g
	aSFktaLDEnUg09rRrXUXCUymvyCWpto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744626248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8pZ1ekNSuzCGbf1/ozGBr9ns5MGwbJ9vX66mbbuzuI=;
	b=ON52rTejpJKFUg6QhdFxhOOh4VdkLZhizhNnJZJ9XCqTl6fFq63Ppb6hL6Cmchgcfek4ox
	MAdhrUBikm1RxRBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eWGLZUdQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ON52rTej
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744626248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8pZ1ekNSuzCGbf1/ozGBr9ns5MGwbJ9vX66mbbuzuI=;
	b=eWGLZUdQkN8rhGHJPhiETdEf0Xyn3osto9P+8QnsVnyaAxmy2nm4l9NF0kYp/UmxfZzysI
	+wW727D9Dy+g8vf2Dx1y0yRqXbqamXQ7ZvU/zVpRCAM9x7yqTFpzI7js71bu2U2MYLoH9g
	aSFktaLDEnUg09rRrXUXCUymvyCWpto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744626248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8pZ1ekNSuzCGbf1/ozGBr9ns5MGwbJ9vX66mbbuzuI=;
	b=ON52rTejpJKFUg6QhdFxhOOh4VdkLZhizhNnJZJ9XCqTl6fFq63Ppb6hL6Cmchgcfek4ox
	MAdhrUBikm1RxRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 869D01336F;
	Mon, 14 Apr 2025 10:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dJZCIEji/GdFQwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 14 Apr 2025 10:24:08 +0000
Message-ID: <32eb2a11-2079-450b-a34c-ca432f416500@suse.cz>
Date: Mon, 14 Apr 2025 12:24:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] slab: ensure slab->obj_exts is clear in a newly
 allocated slab page
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev,
 roman.gushchin@linux.dev, cl@linux.com, rientjes@google.com,
 harry.yoo@oracle.com, souravpanda@google.com, pasha.tatashin@soleen.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250411155737.1360746-1-surenb@google.com>
 <c88ec69c-87ee-4865-8b2a-87f32f46b0bc@suse.cz>
 <CAJuCfpE6_Hb40kyM7E4ESw8-_ptm3SARuL0q_YBB49cqkVbPig@mail.gmail.com>
 <CAJuCfpGrJNiDWxsD=53ZOzWKHAh=xw2pGidg6oAgwj8mETGPQQ@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpGrJNiDWxsD=53ZOzWKHAh=xw2pGidg6oAgwj8mETGPQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A138C2122D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/11/25 19:45, Suren Baghdasaryan wrote:
> On Fri, Apr 11, 2025 at 9:59 AM Suren Baghdasaryan <surenb@google.com> wrote:
> 
> Kent asked me to forward this (his email is misbehaving for some reason):
> 
> Yes, ktest doesn't flip on CONFIG_MEMCG.
> 
> Those checks you're talking about are also behind CONFIG_DEBUG_VM,
> which isn't normally on. I did do some runs with it on and it didn't

Hm yes I forgot we moved them to be DEBUG_VM or debug_pagealloc only.

> fire - only additional asserts Suren and I added - so something's
> missing.
> 
> In the meantime, this needs to go in quickly as a hotfix because it's
> a 6.15-rc1 regression, and I've been getting distros to enable memory
> allocation profiling and I'd be shocked if it doesn't cause memcg
> crashes as well.

I'll send it this week so rc3.

