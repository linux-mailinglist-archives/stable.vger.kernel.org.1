Return-Path: <stable+bounces-217726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJHkHrg3nGlCBgQAu9opvQ
	(envelope-from <stable+bounces-217726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:19:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEE8175626
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D863F30630A0
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9E83612D2;
	Mon, 23 Feb 2026 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+ZmlUzd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0EB35B65F;
	Mon, 23 Feb 2026 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845466; cv=none; b=UOllPdav0W/rKzoUjajSOek//SLybjp5p7i2ekfaUDCZRUOwYiHxq3pWBEi+Vps+tZRVD1dG/3Uw1w/TJ70oQgohvW88m7POjqJyD0eOCCEjr3gWza2HhJhGIfoBd+wZDdfnQonXCLJ6oE+zPD/VmLK+LqdyKhvSjv1b81M+IQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845466; c=relaxed/simple;
	bh=h3K7cndj4kG1iv/vNT+K90U40QryseuSg7TrHfv0p5c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J8Bz90Tqo/0C5NMWCcuB/C1sVzElhLs0I+LaHegezBbExu0v5w30x/AtLjpAZ4H3RiBuTMWcQb9wHDH1efSf9y5SVfksRoprUxW8bhMs4t1BLGMUeeA9z4g4MYrnlqV8to36qoDmeIhOEHownyJMbeQ/BI0T1rCnS06nBaDuurs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+ZmlUzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD78C2BC9E;
	Mon, 23 Feb 2026 11:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771845466;
	bh=h3K7cndj4kG1iv/vNT+K90U40QryseuSg7TrHfv0p5c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T+ZmlUzdf/h04LkbcDyxLGknTACoTYpcBLRrq+sOPTe6NUCPhryfL6eXp5Hn6pCsO
	 nKNDe1r2hj4mnJ9NUrjpwNSWDTDw5jZwBlM9U2Q/6ISA+C+v2hC4Bcjz6cf9pvxBUM
	 LXpnVd0pHPSa+la12I8raghU+w28gd9gGhov8QEX2L/8ZJGd4aiCyQnmvZABfxPUwJ
	 VQ531qrtYP4Egn+ksVB9UpHf7XMnci4saRnPBfD73m54Mk2xNjA+80PfF++ZlmPmWy
	 bRRscgI67Dihof6svyTtwqSk8PNXuZcLVCbhkaqftqvAPOTfchQzsL9azgDOtVXod8
	 rXpPPAPZY+rbQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 31E4BF4006B;
	Mon, 23 Feb 2026 06:17:45 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 06:17:45 -0500
X-ME-Sender: <xms:WTecaZgA8AvZpn8eSULqZP9B7hCd7CRFOEns11LlNWohktnXoMbOcA>
    <xme:WTecaY2kZ-2lmI20rnAEUoPb7QkSU5zjaEY_sl3GTW_KcWXU5S7tgYdQw55sMX33n
    dP1_pNudIjm1DTEWgLI0PjXNoUFeqRWy9y_hhgoYoxn7XHk8rQi3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepsggvnhhhsehkvghrnhgvlh
    drtghrrghshhhinhhgrdhorhhgpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehtghhlgieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekie
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdho
    rhhgpdhrtghpthhtohepihhlihgrshdrrghprghlohguihhmrghssehlihhnrghrohdroh
    hrghdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgt
    ohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:WTecaU4kQ0Cm_b0_Li1sUA8NmJUle7HisuUZoKxwRtcxYryS4qpbeg>
    <xmx:WTecaVfIOmmR7JPM3JsNK75dtyEvFNW7fuTIZneToo94Sz5oRuQ2iw>
    <xmx:WTecaXwKtaKlcxBU5OxWcGeOn6GnrikiNIKmx_O73BAxMHvQtLW2tw>
    <xmx:WTecabpesWExFjmzzZts0Pp847SBQBpJXbYWZxD5rZt6c_m0IblPfw>
    <xmx:WTecaVwC1NV6aDi1xwqlurWiCkmGRBHl52XU9LP7KjPnI438uye4kjw5>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0D441700065; Mon, 23 Feb 2026 06:17:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AF0NZ4OlJH_7
Date: Mon, 23 Feb 2026 12:17:22 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Mike Rapoport" <rppt@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Ingo Molnar" <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 "Thomas Gleixner" <tglx@kernel.org>, linux-efi@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Message-Id: <e2ad0845-2f87-418a-9f87-5ce619e004ef@app.fastmail.com>
In-Reply-To: <aZwyNAbEqb8ZwLUM@kernel.org>
References: <20260223075219.2348035-1-rppt@kernel.org>
 <b6f4edf5-7587-45d7-b81a-590d4f3d1ddd@app.fastmail.com>
 <aZwyNAbEqb8ZwLUM@kernel.org>
Subject: Re: [PATCH] x86/efi: defer freeing of boot services memory
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217726-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1BEE8175626
X-Rspamd-Action: no action



On Mon, 23 Feb 2026, at 11:55, Mike Rapoport wrote:
> Hi Ard,
>
> On Mon, Feb 23, 2026 at 09:08:29AM +0100, Ard Biesheuvel wrote:
>> Hi Mike,
>> 
>> On Mon, 23 Feb 2026, at 08:52, Mike Rapoport wrote:
>> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> > efi_free_boot_services() frees memory occupied by EFI_BOOT_SERVICES_CODE
>> > and EFI_BOOT_SERVICES_DATA using memblock_free_late().
>> >
>> > There are two issue with that: memblock_free_late() should be used for
>> > memory allocated with memblock_alloc() while the memory reserved with
>> > memblock_reserve() should be freed with free_reserved_area().
>> >
>> > More acutely, with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
>> > efi_free_boot_services() is called before deferred initialization of the
>> > memory map is complete.
>> >
>> > Benjamin Herrenschmidt reports that this causes a leak of ~140MB of
>> > RAM on EC2 t3a.nano instances which only have 512MB or RAM.
>> >
>> > If the freed memory resides in the areas that memory map for them is
>> > still uninitialized, they won't be actually freed because
>> > memblock_free_late() calls memblock_free_pages() and the latter skips
>> > uninitialized pages.
>> >
>> > Using free_reserved_area() at this point is also problematic because
>> > __free_page() accesses the buddy of the freed page and that again might
>> > end up in uninitialized part of the memory map.
>> >
>> > Delaying the entire efi_free_boot_services() could be problematic
>> > because in addition to freeing boot services memory it updates
>> > efi.memmap without any synchronization and that's undesirable late in
>> > boot when there is concurrency.
>> >
>> > More robust approach is to only defer freeing of the EFI boot services
>> > memory.
>> >
>> > Make efi_free_boot_services() collect ranges that should be freed into
>> > an array and add an initcall efi_free_boot_services_memory() that walks
>> > that array and actually frees the memory using free_reserved_area().
>> >
>> 
>> Instead of creating another table, could we just traverse the EFI memory
>> map again in the arch_initcall(), and free all boot services code/data
>> above 1M with EFI_MEMORY_RUNTIME cleared ?
> 
> Currently efi_free_boot_services() unmaps all boot services code/data with
> EFI_MEMORY_RUNTIME cleared and removes them from the efi.memmap.
>

Ah yes, I failed to spot that those entries are long gone by initcall time. Other architectures don't touch the EFI memory map at all, but x86 mangles it beyond recognition :-)

> I wasn't sure it's Ok to only unmap them, but leave in efi.memmap, that's
> why I didn't use the existing EFI memory map.
>
> Now thinking about it, if the unmapping can happen later, maybe we'll just
> move the entire efi_free_boot_services() to an initcall?
>

As long as it is pre-SMP, as that code also contains a quirk to allocate the real mode trampoline if all memory below 1 MB is used for boot services.

But actually, that should be a separate quirk to begin with, rather than being integrated into an unrelated function that happens to iterate over the boot services regions. The only problem, I guess, is that memblock_reserve()'ing that sub-1MB region in the old location in the ordinary way would cause it to be freed again in the initcall?

But yes, in general I think it is fine to unmap those regions from the EFI page tables during an initcall.








