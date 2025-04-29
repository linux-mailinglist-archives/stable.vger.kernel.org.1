Return-Path: <stable+bounces-137075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C78AA0C15
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3D6463084
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E62C2593;
	Tue, 29 Apr 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvpvFcJ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D32701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931014; cv=none; b=eETn973iUSt9V6BHwgWJweszVj0z2gV0NWdBXs8tGJCg5CSBtdh19WInbrT4YA1uUkh/fTCsrWoujie7+fNSkIfVbnWDH+lY3j0XCjahHckc7gpGaBquqp2iGZkkOp563qpEXCpP4j1IsHNpQQS5MhwtekFcHds1zIqPwqkKumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931014; c=relaxed/simple;
	bh=COl785YHF7uvqN/23DCORlDWs4o0yGWKDTgtid/gL4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9yfWOPVG4q+ehvQqFv6vD26guy9e7DQhcU5sap+b2vQ1sRhhTbUVgUG64wlLMgyzdwgE4ldSQAbrQm2JlVQTbSBanTtSLZX0zfa/V+kk0/DEHlnGM6vaTuZ+vLYDd5KMvkZBx/GZMJdfMC+78ml5WApwHF7qoKXUxuiHHrmHes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvpvFcJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2153DC4CEE3;
	Tue, 29 Apr 2025 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931014;
	bh=COl785YHF7uvqN/23DCORlDWs4o0yGWKDTgtid/gL4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvpvFcJ45jPdzNRfjsFUKCJN7j1KTcnXsfVd3NWc+7Ll9cd9EjxF2dxDNaPo08wPT
	 3J+42ZEzg3NySTsUaOb/0qayu4m4MdvlTyajcVHD5/+kap/fNGxMF54IpbMZQ6sks2
	 MFODmT+YAov6ZqD8RRgONKV0Hm8Cf8uumArsZ6zrKSgkCFENp/I/ARJHgpfzYmWOyQ
	 FGUrIQqf/Vv5X7xR+Oxw28NN4pTuvXOh8M1iJ2eU98rZujm17pPyq6uJJSdV8kilC+
	 LHWV5Pd81nftAP6OJjH1fD3UVq+6UBC9KffC2UkdDNQFzaEjCwEdDtGxcujCQfeSiL
	 PHxj/90KbVyjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/3] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Tue, 29 Apr 2025 08:50:11 -0400
Message-Id: <20250428223105-855edd5c6d3b530a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428084916.8489-1-kabel@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  4ae01ec007716 ! 1:  c951fb413223a net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
    @@ Metadata
      ## Commit message ##
         net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
     
    +    commit 4ae01ec007716986e1a20f1285eb013cbf188830 upstream.
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
| stable/linux-5.15.y       |  Success    |  Success   |

