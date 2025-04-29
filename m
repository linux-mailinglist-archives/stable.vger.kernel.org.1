Return-Path: <stable+bounces-137089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B2FAA0C9F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 15:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BF5188ED31
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 13:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA7515747C;
	Tue, 29 Apr 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUAWYEOy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC8130A54
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931672; cv=none; b=kwgOEWaWIz8NFReAuX+1O7WlPSftP5ugWAEbbud3zgsTdqzrvIahu7Qny1iQGyBPYzj1wajUJQKDReU2CHsezz8OaGnopwEf17rfPnd56xr2Fj+1XrlISCimNUkYYOQfeKXdWd3DpzK6PA3VSmjqPhCtVB15FdP78bLBtWQNdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931672; c=relaxed/simple;
	bh=v41Etv/7JdBocAJHdF4JedcECi5I7yOq0peQxRxkhz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltuQS/wj8vCFdLSdJlZoBvTO9pNiInFlCcEWj4Ca3hwfF6LDvqf5KYVqycHKxERqy+7820bxoLMcBXQJtYwvdgOuNSctfddULdfmwBUlzPVicxhUGlaL0mifdJUT9Y3IK5lTJ9ejS47PwPpcSeEzugiTY8ev7XqyKfcZzBmSaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUAWYEOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603CFC4CEE3;
	Tue, 29 Apr 2025 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931671;
	bh=v41Etv/7JdBocAJHdF4JedcECi5I7yOq0peQxRxkhz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUAWYEOy5ZWgUneiX5KNTlcCVv+3YCx5fLyc4PE+NI43eGZM/l6m9IkiObjyiVdMJ
	 PNkaW1xxo1f+QuuzKxdj+E6/v3qR/RBGVZ8YyVog6jxr+XNO6X11uJbZFTWc2kRmse
	 RV9ZXoHr/XlrJKAKLXlLQDObOKZmwv9YuYJPdXtLN73jdw3VOVZx7Fs61zYc3aspXu
	 PklBnv+P/xxEmNKc5tT5JLMGzrbGvu26P//ogZJXfxektIK1VKxmVmDUk1tFxLf4+d
	 tM8p64400GEx52TtbuOQAM6Oi6obqKmMqReV+/UXrafpHtt5QJ31odCZRsLc0nmvzR
	 z3SZ7+ZcrElVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 3/3] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Tue, 29 Apr 2025 09:01:07 -0400
Message-Id: <20250428223917-b22701fd569f6336@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428084916.8489-3-kabel@kernel.org>
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
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a2ef58e2c4aea ! 1:  0730fa59a0c25 net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
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
    - 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
    + 	.port_sync_link = mv88e6xxx_port_sync_link,
      	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
      	.port_tag_remap = mv88e6095_port_tag_remap,
     +	.port_set_policy = mv88e6352_port_set_policy,
    @@ drivers/net/dsa/mv88e6xxx/chip.c: static const struct mv88e6xxx_ops mv88e6320_op
      	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
      	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
     @@ drivers/net/dsa/mv88e6xxx/chip.c: static const struct mv88e6xxx_ops mv88e6321_ops = {
    - 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
    + 	.port_sync_link = mv88e6xxx_port_sync_link,
      	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
      	.port_tag_remap = mv88e6095_port_tag_remap,
     +	.port_set_policy = mv88e6352_port_set_policy,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

