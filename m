Return-Path: <stable+bounces-274885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5AHgA+JjV2qvKwEAu9opvQ
	(envelope-from <stable+bounces-274885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 12:41:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7783E75D115
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 12:41:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ne67WCau;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274885-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274885-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 074493036413
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 10:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB054432E6;
	Wed, 15 Jul 2026 10:36:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FF442136;
	Wed, 15 Jul 2026 10:36:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111790; cv=none; b=ejOkAFptUh/+R4TW6e0j18GT2eRbdCeVZjJvMSapVCF+2WhJ2hS00IXzZ4OyA++wOseOUg1kovsuGwkILHhdLGohqgagvJBqgufiTxDD0w+4LWP5pg6d0cKI72BDwkwb2COFSL07b9ECfSH9vtoDknHOMOFSMcAJi9K2tJveTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111790; c=relaxed/simple;
	bh=/aq+i8O9CzJ+ZmRHBaY9TyImuS1xwSYnvShsBnrjxso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCqHSDqxNmjtU7nkT40lXBa+4diy7Gk/z+daEzAsQMo7upOW0RX3srDecpyWuu4zoRN2Ak9gdZfaCXEs690NiupLuLd7MOEUuXIKeguMYBc9bn69RIk733qxp9M5SmI4VfuKkm0VL5+qypjlV4R2sUWw1AiPvMFIikIQbfiIotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne67WCau; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B46D1F000E9;
	Wed, 15 Jul 2026 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784111789;
	bh=SGc4wLtrcKFcbhoINTj74T+3qOdK6ANKsLr4fj0Hk3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ne67WCauJp+fQiewWjzyh6/0niE6s1/e8+W+KH+ij23kp21DgT+JyYj9szpQItpWz
	 EoxQDrPTyc+MAz2HnB9Oh3GOSAADRGF0swK6gOVyARTCtMbTnmsWQkBOc2paEjNzZD
	 PfM293ve8WxDnKc0Z4PYtgF/9XHIxXVmAoY3WwZ71f8QVnLwkdhPlencxY/W3wQcCK
	 /4HwH2WHq4cMS+iSf/z7/7XTlxzdSh3c7wkkKR9ckbafAoZZFEmmjqx6Ogd4hRaBgZ
	 5BbB61yYAK4sU/LvtVQUYooZlki1NxEuGUTlsdtZDSsoaT0j/hz9VmN44Jfa4+4T5H
	 e1sK+XHx+WxMg==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 66559F40066;
	Wed, 15 Jul 2026 06:36:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 06:36:27 -0400
X-ME-Sender: <xms:q2JXasIcTK87tj0M0Ic5UFNoiOPAF3NQ_Dk0NQ4OKwV6DbMdgZB89g>
    <xme:q2JXapsfnLe82cce_X9YNZ32UrazxLJ7ljJyH0VqgC0vnzqBoF0dHsCxavnczcawL
    jFuMR93yj_XY2XQaeP326wrnJhbGuq3ok_pqQmiW88iRMuljNFRwm0>
X-ME-Received: <xmr:q2JXaluvJMyCEaUSGr9WrIdcYatWNe0w3oVo2l1GGmGg4Bv0sxlCqr6a50qEkg>
X-ME-Proxy-Cause: dmFkZTFoH2pQZa2MB7F8P1KNkzYrZ2FYupTRLNJuIuUdKMkzQz8rOl/YdOFBjeV64/eFiz
    grneVbhOZ/mzsgLWmb97Z2MXlENOxDXRl0cjegtXKlxj7YYlu4P2rypydA+jQG17m5ZjrR
    uLA1BH2IYxm64puaRDdrEUMLMhexkcckKs1sEKyml2zpBfIOSacHHPCSa4mrPwXtsA2S2d
    n0AJWgO4Aw1zfMMWmrVVxIux3bA1rGhvs7yymGF6naIGts5DplcBRYFDrF2cdeaP8bZG8h
    uqCwtISn/RjBCphxWoCiq60O2Gpp2nzA6uqQaHx3NgXSiS8IQjohJzFr1kWpEVdFieI5W+
    zSj+F2tRIKbdZ2G88GOn9AR08ypKHMcQnabYwnXiXOn5vdgj+TTtPEjU77Mr2BjBI6Urjw
    1vmC7n/u6OnMBgowj8zJPICTT4s5l+RuxGFGLXG0NLSHoz4timfc4hGSlksoUVvKCK3QUn
    RativehZ1FvH6M7cZDGxQzTgn3rOMiMnL7PWTwdxApBc83z7CgVqOahJ9cYkPoN2O0N7no
    Uk56UlfKVpn5B5rZ9K92JX11zIjWvcbS3QkUU2KCY1FkHuzb23XDwrGqdb2unwf6VuN9av
    S+AKROKDhvXXTxODKw/rsrmVUYvXwVOH78t1sU2BP4CBslU/925LAlXUL9+w
X-ME-Proxy: <xmx:q2JXakRIMffs8qDUs1mdoH-Go4g25NPKMZ_CN2_PaPuJC3KlAtmQqA>
    <xmx:q2JXat3vrR8eDZNO3tneFiN4zykuaM5Xu5mh8hrWNr55hWX2ztia6Q>
    <xmx:q2JXarO16LV0vMtw1_LPC551Fv11Wz-CIgkMvyOHqYsQFcK4IsisiQ>
    <xmx:q2JXagMG8AUv0D_wEPFu-w5uJ9gEPBmFmz4nKLWwwieLVmfSPPO5kA>
    <xmx:q2JXajnknuqqU4lS55abKbdlbfEbUvoPKP6YacJirxQNOwdPPCl1Zs4U>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 06:36:26 -0400 (EDT)
Date: Wed, 15 Jul 2026 11:36:25 +0100
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
Subject: Re: [PATCH mm-hotfixes v3 3/4] mm/ptdump: always stabilise against
 page table freeing using init_mm
Message-ID: <aldim43Nu5sREkDP@thinkstation>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <20260714-series-vmap-race-fix-v3-3-b812eccfa0f9@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-series-vmap-race-fix-v3-3-b812eccfa0f9@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274885-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:dev.jain@arm.com,m:ryan.roberts@arm.com,m:devnexen@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,linux.intel.com,redhat.com,alien8.de,zytor.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,thinkstation:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7783E75D115

On Tue, Jul 14, 2026 at 06:24:25PM +0100, Lorenzo Stoakes wrote:
> Previous commits have established the invariant that kernel page table
> freeing is performed while an mmap read lock on init_mm is held, which
> fixes races between ptdump and kernel page table freeing over init_mm.
> 
> However, x86 and arm64 can perform a ptdump over an mm other than init_mm
> via ptdump_walk_pgd() and since kernel memory ranges are shared across
> non-kernel mm's, this means that the race still exists for these cases.
> 
> Fix this by acquiring a nested mmap write lock for init_mm in
> ptdump_walk_pgd().
> 
> This is safe as we take this after mmap write locking the mm, and nothing
> acquires the init_mm lock first before locking an arbitrary mm, so no
> deadlock is possible.
> 
> Also update walk_page_range_debug() to assert that init_mm is write locked,
> add a comment explaining why and remove some redundant code, and eliminate
> the unnecessary and confusing invocation of walk_kernel_page_table_range().
> 
> We can safely remove the non-NULL check for walk.mm, as the mmap lock
> asserts would NULL pointer deref if it was (and of course no callers do
> this).
> 
> The first point at which ptdump can race kernel page table freeing is
> commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
> table"), so we target this in the Fixes tag.
> 
> Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

Thanks!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

