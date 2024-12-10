Return-Path: <stable+bounces-100476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA169EBA16
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E25B18888C3
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC4B22618B;
	Tue, 10 Dec 2024 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkpGt5hB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9A214227
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858701; cv=none; b=lJTbPvSeDQyGih0ROWzZzh8uMzCOIjU5XGZCgiFbh1OeBuZMQ3bP8mXXgkRjGTgDoz7VG6W9BHcOUdzC9v6WSnJ+2aVNVqpTBPl/uSAp9lheVwdUrCzd3MZ+syl06IpKkXHh/hXe1EYTASA9+oG90RAQSmaPwkuVljk0W/978rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858701; c=relaxed/simple;
	bh=N/Hh13cruNQKRFNsHkg25Q+CrpZSI1WAJmV4gBFDvp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqVyae+rDYTWnLsdAJc8Bor+FJyfUVuUq0hJX6I9/D2qWKNUg9XQpYQqMZwDWflj634t0BM8LtEtvpl+Rg+PYMtQ5uRzwXhmkkpU+htG63/0f1VsPthAuilBHIcw56Fi3ZksDOBNdzkOOAJ5IijUjbp7FSmjqGM+7FxMV+cSy3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkpGt5hB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E0AC4CED6;
	Tue, 10 Dec 2024 19:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858699;
	bh=N/Hh13cruNQKRFNsHkg25Q+CrpZSI1WAJmV4gBFDvp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkpGt5hBrQqQVsMvb4jcAGoRkxHXbz0d03GxVsHAkb0kwg7cwWe1ntqzJczUdNU5f
	 Z25ppHDYaRyRxDgYaVSFzEOba98anowHTDOOY65Gi3YthRAffXIaPdqiP2Cp6wR145
	 jSsEJMXFpQM/25F37D5m3R9Gs8amRValysa4EOss6tJZd2C3rT+tENRx0TehoIjxtl
	 c6uC4Vhp00Ev+Yk9rSofV+i+zYSf07ffxBmL6P71/gjFslDc6udMaeYv/ZfUourNG3
	 lbyo9UivFdMS20LJSt68USt4yGE3BKvyGSWVxDIkv4rlr++15kpexAeJyUXoVZJ98k
	 2d4ALdzltA/3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] rust: enable arbitrary_self_types and remove `Receiver`
Date: Tue, 10 Dec 2024 14:24:57 -0500
Message-ID: <20241210084221-1376a8121c771a40@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210095506.2027071-1-ojeda@kernel.org>
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

The upstream commit SHA1 provided is correct: c95bbb59a9b22f9b838b15d28319185c1c884329

WARNING: Author mismatch between patch and upstream commit:
Backport author: Miguel Ojeda <ojeda@kernel.org>
Commit author: Gary Guo <gary@garyguo.net>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  c95bbb59a9b22 ! 1:  071e4c8427c47 rust: enable arbitrary_self_types and remove `Receiver`
    @@ Metadata
      ## Commit message ##
         rust: enable arbitrary_self_types and remove `Receiver`
     
    +    [ Upstream commit c95bbb59a9b22f9b838b15d28319185c1c884329 ]
    +
         The term "receiver" means that a type can be used as the type of `self`,
         and thus enables method call syntax `foo.bar()` instead of
         `Foo::bar(foo)`. Stable Rust as of today (1.81) enables a limited
    @@ rust/kernel/lib.rs
     +#![feature(arbitrary_self_types)]
      #![feature(coerce_unsized)]
      #![feature(dispatch_from_dyn)]
    - #![feature(lint_reasons)]
      #![feature(new_uninit)]
     -#![feature(receiver_trait)]
      #![feature(unsize)]
    @@ scripts/Makefile.build: $(obj)/%.lst: $(obj)/%.c FORCE
      # Compile Rust sources (.rs)
      # ---------------------------------------------------------------------------
      
    --rust_allowed_features := lint_reasons,new_uninit
    -+rust_allowed_features := arbitrary_self_types,lint_reasons,new_uninit
    +-rust_allowed_features := new_uninit
    ++rust_allowed_features := arbitrary_self_types,new_uninit
      
      # `--out-dir` is required to avoid temporaries being created by `rustc` in the
      # current working directory, which may be not accessible in the out-of-tree
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

