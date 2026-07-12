Return-Path: <stable+bounces-273503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WklcGczGU2qWewMAu9opvQ
	(envelope-from <stable+bounces-273503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 18:54:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B9745632
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 18:54:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alien8.de header.s=alien8 header.b=hZd3B02y;
	dmarc=pass (policy=none) header.from=alien8.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273503-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273503-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 300FD30028AD
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 16:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E021C3655C2;
	Sun, 12 Jul 2026 16:54:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF8364EAF;
	Sun, 12 Jul 2026 16:54:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783875271; cv=none; b=ct5CQFU145RMR3Ffw0nlGpkeKZqXqhx/I/nPewEvRVNB16n1J00YvH4q0MbXzG5Zh7MMhYAx+pMSZzojwSUvwO0t9MxTfkeXXCC28JgCivE27uiBwJwET5xf1BxPjHblBDkv6f5z3w5ySF1afh/jYI8C0eb2srmFjXM10xRvq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783875271; c=relaxed/simple;
	bh=3t/8oLbvVkCPegE8QAQn71oA+Q4HfSxM+oHBOvO26rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jtd2LG/LTLXyRnjevNQqSCwHgd2XcfMRNvK0p3gwdXxozxW/rR7huxNrgW+ufduJw9kLfDYJ4K92FF+fAvg8wqDByfXALmH9/yxTgO0Txw7ShcwVnUS/ttV7LrD8PsdPVuhabm1UyVsTTQkhhWW7mC2he5uOxLVj0WipM1PuY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hZd3B02y; arc=none smtp.client-ip=65.109.113.108
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C99240E029F;
	Sun, 12 Jul 2026 16:54:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id srior6ed563w; Sun, 12 Jul 2026 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783875255; bh=y0mSGKSljGbp3wm1OkPuo0d6XMXK1FIsRCwQHXpgKVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZd3B02yURgxnaN2bOuG5eS5BGaZkYAs2AweWjgF8MPvxxPq1Pt2vhEEqnCqz6wWA
	 8dNkaOdtd19u+IcSBM/HjAx7JcHZLN7A5upeotFOjvVZJuJPXZ2xLlJORfsSwePPkj
	 s2QScnUZnorDzAAJHT7r+lAsUwSUICK0TK1gzPA+4BNove0iPem796CCGh6+vQ2uTF
	 IaaWP96Soy2OIRtZQ4wj3sYYMzUU7eb9vJwS5dkoeTmPjJv/vViw09zNDbqo+F8B9q
	 AyltvY6d3w6OaBCUM9eOqQsnsnrBBcZmFjmra1vn3CEnFOv/wKIU6VNf/oyr4hwPGu
	 7M7+2UxNFU+pg0Lto33EIt9lKX7i+Z29412SELwxHS1ldaxuC8r38fIiiBJ/60gssa
	 pi0hvyvsYutR7Ji2QjYroHz3Tz4NoMG/Ar3Egs6W/tT79qOi1QngXwmUMBYQyqPoUH
	 Ruz1xqCCFqxR3bLPqeiF9m4mB9wan85MmnjIRAYyecU6ELmJSYolJcfG5wxdEz+Bdf
	 GsCumXAiqGmZg2okklasr3ESHBzuoOl7c9q1iHAJ7QaMfNvEci61R9mQ2/96kYvjQ6
	 X2EbOcc7yHrtpWfN6qHdZShRWsJAMFRBQB9QrCT/E+9KlUi/jyYAcpQpaMbn/8DBjw
	 Da+sRgL8/If7qfYW8RZJTeHc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22D5740E00C3;
	Sun, 12 Jul 2026 16:53:45 +0000 (UTC)
Date: Sun, 12 Jul 2026 09:53:41 -0700
From: Borislav Petkov <bp@alien8.de>
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
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Carlier <devnexen@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v2 2/4] x86/mm/pat: acquire mmap lock on page
 table free to avoid ptdump UAF
Message-ID: <20260712165341.GAalPGldsKpBs5treJ@fat_crate.local>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <20260712-series-vmap-race-fix-v2-2-ad134cc3a12a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712-series-vmap-race-fix-v2-2-ad134cc3a12a@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273503-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:x86@kernel.org,m:hpa@zytor.com,m:kas@kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:dev.jain@arm.com,m:ryan.roberts@arm.com,m:devnexen@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,linux.intel.com,redhat.com,zytor.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,alien8.de:from_mime,alien8.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E97B9745632

On Sun, Jul 12, 2026 at 11:42:25AM +0100, Lorenzo Stoakes wrote:
> This patch resolves the issue by acquiring the mmap read lock on init_mm to

s/This patch resolves/Resolve/

> provide mutual exclusion against ptdump, which acquires the init_mm write
> lock.

...

> We also include cleanup.h in order to use a scoped_guard() to implement
> this cleanly.

You don't need to explain that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

