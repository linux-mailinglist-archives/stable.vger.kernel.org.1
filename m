Return-Path: <stable+bounces-137070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D4AA0C10
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B49D1B65DB4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5292C2ACB;
	Tue, 29 Apr 2025 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9wc2z84"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD72C2593
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930994; cv=none; b=uztprjGtPz9H+ZJ3qi3yQJx8WfSCONGhsxSm0HWxPqem1BM4QsitOpuKxRQRAaGleheF/nJX8wHhwySG15tQ59nYZzAASWeQGdwEcF6gnUQ9UsBDYq8b9r8zO9KafLIOsvy71aWlYVfUHok2n6zBZKW74gNvuaUd8EgQZVTR5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930994; c=relaxed/simple;
	bh=rUOdVgZByuyZnGlyh3MDC7TxIs3LFNU5i0OsHhAFUgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4bqLIH4stCOt8hcsiwKeiWtjjAll1cyYIFBdnDSO2N1Sl2PhBoDt1BNxU6a+fawVYcJzVYxWJ3Uk6AWWQMQZpkxTHXVPw4PJkMzssnGVOPXUAilmp4goJPGpxMQSvf3ifQ4GdMl2YWF/Gi1OqWtNUfHlOc+DZ0tt0zB/s0BMCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9wc2z84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A220BC4CEEB;
	Tue, 29 Apr 2025 12:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745930994;
	bh=rUOdVgZByuyZnGlyh3MDC7TxIs3LFNU5i0OsHhAFUgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9wc2z84C1rIF3Y5FNl2donqmm4pyN7+oruUdSy6yGZHfFsxkDEVadNjlagktFlSb
	 SqS8FRVPNxGYfmDl64ImuqXERHddUMy/VPvQnf+5lKCDh2WCR4nhpM4eV3dTRY8Wrw
	 u3VmHJ0GTSev3S0lvcv9Y2xS6ThJ/gF0mr9hclgd5WePEw+m1pNYQKo9DH9KtwZd7w
	 9Ak05vuX5de69xXPQXvz7UEecdjgvFXkmyj9takEZ1WozCt9QEuFng+XAyyN2VVENH
	 SU4VbQmC0iBNeqgKPtwvnXNSOZOIK0i5/QrQm3wSVB86NXKUHbkjxDFgaK4O73BBIX
	 E276lEHPB/aFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 2/3] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Tue, 29 Apr 2025 08:49:49 -0400
Message-Id: <20250428223512-24397f463c31b347@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428084916.8489-2-kabel@kernel.org>
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
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f85c69369854a ! 1:  a6896c73ecdf9 net: dsa: mv88e6xxx: enable PVT for 6321 switch
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
| stable/linux-6.1.y        |  Success    |  Success   |

