Return-Path: <stable+bounces-273898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A+tNCxMeVWqekAAAu9opvQ
	(envelope-from <stable+bounces-273898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:19:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4B174DF43
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:19:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=boJ4VxME;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273898-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273898-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D751300722F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2179340407;
	Mon, 13 Jul 2026 17:19:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06F29B228;
	Mon, 13 Jul 2026 17:19:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963149; cv=none; b=Pu+uZn129EvF+muTSzLabBxg79mX6MTLPD+gQVtJo7IQFyrYgsxhm8Qb1UVa+Wv+lfoK50KEP92KmEb1fFKWG3lJ3R9s2FcOq5l4C48HHW912coEGQNirUQDoykZlY1edXtVxjCqeG1+uxT08YfVPGTmYvb3T2jk1r9MDCV7PPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963149; c=relaxed/simple;
	bh=OP5zFLSF2uBJkImUkWMBqP948PbgqJn0AGqQgF1gQDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIFHgKRjeyiSQq1fAXwgBKs9LWt4cnOvhOYe0m8osLmFfi5bGAGDkO1QBmpf10AIH7QGsg0IphJc9Z31hSKYlTzvxOb1QHV3vZig1VIxY1lLl2lXWswYjnzdHwnP/Qifm/jUnJztzVNAz86flM/ONoPxV4SGIeYHtF8PoMO8XoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boJ4VxME; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A44D1F00A3A;
	Mon, 13 Jul 2026 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783963148;
	bh=sT8ncCoskQ+pPBlVmZsj1ldkcql22WoFMry/YNTn7dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=boJ4VxMEmG63STqe+XFCnj16oQ7l+0rEaBTr5BJHY/4QyYwdcOPLk/CHmde/re4iF
	 fEh0mglmtEmzRuQhUOEqnWlQt0tNYHyA87uDBHT4b4eL/9psB7SXrBl/4bqVXFwHh0
	 l7qy6tODw0b+aIxGBGn7vD44LU8rX1Zp+c/ToNTc2uPGrxPaPSqjqSs2f5z9OBXHUd
	 6Ay1qFpyMD142+txfZQ+JBuhv8KK+GOMsU6TVRKs/7SR2+5/454lJUVIwvwoNuuOuL
	 ASVfuIEZbms/fzPv86YOTlYqCDS7kM8Ui9XQKZ/7H784DFE+qnfoQFLk9EJJ4zKObG
	 AuoKKLf26ZUYw==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id BF36FF4027E;
	Mon, 13 Jul 2026 13:19:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 13 Jul 2026 13:19:06 -0400
X-ME-Sender: <xms:Ch5Vapkw_J_hWklNR21wK1KKIBeblcJH9nG69vBtUr8uQjtvdjbPzA>
    <xme:Ch5VaoEfePqA02oVSHz1UNta3XSzzWuL7PMDrX_CqI7wdD4WRaeY1Lg0laPXMYiCN
    wCRW_Yo5Hc-hxCmB9N_B7KSofxg-hYvVALdgo1XQkJBX2WtxtdL8H0>
X-ME-Received: <xmr:Ch5VanIsgv6d1HLy3wvj80hRkRg2wnsowoe86iILxc08bdfEiELSDRpW4Pq-ZQ>
X-ME-Proxy-Cause: dmFkZTEJ4lXnpy7cJu3kFZKie8XWmk7c16mf9c3dcg0mO/FRWw9JnqjgAXFL0YAMoBP1EJ
    3xyuhbt9BpRDEzXMxnJfwaKFHYcsya5wGuyrDMTWWxzCkKI4Pv2rog+fL8gPL5WqfWAbUY
    ICsHYG56N5Gu45mM1QaSisXid9T5TyNpxl5uf69gdMIrqWPh+JXRP5hXTFb/mkMc+UZAKA
    CjLTsZZCg8zJeTPMIApQmEoo4QI6fow3qIeTeBGGYfSrtF8keWO2+L4+L3246fvQcvYPsD
    o3OWDXJkLyganHi/46YNGLhBEpkTvo55OAnPmHxwvEvEXua41QXG/KQ5VQtjTJBqbr2LtQ
    dDHAxskcep2CzldPvnyC0cQU9W5m7ZnNLvHQD32nI/REFI51GAnENKrKi4nGZu44nogMkA
    M8DvSGtHMwaG3Tq9XiOUMo/oggtZVqfJkJPMieBMIykGMstIdx+hkm4v7j82UolMzsQaKn
    70uRX+2FasfCx9DVifeP+mFUBYMOEemngKsgGj32mI1qPdvsXdWFgZt7NlfGVd7V1zgeGB
    DeSZN38Ez3MKW0qgKNsGPX+mFRnIWtMdEJfdqszTSk7PJbHp4kYi0PT6dwN/ZcHV+jX76K
    2xvLHjPdyR5tLmOwT7JWSXJxl4RH8Aa4m3eU/bqdZeoNZrBgBUfZ+bMC9wNQ
X-ME-Proxy: <xmx:Ch5VanNriCjfnz8yYshIDIf3p97N9HWCROMmDfgsNcmm-xkWsAc9kw>
    <xmx:Ch5VapEYQMiAAASjG9sGsIVxLSdOmHJNRPEhZi9iQBk3ZTFu7vi6sw>
    <xmx:Ch5VaomSoAAa4XNbLcCuZxhmsnahq9uskwAhdsHd75mnMcxahDPxRg>
    <xmx:Ch5VakcdkwWfOV1Xn37kJWx2WqlIHFcP2GCFH0zriKVprx1VvV2Dow>
    <xmx:Ch5VaiYvYAoJxn7KpCO1wmZUIlSx6AbdaYmo4o1S8m3emWW2DXghwl4Q>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 13:19:05 -0400 (EDT)
Date: Mon, 13 Jul 2026 18:19:05 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Carlier <devnexen@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v2 3/4] mm/ptdump: always stabilise against
 page table freeing using init_mm
Message-ID: <alUdUKk0zGmskSib@thinkstation>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <20260712-series-vmap-race-fix-v2-3-ad134cc3a12a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-series-vmap-race-fix-v2-3-ad134cc3a12a@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273898-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:dev.jain@arm.com,m:ryan.roberts@arm.com,m:devnexen@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,linux.intel.com,redhat.com,alien8.de,zytor.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C4B174DF43

On Sun, Jul 12, 2026 at 11:42:26AM +0100, Lorenzo Stoakes wrote:
> x86 and arm64 invoke ptdump_walk_pgd() with non-init_mm mm whilst still
> walking kernel page table ranges.

The code looks good to me.

Same comment as on patch 1 about the commit message structure, only
more so: the race itself is never actually stated -- that these walks
hold only the walked mm's lock, while the freeing exclusion built by
patches 1 and 2 hangs off the init_mm lock. The fact that makes it
possible (x86 shares kernel pgd entries with every mm) is hidden in a
parenthesis. And the last three paragraphs read like v2 changelog
rather than commit message material.

> We take this after mmap write locking the non-init_mm mm. Nothing acquires
> the init_mm lock first before locking an arbitrary mm, so no deadlock is
> possible.

Do we want to document this locking order somewhere?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

