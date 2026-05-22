Return-Path: <stable+bounces-253816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DCTEeyCEGoHYgYAu9opvQ
	(envelope-from <stable+bounces-253816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:23:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FFF5B7884
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2544030041C0
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725924219E1;
	Fri, 22 May 2026 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udbagh6n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965F378D87
	for <stable@vger.kernel.org>; Fri, 22 May 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466976; cv=none; b=bsMsp6sm5ORm+aJyQ6BoQ8eoieTbObxto10/JqVqKfxeoJ4RZBkLwiMyK6alNzd0pVvEKYkYY6utzCO7CnNUiIYUZYGheSZNdzm0L/dMHnHW9bP8ssmSY8RvDoIiccRewVLgr1JR2l0Tx9CQ43f5NhuLQCzhYhOCOCMmBFVFNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466976; c=relaxed/simple;
	bh=k5IIM/WuvVoj26e6a9CXnFnmxNMSYOY0Hr0TpIGocQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiLwOEvQvSnfFXvW1OmeVHsRHV7ucUcF7ZCSzbv4YYI8Cc0uioauF7kl94OgZhgw46LS+KN3ZLp9tDNBL567mn7HYFJ+Y3um0zPaKMFcC0f6W34oENEyLs37wdv0VcjtztNuYCjBjAWYe38LrNStKq/m2I9eMHqV+N3hmNCGd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udbagh6n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EE91F00A3F;
	Fri, 22 May 2026 16:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779466975;
	bh=HXtVzRGfukj3ds6TKFAVxguxeD4B59V0+qCrjbHjkwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Udbagh6nfgLATNrOrLViSNgBBqmlbIigWTtnuyBjc6N7jDcsa6RoqwnrdRlQioPk7
	 eHFy05PvSZC3oa0UF87inIAIPa0bMzgnOOiMVcKUTWe6T2LLkD95+hxB6EzBbnyJne
	 otRHlBlpBBSCJpb1XCFcaY3J1ayQ8JYXTM79JvoJCbGKAInd2Vm+0DhMST7S3c5UR8
	 niUGUh/z6A4qXZoDRu41m7hWQM2ajs/riPNjryDASnOV2bUXyDMEtZnkS7mGwFD4W6
	 EW31O0001KX9fJsggvkTvpNfPY71p02QJ6P+4u7kHJKR3Qw/y+YB59LauIvD9q+SkA
	 d2lH6TIjGh8/A==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9FE30F40069;
	Fri, 22 May 2026 12:22:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 22 May 2026 12:22:53 -0400
X-ME-Sender: <xms:3YIQardEGQLOXFYBnvSEETcGGZVXgEZW45Y5IxLqjXXPmZ3VT7eEDg>
    <xme:3YIQajhQLEBqcpNcIWu3gmlGGEH2Q-ylCLZfDODkoEB4gyCiypDHv5JoHR0-69TbK
    qOqMGoZfCcl1LxCmjBpJMtdn6zcbODvBPvuhb7u6Fo30xOp7Ertcv0>
X-ME-Received: <xmr:3YIQajPVY8PZPAj7DCZIF5qneg40bxfQPZGwqZ_MstdGaLOvGh5PVGXa67nS_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfedtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghvvgdrhhgrnhhsvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepthhglh
    igsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhh
    grnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtth
    hopehrihgtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtphhtthho
    pehsrghthhihrghnrghrrgihrghnrghnrdhkuhhpphhushifrghmhieslhhinhhugidrih
    hnthgvlhdrtghomh
X-ME-Proxy: <xmx:3YIQap6uPiHgStdN6slLX3-6-wsZcJ-ZlBtbsEa5JMihJGDPMr0osA>
    <xmx:3YIQalVqyxMmX-hg356lqe_kxv-FN5yQC_0lqRuy_kXk-0d-G38EVA>
    <xmx:3YIQajFUUBtqxeNhQl_IWtAGMvThboSss_-8rn1l9s2iHjCsu7mDXg>
    <xmx:3YIQatf0ePI3bhJ-yeUkFvxe2eX-lLA7HR6vw692U5etBhhmTqQVcA>
    <xmx:3YIQallRHrCZuIyJDyJEBn-s6N882ow7iGqKd8wAmEHNL1CbJYwXwz_r>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 12:22:52 -0400 (EDT)
Date: Fri, 22 May 2026 17:22:51 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Message-ID: <ahCCYYA-pfJC-QUu@thinkstation>
References: <20260428125632.129770-1-kas@kernel.org>
 <20260428125632.129770-3-kas@kernel.org>
 <bf92ebbf-8d70-406a-aea1-c11ca576de90@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf92ebbf-8d70-406a-aea1-c11ca576de90@intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253816-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 03FFF5B7884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 06:14:13PM -0700, Dave Hansen wrote:
> On 4/28/26 05:56, Kiryl Shutsemau (Meta) wrote:
> > +	if (size == 4)
> > +		regs->ax = 0;
> > +	else
> > +		regs->ax &= ~mask;
> 
> I haven't thought about this _that_ much, but this feels wrong. Why is
> is 4 so special cased?
> 
> Also, what _are_ the limits on the registers that 'in' can be used on?
> 
> RAX - n/a, no 64-bit I/O
> EAX - size=4
> AX  - size=2
> AH  - n/a no encoding for inb
> AL  - size=1
> 
> I'd find this much easier to grasp if there was a nice table of what the
> registers, sizes, and masks ended up being usable. As usual, x86 is
> "fun" here.

How about this for the comment:

        /*
         * IN writes the result into a sub-register of RAX. Only the
         * 32-bit form zero-extends; the smaller forms leave the upper
         * bits untouched:
         *
         *   insn  dest  size  bits written     bits preserved
         *   inb   AL    1     RAX[ 7: 0]       RAX[63: 8]
         *   inw   AX    2     RAX[15: 0]       RAX[63:16]
         *   inl   EAX   4     RAX[63: 0]       (none, zero-extended)
         *
         * 'mask' only covers the low 'size' bytes, which is exactly
         * the range affected for size 1 and 2. For size 4 the write
         * also clears RAX[63:32], so widen the clear-mask.
         */

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

