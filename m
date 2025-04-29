Return-Path: <stable+bounces-137082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2CEAA0C1E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3724D7A51D8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271CC2C2585;
	Tue, 29 Apr 2025 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC5oCmZv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE642701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931044; cv=none; b=aEthygyQ5Sztoe1V4H6nZk4+sXm7CackfvYH9BNOEMX65k264JuvXs3NcwyNppcdc5UCytruav8O7nRInZzEL5iDxO1VI/g/uH0adJenmDl5/uoKrP+Nj/1xxTK23LL5okgc79vxlQT5q46evsgwHMnPSDoPuwJz9uf5oapQxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931044; c=relaxed/simple;
	bh=J6wRspDOFyEG4lmKDS8+NY+JlzpHKfqY78iGztijsvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OC32C8S26EDnLb6uWZsWvuNCFE4NJhinAQyMdd0x68HeQ4/oKbiufgWaGBgndSxWGF1RGBM5EH6ifijuZBCv768H24g1wHXb1qWF4asxc2T7kF6WbxE2ttUdP8Lcvl2ximy2Zq2oJ9yJl1qANt1422PDtLajerk9u+N2p3jYru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC5oCmZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B7AC4CEE3;
	Tue, 29 Apr 2025 12:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931044;
	bh=J6wRspDOFyEG4lmKDS8+NY+JlzpHKfqY78iGztijsvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dC5oCmZvVmQV1xpY1J4eTtYKhWuPhB1TOYnfM54xiHFHfHI1UWCxqi6LhfO02xMZ8
	 4EqRLXIzXmGBXz8sfyxRwxvmGNcWnRltbfgDYj+Mk8/bAUbkIVWiDtNWalGe7xXB/Q
	 nDHMU9mtX18YZkP7QjLTwCm7nPNHeuUjnbVUAOdJo9R9Z4McHxPr+a11XoAaSuiT7I
	 SbtbdhdYSkM3SPT6hvz9yR2Q4sS+O+UJL0ExZjB+ddVH1jlKu3X9DMFTssRQfy6Zfo
	 vAEnZfSUlUM7ZavqCfQe5Eeu3WM40Bx11CdPDI8T5PhVxchRWr0dzsx/j8GTv7mErh
	 YNhfo+3h8ZMXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 3/4] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Tue, 29 Apr 2025 08:50:40 -0400
Message-Id: <20250429005326-e61b5d3cf417063c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428081854.3641-3-kabel@kernel.org>
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

The upstream commit SHA1 provided is correct: a2ef58e2c4aea4de166fc9832eb2b621e88c98d5

Status in newer kernel trees:
6.14.y | Present (different SHA1: a0898cf9a38d)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a2ef58e2c4aea ! 1:  2746495add794 net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
    @@ Metadata
      ## Commit message ##
         net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
     
    +    commit a2ef58e2c4aea4de166fc9832eb2b621e88c98d5 upstream.
    +
         Commit f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
         did not add the .port_set_policy() method for the 6320 family. Fix it.
     
         Fixes: f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
         Signed-off-by: Marek Behún <kabel@kernel.org>
    -    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    -    Link: https://patch.msgid.link/20250317173250.28780-5-kabel@kernel.org
    -    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
     
      ## drivers/net/dsa/mv88e6xxx/chip.c ##
     @@ drivers/net/dsa/mv88e6xxx/chip.c: static const struct mv88e6xxx_ops mv88e6320_ops = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

