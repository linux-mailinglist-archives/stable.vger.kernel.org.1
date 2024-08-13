Return-Path: <stable+bounces-67456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD5995028B
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947A01F21995
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDAC195F3A;
	Tue, 13 Aug 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IsgCwgZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F8208AD
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545327; cv=none; b=bQK3jfKU4nCNoA+lFW91zDqb8pkxcTt2Y0DYrts8UyantA1sAm9hJ7v8c9gDRzdzldh2GfRxgBRSRdqZzZFPXxjTAl/DE8ThgbXXy/NKaEB0lQUMtJtZFc22zXoPCYI2htILO5CYcXmZjRhLt1KUQkYx88kIxql0l81jtcthqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545327; c=relaxed/simple;
	bh=mz1EtdOPRaW5R7i3hUrOPfWXYBTXgETDQXkybllBn54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFJAn2DogunycXn9N65BSHZF4KD1ONVpYiJqYU7IZ+sRrZFE90sY/3XcHCI5Kwv9FqdEgoRbtwbxdO5+BnUxtVpZkcOaqt2QStaLHhCNMDzNwqm5qsy4Od96K2IOygGGkWrHqy5GTfHZlnxB+p/fI9ECA1jGxV0IiWqFWxtG7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IsgCwgZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C689C4AF09;
	Tue, 13 Aug 2024 10:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723545327;
	bh=mz1EtdOPRaW5R7i3hUrOPfWXYBTXgETDQXkybllBn54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsgCwgZomdvb7UQah9L8KR54uzbT3N8XBE9TRl2VU7yNBm2wXqeq6xWb/BJHnUaHe
	 Vdu0uMMr/e3M2LTuYeUosa9y7MsfTSHbSdsKUIUmnJMTJajJaYvqkyRq+M3oTjQlWE
	 T7abDcVXJiMvDJm3/2PkEdE2yYMDoZe7Tb4ZORs4=
Date: Tue, 13 Aug 2024 12:35:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.4 and 4.19] kbuild: Fix '-S -c' in x86 stack protector
 scripts
Message-ID: <2024081314-eclipse-earmuff-45b8@gregkh>
References: <2024073000-polish-wish-b988@gregkh>
 <20240730184054.254156-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730184054.254156-1-nathan@kernel.org>

On Tue, Jul 30, 2024 at 11:40:54AM -0700, Nathan Chancellor wrote:
> commit 3415b10a03945b0da4a635e146750dfe5ce0f448 upstream.
> 
> After a recent change in clang to stop consuming all instances of '-S'
> and '-c' [1], the stack protector scripts break due to the kernel's use
> of -Werror=unused-command-line-argument to catch cases where flags are
> not being properly consumed by the compiler driver:
> 
>   $ echo | clang -o - -x c - -S -c -Werror=unused-command-line-argument
>   clang: error: argument unused during compilation: '-c' [-Werror,-Wunused-command-line-argument]
> 
> This results in CONFIG_STACKPROTECTOR getting disabled because
> CONFIG_CC_HAS_SANE_STACKPROTECTOR is no longer set.
> 
> '-c' and '-S' both instruct the compiler to stop at different stages of
> the pipeline ('-S' after compiling, '-c' after assembling), so having
> them present together in the same command makes little sense. In this
> case, the test wants to stop before assembling because it is looking at
> the textual assembly output of the compiler for either '%fs' or '%gs',
> so remove '-c' from the list of arguments to resolve the error.
> 
> All versions of GCC continue to work after this change, along with
> versions of clang that do or do not contain the change mentioned above.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4f7fd4d7a791 ("[PATCH] Add the -fstack-protector option to the CFLAGS")
> Fixes: 60a5317ff0f4 ("x86: implement x86_32 stack protector")
> Link: https://github.com/llvm/llvm-project/commit/6461e537815f7fa68cef06842505353cf5600e9c [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> [nathan: Fixed conflict in 32-bit version due to lack of 3fb0fdb3bbe7]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> This change applies cleanly with 'patch -p1' on both 5.4 and 4.19.
> ---
>  scripts/gcc-x86_32-has-stack-protector.sh | 2 +-
>  scripts/gcc-x86_64-has-stack-protector.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Now queued up, thanks.

greg k-h

