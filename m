Return-Path: <stable+bounces-139211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB0AA52A0
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 19:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B90E4C542E
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D121E0B86;
	Wed, 30 Apr 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UJv2ZgjU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uON408y8"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F677104
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746034334; cv=none; b=eXEe91/dnhD+NdOC4Cdfzrc6EPI7gufRvVzwySQKujmX0BBZdTR5CUPSEy4+5SwpMmGAsGHyDo6Dgrjx74P0bT+Ck3aTwnmIV1NFEsxlgO/i7afTUIU8+pID3nZpDc69Qwoq+bkq3hI5TTSr+qb5DODGVs01bvhdOpkyE+MHbu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746034334; c=relaxed/simple;
	bh=GDERo12fuylocE1QEmf7ZtqDJ8koySNJKbepEfkU+8U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vFqvHY2iC8WgE0JOwo093QziJ/C5ISzQXAX+cT+ujUGHDWsaZuvSazgM0+z90+1yMTsiaESz9nmG+ab7QDnXvH+B7alk6/juCID4XUn9bXTsedOBPCAsTb6V3pjUbDhw+BK56OxX8Tt9e4a/xpd2Oy57/doE5mVGUjLFo800eWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UJv2ZgjU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uON408y8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 16A2E13800BF;
	Wed, 30 Apr 2025 13:32:10 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Wed, 30 Apr 2025 13:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746034330;
	 x=1746120730; bh=015VbXW4QSDjJ/pEV0tZANumHA9OVvM3KFWKJRCZ4lk=; b=
	UJv2ZgjUaSKkF4zhYl4nhxC3ESRP1XOV+eawVzYLCitaBQSOs0deZYmLwARPXcMa
	Sqm9np82NvAfg5Wxa9C0bgdzFhlmREEY27HEKcfCwwZ7HYGNaKcJGgqnJW7wfN7q
	lAvMhD2GOo5UTyHYtYc77n7kP+DZwbHT12ab1KXoVCroGQA0nbDUgq4VPKAIwAKo
	ELX/A7l9hhazF6gu71TmvomuqItmJVsAcKukTbaMTBukpkYWNAzPTOxdHfOwhGu8
	UY3FTFaY0HwxNzvWDTI+OO7ferAu+IfccgvrxokSyKNHHM6o0Kk/G3ZUrw9JcKVd
	nfIolmN9ySbIgtC5K47/8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746034330; x=
	1746120730; bh=015VbXW4QSDjJ/pEV0tZANumHA9OVvM3KFWKJRCZ4lk=; b=u
	ON408y8e6miKi1eISuxU9lpd/R0/LkaBvMHp+jrPQV71e/X7m2GvLXWvxoc3Jlcm
	ZPVNfkMcAX+RALQ0wDc4WZjxc01lSZzJNXTg2kVr7DyFDIM84JDSC7Viwo75pLpA
	I4fktLBbzCyAum/wDkK1WACqTdymcm6H0UxY424xBSErpGR/KCrIz43bs4VfsQqz
	VdnZoyilphQ1aA1SEaU5pcIP43IKzLZAcXyPiMGvEI/CX6lQL79YmQMbkKIWHdUg
	pVRZL9x4D1EN8ZoVArAystkmhIW9OZo26YGj88vc3BWxYi0xaLHFBPo/NNL8599P
	dGnPh+oDyvHxj13K04LAg==
X-ME-Sender: <xms:mF4SaBTDrqSfTJ5Go-_mHN8p4DT0wyqgO7s8lImTc89gM878I6zNUQ>
    <xme:mF4SaKwjE5jyI4EMH-mRYdxftBGmDHMbue_nA1lvuX8ZVmlqyJn-GmacOuh_hFUyp
    ExROb-NAP0F3njjRB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    udegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhiiuhhkihdrphhouhhloh
    hsvgesrghrmhdrtghomhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgr
    uhdprhgtphhtthhopehvrghnnhgrphhurhhvvgesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohep
    khgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehnrghvvggvnheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnh
    eslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:mF4SaG0QI_RSZSoV79KZJd_nG6-SWAQQXm3sq9bo73RE-oeMsOy-wg>
    <xmx:mF4SaJBYD2PDqICn8-rR9y1RolwK-uKbuqpk4BzQcNHS7hqeFwgU1g>
    <xmx:mF4SaKjZHbiQyN1F--m8-TSVcGT3PEmwS3Q-ylCBzVPAISCYQ-HMLQ>
    <xmx:mF4SaNo4CQ6Lw-5Wqu4BuQUj34WEkQbG-SnP9pz28hW6jRBD-eoCUg>
    <xmx:ml4SaDFezXjtWYGUxk2_ryDByr5I-jKTni0DnYWdgu4Z29sMPj2YIoOI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 494E02220073; Wed, 30 Apr 2025 13:32:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3ad4a30312e33025
