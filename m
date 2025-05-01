Return-Path: <stable+bounces-139296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB757AA5BF8
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 10:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4441BC55BF
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B55026157E;
	Thu,  1 May 2025 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QjSOFdsF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/eqYwVv"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572A2DC770
	for <stable@vger.kernel.org>; Thu,  1 May 2025 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746087186; cv=none; b=CSrvTz8CFck0m31qIm+6JvMYGi/6o6j1kEEdG7ogawADLux3HMvR05BH914mgUPp38/28dFk1F1ljN88MHfQQLsjXsYoG0+8k+GBy5DQvFzRVdM8L1Rc1K6C2lYMc8K6VETZRiE/rGNIZJ8F8H4I9rVYtuuS9RKUfDFoKoJZvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746087186; c=relaxed/simple;
	bh=Kfet0z5MYBG5NdDYWAJeCq0jk5SsurFJ/QDiffzvnPo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jHF/Wr1Z6MmnlA2Qv1MwaI1SZ7hiPaC1/CCT9AjbNl4P8rAoSVECFr1JVZmU46QsQyzKEo2iigZOC2cfR80V5+WYSdropbQCf7CHjKeMBVCMuOlFdaD6x2ni6e32WIX7kGUiX/RBQwQSf8Leh3hv+eJnFhzg3SufpRCh78uSPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QjSOFdsF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R/eqYwVv; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 43019114019B;
	Thu,  1 May 2025 04:13:02 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Thu, 01 May 2025 04:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746087182;
	 x=1746173582; bh=S95BdOMfTwyiLY6VbmcL7u8I6TTnOATgFWpbyEqEii0=; b=
	QjSOFdsFtwgrDNEihfkCqe1vRTVgycVfSeS5YSWFcULigc1N4xJa5Bqdy/kS0tbl
	d2ZRsxK7j2Pp4h6LxNRR7MRLEbrBRQ5C//Ydc5VgTryPUsWwubNvHPUBzTq2/fOP
	CXEglDih725tbcsebk47lrsQrtvuQDTobhR3mMisk6mKZBk6VfOPt/Vn2Pe9P58i
	f/hIifzIP/7fl2TPiZ6vQlvEIkd68QrrqZdnqeNpDVz3hcefWtJ1l+Ud4b0s0Ahc
	ANTx8CsNYfH4UGd2FjKDPzD2q319ZEp0gC2w+vhd7MPKsQA22k1pqbqCCiq4wIr0
	Be+xhdoeFlJ/3D7J3PiGfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746087182; x=
	1746173582; bh=S95BdOMfTwyiLY6VbmcL7u8I6TTnOATgFWpbyEqEii0=; b=R
	/eqYwVvBWqJ8DFsMkLYVqJVmtcFezkKXdFNqRAv1zDna2aNaAqCX5r3UtBzQ+zUq
	G5SP0PBwoC39b/tIB4h433mVwR+MJSn11CwG31RVCushl67Ym1/n1bBz6r6AB+nI
	fnQL1lIFPSPEi6Znf975eyliEqGd9MVMdYEvgjH5i32CTqHUy89N9mBzgRgVimaH
	KgQiWU+wgMiME7hg+iEVVQsX7T3eMA8LYwD1/IaBgTciUcPDKYKwQFdv2Amd3x2T
	QgihJJ37BMCLV9IzaUcwWPOmmgCzf51a6Z65m2uBO7m0V9K+FIud5L+p+ADepm2l
	j4bJi97tF0PEU6GMH1i0w==
X-ME-Sender: <xms:DC0TaH6ngWN6JZS6gGuK0AANkUPugzcJmSCX0hTEfjJG0VF4RoWAYg>
    <xme:DC0TaM6gzc4V_f641YQvPBZ0NJYu5-74f7tkJOqn3fuNa63PfhXXsU6UavT2HecKC
    PL8lPYp0Dj8iZ1-H7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeej
    feekkeelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepshhuiihukhhirdhpohhulhhoshgvsegrrhhmrdgtohhmpdhrtghpthht
    ohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepvhgrnhhnrghpuh
    hrvhgvsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghnrdhjrdifihhllhhirghm
    shesihhnthgvlhdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrvhgv
    vghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:DS0TaOfjTqWZkjqa69-IckPxx5zjchm-GxVtsJjI2hCnP_uTryPBeg>
    <xmx:DS0TaIL_L_MTfQYrOE0IrWlgNvQc6BZq3J20Wxik08MXyIcrwrrv3w>
    <xmx:DS0TaLJaGi9VPl3W-1wLCAMsg3bVxTnZdMZh1TVWEz8ffzDXY6ZPWg>
    <xmx:DS0TaBwmszRpi7bGyQ0H42manJvxf_SgEhB92Ef8VUOXXCm5qrSuBA>
    <xmx:Di0TaHNvcVB7zAiBMbkcfei5J3vRkpPu1zc-JovISdstx-0-iW1xr1WD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E35D72220073; Thu,  1 May 2025 04:13:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3ad4a30312e33025
