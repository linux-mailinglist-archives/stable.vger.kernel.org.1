Return-Path: <stable+bounces-134895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE89A95AD9
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660D9175527
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8D13AD1C;
	Tue, 22 Apr 2025 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikAqcpml"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751E33C9
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288147; cv=none; b=rBS6NA4A82FtVQ7817bGZ76j8p5e7gF3ZCeSsJst2DxU/dHgS5X0VpPNnOg21AeWYZ3Qis537Wf94cNpf6ajTvt4WybELtY+qLJ9ohxjs9v7JbcECyN/cIEs0DexdJd9Bi7wugxlYs2ZSYEVTpzTMnK5gLCZVHAUlisuVucjzKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288147; c=relaxed/simple;
	bh=EkCWwcIixhMyKWzh37ypNK/AuqagVJ3S0rA7KzWdW7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfEDhM+QFAbVzm7IhdKo7bDzcdvydTigYa/gIwhnlYX89Y4tPzswWDSqcEWmyMb39rQzbN8hj22JD3fvfmf/bc2NL3zeaSVnBTOEau3q0GvPtQki3H12F9uYd1ZAQyGYxH0vIw55Z3g8OBPeHadMxoeTX3Uy05A/aDePKGrLNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikAqcpml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADD0C4CEE4;
	Tue, 22 Apr 2025 02:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288147;
	bh=EkCWwcIixhMyKWzh37ypNK/AuqagVJ3S0rA7KzWdW7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikAqcpmlVBL4zMjQTyk8865vOBbnar/ayxpiU/GRmStYfWTvPRi0lPrStbs9wqA5/
	 1PUTx2y3JYBWZ7VrsoTOrl5mNMTGXe+ac89YQTH1jqkuEaO78n3fSrxXaxdB14b9u7
	 5uHjAZGcf3chuFEYP7Gs6kvCoHr+fk8Fi0NAIAY5HeUXhnxebCUHOZG27cUXz0ecxC
	 UrHpR+hel8VLo1xhzLIHKSYxUkIEyYwluo3AjCQZSLHH6+JB72dpVNyCNNYlNVdKa3
	 PSCS1ppJgKkNFVHRdDvTxAk2cVdM18FavkS6Dx6u876SsrsnVfbwPaTCQk+VBzuyYe
	 4nfz9m7ettmfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] scripts: generate_rust_analyzer: Add ffi crate
Date: Mon, 21 Apr 2025 22:15:45 -0400
Message-Id: <20250421193449-7c398e90b1b874f5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250421123743.3147213-1-ojeda@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 05a2b0011c4b6cbbc9b577f6abebe4e9333b0cf6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Miguel Ojeda<ojeda@kernel.org>
Commit author: Lukas Fischer<kernel@o1oo11oo.de>

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  05a2b0011c4b6 ! 1:  dfc4475fa6764 scripts: generate_rust_analyzer: Add ffi crate
    @@ Metadata
      ## Commit message ##
         scripts: generate_rust_analyzer: Add ffi crate
     
    +    commit 05a2b0011c4b6cbbc9b577f6abebe4e9333b0cf6 upstream.
    +
         Commit d072acda4862 ("rust: use custom FFI integer types") did not
         update rust-analyzer to include the new crate.
     
    @@ Commit message
         Cc: stable@vger.kernel.org
         Link: https://lore.kernel.org/r/20250404125150.85783-2-kernel@o1oo11oo.de
         Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
    +    [ Fixed conflicts. - Miguel ]
    +    Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
     
      ## scripts/generate_rust_analyzer.py ##
     @@ scripts/generate_rust_analyzer.py: def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
    -         cfg=["kernel"],
    +         ["core", "compiler_builtins"],
          )
      
     +    append_crate(
    @@ scripts/generate_rust_analyzer.py: def generate_crates(srctree, objtree, sysroot
      
     -    append_crate_with_generated("bindings", ["core"])
     -    append_crate_with_generated("uapi", ["core"])
    --    append_crate_with_generated("kernel", ["core", "macros", "build_error", "pin_init", "bindings", "uapi"])
    +-    append_crate_with_generated("kernel", ["core", "macros", "build_error", "bindings", "uapi"])
     +    append_crate_with_generated("bindings", ["core", "ffi"])
     +    append_crate_with_generated("uapi", ["core", "ffi"])
    -+    append_crate_with_generated("kernel", ["core", "macros", "build_error", "pin_init", "ffi", "bindings", "uapi"])
    ++    append_crate_with_generated("kernel", ["core", "macros", "build_error", "ffi", "bindings", "uapi"])
      
          def is_root_crate(build_file, target):
              try:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

