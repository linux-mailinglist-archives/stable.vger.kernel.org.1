Return-Path: <stable+bounces-249287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JnNLZ8TC2o5/wQAu9opvQ
	(envelope-from <stable+bounces-249287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:26:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2621F56D97B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58E9C303F2BD
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0B84657F5;
	Mon, 18 May 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="jTuvA+kW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9C33557D
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110520; cv=none; b=pHWwDschVKox5+wOOKECpy3CJ2L0WEb66ywkj5t1WwXmvzXFO8TVHnaVJgAl7rPpJwGYSQmfHH4FJiKADbveJgKuF2D7G/2U+JHm0hQqCok8oiBqOyL3/Ay/HXMn5SEJzkv/iguVbyJBGo/WbBTiu1PsN/5/ybdpcIkbL7s+ZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110520; c=relaxed/simple;
	bh=6UYKcNQm72GyMtIHNlGEBzktPmOrdk1rsDS7GHVaUkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaLbLUxaKVwMIR102Y/ANl1iCbrNJid1QtBLVfTeVPxHZZFTHYyk1u+uBEhsLIzYMCCBh8VULVJgfUG7elmbJ/9CCMiwoxTSrMVoveujB670rg+0MnATgLMoMWiYk1zJj19on3oUmlFB00COzVrcmmil5HJpZ7UwDYbfdyjMj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=jTuvA+kW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-912475287a5so252477585a.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779110517; x=1779715317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8m8UOlb8bhby27tmt+X53ydiTiMfQFdaV5Cc51ilhA=;
        b=jTuvA+kWugyK6f9p5WvbDeFreke58EEHjGPORKXApuMoP6WCDSXpp3sT3u66mRGRKB
         XPdpi5FlOqClECih+QFbUaDRAUrJUgwxy2UH2tuee6ytRyW+ab626k+lZQDfzyaMWKv6
         6cwCWBg65Mn712RxQ/0yoi/t/iKQMaNpFusFQcQshRumKHWaqt+DSXszXTiFtdbDPx0J
         tNyBxetoL3sij2uze1FWKQPgLWpek9+htjriLRkuwcTv1/vdFWOiE4i3clxeiSR8XzrQ
         MVyDyM8/Ak57qw075Er8xmHQTmkauwQu5wg7vhUhlJH/0OBhW3xY3EdZjgnwpOBcIpZM
         Xj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110517; x=1779715317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8m8UOlb8bhby27tmt+X53ydiTiMfQFdaV5Cc51ilhA=;
        b=hUVOiWUYH5DreItFY7HqoQpyufGUt6cmgzuMVNEPb3Lv9ZyybwEPTqDzfDaL0+SktZ
         mUhio0RthmlkozuoJafKPmwfcyuxDPqXoudLQxMCBa54EWvtmzIfp6OOIV/qAU1GBBG7
         5QvPg6RT4CFiA/KkUrwE7l1ypSbMvY/afgLuc4jtTDbNdIvdVZ1aWd49MwcqRBAg40Sg
         +XyODw/PMtFLlKJ9T2E+eCyUHsZDNqfJ3IR8q7I8aCSKQPnk/2AGBXQz/DaTatph6Tf3
         ZtUZWPJcqnVZdTJ2M/lFC+Gy9s1ptPuFmRJL++KZE9Cy9IVKcWtcX0kmP0+KwMYvkE03
         H8zw==
X-Forwarded-Encrypted: i=1; AFNElJ/0hSup+XK7XTIFcA/CJiqTAQtIYajdctksB4ukeAWGsYxT5oEWsLXGNPe6hjDgI1CibPq1mzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAoW2bpwPX4PVGI4P4JdbHmeF4hEHWEtR+m/PG9Gl1hSDd1PCP
	vSpF5H/kH35fSPp2Vt79Gw8ciqwqwPgrZDK4VColII5dAPV/S+zZSWlWJcGpYE+kIgc=
X-Gm-Gg: Acq92OGJIco0lQRZvVzXci1yjWN8OPrVEbliya9lWRLd1RJ/tXBka0HQbKU9p78PY8X
	cb7Ova2tJWQ6byE/avxQ2Zr1mk71sbOXBvPKJtwsqv69tCorTeRPDdTCPXbT43ffk8gQn/31TGY
	gWZjxYkQlzYE46iw3LCXIOJHkv1kBWzIIaonKsZ/O4MiN2gfBeyTCTgi3NXzc2eXFqL+THzl+NC
	5wB4OBouUuqC/pQwiOvfyWgtotx6vTJzG9VSanXv1lVjzcTSyf9qiJJOZP04BfoRVp9mF2Re2vs
	HDk8Oa72Qihbos5OR55hrAC7LGkA9vgDwQSvPEzUxvh6gp4mUbtQjtR0ZmOX07sr4e3A6bD5ml5
	n2kDsRSzqHGk6UzW86dpP3Q2azGFIb4l7GBsZjdogB7UOFYHKuoL2JX9sa0uty/yuRSWWksImft
	icYp4KZuiEbGMeH7cHxNyo/7DRuQTAY3Ji
X-Received: by 2002:a05:620a:8413:b0:913:c647:fadd with SMTP id af79cd13be357-913c647fdb0mr681606085a.39.1779110517498;
        Mon, 18 May 2026 06:21:57 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf318e4sm1460238885a.32.2026.05.18.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:21:56 -0700 (PDT)
Date: Mon, 18 May 2026 09:21:56 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: propagate NMI slab stats to memcg vmstats
Message-ID: <agsSdPRDjFwqUdd7@cmpxchg.org>
References: <20260518082830.599102-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518082830.599102-1-alex@ghiti.fr>
X-Rspamd-Queue-Id: 2621F56D97B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249287-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 10:28:19AM +0200, Alexandre Ghiti wrote:
> flush_nmi_stats() drains per-node NMI slab atomics into the per-node
> lruvec_stats, but does not propagate them to the memcg-level vmstats.
> 
> For non NMI case, account_slab_nmi_safe() calls mod_memcg_lruvec_state()
> which updates both per-node lruvec_stats and memcg-level vmstats, so
> flush_nmi_stats() needs to flush to per-node lruvec_stats as well as
> memcg-level vmstats.
> 
> So fix this by flushing to the memcg-level vmstats for NMI too.
> 
> Fixes: 940b01fc8dc1 ("memcg: nmi safe memcg stats for specific archs")
> Cc: stable@vger.kernel.org
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

