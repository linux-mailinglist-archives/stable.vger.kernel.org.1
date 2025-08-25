Return-Path: <stable+bounces-172816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62852B33D2A
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 12:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D763E3A39E8
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE05028C035;
	Mon, 25 Aug 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3xX7Spl"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818D2D73AA;
	Mon, 25 Aug 2025 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118991; cv=none; b=BrYyJPwHmH3vLqxKV5D5MA4/fIR8ahm7XmOmrK025sKoHzCaEryIiJLQ+gkpUtH5yAGrmOOsmYegXD/5SpfkEtyCHSBB+JE2H3pxm7VtXDx3jFkn+dVWbGgorNa9vzHujDiVAfwpPik6OKvNWnJd7BlhvQigZuo3HFYuqchKnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118991; c=relaxed/simple;
	bh=A5e0g3A5w23DzIM9o26RbMYH8roh80cNhkZmB5++jQ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EdmFnXup/4SnevySFqwJfcbiPoKoi/XTi9sPAYNzpyKFsPyjQmvW3TjAS7UlRIuNAmXEHTENAflb+8uLlgFg43qRxwFOTBQghiYB6Q9dr179va8x8qrK/7J/UBv5xZty2sTld5O1yjuEDVz9yZK4zPz5a4BVmnx/A17Q4y/u7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3xX7Spl; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2136F7A00B5;
	Mon, 25 Aug 2025 06:49:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 25 Aug 2025 06:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756118987; x=1756205387; bh=10eh3N4jyDTXYO/BHE5C2RtFW5688leWuGj
	xIzsegzs=; b=k3xX7SplGmP8SSjuwtxnU+ZAhbUb3o3mZNvPMAZgpqkhHwWyd7q
	z9OzNupyrVXXTvBNvdiJThDWrf7wEr9njNAl1G4x8jV5Ze2TM3W3WyBKuq1+Ax6S
	PwZMaPEXvKw0kwyqYW8XBVPb3EEQG5Fh0hZkNThTqb/fTAj6XX2bj4DN9NH95zFJ
	mlEbrYJpb4mOx6zhzAJ8ZsoPcRUmRh3o/69WoLPFfQS0hRg71hR9LXTEabGneLBV
	H0XSPk/wsHZU4aJeTCB9lP3w3jNzm37BdCQRLSse9YTETyzsicwJOWMMDmiqzA8D
	XUJAO4quV979lIG4TiUdLfJc2cTGMVhUjnQ==
X-ME-Sender: <xms:yj-saFbeGFsZBoYb7E_JIts9CVvFXt9msvSnS5QT7PbxZi6mHQGR3g>
    <xme:yj-saLkJa3xlhedfamF1g8lOHfQkR89ihgSFdStgMjymAfcq3_Yi0-gFEnZvrVngp
    QCsHMZK1a4AeyWAgJ4>
X-ME-Received: <xmr:yj-saKrEDEaaJl1vOcIwwSoCXcfB0D_KHWIdoIWhDroPMN39zDyQGcaeb66y1wWVeQaI1cx5jZ2b8FYOOOtDHnMUZCbI2My-N9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeuheeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnhgtvgdrhigrnhhgsehlihhnuhigrd
    guvghvpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohgrkheshh
    gvlhhsihhnkhhinhgvthdrfhhipdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggv
    rggurdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yj-saNCxKc2O3YWu30nvgu472OnYnqOMCyNFDkFqAUYpHXBkDr0blg>
    <xmx:yj-saNHS705Fyzu_Vq6MoYEBPPQr1bKPkfwXlSReP8YKVmtXiE0p9g>
    <xmx:yj-saH0fu_C5itZIZ9xugF600fHPZiLmo9y-84tPu04M6IEfit0Xyg>
    <xmx:yj-saOOHMTbr5Lj-uOR-7jSqrAuKbdJtU4mdKnvkaYluZKHIT61Hkw>
    <xmx:yz-saAmMSdqEDrRBRD3yWUDoQxZC_q6RocuMBVzkzBly6rqS1CVTlt-Z>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 06:49:43 -0400 (EDT)
Date: Mon, 25 Aug 2025 20:49:38 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Lance Yang <lance.yang@linux.dev>
cc: akpm@linux-foundation.org, geert@linux-m68k.org, 
    linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi, 
    peterz@infradead.org, stable@vger.kernel.org, will@kernel.org, 
    Lance Yang <ioworker0@gmail.com>, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
In-Reply-To: <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev>
Message-ID: <d07778f8-8990-226b-5171-4a36e6e18f32@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org> <20250825032743.80641-1-ioworker0@gmail.com> <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org> <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
 <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org> <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


[Belated Cc linux-m68k...]

On Mon, 25 Aug 2025, Lance Yang wrote:

> 
> On 2025/8/25 14:17, Finn Thain wrote:
> > 
> > On Mon, 25 Aug 2025, Lance Yang wrote:
> > 
> >>
> >> What if we squash the runtime check fix into your patch?
> > 
> > Did my patch not solve the problem?
> 
> Hmm... it should solve the problem for natural alignment, which is a 
> critical fix.
> 
> But it cannot solve the problem of forced misalignment from drivers 
> using #pragma pack(1). The runtime warning will still trigger in those 
> cases.
> 
> I built a simple test module on a kernel with your patch applied:
> 
> ```
> #include <linux/module.h>
> #include <linux/init.h>
> 
> struct __attribute__((packed)) test_container {
>     char padding[49];
>     struct mutex io_lock;
> };
> 
> static int __init alignment_init(void)
> {
>     struct test_container cont;
>     pr_info("io_lock address offset mod 4: %lu\n", (unsigned long)&cont.io_lock % 4);
>     return 0;
> }
> 
> static void __exit alignment_exit(void)
> {
>     pr_info("Module unloaded\n");
> }
> 
> module_init(alignment_init);
> module_exit(alignment_exit);
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("x");
> MODULE_DESCRIPTION("x");
> ```
> 
> Result from dmesg:
> [Mon Aug 25 15:44:50 2025] io_lock address offset mod 4: 1
> 

Thanks for sending code to illustrate your point. Unfortunately, I was not 
able to reproduce your results. Tested on x86, your test module shows no 
misalignment:

[131840.349042] io_lock address offset mod 4: 0

Tested on m68k I also get 0, given the patch at the top of this thread:

[    0.400000] io_lock address offset mod 4: 0

> 
> As we can see, a packed struct can still force the entire mutex object 
> to an unaligned address. With an address like this, the WARN_ON_ONCE can 
> still be triggered.

I don't think so. But there is something unexpected going on here -- the 
output from pahole appears to say io_lock is at offset 49, which seems to 
contradict the printk() output above.

struct test_container {
        char                       padding[49];          /*     0    49 */
        struct mutex               io_lock __attribute__((__aligned__(1))); /*    49    12 */

        /* size: 61, cachelines: 1, members: 2 */
        /* forced alignments: 1 */
        /* last cacheline: 61 bytes */
} __attribute__((__packed__));

