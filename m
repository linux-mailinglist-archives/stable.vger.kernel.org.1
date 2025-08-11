Return-Path: <stable+bounces-167081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86431B2198A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 01:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F491728C1
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 23:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CB6285C80;
	Mon, 11 Aug 2025 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKiuEddp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC42857EF;
	Mon, 11 Aug 2025 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956333; cv=none; b=Qm2bSlqMtxE7jJdMaEdh9oyvSpsgf0JgsvyZvd1L03NdeqIT9IBoWn47q5SIqehurnnrzZnfuR31TfX0yPX35g5/3soNpWqy2vFMsJL1vKMYjKqueC4O7UJCLz8BNentc+72hoVxbQqepAyNqYPfOFM73/MBxXz55f7Va6vdgfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956333; c=relaxed/simple;
	bh=VonkOmxzVa0jkBPQiew94+Qf9+4HNfFmIM5rtIMIq8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqxa8HJasIpHciyFP7kqzN5Zng/CtLzOR3sDRyF5xD3kkP2uG3ym+8e7lf70uAPHe2ks5oPLLiareIegk/1IMilhBt6WpFRp1CSsWONhpDllLQeOm/uWjNa3j8a92z1blCHUAhUxtSc0MSohsZo1ATW3UG1X/b9IVoCvdrgBw5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKiuEddp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D516C4CEED;
	Mon, 11 Aug 2025 23:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754956332;
	bh=VonkOmxzVa0jkBPQiew94+Qf9+4HNfFmIM5rtIMIq8g=;
	h=From:To:Cc:Subject:Date:From;
	b=oKiuEddpVPoHfopMlYWnMullrSoK+PznYmvTs1yQPWir45iFPuxkqo//EZj/tFsl7
	 y5WLagFHCC3Gke/8nNf3GW/Z5mbWli/CfgTQgUAiaTqdJ7oU2krZY5nekwiTtUsUcU
	 Yyb5NLbABsGlpEdP+px2bwBUJrMNR+bXWKaO+2NIKBCYynDK97GT9+kaPW9n0dNUi+
	 80mjWSAbJmovxoJu3YY6tk5BWcoCGC/kJ3GlVp+X1ipNgTo4fZYVUUK4E0SZyiEw12
	 7/w6NIb4AKSZLbqgSWoNSOcHeWHsWLvk1t2MgfQNJyAGcQJeMnAgTn/pD+XCX6DW60
	 hSMljKJZKNmSA==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 5.4 0/6] Fix build due to clang -Qunused-arguments change
Date: Mon, 11 Aug 2025 16:51:45 -0700
Message-ID: <20250811235151.1108688-1-nathan@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an updated version of [1], just for 5.4, which was waiting on
commit 87c4e1459e80 ("ARM: 9448/1: Use an absolute path to unified.h in
KBUILD_AFLAGS") to avoid regressing the build [2].

These changes are needed there due to an upstream LLVM change [3] that
changes the behavior of -Qunused-arguments with unknown target options,
which is only used in 6.1 and older since I removed it in commit
8d9acfce3332 ("kbuild: Stop using '-Qunused-arguments' with clang") in
6.3.

Please let me know if there are any issues.

[1]: https://lore.kernel.org/20250604233141.GA2374479@ax162/
[2]: https://lore.kernel.org/CACo-S-1qbCX4WAVFA63dWfHtrRHZBTyyr2js8Lx=Az03XHTTHg@mail.gmail.com/
[3]: https://github.com/llvm/llvm-project/commit/a4b2f4a72aa9b4655ecc723838830e0a7f29c9ca

Masahiro Yamada (1):
  kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS

Nathan Chancellor (4):
  ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
  mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
  kbuild: Add CLANG_FLAGS to as-instr
  kbuild: Add KBUILD_CPPFLAGS to as-option invocation

Nick Desaulniers (1):
  kbuild: Update assembler calls to use proper flags and language target

 Makefile               | 3 +--
 arch/arm/Makefile      | 2 +-
 arch/mips/Makefile     | 2 +-
 scripts/Kbuild.include | 8 ++++----
 4 files changed, 7 insertions(+), 8 deletions(-)


base-commit: 04b7726c3cdd2fb4da040c2b898bcf405ed607bd
-- 
2.50.1


