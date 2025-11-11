Return-Path: <stable+bounces-194538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BA4C4FD24
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 22:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D5154EA591
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D2326929;
	Tue, 11 Nov 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3fh+gYs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B918A6B0;
	Tue, 11 Nov 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895654; cv=none; b=d/mHSBFoI5LE0p4LESZs48PMIwvXslsNVZLvmpxSMTo7iDaSXsXcBQlYnjaucfbfvwEum9AkVr6hiJZTAlpQGrJ3c4ttAR5iIud71dOLVrI4RMj6kzdfaXJjJOeey1rsY30bNZpnSM4hAFp6wop7LR9CPU8D+mBOqyezfNsfWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895654; c=relaxed/simple;
	bh=fqT2OYcgB8LhPe88EW+aSGHD9PETQ4o5wspTZSm3Xzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9iNHpnuo0NHBOg+SWTr11iOfY+DDRUEYZ8lhiP3gwq/SIf7+WXU9N8pmgF+8x1Joun8PxUGOjShqYTRo+SoAuT1NoofOftiajzyO71M7MnH4QF7ryUSMkQ9PyaDsr4xth6sD0+TAWsqLPceoWjZk7eOypCdThPSYs+ZF+eQED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3fh+gYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC29C4CEFB;
	Tue, 11 Nov 2025 21:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762895654;
	bh=fqT2OYcgB8LhPe88EW+aSGHD9PETQ4o5wspTZSm3Xzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3fh+gYs+pHLAln+6/KfsOIb2v+3Zy5vfwUqAoZ8wu+yKEelZqHVqYi9cQL0KJp69
	 7qcR7iqizuJVmylz0xsWAaPBXV3PFWchxazcZka9EMFkq0i5t8IvNoIf8uSEjMwU/f
	 pMFKaKSqmObDsvDKy3bg0VHiNu9IABL87h1n79gc6LTrXDA76f0aWvGGFTSZnRu5RO
	 zCzHyJcJjJXn8mrTrjZX25N/FLEaV4zLUuu3R3aCrMKmM3XuJFBaQza71bIaJBguwd
	 aKJIIf0p75vfCeu9jtWSw1g2GK4Dq40d+IdVxmh+YHVXWymkYhN2pYeDDEalG0l48A
	 KkFv5MriwKBIg==
From: Miguel Ojeda <ojeda@kernel.org>
To: zhengyejian@huaweicloud.com
Cc: ardb@kernel.org,
	arnd@arndb.de,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	jannh@google.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	masahiroy@kernel.org,
	mcgrof@kernel.org,
	ndesaulniers@google.com,
	song@kernel.org,
	wedsonaf@google.com,
	willy@infradead.org,
	yeweihua4@huawei.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] kallsyms: Fix wrong "big" kernel symbol type read from procfs
Date: Tue, 11 Nov 2025 22:13:56 +0100
Message-ID: <20251111211356.18882-1-ojeda@kernel.org>
In-Reply-To: <20241011143853.3022643-1-zhengyejian@huaweicloud.com>
References: <20241011143853.3022643-1-zhengyejian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Oct 2024 22:38:53 +0800 Zheng Yejian <zhengyejian@huaweicloud.com> wrote:
>
> Currently when the length of a symbol is longer than 0x7f characters,
> its type shown in /proc/kallsyms can be incorrect.
>
> I found this issue when reading the code, but it can be reproduced by
> following steps:
>
> 1. Define a function which symbol length is 130 characters:
>
> #define X13(x) x##x##x##x##x##x##x##x##x##x##x##x##x
> static noinline void X13(x123456789)(void)
> {
> printk("hello world\n");
> }
>
> 2. The type in vmlinux is 't':
>
> $ nm vmlinux | grep x123456
> ffffffff816290f0 t x123456789x123456789x123456789x12[...]
>
> 3. Then boot the kernel, the type shown in /proc/kallsyms becomes 'g'
> instead of the expected 't':
>
> # cat /proc/kallsyms | grep x123456
> ffffffff816290f0 g x123456789x123456789x123456789x12[...]
>
> The root cause is that, after commit 73bbb94466fd ("kallsyms: support
> "big" kernel symbols"), ULEB128 was used to encode symbol name length.
> That is, for "big" kernel symbols of which name length is longer than
> 0x7f characters, the length info is encoded into 2 bytes.
>
> kallsyms_get_symbol_type() expects to read the first char of the
> symbol name which indicates the symbol type. However, due to the
> "big" symbol case not being handled, the symbol type read from
> /proc/kallsyms may be wrong, so handle it properly.
>
> Cc: stable@vger.kernel.org
> Fixes: 73bbb94466fd ("kallsyms: support "big" kernel symbols")
> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>

Gary made me aware of this thread (thanks!) -- we are coming from:

    https://lore.kernel.org/all/aQjua6zkEHYNVN3X@x1/

For which I sent this patch without knowing about this one:

    https://lore.kernel.org/rust-for-linux/20251107050414.511648-1-ojeda@kernel.org/

This has been seen now by Arnaldo (Cc'ing) in a real system, so I think
we should take this one since it was first, with:

Cc: stable@vger.kernel.org

Thanks!

Cheers,
Miguel

