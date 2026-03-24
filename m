Return-Path: <stable+bounces-230085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMGDNElPwmnvbAQAu9opvQ
	(envelope-from <stable+bounces-230085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:46:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 760B5304EB6
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34F8C303C6B5
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CA0242D70;
	Tue, 24 Mar 2026 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/UzrF3R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA92571C7;
	Tue, 24 Mar 2026 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341573; cv=none; b=hoDRgnrAlPGlqWg2Pb+DTtuXxxc5BFm1I2uTMnKYgVR42cKRHfGgB/zogjtRYie+5W6VLB1sMTNZzMrpERGYDWpbUGjbEKI3tLN5Rsz1Lty4VUMbepzD3Bc3zjLNwBXnq9iN6MaLlpZacVNyAkxdsNy3A/YP/pUQour1NI1OfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341573; c=relaxed/simple;
	bh=OtOjF7Mt+dJ+1ARMRcLf5kZ/NDUv+K1d9LWNs6dcnt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYduAk1n02+8shb5Dg/amZ464TfGu4POgD8guCLu1Zvr9YEC7J4EOwQq/I6DZbWJmXQfgH4NPQY5zpPrAcbaB7hlEUf2JktB9Nxxmj/RoxyGX5Gf0RmUVivGIB2U87agKZCFqe/uaj/eIUaft2e5hGsB/A6eAleRW5P/4C/xe5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/UzrF3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E084CC19424;
	Tue, 24 Mar 2026 08:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774341573;
	bh=OtOjF7Mt+dJ+1ARMRcLf5kZ/NDUv+K1d9LWNs6dcnt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/UzrF3R7Q1imKzJ2jhgsgeRthZOiNg69HFBVV1fWSI5imjY60puN1El70ZIZGBf2
	 D1YZk+0rneTPNYtbv97N78D/aWJtS3Nkj0jYj0XJxctzsupvzCdTBqQNVt0X6KEyzy
	 hM9COTrvPfHngvFkWcRYMHiAEty1iOudMQ2+m0w1iBl/ydbHmuDHz7Ot6HvmKFqYC4
	 AaMLYY7Xz/zb5TqS9wb23nYFAPRV0MuRMu7IlNGWpUfX/DdWHOHTwfoLy0QJh1rHvO
	 rp3NsYWz/v3KvPDiIEy/GyyqlF9XXPaMUSa3KNXT2TwlpkLhyuq77OE56Py1WymRY9
	 TZGCop/8hv1pQ==
Date: Tue, 24 Mar 2026 10:39:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org, Alex Williamson <alex@shazbot.org>,
	Max Boone <mboone@akamai.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/memory: fix PMD/PUD checks in follow_pfnmap_start()
Message-ID: <acJNvA97csyxd0Ml@kernel.org>
References: <20260323-follow_pfnmap_fix-v1-1-5b0ec10872b3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-follow_pfnmap_fix-v1-1-5b0ec10872b3@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230085-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 760B5304EB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 09:20:18PM +0100, David Hildenbrand (Arm) wrote:
> follow_pfnmap_start() suffers from two problems:
> 
> (1) We are not re-fetching the pmd/pud after taking the PTL
> 
> Therefore, we are not properly stabilizing what the lock lock actually

                                                    ^ lock lock

> protects. If there is concurrent zapping, we would indicate to the
> caller that we found an entry, however, that entry might already have
> been invalidated, or contain a different PFN after taking the lock.
> 
> Properly use pmdp_get() / pudp_get() after taking the lock.
> 
> (2) pmd_leaf() / pud_leaf() are not well defined on non-present entries
> 
> pmd_leaf()/pud_leaf() could wrongly trigger on non-present entries.
> 
> There is no real guarantee that pmd_leaf()/pud_leaf() returns something
> reasonable on non-present entries. Most architectures indeed either
> perform a present check or make it work by smart use of flags.
> 
> However, for example loongarch checks the _PAGE_HUGE flag in pmd_leaf(),
> and always sets the _PAGE_HUGE flag in __swp_entry_to_pmd(). Whereby
> pmd_trans_huge() explicitly checks pmd_present(), pmd_leaf() does not
> do that.
> 
> Let's check pmd_present()/pud_present() before assuming "the is a
> present PMD leaf" when spotting pmd_leaf()/pud_leaf(), like other page
> table handling code that traverses user page tables does.
> 
> Given that non-present PMD entries are likely rare in VM_IO|VM_PFNMAP,
> (1) is likely more relevant than (2). It is questionable how often (1)
> would actually trigger, but let's CC stable to be sure.
> 
> This was found by code inspection.
> 
> Fixes: 6da8e9634bb7 ("mm: new follow_pfnmap API")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> Gave it a quick test in a VM with MM selftests etc, but I am not sure if
> I actually trigger the follow_pfnmap machinery.

Most probably not :)
KVM selftests might, didn't really dig into that. But I doubt any selftest
would trigger potential races there.

> ---
>  mm/memory.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
 
-- 
Sincerely yours,
Mike.

