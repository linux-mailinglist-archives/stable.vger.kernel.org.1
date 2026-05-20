Return-Path: <stable+bounces-249734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JiRL0woDWo8twUAu9opvQ
	(envelope-from <stable+bounces-249734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:19:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D491587294
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 532F5307DFEF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBC2332EB1;
	Wed, 20 May 2026 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VDtfzZay"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8DF33262B
	for <stable@vger.kernel.org>; Wed, 20 May 2026 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246840; cv=none; b=i1/12FKcIr9608pXHseDg0BDRxRgJCoU7epQEsBTuLuW8qMyTSc0a8XC4PoJaDodpwIl0v3EpEbt6bxr4TaCrv51ftLKeXJDgnGULkE3jtm62H4bza/Qo1cjfTceWyD0XJhuazLmZSTGpQYs5cnMYJ224XHomimFzfzvS6O3aDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246840; c=relaxed/simple;
	bh=rkZQB7CmExri+8CjjBQVPCHhPyaffU8DthTqgx6Ywcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewnXljkor7LQCaAXmfFZqU3Ey84/7+G7xQTvrq4Lea6RBBjDdAfZ7wo8tl98HUc4JspeHAw3NEhWWj7VRlrW5J9K1HpUni7OLLO/C2keP5bHdBIP+TzAqq18C739UkcvX8m08r1FA2fj1fcPIEFNszbBu8sUQzanulsSNtavQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VDtfzZay; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <206188f9-5642-4348-9fa1-c48f9a890640@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779246826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/BAsYNaRoSPqOC7pVUIR0S0Ozuw6H+s2VNAeqI7FrU=;
	b=VDtfzZay5VTZ6ayBG0Igk+ssjqN7hXy86j6RFoPTY8GN0Ygzj/uEbwWGWXT6/amFp0Ggi/
	4bLUJ5ByOWyeMYlqfFo+xEwbtESaE4tOmDPkplztGbaNuvVGarHgK2BKteVXVnik1izSfP
	hHXeS+BiQAfGgtxOKHCfjV9XqH86LCA=
Date: Wed, 20 May 2026 11:13:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
To: Zhang Cen <rollkingzzc@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zerocling0077@gmail.com, 2045gemini@gmail.com, stable@vger.kernel.org
References: <20260517121626.406516-1-rollkingzzc@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260517121626.406516-1-rollkingzzc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249734-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 1D491587294
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/17/26 8:16 PM, Zhang Cen wrote:
> SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
> with this bit set are copied before data/data_end are exposed to SK_MSG
> BPF programs for direct packet access.
>
> bpf_msg_pull_data(), bpf_msg_push_data() and bpf_msg_pop_data() rewrite
> the sk_msg scatterlist ring by collapsing, splitting and shifting
> entries. These operations move msg->sg.data[] entries, but the parallel
> copy bitmap can be left behind or stale in slots that no longer contain
> the original entry. A copied entry can therefore later occupy a slot whose
> copy bit is clear and be exposed as directly writable packet data.
>
> Keep msg->sg.copy synchronized with scatterlist entry moves, preserve the
> copy bit when an entry is split, clear it when a helper replaces an entry
> with a private page, and clear every slot vacated by pull-data
> compaction.
>
> Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Cc: stable@vger.kernel.org
> Co-developed-by: Han Guidong <2045gemini@gmail.com>
> Signed-off-by: Han Guidong <2045gemini@gmail.com>
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
> ---
> v2:
> Sashiko-bot pointed out that bpf_msg_pull_data() could leave stale copy
> bits on collapsed tail entries.
>
> Clear msg->sg.copy for every entry consumed by bpf_msg_pull_data()
> before compacting the scatterlist ring.
>
> While researching recent page cache bugs, we discovered this bug.
> We confirmed it allows overwriting the page cache of read-only files
> via splice(). We haven't attempted to write an exploit, but the
> corruption primitive is verified. PoC available upon request.
> Recommend fixing ASAP.

I think only "splice() + KTLS + sockmap" is vulnerable, right ?

I digded a lot but didn't find any other combo.

Actually the normal TCP/UDP  with splice() will not go through sockmap 
(unsupported yet)





I think only "splice() + KTLS + sockmap" is vulnerable, right ?

I digded a lot but didn't find any other combo.


