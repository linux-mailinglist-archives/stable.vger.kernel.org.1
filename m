Return-Path: <stable+bounces-137066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D419AA0C0C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90AB16E0A1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E912701C4;
	Tue, 29 Apr 2025 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPb7a3Hw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1D2C2585
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930976; cv=none; b=auLmoLrSHF5iRaTxIOKmtHvOMVjwXwCdDC/rMtGvRtZgtP+9nvZ9sCbzAAESLbxbLxkWrQUQ/z+dxMbm1TWMg9dAFcT0Kh9gQIDOhkDp6bBgZWYv0vTppbxduKwPP8MhXjYUAXllyifB6AlpQBONRJL/8tq21RNUAUUhP4duqcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930976; c=relaxed/simple;
	bh=WBMIm2EglbHecpwkpx/RvxviIlcpeG2NQIqayS8A68M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CG6spPSnJ3XJMADAm41/ijHTGZ9PGdSrpiCsKZDDDyT92PJptiV/gNHi1SfFPsCAZa8PJgeVdGXDTNnoHpECLHz2qFiMq+5GzPf8QkoFs1xPj0mAd+SU0tLBx3qgMpnsMjhdSNJvTRNT9fA9KPZkjL0xi4biz6VliHb4WTjQZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPb7a3Hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB50DC4CEE3;
	Tue, 29 Apr 2025 12:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745930976;
	bh=WBMIm2EglbHecpwkpx/RvxviIlcpeG2NQIqayS8A68M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPb7a3HwG5pkzBFEp4YN8QH9C92NIVdhY2GI7oDrbgycls9VIUAjzbBoKy+06QsJy
	 eLX/K8M+Qtx/ZgjOaGjrPr2jO4tW4Ed/lj4z1D3R720jYdoBjEpL44skqUMLhQVtB2
	 B8GlZ3BkcPB8uHWno+dBV7WUKuNQGhxwRkisTxuQOMQ232+6EEdt1+3R/aoaFQ16mR
	 9xQi6eHLHROoC45RHB605qzX7caioe4M4UmoiOkW534FZEo+2pdAIQAJ/BKicaQuOV
	 egmP6WRsGwqJN6oe+gzpO1mu2WARfApIvzQHJCKF8VeIaa8yTIWaliecvgXF2Oq149
	 tP3qpAA03ngEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 1/3] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Tue, 29 Apr 2025 08:49:32 -0400
Message-Id: <20250428224320-3e453be15ad7d9a9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428085744.19762-1-kabel@kernel.org>
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

The upstream commit SHA1 provided is correct: 4ae01ec007716986e1a20f1285eb013cbf188830

Status in newer kernel trees:
6.14.y | Present (different SHA1: 74c9ffccc3c8)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4ae01ec007716 ! 1:  8a35807892672 net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
    @@ Metadata
      ## Commit message ##
         net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
     
    +    commit 4ae01ec007716986e1a20f1285eb013cbf188830 upstream.
    +
         The atu_move_port_mask for 6341 family (Topaz) is 0xf, not 0x1f. The
         PortVec field is 8 bits wide, not 11 as in 6390 family. Fix this.
     
    @@ drivers/net/dsa/mv88e6xxx/chip.c: static const struct mv88e6xxx_info mv88e6xxx_t
     +		.atu_move_port_mask = 0xf,
      		.g1_irqs = 9,
      		.g2_irqs = 10,
    - 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
    + 		.pvt = true,
     @@ drivers/net/dsa/mv88e6xxx/chip.c: static const struct mv88e6xxx_info mv88e6xxx_table[] = {
      		.global1_addr = 0x1b,
      		.global2_addr = 0x1c,
    @@ drivers/net/dsa/mv88e6xxx/chip.c: static const struct mv88e6xxx_info mv88e6xxx_t
     +		.atu_move_port_mask = 0xf,
      		.g1_irqs = 9,
      		.g2_irqs = 10,
    - 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
    + 		.pvt = true,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

