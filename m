Return-Path: <stable+bounces-249224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N1uNNXPCmru8QQAu9opvQ
	(envelope-from <stable+bounces-249224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:37:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 707D6568F3C
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D52763021253
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E03E277F;
	Mon, 18 May 2026 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3VFbJpm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493A23E3C4A
	for <stable@vger.kernel.org>; Mon, 18 May 2026 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092796; cv=none; b=luqek3jg6lBnBHsDdZxnGRDOtkO9dfMoAaSea6+cX+b36uLImz07X0e0Q4tV2WpTdSOsfNbSj+g6PbdIrNwrkgzmxLA+9WeVvIbboaUFLxNdiyOHxUEOq4LXhKdyNO7IKWLKys7geMI6e21Gw/e15Vx+piB5elPxiTC+fbQ7gIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092796; c=relaxed/simple;
	bh=4PvfaXRPPE9RDMZilXQdkBPoxKj2jDShuEmzMiZWOXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpUf2JOfjtepTyqwx4RTMZd7+2Y42NJpKfG9L7zhnObUf1c+COK9l2gStD2iLw/zyCwdbWe9lUln1WQT9lOLdKQv+jXtbMKPsLHy8YW64Lay1/B0CW4Yu9ggbBLcxWzNigZCLtUzZ8SVyQAZ+8HcYfojhuv0pyoehLCIWKuUoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3VFbJpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D2CC2BCB7;
	Mon, 18 May 2026 08:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779092796;
	bh=4PvfaXRPPE9RDMZilXQdkBPoxKj2jDShuEmzMiZWOXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K3VFbJpmlrHbltRWK6+8l/mrb+LWCe+rypjgJ527R/9H9WxhSMo8Gp9ZRYf6sPdv+
	 IZ2ukc99XPwwrt6ZPf90pcjLdxYx4coYmKWK4CKjzNjiK26OcmXOHXLWLdrVgFFn6S
	 prCzFHeKAncrZaXdUEGQRGuMyors1GTDNTUPHadALpn/Pj17aocUjPD++JszRfalxg
	 3aNqUdtiIhX3gJj03jWkEHNuCQQXVqVSA1673WSovtfidfMGE3ENzdn7W1qmsCYyoX
	 pDLwI9rzx1nhyvRZxOj/wjFQjW9iWzB7b2c1L2nNq9MFCNHy5RyxxlISZCxnUjfK+Y
	 1uQLz84h1eBUA==
Message-ID: <c059d437-b77a-4ea0-881a-39d8fc833c54@kernel.org>
Date: Mon, 18 May 2026 10:26:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory: Fix spurious warning when unmapping
 device-private/exclusive pages
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, aarsenovic@baylibre.com,
 dri-devel@lists.freedesktop.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, jhubbard@nvidia.com, stable@vger.kernel.org
References: <20260501065116.2057242-1-apopple@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260501065116.2057242-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 707D6568F3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249224-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Action: no action

On 5/1/26 08:51, Alistair Popple wrote:
> Device private and exclusive entries are only supported for anonymous
> folios. This condition is tested in __migrate_device_pages() and
> make_device_exclusive() using folio_test_anon(). However the unmap path
> tests this assumption using vma_is_anonymous().
> 
> This is wrong because whilst anonymous VMAs can only contain folios
> where folio_test_anon() is true the opposite relation does not
> hold. A folio for which folio_test_anon() is true does not imply
> vma_is_anonymous() is true. Such a condition can occur if for example a
> folio is part of a private filebacked mapping.
> 
> In this case vma_is_anonymous() is false as the mapping is filebacked,
> but folio_test_anon() may be true, thus permitting devices to migrate
> the folio to device private memory. This can lead to the following
> spurious warnings during process teardown:
> 
> [  772.737706] ------------[ cut here ]------------
> [  772.739201] WARNING: mm/memory.c:1754 at unmap_page_range.cold+0x26/0x18a, CPU#17: hmm-tests/2041
> [  772.742050] Modules linked in: test_hmm nvidia_uvm(O) nvidia(O)
> [  772.743959] CPU: 17 UID: 0 PID: 2041 Comm: hmm-tests Tainted: G        W  O        7.0.0+ #387 PREEMPT(full)
> [  772.747104] Tainted: [W]=WARN, [O]=OOT_MODULE
> [  772.748509] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [  772.752117] RIP: 0010:unmap_page_range.cold+0x26/0x18a
> [  772.753780] Code: 7e fe ff ff 48 89 4c 24 78 4c 89 44 24 38 e8 f2 ff b1 00 48 8b 4c 24 78 4c 8b 44 24 38 48 8b 44 24 18 48 83 78 48 00 74 04 90 <0f> 0b 90 48 89 ca b8 ff ff 37 00 48 c1 ea 03 48 c1 e0 2a 80 3c 02
> [  772.759602] RSP: 0018:ffff888112607550 EFLAGS: 00010286
> [  772.761310] RAX: ffff88811bbf4dc0 RBX: dffffc0000000000 RCX: ffffea03e9bfffd8
> [  772.763583] RDX: 1ffff1102377e9c1 RSI: 0000000000000008 RDI: ffff88811bbf4e08
> [  772.765914] RBP: 0000000000000006 R08: ffff8881059f7448 R09: ffffed10224c0e68
> [  772.768184] R10: ffff888112607347 R11: 0000000000000001 R12: 0000000000000001
> [  772.770461] R13: ffffea03e9bfffc0 R14: ffff888112607908 R15: ffffea03e9bfffc0
> [  772.772782] FS:  00007f327caa2780(0000) GS:ffff888427b7d000(0000) knlGS:0000000000000000
> [  772.775328] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  772.777187] CR2: 00007f327ca89000 CR3: 00000001994d5000 CR4: 00000000000006f0
> [  772.779135] Call Trace:
> [  772.779792]  <TASK>
> [  772.780317]  ? dmirror_interval_invalidate+0x1a3/0x290 [test_hmm]
> [  772.781873]  ? vm_normal_page_pud+0x2b0/0x2b0
> [  772.782992]  ? __rwlock_init+0x150/0x150
> [  772.784006]  ? lock_release+0x216/0x2b0
> [  772.785008]  ? __mmu_notifier_invalidate_range_start+0x505/0x6e0
> [  772.786522]  ? lock_release+0x216/0x2b0
> [  772.787498]  ? unmap_single_vma+0xb6/0x210
> [  772.788573]  unmap_vmas+0x27d/0x520
> [  772.789506]  ? unmap_single_vma+0x210/0x210
> [  772.790607]  ? mas_update_gap.part.0+0x620/0x620
> [  772.791834]  unmap_region+0x19e/0x350
> [  772.792769]  ? remove_vma+0x130/0x130
> [  772.793684]  ? mas_alloc_nodes+0x1f2/0x300
> [  772.794730]  vms_complete_munmap_vmas+0x8c1/0xe20
> [  772.795926]  ? unmap_region+0x350/0x350
> [  772.796917]  do_vmi_align_munmap+0x36a/0x4e0
> [  772.798018]  ? lock_release+0x216/0x2b0
> [  772.799024]  ? vma_shrink+0x620/0x620
> [  772.799983]  do_vmi_munmap+0x150/0x2c0
> [  772.800939]  __vm_munmap+0x161/0x2c0
> [  772.801872]  ? expand_downwards+0xd60/0xd60
> [  772.802948]  ? clockevents_program_event+0x1ef/0x540
> [  772.804217]  ? lock_release+0x216/0x2b0
> [  772.805158]  __x64_sys_munmap+0x59/0x80
> [  772.805776]  do_syscall_64+0xfc/0x670
> [  772.806336]  ? irqentry_exit+0xda/0x580
> [  772.806976]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [  772.807772] RIP: 0033:0x7f327cbb2717
> [  772.808323] Code: 73 01 c3 48 8b 0d f9 76 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 76 0d 00 f7 d8 64 89 01 48
> [  772.811337] RSP: 002b:00007ffde7f57d38 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
> [  772.812564] RAX: ffffffffffffffda RBX: 00007f327cc9c000 RCX: 00007f327cbb2717
> [  772.813733] RDX: 0000000000000000 RSI: 0000000000400000 RDI: 00007f327c289000
> [  772.814867] RBP: 0000000000421360 R08: 000000000000001a R09: 0000000000000000
> [  772.815991] R10: 0000000000000003 R11: 0000000000000202 R12: 00007ffde7f57d74
> [  772.817121] R13: 00007f327c689010 R14: 0000000000100000 R15: 00007f327c289000
> [  772.818272]  </TASK>
> [  772.818614] irq event stamp: 0
> [  772.819159] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [  772.820174] hardirqs last disabled at (0): [<ffffffff82a57ab3>] copy_process+0x19f3/0x6440
> [  772.821511] softirqs last  enabled at (0): [<ffffffff82a57b00>] copy_process+0x1a40/0x6440
> [  772.822869] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [  772.823871] ---[ end trace 0000000000000000 ]---
> 
> Fix this by using the same check for folio_test_anon() in
> zap_nonpresent_ptes(). Also add a hmm-test case for this.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reported-by: Arsen Arsenović <aarsenovic@baylibre.com>
> Fixes: 999dad824c39e ("mm/shmem: persist uffd-wp bit across zapping for file-backed")
> Cc: stable@vger.kernel.org

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David

