Return-Path: <stable+bounces-273899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ORy7FfIeVWrSkAAAu9opvQ
	(envelope-from <stable+bounces-273899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:22:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C204274DFA3
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:22:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RbA1rChv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273899-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273899-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E4F303CE9C
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF8C346FA1;
	Mon, 13 Jul 2026 17:21:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683512E1DC;
	Mon, 13 Jul 2026 17:21:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963311; cv=none; b=rlRU5R9DUpPeY9KMlYueZwDMYAoIUyXxM1rzlwZQaXZTo5fQ9zJPaWCsuswRIBGmM2o7+FlqjmVApun9iK9MMQxEWqhNQbw7kgyxKU5vc0y2+jL/j+fk7pvIs/+6T/efyjvdRGizJ++mg+EI4nu1RIkcNqchGm7V8cP5hBe/Wds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963311; c=relaxed/simple;
	bh=ZE2h0qoaOqXoIDuIutnTPsN+Uae5G0M+4tVkUaOdW1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYtR5NdO5Rfyr2Mlxw5ZyfSxZUoIaqs8evLAU4LQGQ3SfYn1AKyMwpqkmDKACHrZihyewlMqyUNbbipHCdGE/5Bypkwy0KfJh/ZazbJZ1/Tzl+GRbeuVQhxWzeypuVHRuiWM6UASDG6x7tJR9UY+WJiESRlrQoHYZUDz17xH7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbA1rChv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9451F00A3A;
	Mon, 13 Jul 2026 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783963309;
	bh=BZOphvSkd23b/TrtduYCguYGvr5EK1HZzl/qohcfY7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RbA1rChvxuFHpvQpDnMIbOC1D3+A+tbEwrNL6FcFMyHTv2MI7ERRrcjFRMIC41MMV
	 zEL6U0d7MDA65bCG2d3MXuGmAtBm57rcO1TmCOHrnU3cehgaHcdDSc79gsx63By+PK
	 UlSJhNlEFH2DfZ9kWrnUBoQwtzYZHb6ZXfqqNrRNq7qzhKRG/YSt/BfSKLJSBl9AFF
	 r0DF7trd+SNJRGpmtTwlsDn3a33tCGIxvmWxMGLraW+c12l9akDzYp1h4QVH95WRAN
	 YISJI8elk1Sn0+Kk5cubL6WxzT9XcyLW1zHetzzYJZeA1u4BkD5g5bgad9qZauwwQW
	 RS8GWg+1RL2dg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 598A2F40264;
	Mon, 13 Jul 2026 13:21:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 13:21:48 -0400
X-ME-Sender: <xms:rB5VapuBuKvmIc8h0A0ZvoIBDABQaLm8a1-zwkAo_KS2Vst9rHqLkw>
    <xme:rB5ValtpRpThec3oyqDt1PihMsX3d7FvYGfhdfyax0gJncXqGyrzniaXTIbNNodOS
    y4LrnM542IJs8Z425sE0fD6mT7AqVuiL646qs6YryElQ8P6EmWI7ygg>
X-ME-Received: <xmr:rB5VakR6qfI90gNefqHgPJZUDIMGIF5b9qmTxw7rokqcgWzfUByGk8D3DawaSw>
X-ME-Proxy-Cause: dmFkZTE8vFJ9v3UZX0gql0WylFpu+0srIJpxxoXkBc60QmD6KjWRUGese9oi8JR+h7CtdO
    c5j/pE8W9f0Ds7zY0ofw7mKJEkPXT93kMsaRFp1A73bzp3g4oRGNfknkoKqHDrUJpcUDKe
    4S1qNW0VgsVyeO808aKfKoIkUyhtSmuQaEGoQPTZyPI8Ueh+5TQu7172ohN3cwuOIrThbI
    00w/uyeFrYmAMXYbrVagav1Avz5eB+onspWC2LgrR4amVPrKdwPc0R/NG0aeJmzmGACiYs
    gp/aKmPli6E5v6qzU3vrmb/NihRmn+O4LeV8cB1+umyMkp4jsNMhljH+KgvsWWBCjrVNq9
    mbUSM8sQzHH9TOl8eFIHcOozSUAnDSSXN9bgrjX/5U/l1UwIp73uXZdKre2K5WQxgSUL8L
    RIC+leW0C/NHDT678RvEBLQ/dHcGbwIW55LUhvhKfzX+lRH1V+W21jLvAAJjih/0wmho/K
    FoOIbOPf2E1zSRxbVeR/O0cj5otNJWDxiH7Z4Jz+1nFZRBP7l5mpUHDlUd6ejXuxPJ2OQu
    s6hzlmgL2u3nG/hQeXmAKQfMEuq//TVwdJV2NVbK+3IlDFIPmiOpeLmfn6Jl+7jfOwIvV5
    cSiQqtt28gaqgkV2dN5grNPpHxLfTueZELQCBJkzu9mxD3FKd3T7INWTKcCg
X-ME-Proxy: <xmx:rB5Vat05x0a8gVWVxI6YmJys8iMmvwxFhNIuTgjV1Py0XSlAzS0ozg>
    <xmx:rB5VarM3KUwYdO_HA_sYP81gL3qE-4wI9IRw9ypAEsdzSAxG6Wn85w>
    <xmx:rB5VagNgM8xVjeceZnL-PNUJU1zvieklfuMzjnaQQcDNBuSusEZNfg>
    <xmx:rB5Vajk2KNAct6hG-Xe9MnFUrFkQBrNby_FhWp_imlHtgd-0i_CAsw>
    <xmx:rB5VajA6XRsGOWHYpPY90PInCzmigjdjhLhmL_0cF77v4O-W8LriS9tJ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 13:21:47 -0400 (EDT)
Date: Mon, 13 Jul 2026 18:21:46 +0100
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
Subject: Re: [PATCH mm-hotfixes v2 4/4] arm64: remove redundant concurrent
 ptdump UAF mitigation
Message-ID: <alUeafMBZtSp8XTd@thinkstation>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273899-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:akpm@linux-foundation.org,m:surenb@google.com,m:liam@infradead.org,m:vbabka@kernel.org,m:shakeel.butt@linux.dev,m:david@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:urezki@gmail.com,m:toshi.kani@hpe.com,m:dave.hansen@linux.intel.com,m:luto@kernel.org,m:peterz@infradead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:dev.jain@arm.com,m:ryan.roberts@arm.com,m:devnexen@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,infradead.org,kernel.org,linux.dev,suse.com,gmail.com,hpe.com,linux.intel.com,redhat.com,alien8.de,zytor.com,arm.com,kvack.org,vger.kernel.org,lists.infradead.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email];
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
X-Rspamd-Queue-Id: C204274DFA3

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

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

