Return-Path: <stable+bounces-137091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F8AA0CA0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DA418905B4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE563987D;
	Tue, 29 Apr 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgZtXR4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061C3C6BA
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931680; cv=none; b=f32ONLxj9T6GpEohjsacpmxNhc5XrycSIU6DA8G8ktNEEMMeCKKQoaLCn6STF8rxjtr+KWItMojdf+vBLGmWcUtyAuotkT6BdCCOuSQmtIsmSPq6ROaqecJj1imdnd6KewokZIatkSH81XstRnobYWHKqXKPrlPv0PZNCoKq9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931680; c=relaxed/simple;
	bh=sHAcuFN4wPCy3cht6f6VVk3rpHKbaWus63gZVbkfzGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avUB1Eyo7ha+SFnDrOtY6hRAkXhIiRPJao3TsH1+GqlM7rmLv7Jt7+G8Mq5EgSAIo5iW4WG3evYZfPKysYdfSKFr+e/DnRyrJ+Fvc7HMZDlhSATNGipfL5ss7rvu6gquFbUGGjKyh4UC7IwUaS8af9MknbToYvrARpVc2x4SH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgZtXR4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61452C4CEE3;
	Tue, 29 Apr 2025 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931679;
	bh=sHAcuFN4wPCy3cht6f6VVk3rpHKbaWus63gZVbkfzGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgZtXR4h5xbCpAozsXKnX9Iy1+qS7xmkmzbYANiPCtq/Wr0OiRUMnmV1OjLgJFr5n
	 b/YPnSptnWE647gp5bHGz6yXaooEIBFlacpL+OZdjIqSWo+GOV3b+CXLp9IeaoZzCF
	 ttiWIjy29OvE+H/r57yZZz8eM6Q9INBsEXbZFHhtCXJxFNzkOM4Semn8iYyP4b5949
	 /dvnJY3NBULeieFSt8vT3KoUX9t0let0NWDsFVACMztiXXJQMW9dIH1HL8tJs794Ld
	 pu8t7+m2fUdYF1B/R/Fs4sTaZzJYfqCYmxuISdV5XKoiP4+3WE+9SurpkHqNxIeMzk
	 UlD7/v14fbrvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/4] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Tue, 29 Apr 2025 09:01:15 -0400
Message-Id: <20250429004451-c40021c9ecc951c2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428081854.3641-1-kabel@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  4ae01ec007716 ! 1:  90598ff95c9c6 net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
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
| stable/linux-6.6.y        |  Success    |  Success   |

