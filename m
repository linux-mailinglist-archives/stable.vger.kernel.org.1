Return-Path: <stable+bounces-273655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zTryJnPPVGqQfAAAu9opvQ
	(envelope-from <stable+bounces-273655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:43:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA60874A7A3
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:43:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dZGRJauI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273655-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273655-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D284305689F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FE23EAC65;
	Mon, 13 Jul 2026 11:40:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9983E9589;
	Mon, 13 Jul 2026 11:40:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942817; cv=none; b=qzanJowMou2S46gQd+mygO3utQ0Qgnn7nEQ+K/5K4f1KUj+vwIpZfG2H47wPfr1rJGqdoO2pR77uX+VSlCxE4LBRqigkR5HC2LGIY9wjfoWMzZAQ2893Zcu8ZlC0o5U1hNidZuPB9KYGChOx0DmS3dueaS3FZg5bWVWNyYRgV9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942817; c=relaxed/simple;
	bh=5G0pdP3C+y8EI2GvrAKyQZ37vcepjzGADhYTGQ8PJ6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvab+H8KLJI799tZYjGd+5/fRe9gRQngIQXtI0ga5DG/1ZHMDf76beb7p8+F/7sn4HHlD/+eUL823Ivf4VOLMdj5nuyBCYAvidVL/32GXyNGk4cV3nPeVWjx1Fx85enMbpXXBpG8OyKrg5yeRTiOoin439MMr2YnrkjWf0g28Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZGRJauI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9A41F000E9;
	Mon, 13 Jul 2026 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783942816;
	bh=OCUhcyiwWTmu8QeEJQt1vja0HsbAMaRlJMAEe2Y7DeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dZGRJauIXmFXIXVKASyA43gR9V2NS35VztGQ8qQBxwH8LNdZxq9XD4tytbLxkdY0n
	 B8D/j/tVmRYXiqNFMDWprsqF4C8N/3yT0IGtZC0WViv0Hy5j2DtOrzlO3v1SVEqURF
	 aKZlD64LLIeCcBPb97NqITp5YwBE8GPonzWR8Y7HP1uRC8V2ZwNcmgO6zQst2vzSDQ
	 bUw4pXb9RBEtnyNT00GtkuXO5eCdq/PnU4JxH6o+9qa25c+6C4tJXsww2lKsULk5ei
	 hMUFiw2xJMIXnlL/MOUBqO9VvQPb3J30DdctzBG7xOoUEJCM66BlhH5cq7Hi7LCGwd
	 xEpAPa9EOjiJw==
Date: Mon, 13 Jul 2026 12:40:08 +0100
From: Will Deacon <will@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
	David Carlier <devnexen@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v2 4/4] arm64: remove redundant concurrent
 ptdump UAF mitigation
Message-ID: <alTOmMpGVdRMy7NM@willie-the-truck>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <20260712-series-vmap-race-fix-v2-4-ad134cc3a12a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-series-vmap-race-fix-v2-4-ad134cc3a12a@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:kas@kernel.org,m:catalin.marinas@arm.com,m:dev.jain@arm.com,m:ryan.roberts@arm.com,m:devnexen@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER(0.00)[will@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273655-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,linux.intel.com,redhat.com,alien8.de,zytor.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[willie-the-truck:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA60874A7A3

On Sun, Jul 12, 2026 at 11:42:27AM +0100, Lorenzo Stoakes wrote:
> This partially reverts commit fa93b45fd397 ("arm64: Enable vmalloc-huge
> with ptdump"), retaining vmalloc-huge support but eliminating the now
> redundant mitigation against a race between huge vmap page table freeing
> and ptdump, as this issue has now been fixed at core.
> 
> We also simultaneously remove the arm64 if-deffery when acquiring the mmap
> read lock upon vmap huge page table promotion as it is no longer required.
> 
> Note that this patch relies on the preceding vmalloc patch, and should not
> be backported alone.
> 
> Fixes: fa93b45fd397 ("arm64: Enable vmalloc-huge with ptdump")
> Cc: stable@vger.kernel.org
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>  arch/arm64/include/asm/ptdump.h |  2 --
>  arch/arm64/mm/mmu.c             | 43 ++++-------------------------------------
>  arch/arm64/mm/ptdump.c          | 11 ++---------
>  mm/vmalloc.c                    | 15 +++-----------
>  4 files changed, 9 insertions(+), 62 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

