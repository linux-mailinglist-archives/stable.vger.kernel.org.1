Return-Path: <stable+bounces-274884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7U3GNlljV2qXKwEAu9opvQ
	(envelope-from <stable+bounces-274884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 12:39:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3DC75D0F7
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 12:39:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ari7ydGK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274884-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274884-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11338311239A
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7CC436BF3;
	Wed, 15 Jul 2026 10:34:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39843EDE63;
	Wed, 15 Jul 2026 10:34:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111680; cv=none; b=lY+dMu/jqt66AZKtx9pdkSio9ZKe6t7ytlJfbk99lcc/+IbB95o2rB84vptLavfpTvodUJoT03sdlp0JlasnfavicHQ3konnApcLaZ2UnAZ8juUdUz13JQdbldrUCbPs/Cw0d7yqG9BaVxdBzTURnOgrcCcYhIaOP+1W+JURE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111680; c=relaxed/simple;
	bh=X/xBTiaTtw+oM/yOgW46HC+IAoXSIZgY75gPUdOdf+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5GXkStrNKyoFV0Aj6fK9EpbPmMeu/sa/ImWSoKDGCYoaLXxMm2LtCIqoUUHVLIcFY+ipANURXIPQD6/bCGw8yrQQJ8DT/hAfaL07HE2OU52f6ncdEBCMVUhbYage/xRuO9kQgPanlMXK+0mOecjwmqSab629tMQQZ+2tK9B8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ari7ydGK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75E31F00A3D;
	Wed, 15 Jul 2026 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784111679;
	bh=/u+P2N6zRIR8FUBVRNxWHd1rg794l4gpgYxauKphMTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ari7ydGKpfnwTgzb36nY7kVdlGE6vrYVN/Ti/SAeTHYi1fxDuCYpPGllrZtl2Y1Yg
	 jfK/Fp4iUqc9sKtVxtnvzkBxVk3aqa6rw+8COlt9lKU+uuvG4d0NboqpKhc5Upwvpl
	 Xy4thbUJY3MHpWDEUJg989mLl2Lt7244u3sPbyPWDkJqvjywzYjYwaIR2iEt4tRuE0
	 9Vmf6B9x/XqE0aIanJtr4fnXJDCdN/ZwxKgmSbqao6ayO87cudr1ytx40vZQt+q7pZ
	 l4zfRngP3OjVyd2ydUlpVcN4FKWy4md6cYl5KNquOqlNsLJdIdF06Rh8ho/yYCSjwV
	 xmir6DvcTpteQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id E790AF40066;
	Wed, 15 Jul 2026 06:34:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 06:34:37 -0400
X-ME-Sender: <xms:PWJXagXvnJIrLEGLn2TcaaNLm5k5GJ8CvbH_2X_DyPi17SHywh8FOQ>
    <xme:PWJXam7Zjsa24wXb_097Eqc4nDWs9VG_U2mHOWe2TBMZxU6SqNHp8T9L-4iqGhjY2
    L3VfekuLMx0tRuKTMlNTGbvCtyzLvWSUvGQZZfd-5qzsI5J_r_2lZI>
X-ME-Received: <xmr:PWJXajKPPuRgSNa8OXZIF2oNs_s7HbLU7HuhIUTJafbIBsmifZodbVEVhP0KxA>
X-ME-Proxy-Cause: dmFkZTF8BlW1JbhLHKAA5CCFXFcYGHtkBS3RzYLv20V59nT+I7FpSJ/Ok8ON8iUs6XHz7u
    +G87ehG5oQ0BL42Uj6L+tKW2gixAEPGzywC8/ROEYb+ORNvX3EuvZfc4z0v6davUQgGBef
    nv/jIaoJLpLf5mwPdwSqDDaztaF20dpNkeWVjyaLioO6Khtwor59qcar6llBTGJ0VX6d2c
    tGKzEbkgZrClapzBkAposaU5h3W0k2guVll2eZTtqt9qaU21+vCnXUQav3DkFMNxeWh9bQ
    h4IL8dIXlwpLvyKEvBdV6VCPSf/irpl/uHVoZNcHQDaubztS+Fhd7BZy1pQgRDVMWGg7sR
    ZDqvbDgPX0jEBV46NyMkqHWWmPL5pjyXSZEXm3SVkv84XhOwrRJngtPmkgeQfnRrX0zbxL
    m+HLvlKHwLRImojhngp+JRlI3tXihZtgQAXc0OVB+Ajo92Ha/bn3x4AacB7U3kysFaCJEo
    vvwpqdRcl6EdjaYO8P2aHisOrxXpA3Ib41YGPgA5jXlWDserU+pes/cLGpgn0eUwz+Htrq
    t3i9BWqYrc0iE+3sVUL/69zQpmtnjVcTk+uwY292UIxT0wMlVh1eF2LjA0tPQVC8DXmbPE
    lfMNuqwlQIZB1re+HJkD/FcF5sWDhPZqa1TekZUorvAwxFBEHAKrvN/7zaCA
X-ME-Proxy: <xmx:PWJXaphQ8cqKFJDXfA-hPYB343__wdvaK33Twj9yuIwO205snQ8KrA>
    <xmx:PWJXatIb0xs4XANPVgpl2zaqWQrLAgvU27hhIaXg4kaSN4G2ZLPagA>
    <xmx:PWJXauGW9z-3YwEfJh7p1mFiZHiq2jHUyLWtCrk4rfkPofg3pYXjkA>
    <xmx:PWJXat12aX1XWeTqpZLHbDzwHd8Blu1u4qvLLzlgv9Hhb7rJJ8QzkQ>
    <xmx:PWJXau2fJ6rHSw7XXpJLCXVLbBHBULFi4tfSDhi-2wPRTAjc7yJTgf7Y>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 06:34:36 -0400 (EDT)
Date: Wed, 15 Jul 2026 11:34:35 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
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
Subject: Re: [PATCH mm-hotfixes v3 1/4] mm/vmalloc: acquire init_mm lock on
 huge vmap to avoid ptdump UAF
Message-ID: <aldhVdwj9oMRN1Lk@thinkstation>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <20260714-series-vmap-race-fix-v3-1-b812eccfa0f9@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-series-vmap-race-fix-v3-1-b812eccfa0f9@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274884-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,thinkstation:mid,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: 3A3DC75D0F7

On Tue, Jul 14, 2026 at 06:24:23PM +0100, Lorenzo Stoakes wrote:
> Currently there is a nasty race between ptdump and vmap when attempting to
> map a huge P4D, PMD or PUD entry:

Nit: that's a strange order of levels :P

> Fix this by holding the mmap read lock in vmap_try_huge_*() when freeing
> page tables.

How about adding here something like:

  The read lock is sufficient: ptdump is the only walker that must be
  excluded and it holds the mmap write lock. Other holders of the read
  lock may run concurrently, but each exclusively owns the range it
  operates on and cannot reach the page tables freed here.

> +	/*
> +	 * Kernel page table walkers either walk ranges they own exclusively or
> +	 * hold the mmap write lock on init_mm (ptdump being the motivating
> +	 * case).
> +	 *
> +	 * Therefore, acquire the mmap read lock to prevent use-after-free when
> +	 * freeing page tables.
> +	 */

Same for the comment, maybe:

      /*
       * Acquire the mmap read lock to exclude ptdump, which walks
       * kernel page tables it does not own under the mmap write lock.
       * Concurrent read lock holders are safe: each exclusively owns
       * the range it operates on and cannot reach this page table.
       */

With that:

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

