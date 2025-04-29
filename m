Return-Path: <stable+bounces-136993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6351DAA0211
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 07:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0034659F5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 05:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0345224AF9;
	Tue, 29 Apr 2025 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qHiFNFsV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5143E1922F4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745905924; cv=none; b=E2ZF8f5AgpfZQo2UgkhsdF59vMAD7oP7FJNM2x+wCL1N6QiFZ0RiXFowZNCmL1XRR0Uma6BpCx0tdhBqapU9IJNGtAovX8IQ6DpkJ+6Lfs+1lmZ3WCe7A9A7Y0rBJcDE6HQ97mWwyDeGoAUEeejMb82jgIqLTJE5VlwvS2Op1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745905924; c=relaxed/simple;
	bh=5kSG+DUvUKzdgFcPfKbPHJWBlxEldT6xQxSL9yrE1Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcTMUXxneOa6JJJMzSjLnjFlvSyywA7kE9R8LUztibmmo/d3prrxrwyY1r8UfJsP1+C9QVrPOGjSe6sEnJX+qC0d9q4hojMX45NohCz0R5rvlbIjBrwiyZRixLsnPE07uYW8hb+euVnCtNKkzBBFq/9++/KYapxe1PufKdoUzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qHiFNFsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19808C4CEE3;
	Tue, 29 Apr 2025 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745905923;
	bh=5kSG+DUvUKzdgFcPfKbPHJWBlxEldT6xQxSL9yrE1Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHiFNFsVlZaYMR2pNz0YvUAqQBYPtrZC18T9rYYQ5oqp03nSc7F+yeBAoH6infaqH
	 oi2w+VesXJHcd9FnGt7HEbyBVavgKOBcd2VE77v4utOkmmg8sgWmqHgaK5WBQ7ntVD
	 LhvdOkaXJmo6ZCE1EHxsSe8xjO2xDeONJsvP03HE=
Date: Tue, 29 Apr 2025 07:52:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Build failure due to backport of "bpf: Add namespace to BPF
 internal symbols"
Message-ID: <2025042944-impound-junkman-ef2c@gregkh>
References: <d5qsidvulna547jx6tyrjnocvqlddfpsmy6nqlbjss6dt3xbg5@zeqfjvfng25a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5qsidvulna547jx6tyrjnocvqlddfpsmy6nqlbjss6dt3xbg5@zeqfjvfng25a>

On Tue, Apr 29, 2025 at 10:52:28AM +0800, Shung-Hsi Yu wrote:
> Hi Sasha,
> 
> bpf-add-namespace-to-bpf-internal-symbols.patch is stable-queue.git
> seems like the culprit responsible for build failure in stable 6.12 and
> earlier (log below). The reason is likely due to the lack of commit
> cdd30ebb1b9f ("module: Convert symbol namespace to string literal")
> before v6.13. Getting rid of the quotes s/"BPF_INTERNAL"/BPF_INTERNAL/
> probably would be enough to fix it.
> 
>   In file included from .vmlinux.export.c:1:
>   .vmlinux.export.c:1697:33: error: expected ‘)’ before ‘BPF_INTERNAL’
>    1697 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
>         |                                 ^~~~~~~~~~~~
>   ./include/linux/export-internal.h:45:28: note: in definition of macro ‘__KSYMTAB’
>      45 |             "   .asciz \"" ns "\""                                      "\n"    \
>         |                            ^~
>   .vmlinux.export.c:1697:1: note: in expansion of macro ‘KSYMTAB_FUNC’
>    1697 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
>         | ^~~~~~~~~~~~
>   ./include/linux/export-internal.h:41:12: note: to match this ‘(’
>      41 |         asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
>         |            ^
>   ./include/linux/export-internal.h:62:41: note: in expansion of macro ‘__KSYMTAB’
>      62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name, KSYM_FUNC(name), sec, ns)
>         |                                         ^~~~~~~~~
>   .vmlinux.export.c:1697:1: note: in expansion of macro ‘KSYMTAB_FUNC’
>    1697 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
>         | ^~~~~~~~~~~~
>   .vmlinux.export.c:1706:42: error: expected ‘)’ before ‘BPF_INTERNAL’
>    1706 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
>         |                                          ^~~~~~~~~~~~
>   ./include/linux/export-internal.h:45:28: note: in definition of macro ‘__KSYMTAB’
>      45 |             "   .asciz \"" ns "\""                                      "\n"    \
>         |                            ^~
>   .vmlinux.export.c:1706:1: note: in expansion of macro ‘KSYMTAB_FUNC’
>    1706 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
>         | ^~~~~~~~~~~~
>   ./include/linux/export-internal.h:41:12: note: to match this ‘(’
>      41 |         asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
>         |            ^
>   ./include/linux/export-internal.h:62:41: note: in expansion of macro ‘__KSYMTAB’
>      62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name, KSYM_FUNC(name), sec, ns)
>         |                                         ^~~~~~~~~
>   .vmlinux.export.c:1706:1: note: in expansion of macro ‘KSYMTAB_FUNC’
>    1706 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
>         | ^~~~~~~~~~~~
>   .vmlinux.export.c:1708:34: error: expected ‘)’ before ‘BPF_INTERNAL’
>    1708 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
>         |                                  ^~~~~~~~~~~~
>   ./include/linux/export-internal.h:45:28: note: in definition of macro ‘__KSYMTAB’
>      45 |             "   .asciz \"" ns "\""                                      "\n"    \
>         |                            ^~
>   .vmlinux.export.c:1708:1: note: in expansion of macro ‘KSYMTAB_FUNC’
>    1708 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
>         | ^~~~~~~~~~~~
>   ./include/linux/export-internal.h:41:12: note: to match this ‘(’
>      41 |         asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
>         |            ^
>   ./include/linux/export-internal.h:62:41: note: in expansion of macro ‘__KSYMTAB’
>      62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name, KSYM_FUNC(name), sec, ns)
>         |                                         ^~~~~~~~~
>   .vmlinux.export.c:1708:1: note: in expansion of macro ‘KSYMTAB_FUNC’
>    1708 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
>         | ^~~~~~~~~~~~
>   make[2]: *** [scripts/Makefile.vmlinux:18: .vmlinux.export.o] Error 1
>   make[1]: *** [/home/runner/work/libbpf/libbpf/.kernel/Makefile:1184: vmlinux] Error 2
>   make: *** [Makefile:224: __sub-make] Error 2

Good catch, let me go fix this up...

thanks,

greg k-h

