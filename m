Return-Path: <stable+bounces-137071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBE5AA0C11
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FE2172AAB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95920E023;
	Tue, 29 Apr 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjvsjUnN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB218BEE
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930999; cv=none; b=bqE0zqW41U2ka9YmUJbfEqG8LUMdhHR46iZRaOsj9R1thqrt07HoDuQl0Mhd9rHnYjr1UxQwao4cg941an4thNpchV1OFvsPm8rcsJb5G8u9F/8auPK+S6PDattPwCV9gUlHy48OFsxq3OqQ17qXTg8D92QIgVLWdbbZQYG0mPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930999; c=relaxed/simple;
	bh=PD3YKlBC1Bbpr2lu4BJ37/z6VtTJSbnHrbJTmmaRWHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0s7Nybnspyv1CuuftSFG+yRPBLIrrnobbDCVGTC7bJxf8es4zeWaRWIF68BQ08N1Y5cpQcHhcPM5v3uNo9WPKyJncO5mFDKD1Cj2plzosNdjwWr24qNkNsL6ZHkILmGvFx2oVH4PR9o60vo/CjHGRkSwQZlFWWli+BZhVzVm30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjvsjUnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6D9C4CEE3;
	Tue, 29 Apr 2025 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745930998;
	bh=PD3YKlBC1Bbpr2lu4BJ37/z6VtTJSbnHrbJTmmaRWHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DjvsjUnNHGwHgovKXFQUA31MZpoUbFe2bK30okvx7ZG0So6NE2owMBkZusrODG71B
	 yClzkCVger/oBExxJv5ZyW59tgpUHxFcP7muke2HdAq0FF3KDldx60pd4KgNqcvHT5
	 sekyz27MAZ4K1zbAAHp+PlVU5A6KoUgT8MKsIbGikmAZqpPFCIjkKFyZeCn88NSGC5
	 2VwCHkRVYINipyVVJllgrb3HWmIclHFiEVoLWCTuZ0qkXX8RuXG31PxebA2pOs98Mu
	 YPy49XDlKTo7KFXeRdAyU5uBk1jB/uDl+Q3bcFvkkUMYXzvv9eHYVkVl8wkOEnfuj6
	 k3e7wCnAeRm7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/4] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Tue, 29 Apr 2025 08:49:54 -0400
Message-Id: <20250429004908-5ae7e56cd526b7a9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428081854.3641-2-kabel@kernel.org>
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

The upstream commit SHA1 provided is correct: f85c69369854a43af2c5d3b3896da0908d713133

Status in newer kernel trees:
6.14.y | Present (different SHA1: 7eb13e5b4615)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f85c69369854a ! 1:  74774f34e0efa net: dsa: mv88e6xxx: enable PVT for 6321 switch
    @@ Metadata
      ## Commit message ##
         net: dsa: mv88e6xxx: enable PVT for 6321 switch
     
    +    commit f85c69369854a43af2c5d3b3896da0908d713133 upstream.
    +
         Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
         info") did not enable PVT for 6321 switch. Fix it.
     
         Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
         Signed-off-by: Marek Behún <kabel@kernel.org>
    -    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    -    Link: https://patch.msgid.link/20250317173250.28780-4-kabel@kernel.org
    -    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
     
      ## drivers/net/dsa/mv88e6xxx/chip.c ##
     @@ drivers/net/dsa/mv88e6xxx/chip.c: static const struct mv88e6xxx_info mv88e6xxx_table[] = {
    + 		.g1_irqs = 8,
      		.g2_irqs = 10,
    - 		.stats_type = STATS_TYPE_BANK0 | STATS_TYPE_BANK1,
      		.atu_move_port_mask = 0xf,
     +		.pvt = true,
      		.multi_chip = true,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

