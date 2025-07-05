Return-Path: <stable+bounces-160265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9167AFA218
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 23:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7499C17DA67
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1AE291C10;
	Sat,  5 Jul 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGChQohr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1573E2900A8
	for <stable@vger.kernel.org>; Sat,  5 Jul 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751751625; cv=none; b=bqPsu3Wtzi7ce3C/5aFAt+XmiVKCvrsSHIcfCwmQBAfWDwjuvdH2qKYj4qgZF0h73j6X8LGKgYse6xib+oxNOZmsa6HxGRJ0UuTl/oNjepAgjtg1PG6wSAQzUupMESYj2ud4ekYLALhT/nfTyNRnaXSfl19S/Ba/I3FYQVb3fL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751751625; c=relaxed/simple;
	bh=FX9B5T5KlKe7RT6StbfLXrfw6HYo8Di0onuSM7Knzlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzdPwVDKkDGNidl0M+A7cL5o6dgc9pnyFdt8nJZuYk+jDgkBjKlM4MfJGJIzMOrvjtEPuGWHh4XP6cS4NMprF0Q0+ULbEwhNG5iIhy9yaKJH95niZ3j2zE5ZSOOWtRB0H8utLGUF0BR4egZUXXzGPaQpyjnOTcK+ym4nJEfwYRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGChQohr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4410CC4CEE7;
	Sat,  5 Jul 2025 21:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751751624;
	bh=FX9B5T5KlKe7RT6StbfLXrfw6HYo8Di0onuSM7Knzlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGChQohrTh1UyO4O44wqbljG7SOZLUHWcdrcMPgxL0EKrFkxZ1HG+SYfyknkc2zIC
	 jzs2AAuVWRJoYhBhtIlXiCQRaZ3VypVLT9RSXOTKSoSdbFg2L0mvxt/rNBojXD7dDT
	 vx5kFo/BoHKPdqKEq+rAlD/HaYObBABq/R641C8jcig6QgLR5TUtLCHZ7FBSeUKUQh
	 +63bSgPhk6y1vRh7Qlu9gcbfZNVLmxwvuk8X83B/B4j7sxSJ4Ki9f9MHuv1UuGEkAF
	 Ob0Q+uop4n9vkpmeJWjDz6baRKFTFtEQo3RwMA3UbMUMat4M8mqqadDZGHDeBbuPqf
	 3061FmBaRjhHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] ice: safer stats processing
Date: Sat,  5 Jul 2025 17:40:22 -0400
Message-Id: <20250705105956-b16337d72c8b1426@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250704131620.51803-1-przemyslaw.kitszel@intel.com>
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

The upstream commit SHA1 provided is correct: 1a0f25a52e08b1f67510cabbb44888d2b3c46359

WARNING: Author mismatch between patch and upstream commit:
Backport author: Przemek Kitszel<przemyslaw.kitszel@intel.com>
Commit author: Jesse Brandeburg<jesse.brandeburg@intel.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  1a0f25a52e08b ! 1:  c6c5671ad73f7 ice: safer stats processing
    @@ Metadata
      ## Commit message ##
         ice: safer stats processing
     
    +    [ Upstream commit 1a0f25a52e08b1f67510cabbb44888d2b3c46359 ]
    +
    +    Fix an issue of stats growing indefinitely, minor conflict resolved:
    +    struct ice_tx_ring replaced by struct ice_ring, as the split is not yet
    +    present on 5.15 line. -Przemek
    +
    +    Original commit message:
         The driver was zeroing live stats that could be fetched by
         ndo_get_stats64 at any time. This could result in inconsistent
         statistics, and the telltale sign was when reading stats frequently from
    @@ Commit message
         Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
         Tested-by: Gurucharan G <gurucharanx.g@intel.com>
         Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
    +    Reported-by: Masakazu Asama <masakazu.asama@gmail.com>
    +    Closes: https://lore.kernel.org/intel-wired-lan/CAP8M2pGttT4JBjt+i4GJkxy7yERbqWJ5a8R14HzoonTLByc2Cw@mail.gmail.com
    +    Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
     
      ## drivers/net/ethernet/intel/ice/ice_main.c ##
    -@@ drivers/net/ethernet/intel/ice/ice_main.c: ice_fetch_u64_stats_per_ring(struct u64_stats_sync *syncp, struct ice_q_stats st
    +@@ drivers/net/ethernet/intel/ice/ice_main.c: ice_fetch_u64_stats_per_ring(struct ice_ring *ring, u64 *pkts, u64 *bytes)
      /**
       * ice_update_vsi_tx_ring_stats - Update VSI Tx ring stats counters
       * @vsi: the VSI to be updated
    @@ drivers/net/ethernet/intel/ice/ice_main.c: ice_fetch_u64_stats_per_ring(struct u
       * @count: number of rings
       */
      static void
    --ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi, struct ice_tx_ring **rings,
    +-ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi, struct ice_ring **rings,
     -			     u16 count)
     +ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi,
     +			     struct rtnl_link_stats64 *vsi_stats,
    -+			     struct ice_tx_ring **rings, u16 count)
    ++			     struct ice_ring **rings, u16 count)
      {
     -	struct rtnl_link_stats64 *vsi_stats = &vsi->net_stats;
      	u16 i;
      
      	for (i = 0; i < count; i++) {
    -@@ drivers/net/ethernet/intel/ice/ice_main.c: ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi, struct ice_tx_ring **rings,
    +@@ drivers/net/ethernet/intel/ice/ice_main.c: ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi, struct ice_ring **rings,
       */
      static void ice_update_vsi_ring_stats(struct ice_vsi *vsi)
      {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

