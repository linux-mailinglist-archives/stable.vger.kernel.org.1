Return-Path: <stable+bounces-137063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1221AA0C06
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5D28436B1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1C58BEE;
	Tue, 29 Apr 2025 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFkn+icx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE12D2C17A7
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930964; cv=none; b=NhnLXvrfh2gjVkP9u2wu/I97kgZ4+KwKDvY65mqlNvBhzEByrRwg45Op8FlrTi/Nav/aTI1V3/2mTYTGVJ54zr/ft7FExzs5juU9OktHLRQWpEveYk2rHqLfgsjU5E37fq8Sjp08fxLRkucwTeXXcqIzvx+Ogxa+3yOShDixL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930964; c=relaxed/simple;
	bh=M58MzUw97LR4TtrO3mSdyFX7psUVZGa+PYrTzjM/5jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ll5sPZMKp2/IALUvdCjs/agts9Mv0grI6s+wF81VoT03MUHJ9Dy9VQNR8CpsLwsLwLfOK+Kcw8lvXzJJammmraHmRA7oO3esahU8e/PxhTwV0BzTZff7Dcj8CMUc36xMOACrwP07O2093Ojay+izW1k6Q1MrEtf6OpRMtf76N4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFkn+icx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF30C4CEEB;
	Tue, 29 Apr 2025 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745930964;
	bh=M58MzUw97LR4TtrO3mSdyFX7psUVZGa+PYrTzjM/5jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFkn+icxIQcnIxs63iqc0q1v1W0vbS92xWchGsSrW8d1lDDnzhNL00ozsEg56CFEN
	 G6CzxCDHefspcE+LqjU6a8sC5XnXnbv5PELZhxiRsRjbU6N+9h2hRL9aGp9vyb47ry
	 tqjXcgDzeVI9uNfKKWWEoBXmzld7BKImYmC7Fwlxw8jld3gcS0ubDNjewNOppQamJs
	 n6j/tsRPGNQijx4ppHWglNV+Dt3ofWMuVul4GeFFeQGcQVf1S7mW5fAv5C9lQIlR7I
	 xG0VZA7fVlS2j9wHn9OP+WpdvdlwWaK8PFhBWM6/WXxNXGIWQ/mDvFj9zTrh1o++Mv
	 zVfVwNdXy9jFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 2/5] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Tue, 29 Apr 2025 08:49:19 -0400
Message-Id: <20250428220142-d6a026f6067af5cb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428075813.530-2-kabel@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  4ae01ec007716 ! 1:  6916792f1672f net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
    @@ Metadata
      ## Commit message ##
         net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
     
    +    [ Upstream commit 4ae01ec007716986e1a20f1285eb013cbf188830 ]
    +
         The atu_move_port_mask for 6341 family (Topaz) is 0xf, not 0x1f. The
         PortVec field is 8 bits wide, not 11 as in 6390 family. Fix this.
     
         Fixes: e606ca36bbf2 ("net: dsa: mv88e6xxx: rework ATU Remove")
         Signed-off-by: Marek Behún <kabel@kernel.org>
    -    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    -    Link: https://patch.msgid.link/20250317173250.28780-3-kabel@kernel.org
    -    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
     
      ## drivers/net/dsa/mv88e6xxx/chip.c ##
     @@ drivers/net/dsa/mv88e6xxx/chip.c: static const struct mv88e6xxx_info mv88e6xxx_table[] = {
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
| stable/linux-6.12.y       |  Success    |  Success   |

