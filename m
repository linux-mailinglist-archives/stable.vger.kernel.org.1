Return-Path: <stable+bounces-274472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PDzLGblsVmo65QAAu9opvQ
	(envelope-from <stable+bounces-274472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:07:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4BF75733E
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 19:07:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D8hD0Weu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274472-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274472-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 696973051DDA
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC7039CCF5;
	Tue, 14 Jul 2026 17:05:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C539CCE7
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 17:05:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048711; cv=none; b=J2kHL4uMATSOY3ofZp3TtnKGaR+n68ZGqlyyec+s2pQdq/xcYCltW9fgVOssEA9TkqGP0D44kv5DcG8AazXXdHvroWUBQk48SncPUpIJzlb+KQWJ3SNNWUThUXdFAYytbEg7olwNrx7Q0vH0hsCluEt7yPiDlm9EGTUT15k/f78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048711; c=relaxed/simple;
	bh=iK1clcL4j93nB26JCu+mo8s7xBdBdbWDurBsBejafaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEVwZ5Msx4gCunhcb5tYojP5gRjauEnxTzBJeiTcLkfn4BlD4pJLOX8KmL8IiDZdrAwm/QgN9FI6u3NZl7GoXp7BEfqQtOwixF+IYfbRFF29b6ewvFRNX3HUn7t3Bm+P70IINFPo18Bs34uJrwpUG2shO0t2q9Wd7h/bA+lh0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8hD0Weu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4031F1F000E9;
	Tue, 14 Jul 2026 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784048709;
	bh=ydgxQP/oa7xEv0jlIXInXGbUm/sXAmGgSanquee8prE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D8hD0WeuYKlx36Y5L2e4bzKDjObG0iLRTHPa2FOZvUhTU0FrYNaaMeFA8sHpKtrdA
	 KwXMMoUkns+4VYuoR2bugd6YoPO0xzv7zp3C/c+6pIm7x//ttFG6KF9/lAyy1oYnmg
	 nrHEgYoOFkroutxdRfFu4R2P5Z7bLE1HgkOgsEeg29x7ySkRZKcr1WBFGbdMCmQh7n
	 l8P8t2sd1a2Jckb1bsUT0sr7xbKNJEFkji9hiablV0GE32MsF55/FgOKh0keIbfOdZ
	 ldEnwxHukjw5ov3fGqFNEoi6UovYUE1LUWbJlerABj5mz/RtRICoCh8ZBP89UjqZle
	 hxJZmW76rCqOg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6FB16F4006B;
	Tue, 14 Jul 2026 13:05:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jul 2026 13:05:08 -0400
X-ME-Sender: <xms:RGxWapPXbB5dVu53Jz7RrippvtSKKiAiIJVJ5GoTsW29sf-zJC66Jw>
    <xme:RGxWasZTnBKb9bCAmfX0IqbM8Ed5DZM-tMrieZPtZAv-_vOKsS4WlCPcFe_HzuGoR
    4yhsz-XKh5zBAEJuk9zp0cQ9zWdMZDIdT6qwkGq6rkt24kiKrBV7A>
X-ME-Received: <xmr:RGxWapslvvrOUkuR9AuAdM_Gt0YsL-K_n0305h3XhPWdgjEVANE4Bevhdipelw>
X-ME-Proxy-Cause: dmFkZTFmy+VemEL8y4m/0c6SxM2MpgY/lUB50b1pGO9hizfkVYuDYx4C2dh69xVyekjjVF
    SM16JUY7uBZ4MgywK/EicPR2jaoa2RvJU2pvEyOxthy7IxCU4yoKq5ltVWcNJlEPeG5PD/
    La7r4WvGmHo6f+HQp9hAsZMebjDJ6UU4aeFkik8+mWeHwOszix8pf/umVHOJ3FrSeeX1Ep
    urx2zOqpy79jM/gcgeHPLClx4ZD5PIiAPgkDFFJ8vW2YYYwEh3OSG/Ng0deBensnErFliG
    Cx85IWH5hmqDvVZlFms+1oCUSCe2CgRWM9tg918uHCJjnaCkn6LHh0uivkwfLqo+HrrSqw
    /vD5cDJGDYcRixMT4B1b1W/Oqoir4wrmSc04uvjG+o9qqJajA+QNDm9rCdp5WdTi7wtlWh
    ow8/u1xCky2ml+w62/3u0/11lgO4Ch7qe+KEj+eztYk0agWgOkcNQS7AepEXJIyZ5szllJ
    5aMvBky0fhySWBI5vvukYk5SbrPDoaQ5sIsFNbluAxKbB4KBJjwf0PeW1oKB7+nPQ/n02u
    oCvgqRALMOOl5sngUh6rP3Q5kZHgjv48PtDGFT6kihcspAuv/N1ExURuPiLuhi4HYSCfeL
    q//noQRZyomBaUesw2AggexEf3LHnrFQotNu2k+xS7i3QXELw3IUnA9qhV7g
X-ME-Proxy: <xmx:RGxWaltsTtr4ZjIGeOTb2H7BlQE0FP4YCrbw4gdcPHSHCzs3YznmIg>
    <xmx:RGxWag1RMUC3o23VL7q3yu2zQ7NeU5EL7ocwG3bKkk9QlCg4JI_YCg>
    <xmx:RGxWaqNrWGr5C3kXNzgBHVFPBVDWKgd0N3KUDgFTF3sMfQqZ9VOE8A>
    <xmx:RGxWat5YHEcBpFpFY44XIzGRimwMYLN9Edflpk0v-w5jXuD5GmbpCQ>
    <xmx:RGxWapZdlcn3WvyTxZNGFMK7K0whXjTgVTcsMq0ulr4g5weXE5EZKU6t>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 13:05:05 -0400 (EDT)
Date: Tue, 14 Jul 2026 18:05:01 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 	Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 	Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, 	Uladzislau Rezki <urezki@gmail.com>,
 Toshi Kani <toshi.kani@hpe.com>,
 	Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 	Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, 	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 	"H. Peter Anvin" <hpa@zytor.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 	Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, 	David Carlier <devnexen@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 	bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v2 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-ID: <alZm0tBf8DpMXimM@thinkstation>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <alTn7NguEW_4bodu@thinkstation>
 <alTq4V50767L-s5H@lucifer>
 <alUNiWcygLd4rqBo@thinkstation>
 <178404602957.85099.8935151447302412515.b4-reply@b4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178404602957.85099.8935151447302412515.b4-reply@b4>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274472-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[kas@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:dev.jain@arm.com,m:ryan.roberts@arm.com,m:devnexen@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,linux.intel.com,redhat.com,alien8.de,zytor.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,fd95a72470f5a44e464c];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF4BF75733E

On Tue, Jul 14, 2026 at 05:20:29PM +0100, Lorenzo Stoakes (ARM) wrote:
> Basically you need the IRQs disabled to get the semi-RCU behaviour and to
> be able to safely traverse page tables that way.
> 
> So with CONFIG_PT_RECLAIM you're safe to RCU traverse PTEs only.

I think this is stale. Since 1fb3d8c20bfa ("mm/mmu_gather: replace IPI
with synchronize_rcu() when batch allocation fails") the !PT_RECLAIM
fallback is a real grace period -- note your own quote of
__tlb_remove_table_one() calls tlb_remove_table_sync_rcu(), which is
synchronize_rcu() nowadays, not the IPI broadcast. The name invites
the confusion.

Together with a37259732a7d ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE
unconditional") that means every freeing path through the generic
mmu_gather is genuine RCU, batched or not, all levels. A plain
rcu_read_lock() walker is protected; IRQs disabled is not required.

> HAVE_ARCH_TLB_REMOVE_TABLE is set for powerpc, which also enables PTDUMP :)
> and that's because it actually tracks multiple PTE page tables together as
> a fragment.

sparc also sets it with SMP. So the audit list for custom
tlb_remove_table() implementations is powerpc and sparc -- everything
else gets the generic behaviour above.

No disagreement on the rest: the walker needs
ptep_get_lockless()/pmdp_get_lockless(), and the ppc kernel-side
fragments need a look.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

