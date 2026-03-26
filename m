Return-Path: <stable+bounces-230408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMEWNoeTxGnH0gQAu9opvQ
	(envelope-from <stable+bounces-230408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 03:01:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C2A32E27B
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 03:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6B3130C6F02
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D232ED141;
	Thu, 26 Mar 2026 01:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Df/t31v0"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411130E82B;
	Thu, 26 Mar 2026 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490107; cv=none; b=MKc2JXW+Yb7pYBVrDUK3O7XpdFcL5atsZaSr6Lc66/NQr03fdSkSlACNB5w2kFGicqmg/tkTs944d0FE1cRYwFtHgxF3l102kRQGlhGlspPDbaVizbq7MK2AmXn497qx8SD0YFkfAhw5nuU42M1ZRJhccF4HrADmy5Se2zWOZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490107; c=relaxed/simple;
	bh=Nu+lYMUp27NIIzieWznkU42OBETiqNrSkeWdfeX0RNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X3WHEug7N9VO3Kk0rwSbytt/EqEh5ThiKIwI/WIGEYfubQASKlANYBdK22bZgnZcfjBnTKwcFjyrtEsEZLlOR2kHlCygL36rBhqiGr2wsvfNruRbFmRD7UgCt+IKdv7XsmXOu674wLuGNJu67emycmyYgGPblKa04GQnmNMxAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Df/t31v0; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yEpTAn2gewU3K+9GeBipEKFflq6BhvaNFUGSIoWFGaM=;
	b=Df/t31v0R2MDDqJSK5DMXtwlngxh87KuNPvfr9S2TjkgcYvWiW+IV7wKSG7mW6TZyNnFq6lTA
	fZWuDQ0XB2leOCEn1PkwRRyG47RSSU/gj2eCO/8gVO0g0v9yhZUHXtbSl5JokhlnE5aeFO1n0Fa
	C9SanzvMoy3j5YLTTNHr0sY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fh6BT2rvYzRhyN;
	Thu, 26 Mar 2026 09:48:49 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 601572025E;
	Thu, 26 Mar 2026 09:54:55 +0800 (CST)
Received: from [10.174.178.9] (10.174.178.9) by kwepemr500001.china.huawei.com
 (7.202.194.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Mar
 2026 09:54:54 +0800
Message-ID: <9bef9063-5f6a-4f2c-8ef7-227cbc5ba9b3@huawei.com>
Date: Thu, 26 Mar 2026 09:54:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: mm: Handle invalid large leaf mappings
 correctly
To: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "David Hildenbrand
 (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>, Yang Shi
	<yang@os.amperecomputing.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-3-ryan.roberts@arm.com>
 <a7fa6fd9-79b2-4e46-8ee4-fde9d5853100@huawei.com>
 <c6aef714-6736-42c8-8866-eb4da7ab85a1@arm.com>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <c6aef714-6736-42c8-8866-eb4da7ab85a1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500001.china.huawei.com (7.202.194.229)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230408-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tujinjiang@huawei.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: 60C2A32E27B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


在 2026/3/26 1:31, Ryan Roberts 写道:
> On 24/03/2026 02:30, Jinjiang Tu wrote:
>> 在 2026/3/23 21:03, Ryan Roberts 写道:
>>> It has been possible for a long time to mark ptes in the linear map as
>>> invalid. This is done for secretmem, kfence, realm dma memory un/share,
>>> and others, by simply clearing the PTE_VALID bit. But until commit
>>> a166563e7ec37 ("arm64: mm: support large block mapping when
>>> rodata=full") large leaf mappings were never made invalid in this way.
>>>
>>> It turns out various parts of the code base are not equipped to handle
>>> invalid large leaf mappings (in the way they are currently encoded) and
>>> I've observed a kernel panic while booting a realm guest on a
>>> BBML2_NOABORT system as a result:
>>>
>>> [   15.432706] software IO TLB: Memory encryption is active and system is
>>> using DMA bounce buffers
>>> [   15.476896] Unable to handle kernel paging request at virtual address
>>> ffff000019600000
>>> [   15.513762] Mem abort info:
>>> [   15.527245]   ESR = 0x0000000096000046
>>> [   15.548553]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [   15.572146]   SET = 0, FnV = 0
>>> [   15.592141]   EA = 0, S1PTW = 0
>>> [   15.612694]   FSC = 0x06: level 2 translation fault
>>> [   15.640644] Data abort info:
>>> [   15.661983]   ISV = 0, ISS = 0x00000046, ISS2 = 0x00000000
>>> [   15.694875]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>>> [   15.723740]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>> [   15.755776] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081f3f000
>>> [   15.800410] [ffff000019600000] pgd=0000000000000000, p4d=180000009ffff403,
>>> pud=180000009fffe403, pmd=00e8000199600704
>>> [   15.855046] Internal error: Oops: 0000000096000046 [#1]  SMP
>>> [   15.886394] Modules linked in:
>>> [   15.900029] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc4-
>>> dirty #4 PREEMPT
>>> [   15.935258] Hardware name: linux,dummy-virt (DT)
>>> [   15.955612] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>>> [   15.986009] pc : __pi_memcpy_generic+0x128/0x22c
>>> [   16.006163] lr : swiotlb_bounce+0xf4/0x158
>>> [   16.024145] sp : ffff80008000b8f0
>>> [   16.038896] x29: ffff80008000b8f0 x28: 0000000000000000 x27: 0000000000000000
>>> [   16.069953] x26: ffffb3976d261ba8 x25: 0000000000000000 x24: ffff000019600000
>>> [   16.100876] x23: 0000000000000001 x22: ffff0000043430d0 x21: 0000000000007ff0
>>> [   16.131946] x20: 0000000084570010 x19: 0000000000000000 x18: ffff00001ffe3fcc
>>> [   16.163073] x17: 0000000000000000 x16: 00000000003fffff x15: 646e612065766974
>>> [   16.194131] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>> [   16.225059] x11: 0000000000000000 x10: 0000000000000010 x9 : 0000000000000018
>>> [   16.256113] x8 : 0000000000000018 x7 : 0000000000000000 x6 : 0000000000000000
>>> [   16.287203] x5 : ffff000019607ff0 x4 : ffff000004578000 x3 : ffff000019600000
>>> [   16.318145] x2 : 0000000000007ff0 x1 : ffff000004570010 x0 : ffff000019600000
>>> [   16.349071] Call trace:
>>> [   16.360143]  __pi_memcpy_generic+0x128/0x22c (P)
>>> [   16.380310]  swiotlb_tbl_map_single+0x154/0x2b4
>>> [   16.400282]  swiotlb_map+0x5c/0x228
>>> [   16.415984]  dma_map_phys+0x244/0x2b8
>>> [   16.432199]  dma_map_page_attrs+0x44/0x58
>>> [   16.449782]  virtqueue_map_page_attrs+0x38/0x44
>>> [   16.469596]  virtqueue_map_single_attrs+0xc0/0x130
>>> [   16.490509]  virtnet_rq_alloc.isra.0+0xa4/0x1fc
>>> [   16.510355]  try_fill_recv+0x2a4/0x584
>>> [   16.526989]  virtnet_open+0xd4/0x238
>>> [   16.542775]  __dev_open+0x110/0x24c
>>> [   16.558280]  __dev_change_flags+0x194/0x20c
>>> [   16.576879]  netif_change_flags+0x24/0x6c
>>> [   16.594489]  dev_change_flags+0x48/0x7c
>>> [   16.611462]  ip_auto_config+0x258/0x1114
>>> [   16.628727]  do_one_initcall+0x80/0x1c8
>>> [   16.645590]  kernel_init_freeable+0x208/0x2f0
>>> [   16.664917]  kernel_init+0x24/0x1e0
>>> [   16.680295]  ret_from_fork+0x10/0x20
>>> [   16.696369] Code: 927cec03 cb0e0021 8b0e0042 a9411c26 (a900340c)
>>> [   16.723106] ---[ end trace 0000000000000000 ]---
>>> [   16.752866] Kernel panic - not syncing: Attempted to kill init!
>>> exitcode=0x0000000b
>>> [   16.792556] Kernel Offset: 0x3396ea200000 from 0xffff800080000000
>>> [   16.818966] PHYS_OFFSET: 0xfff1000080000000
>>> [   16.837237] CPU features: 0x0000000,00060005,13e38581,957e772f
>>> [   16.862904] Memory Limit: none
>>> [   16.876526] ---[ end Kernel panic - not syncing: Attempted to kill init!
>>> exitcode=0x0000000b ]---
>>>
>>> This panic occurs because the swiotlb memory was previously shared to
>>> the host (__set_memory_enc_dec()), which involves transitioning the
>>> (large) leaf mappings to invalid, sharing to the host, then marking the
>>> mappings valid again. But pageattr_p[mu]d_entry() would only update the
>>> entry if it is a section mapping, since otherwise it concluded it must
>>> be a table entry so shouldn't be modified. But p[mu]d_sect() only
>>> returns true if the entry is valid. So the result was that the large
>> Maybe I missed something, pmd_sect() only checks PMD_TYPE_SECT, doesn't check
>> PTE_VALID?
>> Why it only returns true if the entry is valid?
> PTE_VALID is bit 0.
>
> #define PMD_TYPE_MASK		(_AT(pmdval_t, 3) << 0)
> #define PMD_TYPE_TABLE		(_AT(pmdval_t, 3) << 0)
> #define PMD_TYPE_SECT		(_AT(pmdval_t, 1) << 0)
>
> So PMD_TYPE_TABLE and PMD_TYPE_SECT are both implicitly checking that PTE_VALID
> is set.

Understood, thanks.

>> #define pmd_sect(pmd)        ((pmd_val(pmd) & PMD_TYPE_MASK) == \
>>                   PMD_TYPE_SECT)
>>
> Thanks,
> Ryan
>
>

