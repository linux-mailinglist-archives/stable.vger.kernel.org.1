Return-Path: <stable+bounces-139402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE42AA648C
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 22:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24491BA3C21
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3B3246777;
	Thu,  1 May 2025 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="tKXENaT4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="poc9MR9N"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B9F22FAC3
	for <stable@vger.kernel.org>; Thu,  1 May 2025 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129807; cv=none; b=umGdwieyp/D57WSv2iRlwVQtX7Ix3pOrbrDDIor2GjOW0Y+8Nojhhom24pyrd9VaJX1yVMj+4YdChkR4FElL58S7QmOk2LonPhxJuJBW2ldSTVcpjFHFbnf1/d2G9VllIV5M2m8Pj+lBEtC/WcWFQalYdzEQiW64uhxcAWpWsLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129807; c=relaxed/simple;
	bh=a4fF2rnq9c73XIGU80bI/SGsIe2nZ6yVNaTWRL7DRIw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ph1yUrTDUinDR0+72Yk9JYxVgIiXlQFBlKaIPiaKYtUUl9h5DQQptCbSjWXr24t7WTJyQusTNJSy4JMHKYy5fQoUj6qy+NbY4UZ+Oasa6slYFf+EskaxVlNUd0F+WsY5plYc1OyypoP23YIFJRLxy6vlHfDmVGUenp2mtdlmnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=tKXENaT4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=poc9MR9N; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 236EB254015C;
	Thu,  1 May 2025 16:03:24 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Thu, 01 May 2025 16:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746129803;
	 x=1746216203; bh=PJvrlBuargBsoDMpUJKUg9batdHN+WAF+1+xtO2/hU0=; b=
	tKXENaT401VHxdYYQOqF0t22cKLRfoDiNQfYL5GakB7mBlLvI40SBunwikm0qNoQ
	QKjKejNDKNyG7QVEY7o9yFzZ1KCjinnWjc3whNDoK+ZMSS+b5DSsLCSEEDLcHj8r
	ehWCPoeeFvTFGlyOXk5xY/CmcBqET4R3eMNrxfTjOOQifci1OC/kR+VJwPwf+TSf
	cfoTES4vmAEiVxaAkJb8LH0JhJqE+f9ZHCR5wrbjHxD/cNqOgQnGFYN/9q87gMkr
	neWnDwo77lhLTwCCZPbh0L+ZuhriPzUMaKIfcPgGMKl3TZCGtMylsYZjPg3PPEZE
	iTFzBYk+N3K5aLUsc1QY5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746129803; x=
	1746216203; bh=PJvrlBuargBsoDMpUJKUg9batdHN+WAF+1+xtO2/hU0=; b=p
	oc9MR9N0iYtULCwKHkBot6DmaVOFsjSazI8u3ObOwLaYp15kNXU5ZzQj1RMsrrcd
	yBKx+AaamNszAiidTDlHH64/FlrRlSOD6ndATmMaZr/zduGaJpv5Zv8KiBKXD7es
	p0L5GDSnWf6hX9gpMs57TilyOsxY4sWdm+eCwH8ME0vjYJRgoh2nHVXpvlvGWU1h
	+Z45TIBhF587j8nf3Pr9v8mk/oniq2u0ogq+OaRpZUk3pqcMkLofxDY8EjgOFURB
	5UjdQWIElwJhF+dhgg+9Zm9x4lNLohPLAunOIExTJHos0nzfhIizv4pGl+iTraav
	8n0VGN823KiufWQtyfOFg==
X-ME-Sender: <xms:itMTaIZrt-cWGtjcmamuNZDZyC8JnKP69J_Br_B4PWfqtXBvpsmz1g>
    <xme:itMTaDZIMQ-Io00uFYWR5eZdUE-s4Tb5T5WzjFSeokBvTfMSmqqgEBDq-RhT6ZR-l
    2wp7dNN1XQdICLfCuU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepkeelvedvkeegkedutdelueeileettdetledu
    ffdvgeekveeljeeiuefffeejfeelnecuffhomhgrihhnpeguvggsihgrnhdrnhgvthenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepshhuiihukhhirdhpohhulhhoshgvsegrrhhmrdgtohhmpdhrtghpthht
    ohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepvhgrnhhnrghpuh
    hrvhgvsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghnrdhjrdifihhllhhirghm
    shesihhnthgvlhdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrvhgv
    vghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:itMTaC-bBBwoWx1WA9dHoX5W9Ei_6SpXs5vcfK0GDe9iBa_3vD_-Fw>
    <xmx:itMTaCq5mSdQUKDWYf3WOaUU2XJxD7Mkbk2DJBjYo7VxWueHDwccow>
    <xmx:itMTaDpXy1OyQEjM0J7n_261gd-zei52C-Gh7XgBidJXldRpL9BmTA>
    <xmx:itMTaATcUJTTocZVZmRf7opTcs_qOLdVdUXjiorMKOTvrtt25Yv4Yg>
    <xmx:i9MTaFt1D0zcnMSghoeW5unIp2JEbra_KQudHMVPZcG3WOBv4Ac0khyg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 54B7E2220073; Thu,  1 May 2025 16:03:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3ad4a30312e33025
Date: Thu, 01 May 2025 22:01:02 +0200
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
Message-Id: <5f80ae16-8d41-4a68-b978-c1bb60fce3f1@app.fastmail.com>
In-Reply-To: <b48aac71-5148-4be2-b95f-ec60e4f490bd@app.fastmail.com>
References: <20250430024622.1134277-1-dan.j.williams@intel.com>
 <20250430024622.1134277-3-dan.j.williams@intel.com>
 <0bdb1876-0cb3-4632-910b-2dc191902e3e@app.fastmail.com>
 <6812c6cda0575_1d6a294d7@dwillia2-xfh.jf.intel.com.notmuch>
 <b48aac71-5148-4be2-b95f-ec60e4f490bd@app.fastmail.com>
Subject: Re: [PATCH v5] x86/devmem: Drop /dev/mem access for confidential guests
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 1, 2025, at 10:12, Arnd Bergmann wrote:
> On Thu, May 1, 2025, at 02:56, Dan Williams wrote:
>> Arnd Bergmann wrote:
>>> On Wed, Apr 30, 2025, at 04:46, Dan Williams wrote:
>
> The other bit of the puzzle is that memremap() on x86 silently
> falls back to ioremap() for non-RAM pages. This was originally
> added in 2008 commit e045fb2a988a ("x86: PAT avoid aliasing in
> /dev/mem read/write"). I'm not sure what happened exactly, but
> I suspect that the low 1MB was already mapped at the time
> through a cached mapping, while the PCI MMIO hole was perhaps
> not mapped. On x86-32, the 32-bit PCI BAR area should not
> be included here (since it's above high_memory), but the 16MB
> hold may be.

Following up myself after thinking about it some more:
if we remove both the <1MB special case and the memremap()
hack on x86-64 but leave both for x86-32, that would
also avoid the cases that break CC guests, right and
make x86-64 behave exactly like the other architectures,
right?

If there is software that still relies on those hacks, it's
probably very old, and more likely to be on 32-bit systems.
There are many references to /dev/mem in Debian codesearch [1],
but it's usually related to pre-PCIe graphics (svgalib, XFree86,
uvesafb/v86), or it's memory-only accesses that rely on
!CONFIG_STRICT_DEVMEM to read kernel structures.

     Arnd

[1] https://codesearch.debian.net/search?q=%2Fdev%2Fmem&literal=1&perpkg=1

