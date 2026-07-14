Return-Path: <stable+bounces-274526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9D7yNYCVVmrt+AAAu9opvQ
	(envelope-from <stable+bounces-274526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:01:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 346757588CF
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:01:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Zy+ZtPAo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274526-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274526-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F2923064FF3
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F52D43E48A;
	Tue, 14 Jul 2026 19:59:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204A3ED5DE
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 19:59:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059198; cv=none; b=m05wjeQdPyDis3weo3T+Z2mNC+u9fzGZOqfcDyHe5IIb7eQIOTGri6fIEyZHHdEyXhBM7sq/PFjGJOE+6yal7mteQNnu+vkUbUvS4/1rcxZHXMCg5xWzX+53ltPORHjVesKkPdoUYwtiVbuQrrX8cQMl3hQMTT9nfV6FXOnVAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059198; c=relaxed/simple;
	bh=KSumWhLUw1UkukeoZQCDw4phlIVdqeL5qdt5XPGHCVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv5GLiqg9e8N3kZ9AtQRuzcP28pL6RhEfVawsh/d5xCy84hk0rpRbeq+pJqmxOq8UbM6seIQ5JrHhfdY+HaqpRwDfi/o7ZPEGraD+3sjlVG6jSdOvvOOZwk5Zkkz2u4Fa57Rsax4P/LT7TTviIZ8sd6U/UMsk0Ezh7KJiP6yXjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zy+ZtPAo; arc=none smtp.client-ip=95.215.58.188
Date: Tue, 14 Jul 2026 12:59:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784059184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDSJzO5pJmxkBK1F3ZKqyU0APXt0C4YAh0U5SLJWhSc=;
	b=Zy+ZtPAoEvh7n4JxV8gDM1sCVb4ngVGAqPqLN4Exmlew8U8V2P5GUpMzQ4ESE3ozLvRw48
	k9apBqcULygG1J53BQG/k496OfQvi9WDXlJBl1/Or+XlCWY/I3a1VA32qSyk09Hrp7i5Wg
	9SLUIbl6pRFyAQqKq9k96WFfvcLU34c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Stanislav Fort <stanislav.fort@aisle.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcg-v1: account vmpressure event allocations
Message-ID: <alaVDim_cqqE9bFr@linux.dev>
References: <20260713085520.2953121-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713085520.2953121-1-guopeng.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:guopeng.zhang@linux.dev,m:akpm@linux-foundation.org,m:roman.gushchin@linux.dev,m:stanislav.fort@aisle.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274526-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 346757588CF

On Mon, Jul 13, 2026 at 04:55:20PM +0800, Guopeng Zhang wrote:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> Commit 72797d218b43 ("mm/memcg: v1: account event registrations and drop
> world-writable cgroup.event_control") accounted cgroup v1 event
> registration allocations with GFP_KERNEL_ACCOUNT, but missed struct
> vmpressure_event.
> 
> Use GFP_KERNEL_ACCOUNT for this allocation as well.
> 
> Fixes: 72797d218b43 ("mm/memcg: v1: account event registrations and drop world-writable cgroup.event_control")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