Date: Wed, 30 Apr 2025 19:31:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Williams" <dan.j.williams@intel.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Ingo Molnar" <mingo@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>, "Naveen N Rao" <naveen@kernel.org>,
 "Nikolay Borisov" <nik.borisov@suse.com>, stable@vger.kernel.org,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Vishal Annapurve" <vannapurve@google.com>, x86@kernel.org,
 linux-coco@lists.linux.dev
Message-Id: <0bdb1876-0cb3-4632-910b-2dc191902e3e@app.fastmail.com>
In-Reply-To: <20250430024622.1134277-3-dan.j.williams@intel.com>
References: <20250430024622.1134277-1-dan.j.williams@intel.com>
 <20250430024622.1134277-3-dan.j.williams@intel.com>
Subject: Re: [PATCH v5] x86/devmem: Drop /dev/mem access for confidential guests
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Apr 30, 2025, at 04:46, Dan Williams wrote:
> While there is an existing mitigation to simulate and redirect access to
> the BIOS data area with STRICT_DEVMEM=y, it is insufficient.
> Specifically, STRICT_DEVMEM=y traps read(2) access to the BIOS data
> area, and returns a zeroed buffer.  However, it turns out the kernel
> fails to enforce the same via mmap(2), and a direct mapping is
> established. This is a hole, and unfortunately userspace has learned to
> exploit it [2].

As far as I can tell, this was a deliberate design choice in
commit a4866aa81251 ("mm: Tighten x86 /dev/mem with zeroing reads"),
which did not try to forbid it completely but mainly avoids triggering
the hardened usercopy check.

> The simplest option for now is arrange for /dev/mem to always behave as
> if lockdown is enabled for confidential guests. Require confidential
> guest userspace to jettison legacy dependencies on /dev/mem similar to
> how other legacy mechanisms are jettisoned for confidential operation.
> Recall that modern methods for BIOS data access are available like
> /sys/firmware/dmi/tables.

Restricting /dev/mem further is a good idea, but it would be nice
if that could be done without adding yet another special case.

An even more radical approach would be to just disallow CONFIG_DEVMEM
for any configuration that includes ARCH_HAS_CC_PLATFORM, but that
may go a little too far.

The existing rules that I can see are:

- readl/write is only allowed on actual (lowmem) RAM, not
  on MMIO registers, enforced by valid_phys_addr_range()
- with STRICT_DEVMEM, read/write is disallowed on both
  RAM and MMIO
- an an exception, x86 additionally allows read/write on the
  low 1MB MMIO region and 32-bit PCI MMIO BAR space, with
  a custom xlate_dev_mem_ptr() that calls either memremap()
  or ioremap() on the physical address.
- as another exception from that, the low 1MB on x86 behaves
  like /dev/zero for memory pages when STRICT_DEVMEM
  is set, and ignores conflicting drivers for MMIO registers
- The PowerPC sys_rtas syscall has another exception in
  order to ignore the STRICT_DEVMEM and write to a portion
  of kernel memory to talk to firmware
- on the mmap() side, x86 has another special to allow
  mapping RAM in the first 1MB despite STRICT_DEVMEM

How about changing x86 to work more like the others and
removing the special cases for the first 1MB and for the
32-bit PCI BAR space? If Xorg, and dmidecode are able to
do this differently, maybe the hacks can just go away, or
be guarded by a Kconfig option that is mutually exclusive
with ARCH_HAS_CC_PLATFORM?

> @@ -595,6 +596,15 @@ static int open_port(struct inode *inode, struct 
> file *filp)
>  	if (rc)
>  		return rc;
> 
> +	/*
> +	 * Enforce encrypted mapping consistency and avoid unaccepted
> +	 * memory conflicts, "lockdown" /dev/mem for confidential
> +	 * guests.
> +	 */
> +	if (IS_ENABLED(CONFIG_STRICT_DEVMEM) &&
> +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return -EPERM;
> +

The description only talks about /dev/mem, but it looks like this
blocks /dev/port as well. Blocking /dev/port may also be a good
idea, but I don't see why that would be conditional on
CC_ATTR_GUEST_MEM_ENCRYPT.

When CONFIG_DEVMEM=y and CONFIG_STRICT_DEVMEM=n, doesn't this still
have the same problem for CC guests?

     Arnd

