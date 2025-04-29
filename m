Return-Path: <stable+bounces-137065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B64AA0C0B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE4F1B65BBF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5F2C377A;
	Tue, 29 Apr 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsBB5Jna"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864A2C3770
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930972; cv=none; b=L9+ie8RAuMZMXAjMLaKpXuh8B4WgPlT0K4bG0SNZ9Wz1JAFo21xw1pv9g09dGHCRaFqXESZUnpSHqF36VyxPVhdnY6ANW6xJ1bVrE5lDnzotNLeZna7sGpJ6qAjpr+JA9OiUUw5s4w/X8+qqI1llVXULu4gRvA/NuMJmlh26mpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930972; c=relaxed/simple;
	bh=W+AZ/UohmghsVvpLwFOe27bNo2brt9b7hMVZsVnOGwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOQZudWPrGmQMBcPbZQSTjni82Sv8aNNozBQSHMTtfhKz2qBXfZx5M956kw+Foii6VN6qspH0ybRofnOhnt0MlUUhtWZ666Blff2h7N4zsPxsPyWSKVJ7sci5tdDNk/qCMlGYct2d+KtxKQ+GYocQzZPkpPqHcZ6dA17NgmJxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsBB5Jna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A625C4CEE3;
	Tue, 29 Apr 2025 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745930971;
	bh=W+AZ/UohmghsVvpLwFOe27bNo2brt9b7hMVZsVnOGwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QsBB5JnaksO++5rdhvHjHAkBuh0rN3QxwozhAeqOcvJqjKG6XXyav3Uu+qh7hQQiI
	 aixMP+RnQuTpW6dbeaDAZlZK75Ios7JuAdQyLuA4OzSujTsLhJcr9akrzAvJK6UniX
	 wcKMjpX2bIqVhfuL0PWLj40EZYaAalX9XOjWSnjSMzcG8WvfvEtyBTjZjyzjp+Dxzc
	 TyThxfSlIQ1OzUmnYjtSSmfAUB4xUfUBkbyYrjFDkLzkB3U66R25OUPXkd8LivmW+/
	 Jf8CKV006QU+nxI5kMcKQ+jFzkyXrP502b0e7L2P1oNJQoJjZmVA6mRtUYCRavcLdQ
	 o/KeH/CpPeB0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 3/5] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Tue, 29 Apr 2025 08:49:27 -0400
Message-Id: <20250428220408-bf56516ab125fd9e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428075813.530-3-kabel@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  f85c69369854a ! 1:  7f8de8bf4f5de net: dsa: mv88e6xxx: enable PVT for 6321 switch
    @@ Metadata
      ## Commit message ##
         net: dsa: mv88e6xxx: enable PVT for 6321 switch
     
    +    [ Upstream commit f85c69369854a43af2c5d3b3896da0908d713133 ]
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
| stable/linux-6.14.y       |  Success    |  Success   |

