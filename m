Return-Path: <stable+bounces-137076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC400AA0C16
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7D5843AF1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F10020E023;
	Tue, 29 Apr 2025 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGEOVqfy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB002701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931019; cv=none; b=OIThRk90zPWmZTWtARHv/Wfq5vRqhZIHCaY1WmegQY30R/krJtkrK/ueLMxHmcgZIgY1g/qNf9FQFtzLwrBDL7e1yk/ySt96fW16WemF5+4u9uco284bLZUFxhCndDQqUeWyb33I+56ENN6s26teewq2dMZpv8h+hXbZLFoFoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931019; c=relaxed/simple;
	bh=NwQzBFAn1NXUgjV2uEUsqnR4SDackyTAr12CkrRurVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kisM38ZQUXuJ/woLadmPATjFFzPIYSQEicmNlniYL6WC1PWc6VFYd8OB+ArmbWnB4OvdBAXue9vtJsku3Iw4lWrUmnCJIC9Qu93+FbSDwd26PAfq4ML1bRrUuHen0pX+VGtOpSuCQXztQWzVk04q6/PAC3LCeDMgR5GDj5t0I4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGEOVqfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84947C4CEE3;
	Tue, 29 Apr 2025 12:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931019;
	bh=NwQzBFAn1NXUgjV2uEUsqnR4SDackyTAr12CkrRurVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGEOVqfyIOw9mKIL6Zy99MmjmBYx/0lWKOdG0yrH0RMHGyKlpOEJLmkQvZUd7rKSd
	 B+5QPodhH7DU4C53uNPgv+G0craXeMptJSH90OcJMtRT4kW7xaiMtruQ24L7WisDgS
	 iFYWv1sFj/MM4vcXkXU6R1VYeyE1n2+EuEQUWOCr7LSaYqtx7kp/ZP0ipqgcjK3w++
	 4HaexOKIcYE/QZKCUXovFRIx+Z2ISyp+RkS3ZG47Oy1fhdOzfavA1wEgCpKEskbkma
	 azE7S+cpLcEQFMi+rXJEoS7oyhGekVpKUaJVfEc08r/EwRjIOaH1vWus9rpy0SDsnC
	 Bx8BCQ9Gb3fFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 4/5] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Tue, 29 Apr 2025 08:50:14 -0400
Message-Id: <20250428220636-9daca0f15a8b604e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428075813.530-4-kabel@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  a2ef58e2c4aea ! 1:  b90c39215fbb3 net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
    @@ Metadata
      ## Commit message ##
         net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
     
    +    [ Upstream commit a2ef58e2c4aea4de166fc9832eb2b621e88c98d5 ]
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
| stable/linux-6.14.y       |  Success    |  Success   |

