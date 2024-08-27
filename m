Return-Path: <stable+bounces-71350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E999619F9
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 00:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D7D1C2285A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 22:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2A61D27BF;
	Tue, 27 Aug 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYtsuTN0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200484D34;
	Tue, 27 Aug 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724797321; cv=none; b=qoGeQY8/LszlLum+SZMCpK36GMLGeZFWm6P4qpkl72fSnfC3ScJYDy4qw19pdb4bSGgNHCKV9/Ijcw6WgfWTzSIeNmMWfbmbYwUTmF8bILuIyxEVLhW2ftJ6N0txzmIkTfiNf1MlbMZcunEd0exsbNNu7ZUMth2+BfnJROCjiIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724797321; c=relaxed/simple;
	bh=A0s60QbzuSlrrDqZftQ45xwzEnGAMomAywshjLBlGOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sKAwAGXwGLC7yDbDVVMRivQdeb4RY0K2XWwYNyYRnxKMn/4+GsWuSfVXP6u03JQHVjE7TrnyXjyz5CrasYlYsIl0hJsL84EFtRdhi0OOBUr/8ZsvRhgpLGHDuSWrI2FfW1PDLXflSUPs8MKg/Ku45N49Qq1vkSeRyNLK4D/USn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYtsuTN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE508C4AF1B;
	Tue, 27 Aug 2024 22:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724797321;
	bh=A0s60QbzuSlrrDqZftQ45xwzEnGAMomAywshjLBlGOQ=;
	h=Date:From:To:Cc:Subject:From;
	b=hYtsuTN0yY8uhMCZfFVl8Etd3SdLGzoSuWxKwLV8OEBc86GVsmOrsF6295jOEIpt5
	 wsVS59RmCzKrSKwOfaq716lHz2D/DhWfzYiRukBlgRUzESNaR0W/jsFwJFt9ISEpyR
	 ykqFbcUBmVpJAnQe4uFeaB33YqZU5qdytqlzyZvJBj728cFYXACkSix+Afse4GYlT5
	 P5RNKkZaxoJKly72uQWFls9JiGj41aJIbVa5qPYHUD0dK9e5eWFWJMTcBjgAF6UBFp
	 KeUM6OsAOH5AilL8RUbT7nlV2XXCbr9K6LFYdChouqaCfXt7hMMyWiCuesleawH5e4
	 buM6vEsw0q0Dw==
Date: Tue, 27 Aug 2024 15:21:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Apply dbaee836d60a8 to linux-5.10.y
Message-ID: <20240827222159.GA2737082@thelio-3990X>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Please apply commit dbaee836d60a ("KVM: arm64: Don't use cbz/adr with
external symbols") to linux-5.10.y, as a recent LLVM optimization around
__cold functions [1] can cause hyp_panic() to be too far away from
__guest_enter(), resulting in the same error that occurred with LTO (for
the same reason):

  ld.lld: error: arch/arm64/built-in.a(kvm/hyp/entry.o):(function __guest_enter: .text+0x120): relocation R_AARCH64_CONDBR19 out of range: 14339212 is not in [-1048576, 1048575]; references 'hyp_panic'
  >>> referenced by entry.S:88 (arch/arm64/kvm/hyp/vhe/../entry.S:88)
  >>> defined in arch/arm64/built-in.a(kvm/hyp/vhe/switch.o)

  ld.lld: error: arch/arm64/built-in.a(kvm/hyp/entry.o):(function __guest_enter: .text+0x134): relocation R_AARCH64_ADR_PREL_LO21 out of range: 14339192 is not in [-1048576, 1048575]; references 'hyp_panic'
  >>> referenced by entry.S:97 (arch/arm64/kvm/hyp/vhe/../entry.S:97)
  >>> defined in arch/arm64/built-in.a(kvm/hyp/vhe/switch.o)

It applies cleanly with 'patch -p1' and I have verified that it fixes
the issue.

[1]: https://github.com/llvm/llvm-project/commit/6b11573b8c5e3d36beee099dbe7347c2a007bf53

Cheers,
Nathan

