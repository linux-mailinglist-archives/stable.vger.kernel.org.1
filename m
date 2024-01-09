Return-Path: <stable+bounces-10364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052BF82834F
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 10:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FD91F25E78
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4CE3399D;
	Tue,  9 Jan 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lP4skhCT"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25C3608A
	for <stable@vger.kernel.org>; Tue,  9 Jan 2024 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-466ec3e942bso321848137.1
        for <stable@vger.kernel.org>; Tue, 09 Jan 2024 01:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704792976; x=1705397776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2kvtwERabor0ovhKcasBi1QrG566y9gSjsPmQwcCohY=;
        b=lP4skhCTxfN6u8TQ/LX427eGz7ZKF3l9wxUhA0fsvmv4Tv7P+wsqXALyu1eJ5vl422
         z0uJ2HOm5bJnV+0hBkyAxuWIc0dcWmYSWcXeE+QoKGwCf3zjI6bFbWZc4d8RE0jNdzHC
         sVn8SdUi5BlCaxkQu9XIjhtN+ipqtcnjPMDoFT/KMNdwmnzaFSOdnk+Gg51jtE5gyy6L
         ntdjVGUIH9hKlK904rpmLy+UTNoCDRcKs6il/+c/8yVEOom7x1Q3ALn2yrnYUtOUXjMu
         oAuUY4NDfEofcWlhcbPYiDFxnOFtRbKySo6YuNosye1yN/cSP3e8i/OaS0r1/xTMjmtC
         k0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792976; x=1705397776;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kvtwERabor0ovhKcasBi1QrG566y9gSjsPmQwcCohY=;
        b=aovhRDoqU1fNcP70YcMIQLgbFuhKSiQ6ecl8s96W8+CbkBVbHmV5+EezReTRX/RbEd
         qyj/V9J+R77H6Ok5TwZEnGczS8QNA3v0WPbxnOulvd5CurqrT2xo6CukViIeFUoHOwrm
         22kYT1YWRv1xtQQGlY7BqVGIKE5NmDubLhruClL8jCfcJJJwzqkvYC8An16pFXKZpWLm
         7bxdnTowGBg8CqJJgehnvUde9E7LWmsZhUaPL7AAgAVbZxM8KxmTp27qQLBhd8Y/lPww
         NsdLbwJUSA9RG+mgMSqkzNWCceAIS7UjmBJOBhwqLpM9NG325rcEk3fsBPcsJXaIqi+g
         0xnQ==
X-Gm-Message-State: AOJu0Yy2p0oUBsa9KMlixqbgzhOphRhKw/+sHd9K6Hy9PDA09tpIH3Mp
	TGmnzl6JdfaXQ3+oisQPksgyJOAp5ekYCSAgdqNNV4ktHu2c2kxrKsKx//jaD3g=
X-Google-Smtp-Source: AGHT+IHarpJCgQaUpefGQAx4VwLOqfsSHwF2QlLzvgIw/HF2yUfCVvYOt4SIRnJcsxEI4QHmR+B6B7wxmNlm1J9w9Oo=
X-Received: by 2002:a05:6102:3f09:b0:467:bf0a:a0b2 with SMTP id
 k9-20020a0561023f0900b00467bf0aa0b2mr1690491vsv.21.1704792975829; Tue, 09 Jan
 2024 01:36:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 9 Jan 2024 15:06:04 +0530
Message-ID: <CA+G9fYtbTSVtYQF4gdKK_SjibEZAV5KXFOtbC0YK9QF9Z8gSRw@mail.gmail.com>
Subject: riscv: clang-nightly-allmodconfig: failed on stable-rc 6.6 and 6.1
To: linux-stable <stable@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	lkft-triage@lists.linaro.org
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The clang nightly build failures are noticed on stable-rc 6.6 and 6.1 for
riscv allmodconfig builds.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Logs:
=====
 arch/riscv/kernel -I ./arch/riscv/kernel -dwarf-version=4 -mrelocation-model
  static -target-abi lp64 -mllvm -riscv-add-build-attributes
   -o arch/riscv/kernel/kexec_relocate.o /tmp/kexec_relocate-28089a.s

 #0 0x00007f5039e1667a llvm::sys::PrintStackTrace(llvm::raw_ostream&,
