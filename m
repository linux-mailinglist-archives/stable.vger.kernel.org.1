Return-Path: <stable+bounces-126010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11B2A6F41D
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B2516D830
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A4255E47;
	Tue, 25 Mar 2025 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZ7l4u+1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B9BA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902401; cv=none; b=sWFxvHkDonNfosSy+XGIAUx+RfmeezOnxvsNQUWdpYB9weixmMH+nLqijCUTHHoKhn0871hUs7YC/FP5EINE7NTtunQePtwC2yA5OPOyVRRp4xZP26M7sgBHbJwsMqdD5tChRuSC9l2HG2WTG6QOgOYSF2i4+hiOF8VEDaMzn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902401; c=relaxed/simple;
	bh=kFJMpnxeh2lRx9bkDsJkWyPMhJgwEZEc5GLuI8DNHKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5yK0e5Lj3z3jDadThB5NylM5gPy2WUlAg8xRXuG5mys79fUhOlT9pT46dtSNfT0GYTwWOnAQDJKKO/amCkIrwAgTvzBjWs1VEBslbL0jgponNJmwQHjUy2mRGQaktt57iYF9Q+3ureVXLc5xfVcnlNLqwP1B5B/WJik5oBIpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZ7l4u+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22710C4CEE4;
	Tue, 25 Mar 2025 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902400;
	bh=kFJMpnxeh2lRx9bkDsJkWyPMhJgwEZEc5GLuI8DNHKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZ7l4u+1y6SN17sNQdpa8S7P51EBG5/umY3dvR4dwZ5qSUVsRV87t6gwSz5PPUygD
	 ptA0viSo9dl+Vfx4xGg9tSPXL4J5elTsWWt9pHB5yuCBw9r+VDSXwvgbkRzx3403lS
	 67Kbhz8w43jw1AjPvmBJCv5tQHuOH2+zns/XHWVT4zdcqiO3sEdkffkZj9iYOVrAZV
	 Ma9RzoA2kfhcW1P8c1iiGdI3Ur/jKy6t8gjuqXGxQrGbA/mfwKwakQBj+utpdz+wGp
	 +2ze8CMTgcV2E5IOtc/779DkeEWp0SnmWrphB93hg3Tw2e43+4g0/bH+TrNvBfXqg2
	 Fonj1etdtNsGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] bnxt_en: Fix receive ring space parameters when XDP is active
Date: Tue, 25 Mar 2025 07:33:18 -0400
Message-Id: <20250324202923-bbc187d2cd3a0a46@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324065258.3795814-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 3051a77a09dfe3022aa012071346937fdf059033

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Shravya KN<shravya.k-n@broadcom.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 84353386762a)

Note: The patch differs from the upstream commit:
---
1:  3051a77a09dfe ! 1:  beb28b174e3b5 bnxt_en: Fix receive ring space parameters when XDP is active
    @@ Metadata
      ## Commit message ##
         bnxt_en: Fix receive ring space parameters when XDP is active
     
    +    [ Upstream commit 3051a77a09dfe3022aa012071346937fdf059033 ]
    +
         The MTU setting at the time an XDP multi-buffer is attached
         determines whether the aggregation ring will be used and the
         rx_skb_func handler.  This is done in bnxt_set_rx_skb_mode().
    @@ Commit message
         Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
         Signed-off-by: Michael Chan <michael.chan@broadcom.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/net/ethernet/broadcom/bnxt/bnxt.c ##
     @@ drivers/net/ethernet/broadcom/bnxt/bnxt.c: int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
    @@ drivers/net/ethernet/broadcom/bnxt/bnxt.c: int bnxt_set_rx_skb_mode(struct bnxt
     @@ drivers/net/ethernet/broadcom/bnxt/bnxt.c: static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
      		bnxt_close_nic(bp, true, false);
      
    - 	WRITE_ONCE(dev->mtu, new_mtu);
    + 	dev->mtu = new_mtu;
     +
     +	/* MTU change may change the AGG ring settings if an XDP multi-buffer
     +	 * program is attached.  We need to set the AGG rings settings and
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

