Return-Path: <stable+bounces-134899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4096A95ADE
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FCF17594F
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA450194AD5;
	Tue, 22 Apr 2025 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmn36GZG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8117B50A
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288153; cv=none; b=hQc5wwO7ONXcucWb9fDrUEDhkYlspVhTfGCbGuOT3Y4at1IAk9Ju7n6BW1oTLuWSduU7Z8Tus5gJiLGsOP2EfzQ1AmqVygQWCGXQu/eKqnPTCuMO0OOwmoyEHJfdFYx1G3ZcfSekt71R/9o45vYyNdvDjR5yeGlNSwFDEWuMUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288153; c=relaxed/simple;
	bh=LA8FVqDCX3aJjmh3dEWDDanAT8HO5fH9ufYyYYKIs8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mw1C6t4ED8KxUj+ey3VduBE8kNX7oG+7wAGTDKbgVuqpCguIZq+pDiNzoHDgz7MrajBcp3k7TJYuBG1gNubMLLMr25P3N06Vzca0vXN+K9NC1XTt3or6pRUAoDmQHivEOJDC1G+oAPAcjf4Iluo36spwmeOnlq4/cSn+M77uyZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmn36GZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF79C4CEE4;
	Tue, 22 Apr 2025 02:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288153;
	bh=LA8FVqDCX3aJjmh3dEWDDanAT8HO5fH9ufYyYYKIs8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jmn36GZG/bTPgYNMiNQsCj3tf/0/7ntgbksWXzwDp9y2UE1lQ7ftKgMh9TbnFEMYq
	 QmThVxTOAZUjkKctxWINXDH/JqggSqrYKOQPWqthFwWfsljrQd6xLM95VKIhFu3XWs
	 8wQXLFOKy4rmkFzHr7rx9eUlVVNZ0xHMxL47ri5M/9RmJbjQgVpBq0mCN/zKKjtZ0p
	 ylhvwSNtlQNAeZY9oejvgz8cCVyoQIeIbqGOQuq4gSmcUE8yIqp4JBemFPnJ6D0mYg
	 CM+w4JYnCIyBnLbhUVELLXgLXVgQ7NWu9emQJDq/uM+loWwO3PPIMnIbVrP4VGa7U3
	 SEZ599QCQNefw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y] scripts: generate_rust_analyzer: Add ffi crate
Date: Mon, 21 Apr 2025 22:15:51 -0400
Message-Id: <20250421194247-50eb35a87a22ee4f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250421123827.3147434-1-ojeda@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  05a2b0011c4b6 ! 1:  5869631cf792b scripts: generate_rust_analyzer: Add ffi crate
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
| stable/linux-6.14.y       |  Success    |  Success   |