int) (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0xd6d67a)
 #1 0x00007f5039e146a4 llvm::sys::RunSignalHandlers()
(/lib/x86_64-linux-gnu/libLLVM-18.so.1+0xd6b6a4)
 #2 0x00007f5039e16d3b (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0xd6dd3b)
 #3 0x00007f5038ba8510 (/lib/x86_64-linux-gnu/libc.so.6+0x3c510)
 #4 0x00007f503c8f50c8 (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x384c0c8)
 #5 0x00007f503b492cf5 (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x23e9cf5)
 #6 0x00007f503b492607 (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x23e9607)
 #7 0x00007f503b492300
llvm::MCExpr::evaluateAsRelocatableImpl(llvm::MCValue&,
llvm::MCAssembler const*, llvm::MCAsmLayout const*, llvm::MCFixup
const*, llvm::DenseMap<llvm::MCSection const*, unsigned long,
llvm::DenseMapInfo<llvm::MCSection const*, void>,
llvm::detail::DenseMapPair<llvm::MCSection const*, unsigned long>>
const*, bool) const (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x23e9300)
 #8 0x00007f503b492536
llvm::MCExpr::evaluateAsRelocatable(llvm::MCValue&, llvm::MCAsmLayout
const*, llvm::MCFixup const*) const
(/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x23e9536)
 #9 0x00007f503b46d51a
llvm::MCAssembler::evaluateFixup(llvm::MCAsmLayout const&,
llvm::MCFixup const&, llvm::MCFragment const*, llvm::MCValue&,
llvm::MCSubtargetInfo const*, unsigned long&, bool&) const
(/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x23c451a)
#10 0x00007f503b46f8d2 llvm::MCAssembler::layout(llvm::MCAsmLayout&)
(/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x23c68d2)
#11 0x00007f503b46fbeb llvm::MCAssembler::Finish()
(/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x23c6beb)
#12 0x00007f503b48e43c llvm::MCELFStreamer::finishImpl()
(/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x23e543c)
#13 0x00007f503b4ec410 (/lib/x86_64-linux-gnu/libLLVM-18.so.1+0x2443410)
#14 0x000055b46ddce675 cc1as_main(llvm::ArrayRef<char const*>, char
const*, void*) (/usr/lib/llvm-18/bin/clang+0x18675)
#15 0x000055b46ddc6285 (/usr/lib/llvm-18/bin/clang+0x10285)
#16 0x000055b46ddc53a8 clang_main(int, char**, llvm::ToolContext
const&) (/usr/lib/llvm-18/bin/clang+0xf3a8)
#17 0x000055b46ddd3016 main (/usr/lib/llvm-18/bin/clang+0x1d016)
#18 0x00007f5038b936ca (/lib/x86_64-linux-gnu/libc.so.6+0x276ca)
#19 0x00007f5038b93785 __libc_start_main
(/lib/x86_64-linux-gnu/libc.so.6+0x27785)
#20 0x000055b46ddc2b11 _start (/usr/lib/llvm-18/bin/clang+0xcb11)
clang: error: unable to execute command: Segmentation fault (core dumped)
clang: error: clang integrated assembler command failed due to signal
(use -v to see invocation)
Debian clang version 18.0.0
(++20240107111313+2835be82db20-1~exp1~20240107111423.1804)
Target: riscv64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/local/bin
clang: note: diagnostic msg:
********************

PLEASE ATTACH THE FOLLOWING FILES TO THE BUG REPORT:
Preprocessed source(s) and associated run script(s) are located at:
clang: note: diagnostic msg: /tmp/kexec_relocate-53192a.S
clang: note: diagnostic msg: /tmp/kexec_relocate-53192a.sh
clang: note: diagnostic msg:

********************
make[4]: *** [scripts/Makefile.build:382:
arch/riscv/kernel/kexec_relocate.o] Error 1

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.10-125-gc52463eb66c8/testrun/22017748/suite/build/test/clang-nightly-allmodconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.71-151-g28e6ce52ce18/testrun/22017752/suite/build/test/clang-nightly-allmodconfig/details/

Test history link:
 - https://qa-reports.linaro.org/_/comparetest/?project=1597&project=1971&suite=build&test=clang-nightly-allmodconfig


--
Linaro LKFT
https://lkft.linaro.org

