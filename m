Return-Path: <stable+bounces-10392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBD1828900
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 16:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2C31F21BD5
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965E739FDB;
	Tue,  9 Jan 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfwH8xmT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC173A1A0;
	Tue,  9 Jan 2024 15:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FCCC433F1;
	Tue,  9 Jan 2024 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704813996;
	bh=+lV/DrwzrTu5CK485TUWaE1tfOdwjxBJErdXczf0neQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfwH8xmTVnrqoKhO8DjPGGYDey+YpqKsQ2VQu5WlWEwAk3xuuYU4ed9ci7hf1Z5dN
	 xv8v/kckLQXJLtarReV96ZqcLB5lrP5r+mOqpHnpn6n4IOSH4jRz7PFX7Wnrd+zKRa
	 sj0sasMxp3dX37NNIgYm7gm0UW/bvc/asKQHbPZQVX1TfbBFUuT3iMNMCSmyO/yEou
	 5bGG1X5TKCnjvtwMlgTkMCyqkkxB3mZ9VwBJ3l8ou+Kj3wWO2c4L10hc31L+MOBe4G
	 Kp1awsUdphcKkgt0UjyLLKNL38yupEwNkB/IuV++5cDJqEPMZcthGDNi2GGhwTSkIa
	 2E/pBOrLdhv2A==
Date: Tue, 9 Jan 2024 08:26:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-stable <stable@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	lkft-triage@lists.linaro.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: riscv: clang-nightly-allmodconfig: failed on stable-rc 6.6 and
 6.1
Message-ID: <20240109152634.GA205272@dev-arch.thelio-3990X>
References: <CA+G9fYtbTSVtYQF4gdKK_SjibEZAV5KXFOtbC0YK9QF9Z8gSRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtbTSVtYQF4gdKK_SjibEZAV5KXFOtbC0YK9QF9Z8gSRw@mail.gmail.com>

Hi Naresh,

On Tue, Jan 09, 2024 at 03:06:04PM +0530, Naresh Kamboju wrote:
> The clang nightly build failures are noticed on stable-rc 6.6 and 6.1 for
> riscv allmodconfig builds.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Logs:
> =====
>  arch/riscv/kernel -I ./arch/riscv/kernel -dwarf-version=4 -mrelocation-model
>   static -target-abi lp64 -mllvm -riscv-add-build-attributes
>    -o arch/riscv/kernel/kexec_relocate.o /tmp/kexec_relocate-28089a.s
> 
>  #0 0x00007f5039e1667a llvm::sys::PrintStackTrace(llvm::raw_ostream&,
> int) (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0xd6d67a)
>  #1 0x00007f5039e146a4 llvm::sys::RunSignalHandlers()
> (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0xd6b6a4)
>  #2 0x00007f5039e16d3b (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0xd6dd3b)
>  #3 0x00007f5038ba8510 (/lib/x86_64-linux-gnu/libc.so.6+0x3c510)
>  #4 0x00007f503c8f50c8 (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x384c0c8)
>  #5 0x00007f503b492cf5 (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x23e9cf5)
>  #6 0x00007f503b492607 (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x23e9607)
>  #7 0x00007f503b492300
> llvm::MCExpr::evaluateAsRelocatableImpl(llvm::MCValue&,
> llvm::MCAssembler const*, llvm::MCAsmLayout const*, llvm::MCFixup
> const*, llvm::DenseMap<llvm::MCSection const*, unsigned long,
> llvm::DenseMapInfo<llvm::MCSection const*, void>,
> llvm::detail::DenseMapPair<llvm::MCSection const*, unsigned long>>
> const*, bool) const (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x23e9300)

Thank you for the report, this is an LLVM regression that I reported a
few days ago and it has now been resolved upstream a few hours ago:

https://github.com/llvm/llvm-project/pull/76552#issuecomment-1878952480
https://github.com/llvm/llvm-project/pull/77236

It may take a few days for it to be fixed on your side between the
apt.llvm.org update cycle and the tuxmake container rebuild cycle.

Cheers,
Nathan

