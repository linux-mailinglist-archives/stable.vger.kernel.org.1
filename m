Return-Path: <stable+bounces-226026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MfPKYBhuWlsCwIAu9opvQ
	(envelope-from <stable+bounces-226026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:13:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB202AB91B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAE8330B1B5C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B463E3D96;
	Tue, 17 Mar 2026 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri6T6pi1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3613ACA43;
	Tue, 17 Mar 2026 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756343; cv=none; b=eRATIjCjt2YNsInA2L8jxQJX1ECYOam53IN8c40fzpYLJgdDwUFsPTYVBzsOdaLLZPrvPuVVdOtbhC8+GGZYiTXdOttkiG4IBJpX9LthX7BGKJQQKR/ObKSDu6FLr0dXl3Qw36+bMvGt3S5PKTU9jE30y00Nn3hV/ZGXI/i4PKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756343; c=relaxed/simple;
	bh=1sbqgNXyu2WMmYk8by5cABtxizG2nxoEyafVwjmfq10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9beUt66C4yBc2705rgx4HWLfkFWzxOQo5GazOWUQkQ10fJF/fH2i+fdNNwXcNL38QP7fNP6O7HIKUoiB0ArUwtZNQAb99QY7L9ogpCG09wVecrifQZEX+V/vVtS2XR/zYTCUoWts5fvUy4W1W/ibCKn3AhRxO7g2IIxJI+8Gp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri6T6pi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB0EC4CEF7;
	Tue, 17 Mar 2026 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773756342;
	bh=1sbqgNXyu2WMmYk8by5cABtxizG2nxoEyafVwjmfq10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ri6T6pi1H13WvM/4/umOiNgP5i/JgzzB82JRb0t1zzGpdQMvyBN80YkgubPATmTO7
	 HP5xNuWKCERKeDfphiZH+/rsG31IKv3mM8+EuDxCJRXt4mKCw4faRzLtQwSyeAoeB0
	 JydOwImqSO4RryEZZIv8Homrp+uyrw6wFmvJn+bZ/tg2fmBi0APzds3464luEPdgJS
	 FsZXK0XaJCDsU/YtwJ8wIeuLAlrNqIoFaIssiAcAWO/YR0Dgwf5Ge1W6+keCzILx7D
	 idnwYlgz/mh7uCW1HreKv+tQHviGDo+jm/vcO+vRUcmYeXNwtM9OtNYTWj/yDB7odv
	 1pYtoIwTuf75A==
Message-ID: <12804801-d4f9-42c9-8580-e3897efd15ef@kernel.org>
Date: Tue, 17 Mar 2026 15:05:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/pagewalk: fix race between concurrent split and
 refault
To: mboone@akamai.com, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 stable@vger.kernel.org
References: <20260317-pagewalk-check-pmd-refault-v1-1-f699a010f2b3@akamai.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260317-pagewalk-check-pmd-refault-v1-1-f699a010f2b3@akamai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226026-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,akamai.com:email]
X-Rspamd-Queue-Id: 4FB202AB91B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 15:03, Max Boone via B4 Relay wrote:
> From: Max Boone <mboone@akamai.com>
> 
> The splitting of a PUD entry in walk_pud_range() can race with
> a concurrent thread refaulting the PUD leaf entry causing it to
> try walking a PMD range that has disappeared.
> 
> An example and reproduction of this is to try reading numa_maps of
> a process while VFIO-PCI is setting up DMA (specifically the
> vfio_pin_pages_remote call) on a large BAR for that process.
> 
> This will trigger a kernel BUG:
> vfio-pci 0000:03:00.0: enabling device (0000 -> 0002)
> BUG: unable to handle page fault for address: ffffa23980000000
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> ...
> RIP: 0010:walk_pgd_range+0x3b5/0x7a0
> Code: 8d 43 ff 48 89 44 24 28 4d 89 ce 4d 8d a7 00 00 20 00 48 8b 4c 24
> 28 49 81 e4 00 00 e0 ff 49 8d 44 24 ff 48 39 c8 4c 0f 43 e3 <49> f7 06
>    9f ff ff ff 75 3b 48 8b 44 24 20 48 8b 40 28 48 85 c0 74
> RSP: 0018:ffffac23e1ecf808 EFLAGS: 00010287
> RAX: 00007f44c01fffff RBX: 00007f4500000000 RCX: 00007f44ffffffff
> RDX: 0000000000000000 RSI: 000ffffffffff000 RDI: ffffffff93378fe0
> RBP: ffffac23e1ecf918 R08: 0000000000000004 R09: ffffa23980000000
> R10: 0000000000000020 R11: 0000000000000004 R12: 00007f44c0200000
> R13: 00007f44c0000000 R14: ffffa23980000000 R15: 00007f44c0000000
> FS:  00007fe884739580(0000) GS:ffff9b7d7a9c0000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffa23980000000 CR3: 000000c0650e2005 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  __walk_page_range+0x195/0x1b0
>  walk_page_vma+0x62/0xc0
>  show_numa_map+0x12b/0x3b0
>  seq_read_iter+0x297/0x440
>  seq_read+0x11d/0x140
>  vfs_read+0xc2/0x340
>  ksys_read+0x5f/0xe0
>  do_syscall_64+0x68/0x130
>  ? get_page_from_freelist+0x5c2/0x17e0
>  ? mas_store_prealloc+0x17e/0x360
>  ? vma_set_page_prot+0x4c/0xa0
>  ? __alloc_pages_noprof+0x14e/0x2d0
>  ? __mod_memcg_lruvec_state+0x8d/0x140
>  ? __lruvec_stat_mod_folio+0x76/0xb0
>  ? __folio_mod_stat+0x26/0x80
>  ? do_anonymous_page+0x705/0x900
>  ? __handle_mm_fault+0xa8d/0x1000
>  ? __count_memcg_events+0x53/0xf0
>  ? handle_mm_fault+0xa5/0x360
>  ? do_user_addr_fault+0x342/0x640
>  ? arch_exit_to_user_mode_prepare.constprop.0+0x16/0xa0
>  ? irqentry_exit_to_user_mode+0x24/0x100
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fe88464f47e
> Code: c0 e9 b6 fe ff ff 50 48 8d 3d be 07 0b 00 e8 69 01 02 00 66 0f 1f
> 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00
>    f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> RSP: 002b:00007ffe6cd9a9b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fe88464f47e
> RDX: 0000000000020000 RSI: 00007fe884543000 RDI: 0000000000000003
> RBP: 00007fe884543000 R08: 00007fe884542010 R09: 0000000000000000
> R10: fffffffffffffbc5 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
>  </TASK>
> 
> Fix this by validating the PUD entry in walk_pmd_range() using a stable
> snapshot (pudp_get()). If the PUD is not present or is a leaf, retry the
> walk via ACTION_AGAIN instead of descending further. This mirrors the
> retry logic in walk_pmd_range().
> 
> Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
> Cc: stable@vger.kernel.org
> Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Max Boone <mboone@akamai.com>
> ---

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David

