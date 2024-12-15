Return-Path: <stable+bounces-104288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C7A9F2525
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 18:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DF3164B5C
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75121B3926;
	Sun, 15 Dec 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3e1EReK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680591119A
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734285095; cv=none; b=YzxDIh2Jt64UbJwu+e6MKf3EnjibFyof1iMSJL96SAmZNNKORA8dnu+owSUYkEsbqyySZo1+F8cpJsw7z6pnxOgqvIPEgz0kmFaf6FrCGo5k/ToKpOpZd7ocyHQlfUu3kdr2F4U1h0kdZRMiKRgDWepU3Y+3b7O47DSnETg1htA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734285095; c=relaxed/simple;
	bh=UqgP/mDeF22L8Y/0NvHoAS63HcH0rAEYl94a3LXWAro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stxzQ/8PavY2sf+e6CUMrxzzi0AoPkZ8n8+WdOZbqK0tDzNGulzUrGAKaeeheSMEbAfQ2oXoir0aXbdVQnoA1FQO/tgCuGAVDC7w69VpWBAlGDkzO7UwHEGNsMVpXsO9QcRAGxy9M+cCySrSZM3DFQ0xiJo9JaWm0HJ6WVScS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3e1EReK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D3CC4CECE;
	Sun, 15 Dec 2024 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734285094;
	bh=UqgP/mDeF22L8Y/0NvHoAS63HcH0rAEYl94a3LXWAro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3e1EReKC7HrDVZjt/zke9BCv0VJ2cfCt4dAwg5o7UvpBHuP+JLst1gWlt9QZwrLG
	 6iAKsJdLRKScwKp8H1JF2WbymRymTjFwDjOnlEXxAl/wDX4XTB6ccOZHyfbCsQxNC8
	 yH0ZeCuVUM39NK32DzZufPGQJO6Qh4Sh8t5abzS+lRVYJE65zvaYFzIXjCZ8H5KWao
	 JQJAO6eBEfN3+5ltxx0z6wn70oFx/lJ6EhXsB0c5U0i4lWX3H+Di/e/rQheBR8RyU9
	 kPJyIMMxMi9d6DKw+KMu2Dt5vR7MZuWzoroaMrOliZrXwk6lu4eK96NqJi5nQgImfK
	 K2WWEqWPVKHDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] rust: kbuild: set `bindgen`'s Rust target version
Date: Sun, 15 Dec 2024 12:51:33 -0500
Message-Id: <20241215123630-0a2c2266629f4f9e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241215145740.237008-1-ojeda@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 7a5f93ea5862da91488975acaa0c7abd508f192b


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7a5f93ea5862 ! 1:  97fd2a891113 rust: kbuild: set `bindgen`'s Rust target version
    @@ Metadata
      ## Commit message ##
         rust: kbuild: set `bindgen`'s Rust target version
     
    +    commit 7a5f93ea5862da91488975acaa0c7abd508f192b upstream.
    +
         Each `bindgen` release may upgrade the list of Rust targets. For instance,
         currently, in their master branch [1], the latest ones are:
     
    @@ Commit message
     
      ## rust/Makefile ##
     @@ rust/Makefile: endif
    - # architecture instead of generating `usize`.
    - bindgen_c_flags_final = $(bindgen_c_flags_lto) -fno-builtin -D__BINDGEN__
    + 
    + bindgen_c_flags_final = $(bindgen_c_flags_lto) -D__BINDGEN__
      
     +# Each `bindgen` release may upgrade the list of Rust target versions. By
     +# default, the highest stable release in their list is used. Thus we need to set
    @@ rust/Makefile: endif
            cmd_bindgen = \
     -	$(BINDGEN) $< $(bindgen_target_flags) \
     +	$(BINDGEN) $< $(bindgen_target_flags) --rust-target 1.68 \
    - 		--use-core --with-derive-default --ctypes-prefix ffi --no-layout-tests \
    + 		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
      		--no-debug '.*' --enable-function-attribute-detection \
      		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

