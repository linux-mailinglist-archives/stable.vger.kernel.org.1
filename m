Return-Path: <stable+bounces-119537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4503DA445AA
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD94E188BCE0
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1F18DB17;
	Tue, 25 Feb 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiV8LcFB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7518DB14
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500033; cv=none; b=cqzB2f5FZgUTrtBXLfTLCmZJprJEbNeaZqCoZAhXf2Yz7ZMGt7m37EBB6PMgCSbQhwvufQC88yFoi6iCqjyDS2PDyZ/K64h1by3PN+qWdiFiwAaJJiaNbzmF6vrSE9R4wz1o6Laz5a6OrnjZ1W937rtasUMcv9qRfgP71NEydaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500033; c=relaxed/simple;
	bh=ke5hMVG1I/vAU33DXxLQiR5mnIwxzX8mHa3FsYi868I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tY7F7Somojs/9alEXXmBNVJvnuV24bttS1wvZ7n/cHm6F4KukOkF7T+eBfAQs1sveR1n5tTNRqrQdsttz2S9I47X25jZhQ37hhbsMW52cZzgRN/kd9bTF8B0dGbPC/19yktdw8dakeYenuWq399AbD/ReTGf46pRNw1Kd+Me2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiV8LcFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E15C4CEE6;
	Tue, 25 Feb 2025 16:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500033;
	bh=ke5hMVG1I/vAU33DXxLQiR5mnIwxzX8mHa3FsYi868I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DiV8LcFB7F7XhySmRYRr7FGhOuqxzt0WpcDmvhG20nNRlaxuzgPw2g6IjQJs1U9NR
	 sdo1acJeAZ6fPOhPv2TysV6/TCiuwU0QZXhSxxx5pM9vVPTiLFVAtOWmvJChq3d5yt
	 7z4VCaEgxDxgKWBIAZNYR+L9mD8JrEsiy9YghROtVqfe4MiWo07PAR1p9CYVQenqeq
	 iZw5nsw7MrQvl4OONBeN3yZxJ0bGYzCLdQ2dMVFwx+bBJ/FL50758CIUosNExvYWRV
	 1S8lZerLFni0UL8H9nS9D6aECcENZZxY4MXSVa/fo/h1a8bYuhh7urpDC7xDNhBn7K
	 TZhlUwtaMg0Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	joshwash@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] gve: set xdp redirect target only when it is available
Date: Tue, 25 Feb 2025 11:13:51 -0500
Message-Id: <20250225103916-7c666ca3f8493440@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250224195238.961070-1-joshwash@google.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 415cadd505464d9a11ff5e0f6e0329c127849da5

Note: The patch differs from the upstream commit:
---
1:  415cadd505464 ! 1:  f1af823cbe6e3 gve: set xdp redirect target only when it is available
    @@ Commit message
         Signed-off-by: Joshua Washington <joshwash@google.com>
         Link: https://patch.msgid.link/20250214224417.1237818-1-joshwash@google.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 415cadd505464d9a11ff5e0f6e0329c127849da5)
    +    Signed-off-by: Joshua Washington <joshwash@google.com>
     
      ## drivers/net/ethernet/google/gve/gve.h ##
     @@ drivers/net/ethernet/google/gve/gve.h: static inline u32 gve_xdp_tx_start_queue_id(struct gve_priv *priv)
    @@ drivers/net/ethernet/google/gve/gve.h: static inline u32 gve_xdp_tx_start_queue_
     +	}
     +}
     +
    - /* gqi napi handler defined in gve_main.c */
    - int gve_napi_poll(struct napi_struct *napi, int budget);
    - 
    + /* buffers */
    + int gve_alloc_page(struct gve_priv *priv, struct device *dev,
    + 		   struct page **page, dma_addr_t *dma,
     
      ## drivers/net/ethernet/google/gve/gve_main.c ##
     @@ drivers/net/ethernet/google/gve/gve_main.c: static void gve_turndown(struct gve_priv *priv)
    @@ drivers/net/ethernet/google/gve/gve_main.c: static void gve_turndown(struct gve_
      	gve_clear_report_stats(priv);
      
     @@ drivers/net/ethernet/google/gve/gve_main.c: static void gve_turnup(struct gve_priv *priv)
    - 		napi_schedule(&block->napi);
    + 		}
      	}
      
     +	if (priv->num_xdp_queues && gve_supports_xdp_xmit(priv))
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

