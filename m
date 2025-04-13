Return-Path: <stable+bounces-132354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907CCA872B3
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C29E3B776F
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C561D7E37;
	Sun, 13 Apr 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNshVhPq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E214A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562836; cv=none; b=fPHKzXR0n1aHrpCNmLYLApWNUQVT9rB50ZkLp4VeM/YGkunnP8CjWQEYM791lVHNZeiWJEveNBBAPsD8PWYvRAzoo+8y2kEVJURK4TAatAzJksVZ7WhanQLq3IdNJZXToy0Bz4c4buJpjHLew6hgv6hX9OvhoeOL0PXdnD+jiZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562836; c=relaxed/simple;
	bh=WoC61Fw3W9cjHAFqqzw4tkGU56FLwZj++VdW+FSxMzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asWVAVTVpautbyVxjoApb32fK28j6VdEBuCy1RL2+rLr2TG5w6wTcW5WQTUWYW6hUMfSYIHC82e/hy8reo7t0e7hQ3hGG4cxp6TThOskw7aFkVGiy7J0uQ7VM6L0E1Vhw1jskznfIxOVFJ3Hz5T4YyZ9e/TMgYVscPkkLvc4n2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNshVhPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6232BC4CEDD;
	Sun, 13 Apr 2025 16:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562834;
	bh=WoC61Fw3W9cjHAFqqzw4tkGU56FLwZj++VdW+FSxMzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNshVhPqdKnR7Pm+2vjPaf/R7HCbzqv8lAJVtbUmEmlbQ0DWlJZCpW+KKdYkWZ3BR
	 AmmufJ8i9MHdg7sHbPrQC1yQjfnMyu4PNluy19NsvVzyAJXJCkAVcFC1ARVJiurjiE
	 2s8Wf4mVaCKcm1kmwW1NmV2/Ejr1bK2I+D4tKMoPFDznMJlY25FzxLCh7kiNMq9UKJ
	 hSlVErZGJ4x1tk6rn+8kKUbcvS26WLGzG8+Lpm3SeCNkZA9oIjoEGv6sxCQq2HkzaD
	 VTENlFtBg0l+rzd/uNrFm9y8s7lDN6TJ1HbviP81/1LYqfm5gWM0dUCssdIHOU7zCx
	 D0dRed/qarVoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: He Zhe <zhe.he@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] libbpf: Prevent compiler warnings/errors
Date: Sun, 13 Apr 2025 12:47:11 -0400
Message-Id: <20250412091854-fc75ac150750cf4d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411033644.1156976-1-zhe.he@windriver.com>
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

The upstream commit SHA1 provided is correct: 7f4ec77f3fee41dd6a41f03a40703889e6e8f7b2

WARNING: Author mismatch between patch and upstream commit:
Backport author: He Zhe<zhe.he@windriver.com>
Commit author: Eder Zulian<ezulian@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  7f4ec77f3fee4 ! 1:  1a7061fb10c80 libbpf: Prevent compiler warnings/errors
    @@ Metadata
      ## Commit message ##
         libbpf: Prevent compiler warnings/errors
     
    +    commit 7f4ec77f3fee41dd6a41f03a40703889e6e8f7b2 upstream.
    +
         Initialize 'new_off' and 'pad_bits' to 0 and 'pad_type' to  NULL in
         btf_dump_emit_bit_padding to prevent compiler warnings/errors which are
         observed when compiling with 'EXTRA_CFLAGS=-g -Og' options, but do not
    @@ Commit message
         Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
         Acked-by: Jiri Olsa <jolsa@kernel.org>
         Link: https://lore.kernel.org/bpf/20241022172329.3871958-3-ezulian@redhat.com
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
     
      ## tools/lib/bpf/btf_dump.c ##
     @@ tools/lib/bpf/btf_dump.c: static void btf_dump_emit_bit_padding(const struct btf_dump *d,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

