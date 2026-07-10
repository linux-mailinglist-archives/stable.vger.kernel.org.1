Return-Path: <stable+bounces-273232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LaHjF/ryUGrH8wIAu9opvQ
	(envelope-from <stable+bounces-273232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 15:26:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF71D73B3AB
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 15:26:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NVnYB7qs;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273232-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273232-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 583E53049AE1
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 13:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E4642DA37;
	Fri, 10 Jul 2026 13:24:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D02426D18;
	Fri, 10 Jul 2026 13:24:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689863; cv=none; b=NjjSz8+soWba0JeadkZ5dFglcktxKwV0hTmfwVObYYSGjFMQCedw3oyIWihdevvWTg+E+OlXAnjyKhz06e+6vL0WkxNQafkzL+7bT0F0rGDRHRbqHmBc8nBbdGK9lhz1rDfgoTylEvF3id35K7ZVCV0tljVdq5JSYH/GQHK5V/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689863; c=relaxed/simple;
	bh=1Fon9jg74hfJtQTNtNZd+Uj09wB/Cwtq9F9KzsKn9B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6GPY6Kgx0JlTdB21u+8F/wmSEo8XgdqQZHc2DkUiYuUgSaX+9gx0Kb6TTVsVTcs78Gp2GpSMUfMJO4pIAiiiuoRMtLzLrWBnp2mrd06+RsApsceUp6k6Yuac7KvLlBcYJvLJ5+PTn4cJYx/4BY/BbtX1aoj+qX4Ij6DJ/rfK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVnYB7qs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395931F000E9;
	Fri, 10 Jul 2026 13:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783689861;
	bh=1Fon9jg74hfJtQTNtNZd+Uj09wB/Cwtq9F9KzsKn9B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NVnYB7qshocoVxRV8CxAk3K1UiaS25s7tEAanIJNDA0I+JhoP1Fdjd3uEVUjDb36f
	 WAkdzxMki0U8Yxx7+84NqkzZYRg/fGDafcjw9CNYFfOueZcufTkoWVGJYRlmobzoKy
	 nYraqm8HB5NmLtu5MlKgLyM/1vNol7ynal2bQYMTCm/kXHbgnivt+hvgAzi3/9Vq4i
	 gs3bjvFfBU+pXvomK/gXFBg4whAGb6xa+9+JrOVyavRclkvqHHZQFI9xlERNwbUcB/
	 mTX45vQQ37tkfW1L4CdrW2xMXK/lcfHZS8UtusMYO7awfwKSvmQ55gzJnMiMD8/LOa
	 /T3YJLc8QfACQ==
Date: Fri, 10 Jul 2026 14:24:08 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: David Carlier <devnexen@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/vmalloc: acquire init_mm read lock on huge vmap
 promotion
Message-ID: <alDyT43CLwtBtsAa@lucifer>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <20260710-series-vmap-race-fix-v1-1-5b3794c113fe@kernel.org>
 <alDnFGncVvcjsvTg@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alDnFGncVvcjsvTg@lucifer>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:devnexen@gmail.com,m:dev.jain@arm.com,m:ryan.roberts@arm.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[linux-foundation.org,google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,arm.com];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273232-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org,syzkaller.appspotmail.com];
	TAGGED_RCPT(0.00)[stable,fd95a72470f5a44e464c];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF71D73B3AB

On Fri, Jul 10, 2026 at 01:57:46PM +0100, Lorenzo Stoakes wrote:
> As per Sashiko, we need to account for x86's slightly bat... interesting
> ptdump of non-init_mm page tables.

Well it turns out arm64 also traverses EFI ranges which is kinda the saner end
of it ;)

Patch incoming in any case. Will send separately as each patch stands alone and
this series is fine as-is.

>
> The fix is to take a nested init_mm lock in ptdump_walk_pgd(), which is
> safe as nothing depends on an init_mm lock prior to acquiring an arbitrary
> mm's lock.
>
> I think this could potentially be sent as an entirely separate patch, as it
> doesn't change what this protects against, nor the x86 CPA patch, both of
> which stand on their own.
>
> Cheers, Lorenzo

Cheers, Lorenzo

