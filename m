Return-Path: <stable+bounces-274524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iv6NHI6VVmr3+AAAu9opvQ
	(envelope-from <stable+bounces-274524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:01:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B440B7588E7
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:01:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=xbEaUCOX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274524-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274524-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A5F53183037
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9EA433035;
	Tue, 14 Jul 2026 19:51:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316C41F37F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 19:51:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058716; cv=none; b=eI/Bpny1L7yyvaGkXJnEUScflam2ZntQezuXSd3WAIVhSx88ASBnQVHkADWhViAkk/0DGqjI6UI/WwL0uNafSF7h7rGMnuhiamnNHM71pfcY0hDa41crx3kTkW6j3jec1LqqZ+/X8JwGdlCFCcmaKJ/n92NggptSxCeXTM/OFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058716; c=relaxed/simple;
	bh=lFyokh7MUwA6B1sjQ4JNosFhqk0VvrtBmAVznOUX+WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUwe6UutJIaPDd4cCNiEJVNmAsXip5uyh6cXggVYOefB88/IKrAuEtl67edj+t0cLCFmg++v+ViFZcAuN9W5xCMX53u2I9GcJrPiQXCcWGiO8T42JZLk/uo7sooOj/agDKaRzk0CoPCuVbrOn31Fz/l0lSA+dT/gxZhuhiwk2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xbEaUCOX; arc=none smtp.client-ip=91.218.175.182
Date: Tue, 14 Jul 2026 12:51:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784058710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cuoijzz0rTY63A4da4n+CjQ+9RFOuE3zmPGDmmxWI6M=;
	b=xbEaUCOXuxx8FfZYpiWNatKkOn8twLD8coYe4FO6wtqEyxg+Xc5o0DpNmmhZq091tIF8d+
	DgEzCKaSTpgZl3w6bv1b4wdJ4vO/M/B95cjJk4wLhxu5e80JY+rubyvjdOYeWuf0s9uOAr
	k3jZZEiWpz4kF5sfNDvVwF0yHk0V/hU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Guopeng Zhang <guopeng.zhang@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcontrol: update state_local when flushing NMI
 stats
Message-ID: <alaTQeiiTTmKLngu@linux.dev>
References: <20260713085053.2916813-1-guopeng.zhang@linux.dev>
 <20260713113901.GG276793@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713113901.GG276793@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:guopeng.zhang@linux.dev,m:akpm@linux-foundation.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:vbabka@kernel.org,m:alex@ghiti.fr,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274524-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:email,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B440B7588E7

On Mon, Jul 13, 2026 at 07:39:01AM -0400, Johannes Weiner wrote:
> On Mon, Jul 13, 2026 at 04:50:53PM +0800, Guopeng Zhang wrote:
> > From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> > 
> > flush_nmi_stats() updates state[] for kmem and slab counters but leaves
> > the corresponding state_local[] counters unchanged. Local kmem and
> > slab statistics therefore miss updates collected through the NMI-safe
> > atomic path.
> > 
> > Update state_local[] together with state[].
> > 
> > Fixes: 940b01fc8dc1 ("memcg: nmi safe memcg stats for specific archs")
> > Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> This issue affects memcg1 but also the workingset shrinker.
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> And we should probably CC: stable # 6.15. Shakeel?

Yes it makes sense.