Date: Thu, 01 May 2025 10:12:06 +0200
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
Message-Id: <b48aac71-5148-4be2-b95f-ec60e4f490bd@app.fastmail.com>
In-Reply-To: <6812c6cda0575_1d6a294d7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250430024622.1134277-1-dan.j.williams@intel.com>
 <20250430024622.1134277-3-dan.j.williams@intel.com>
 <0bdb1876-0cb3-4632-910b-2dc191902e3e@app.fastmail.com>
 <6812c6cda0575_1d6a294d7@dwillia2-xfh.jf.intel.com.notmuch>
Subject: Re: [PATCH v5] x86/devmem: Drop /dev/mem access for confidential guests
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 1, 2025, at 02:56, Dan Williams wrote:
> Arnd Bergmann wrote:
>> On Wed, Apr 30, 2025, at 04:46, Dan Williams wrote:
>> > While there is an existing mitigation to simulate and redirect access to
>> > the BIOS data area with STRICT_DEVMEM=y, it is insufficient.
>> > Specifically, STRICT_DEVMEM=y traps read(2) access to the BIOS data
>> > area, and returns a zeroed buffer.  However, it turns out the kernel
>> > fails to enforce the same via mmap(2), and a direct mapping is
>> > established. This is a hole, and unfortunately userspace has learned to
>> > exploit it [2].
>> 
>> As far as I can tell, this was a deliberate design choice in
>> commit a4866aa81251 ("mm: Tighten x86 /dev/mem with zeroing reads"),
>> which did not try to forbid it completely but mainly avoids triggering
>> the hardened usercopy check.
>
> I would say not a "design choice", but rather a known leftover hole that
> nobody has had the initiative to close since 2022.
>
> https://lore.kernel.org/all/202204071526.37364B5E3@keescook/

Ok, I see.

>> The existing rules that I can see are:
>> 
>> - readl/write is only allowed on actual (lowmem) RAM, not
>>   on MMIO registers, enforced by valid_phys_addr_range()
>> - with STRICT_DEVMEM, read/write is disallowed on both
>>   RAM and MMIO
>> - an an exception, x86 additionally allows read/write on the
>>   low 1MB MMIO region and 32-bit PCI MMIO BAR space, with
>>   a custom xlate_dev_mem_ptr() that calls either memremap()
>>   or ioremap() on the physical address.
>> - as another exception from that, the low 1MB on x86 behaves
>>   like /dev/zero for memory pages when STRICT_DEVMEM
>>   is set, and ignores conflicting drivers for MMIO registers
>> - The PowerPC sys_rtas syscall has another exception in
>>   order to ignore the STRICT_DEVMEM and write to a portion
>>   of kernel memory to talk to firmware
>> - on the mmap() side, x86 has another special to allow
>>   mapping RAM in the first 1MB despite STRICT_DEVMEM
>> 
>> How about changing x86 to work more like the others and
>> removing the special cases for the first 1MB and for the
>> 32-bit PCI BAR space? If Xorg, and dmidecode are able to
>> do this differently, maybe the hacks can just go away, or
>> be guarded by a Kconfig option that is mutually exclusive
>> with ARCH_HAS_CC_PLATFORM?
>
> I see the 1MB MMIO special-case in x86::devmem_is_allowed(), but where
> is the 32-bit PCI BAR space workaround? Just to make sure I am not
> missing a detail here.

The main difference on x86 is the xlate_dev_mem_ptr() function
that does an extra memremap() of the physical address, everything
else just does a phys_to_virt(). The only other architecture
with an xlate_dev_mem_ptr() implementation is s390, which uses
it to work around the first physical page being different per CPU.
ia64 had something similar to x86 but is gone now.

The other bit of the puzzle is that memremap() on x86 silently
falls back to ioremap() for non-RAM pages. This was originally
added in 2008 commit e045fb2a988a ("x86: PAT avoid aliasing in
/dev/mem read/write"). I'm not sure what happened exactly, but
I suspect that the low 1MB was already mapped at the time
through a cached mapping, while the PCI MMIO hole was perhaps
not mapped. On x86-32, the 32-bit PCI BAR area should not
be included here (since it's above high_memory), but the 16MB
hold may be.

The address is first checked by valid_phys_addr_range(), which
is defined in an architecture specific way, so it's possible that
there are additional architectures on which that includes MMIO
ranges that can be accesses through phys_to_virt(), but I could
not find any.

The default valid_phys_addr_range() just checks against
'high_memory' to see whether the address is in the linear
map. This works on all architectures that don't have holes
in the memory map for MMIO (most of them) or that don't
just ioremap() all MMIO space into the hole (most of the rest).

arm64 and loongarch check memblock allow known RAM both in
the linear map and outside of it, while arm32 and sh explicitly
exclude addresses before PHYS_OFFSET on machines where RAM
does not start at address 0.

       Arnd

