Return-Path: <stable+bounces-108124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B064A0798B
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 15:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495887A050A
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE621B18C;
	Thu,  9 Jan 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNGk/iZs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC73219E8F
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433868; cv=none; b=Ko02mRSSR1fU66c/mFZn3ESy189Tijk/sxaaxBuIadFGnBnyUSnNME0jqnLiU26L223akEwORRLkMiDtM2UmX3jc6N9T8/FXK3MzWNDUsL39A2gnCP2nfxG0j+i5iYIA9m5i1PfpsUYup80G6cnzYRPig+v27XG8SR6WOZvXRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433868; c=relaxed/simple;
	bh=r4qtrWY6qzTMswnSpIKQ5ntoydk+qoOxNR30rwD9xOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/EYFL9mnbBm2JlYPYee51VEFQMb8vOrIakLDvmUvWHIL1MqZBruq2X/gAYyyRmNwVnMwdetZS1DM1MkcsQ5q7EoOCDsNYp2xvPgO12JkvQAVvdEQsHhj8/0Ulrneku8uYwNqVx78P/cO6qOnWRoXVZ7Y/S2RrWWJAmoCED6xoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNGk/iZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8163AC4CED2;
	Thu,  9 Jan 2025 14:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736433868;
	bh=r4qtrWY6qzTMswnSpIKQ5ntoydk+qoOxNR30rwD9xOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNGk/iZs4sbaq3+l0vS2dWWmaxUDyxKDVuauHQ1naquuFvlNZbK4MBEL1/Bf6e4Wx
	 AGNI/ois8BS4hZwsw1TEUJg5zK9T1HHTu/Dug8QCBTSi2TJntgKGHg4wUIrDFxzogx
	 hQbPMoNZO2R0pdSMgYBhp+XCQvM0unW4bz81HTXSVi4/Q4gWOnJuZTXKL4hIBO1veK
	 lRowpXi5Ubuvg3qGoT6M3VDIfnhjAfJ7LblYhs5EL3ggUYPsrnLfmC99sbRETgFfC5
	 o7E46BVIpdpQCv7ovytHTs9u2XDwWCdFaci1zwPWy2u6in2w9A2HTJS5oZbm+qx/Sx
	 hExfsaGR+t/LQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alva Lan <alvalan9@foxmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] bpf, sockmap: Fix race between element replace and close()
Date: Thu,  9 Jan 2025 09:44:25 -0500
Message-Id: <20250109092342-e7b05470e6eae637@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_B2D63C382230E90D77B40E353B1F6F92AB08@qq.com>
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

The upstream commit SHA1 provided is correct: ed1fc5d76b81a4d681211333c026202cad4d5649

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alva Lan<alvalan9@foxmail.com>
Commit author: Michal Luczaj<mhal@rbox.co>


Status in newer kernel trees:
6.12.y | Present (different SHA1: bf2318e288f6)
6.6.y | Present (different SHA1: b015f19fedd2)
6.1.y | Present (different SHA1: b543d4a4153f)

Note: The patch differs from the upstream commit:
---
1:  ed1fc5d76b81 ! 1:  559c7465df3b bpf, sockmap: Fix race between element replace and close()
    @@ Metadata
      ## Commit message ##
         bpf, sockmap: Fix race between element replace and close()
     
    +    [ Upstream commit ed1fc5d76b81a4d681211333c026202cad4d5649 ]
    +
         Element replace (with a socket different from the one stored) may race
         with socket's close() link popping & unlinking. __sock_map_delete()
         unconditionally unrefs the (wrong) element:
    @@ Commit message
         Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
         Reviewed-by: John Fastabend <john.fastabend@gmail.com>
         Link: https://lore.kernel.org/bpf/20241202-sockmap-replace-v1-3-1e88579e7bd5@rbox.co
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## net/core/sock_map.c ##
     @@ net/core/sock_map.c: static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
    @@ net/core/sock_map.c: static void *sock_map_lookup_sys(struct bpf_map *map, void
     +	struct sock *sk = NULL;
      	int err = 0;
      
    - 	spin_lock_bh(&stab->lock);
    + 	if (irqs_disabled())
    + 		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
    + 
    + 	raw_spin_lock_bh(&stab->lock);
     -	sk = *psk;
     -	if (!sk_test || sk_test == sk)
    ++
     +	if (!sk_test || sk_test == *psk)
      		sk = xchg(psk, NULL);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

