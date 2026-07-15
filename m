Return-Path: <stable+bounces-274946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UmJYD92XV2p1XgAAu9opvQ
	(envelope-from <stable+bounces-274946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 16:23:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA90A75F52F
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 16:23:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LRTh16mR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274946-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274946-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37BA83059644
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415D62F9D85;
	Wed, 15 Jul 2026 14:16:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2D35979;
	Wed, 15 Jul 2026 14:16:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124991; cv=none; b=KfK0v56/ipYIpSpSwVLZDSgYBKT7x2c0ucwRMmkZtUwGBEvp1GPNUb8vxudq+Uir0Mpxdaac6BtWlQnq8UKj2fw5fik26w4ipmFQcA7vAfAAWnsKMezZHxua9QFNheDGkdsXnAIK/ZLhT7DzIvW2RBMgfn6jFXnfEZWAzSOt154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124991; c=relaxed/simple;
	bh=pGwB/bTHOs2/inH07hoVPtuuEgBzmNSQea1pphRCakw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=LbD2t04Lre72qTgEjg4+pYX7WmhXLPaXgbE/tezeT6zqeReDKHp7qguLf7VKHXSJafYrRbzq7BWkV5P2NtFEWWqVUwUmn8aFg+UhFTqdMPmhuM25qdD/bUKT5snBLG+n0S7S9/S53Wpqic0cARIvzfzHPdpRErEiuZbY32rQ6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRTh16mR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179E91F000E9;
	Wed, 15 Jul 2026 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784124989;
	bh=t+bwpuTRptvyCO3bOxQYXi/J+49Jig0wU9FV1VYgk1U=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LRTh16mRsy/c1BfJrXztagTLiF6iwreCzUL+HMeDfNjLTGE+v0MTqoHM8/94eqABY
	 N+4rtgZL0EhbYK5cAWGP8gj1ZAFr8ysQnUg3LJ1PmoX2SySSt09D3L2ijTv/4nXxuR
	 4LDqQrY4WGX8Sm/idsfK4IcTNLzYVepREK/kdWMk38B1xyBvHKg+MdYQDRQF14bs45
	 jul3NIZI0mB8QJhljbpCxZSix9msf8uYy+MmNt65ImY7LaGLv/N9lIzfEszPHiiEtr
	 Acq2DWAV0AppoRiInvJeAEKS8BHpzof/0gBMpYFlWjlydAXfZwQxHBKZTGLZ8EgTm/
	 CUv8LK3VaELxw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mm-hotfixes v3 1/4] mm/vmalloc: acquire init_mm lock on
 huge vmap to avoid ptdump UAF
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
In-Reply-To: <aldhVdwj9oMRN1Lk@thinkstation>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <20260714-series-vmap-race-fix-v3-1-b812eccfa0f9@kernel.org>
 <aldhVdwj9oMRN1Lk@thinkstation>
Date: Wed, 15 Jul 2026 15:16:08 +0100
Message-Id: <178412496800.59347.11482869717348078349.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1974; i=ljs@kernel.org;
 h=from:subject:message-id; bh=pGwB/bTHOs2/inH07hoVPtuuEgBzmNSQea1pphRCakw=;
 b=kA0DAAoWz53NioHifxQByyZiAGpXlimhljcAvWKWFrIOS3sEzEn8GxUJs2S9+ijUshZ0yWDKX
 oh1BAAWCgAdFiEE5/QXv1IUVp6J0E9Gz53NioHifxQFAmpXlikACgkQz53NioHifxSp3QD/TBV5
 Z46e/1R1KuwDd9I5f4zeXSY2PL7Lfd/HyDWWJhEA/2/77m0B36Vzye1+PL6ojrs5HOdPpWBBkzu
 ZANDfPtQA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
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
	TAGGED_FROM(0.00)[bounces-274946-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kas@kernel.org,m:ljs@kernel.org,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:dev.jain@arm.com,m:ryan.roberts@arm.com,m:devnexen@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,google.com,infradead.org,linux.dev,suse.com,gmail.com,hpe.com,linux.intel.com,redhat.com,alien8.de,zytor.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,fd95a72470f5a44e464c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA90A75F52F
X-Rspamd-Action: no action

On 2026-07-15 11:34 +0100, Kiryl Shutsemau wrote:
> On Tue, Jul 14, 2026 at 06:24:23PM +0100, Lorenzo Stoakes wrote:
> > Currently there is a nasty race between ptdump and vmap when attempting to
> > map a huge P4D, PMD or PUD entry:
>
> Nit: that's a strange order of levels :P

Ha, seems I couldn't decide on ordering so went with something random :P

Let's try 'P4D, PUD or PMD' instead :))

>
> > Fix this by holding the mmap read lock in vmap_try_huge_*() when freeing
> > page tables.
>
> How about adding here something like:
>
>   The read lock is sufficient: ptdump is the only walker that must be
>   excluded and it holds the mmap write lock. Other holders of the read
>   lock may run concurrently, but each exclusively owns the range it
>   operates on and cannot reach the page tables freed here.

You mean maybe I put the commit message on _too_ much of a diet? :)

Yeah sure, sounds good.

>
> > +	/*
> > +	 * Kernel page table walkers either walk ranges they own exclusively or
> > +	 * hold the mmap write lock on init_mm (ptdump being the motivating
> > +	 * case).
> > +	 *
> > +	 * Therefore, acquire the mmap read lock to prevent use-after-free when
> > +	 * freeing page tables.
> > +	 */
>
> Same for the comment, maybe:
>
>       /*
>        * Acquire the mmap read lock to exclude ptdump, which walks
>        * kernel page tables it does not own under the mmap write lock.
+	 *
>        * Concurrent read lock holders are safe: each exclusively owns
>        * the range it operates on and cannot reach this page table.
>        */

Yeah that's better agreed.

Let's replace it, but I think (being super nitty) with an extra blank line as
above.

>
> With that:
>
> Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

Thanks!

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
>

Andrew - could you fix the commit message and the comment as above? Can respin
if needed.

Thanks, Lorenzo


