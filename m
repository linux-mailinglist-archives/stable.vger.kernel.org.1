Return-Path: <stable+bounces-126562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57EA701BA
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC73178810
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E1F25A62F;
	Tue, 25 Mar 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXexVP+5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7EB25A627
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907743; cv=none; b=KQvCKSGZADGOuhYw0FBM48SYfjFI5xFALvjVamKKI4gaQnJm4mNg2COKrXne/teQmapwmegHOd2rjEEkFaoU0htlIJmHnGStWqqTAnghWw1GCpbcLKxalMS2uO5jSWc+i2cwlwXZTvB5pgOEG4HfxNlylktMNstL2FoebZnfvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907743; c=relaxed/simple;
	bh=KMA3T0il600Y/0tEMPfignHfKxkFsamhLLYxT4TDZts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2ZvEcOYaJME5I4wLcaqsAQ18a9wVFpRVnTOVWN76uIP+nFF2D09Jl0N0NiPVUdPiy99qPMby2myVxs68aFXLOPB3zeNocPvMMwKqvOj8wuOb88xTN6Ng4O8f6Z7WNEp7lvuXPG04UAUna8XfJ1xcukJNKptkEOgh+C4hn8+IXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXexVP+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B526C4CEE4;
	Tue, 25 Mar 2025 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907742;
	bh=KMA3T0il600Y/0tEMPfignHfKxkFsamhLLYxT4TDZts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXexVP+5Js3m41ncMCsqxZgEAlUwvIzVjjjh3BfFkCmsRRn7vmqBkyPRrIzt8ruKx
	 oJbTKP7ZOLkKFRtQf1IIgObX/oKCC4WWYe2LMC2875Ceyu43mfl2PY0p7K2KoJcRsg
	 Gf34pN+OVflB1bxI2MUCiRLxrst2SyMekm8dHLCw7iiSvxR4ATejskz8Nh29SEmsrJ
	 4m7U0dhXSdmCOOmYkd3Dh/yBWgjwiZQeSK3215h+inDbij+Sdcvkuoy7lMTGP3SESU
	 ELsvcIfTR4jAxLlr7ZU5eEVRroCcjHacvms2Lircftqd+8rTcH+hkt3MbIMo5iPcfS
	 VSZkyULdaoHeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] bpf, sockmap: Fix race between element replace and close()
Date: Tue, 25 Mar 2025 09:02:20 -0400
Message-Id: <20250325074934-d8a1a35ac67e38b7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325081045.2210079-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: ed1fc5d76b81a4d681211333c026202cad4d5649

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Michal Luczaj<mhal@rbox.co>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: bf2318e288f6)
6.6.y | Present (different SHA1: b015f19fedd2)
6.1.y | Present (different SHA1: b79a0d1e9a37)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ed1fc5d76b81a ! 1:  a13e934a36451 bpf, sockmap: Fix race between element replace and close()
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
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
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
     +	if (!sk_test || sk_test == *psk)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

