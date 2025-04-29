Return-Path: <stable+bounces-137088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A961AAA0C9E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40697188DFDD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3188E1547D2;
	Tue, 29 Apr 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSpWgUyY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54108F54
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931667; cv=none; b=TpW48NX4/OiCYf6OB8LkJgfLmNAiYef55GfxpZnaG7kBh/GeeEnJNvmpb+0BteU3hgf3cfMibQlftrBJwfaaY8ECrCG8jUAsgrxQyXYAHH5qhkn3sZ/IWiPQVjUxeFGv3UwyhK5BLA/SRDliq18HqMCRzYomWIySSpqH/ZYM+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931667; c=relaxed/simple;
	bh=vrJgOJNsQs1rGAr7bgGiQXigLatWq7QcPl1hgipP5Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zj+85U6UrFdcZZcOOjLLcAuGpDVetM0leVoqkbHmrTwQKlCIJYMkdmpxxn+HMHuvKCXrmerecHDFAiugv3aZQB9P7zqQafV+mbOksmEoabrmrOIsadLm6iyXruueGv0DrIvMVm6WeMPKmX2kZYuEROy64NQsXt6TfsWtOyTa2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSpWgUyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA08C4CEE3;
	Tue, 29 Apr 2025 13:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931667;
	bh=vrJgOJNsQs1rGAr7bgGiQXigLatWq7QcPl1hgipP5Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSpWgUyY6wK7ptBQjgYSnO6DhExjTBvz76IumO0lw3WC0xJjAq4OTwAd3wJt/tvwT
	 5xBEzZdRTGwHLgzSUxuO3J+vLNgdAfJehntmAi2gRR69Xbva1xFsMz4+Dk7e/Zbv8l
	 rJTOPv7/D0WRbJtED7RSAl3Q5xwRQ2TWGulqurX405tRXP8r49plada17wSVOk4w0S
	 +rnZks1euI43voN3qsaToVQ7nYhNEjnz/sip5ByZwLJvu5QqGqqzuA+s8q/GJxscmb
	 LpPaAIzPfryobh1+aDzi/fgG1OOgaRJMI4fb5jgqYbGWF0DigN14eVr2wUlzdlqASP
	 5s+w+LeXmw2fA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/4] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Tue, 29 Apr 2025 09:01:03 -0400
Message-Id: <20250428221344-11bfacb9bdcb5858@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428082956.21502-1-kabel@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  4ae01ec007716 ! 1:  479a2a839e0a2 net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
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
| stable/linux-6.1.y        |  Success    |  Success   |

