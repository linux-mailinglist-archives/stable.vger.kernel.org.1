Return-Path: <stable+bounces-119987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395CBA4A87A
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9B91758B2
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F971519BE;
	Sat,  1 Mar 2025 04:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLFNlVrE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369122C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802862; cv=none; b=O8eO2RvN60BLNO3jptDMlPulNDMReKVUuFsms6pNB3SjOPkMPaX7bVkQk7SjfTBdsJ74lh9anbB+KAMwwoqtctMwFLRn2wCdVr7RmSecRPkt5o/1G4P8skMn/SLE/jpeB+UL8XAK/nVf5rFcLFekjsRMycEhYQXiUikaMu6Ie8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802862; c=relaxed/simple;
	bh=CNmBJqjKkK/fx5AOdugPnrWZ6cGHZMpeCbf17bOlOlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fj8srU10OLupkg1CYk564TUH2j8kRz4sGfsSG24XczXh+2sFcKev2pcqQUXh9AV6yP+W1yguKQ7fjT8wurny9BJ0+rB7RUqse/h8sH6M3+XEPde9HhOh3+PSndA328ox6U3J9/bYo8qOfSHVfYtv/RjKxjp+nu1meRyGPe18bAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLFNlVrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B8BC4CEF3;
	Sat,  1 Mar 2025 04:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802861;
	bh=CNmBJqjKkK/fx5AOdugPnrWZ6cGHZMpeCbf17bOlOlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLFNlVrESo+8pAJnnRJpQalXJe+T2KciRVbnd3RZwhUpPN9Fo0DBoAkWsJSdKPEQ7
	 y9KM/e9TTFdOWlrTTwJxWs+x/XdjXC2+YX2HLJjluecnIpJCBs0MLCfEGB4fWpXVu5
	 0KN8E2FKPFDsJZnoAGP5PXPr6Uv3hdJLdtXnFUEmljzG7aEySDVC9ILLaFIdjsWTbA
	 Z+tasyXwiJBK6h/a/v0IyRklQ7DOSFgl4cA4zvyAtJsSnJQV7NEQ9rGBSbWVCfS7MR
	 T5IDI8o1g8mqlsJ1Xq95JzzmPdc59TorwHbHPuIGhp43AKN0J67/Q20U0fHAtUVqjZ
	 bP5Lt7q3rxqqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Panov <apanov@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 5.10/5.15] team: prevent adding a device which is already a team device lower
Date: Fri, 28 Feb 2025 23:20:38 -0500
Message-Id: <20250228193220-9d9c7d4fcea817b5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228094112.32572-1-apanov@astralinux.ru>
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

The upstream commit SHA1 provided is correct: 3fff5da4ca2164bb4d0f1e6cd33f6eb8a0e73e50

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexey Panov<apanov@astralinux.ru>
Commit author: Octavian Purdila<tavip@google.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: d9bce1310c0e)
6.12.y | Present (different SHA1: 1bb06f919fa5)
6.6.y | Present (different SHA1: 184a564e6000)
6.1.y | Present (different SHA1: adff6ac889e1)
5.15.y | Present (different SHA1: 32f50326827e)
5.4.y | Present (different SHA1: f29d32fd102d)

Note: The patch differs from the upstream commit:
---
1:  3fff5da4ca216 ! 1:  2cf7fffdad4c3 team: prevent adding a device which is already a team device lower
    @@ Metadata
      ## Commit message ##
         team: prevent adding a device which is already a team device lower
     
    +    commit 3fff5da4ca2164bb4d0f1e6cd33f6eb8a0e73e50 upstream.
    +
         Prevent adding a device which is already a team device lower,
         e.g. adding veth0 if vlan1 was already added and veth0 is a lower of
         vlan1.
    @@ Commit message
         Signed-off-by: Octavian Purdila <tavip@google.com>
         Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    [Alexey: fixed path from team_core.c to team.c to resolve merge conflict]
    +    Signed-off-by: Alexey Panov <apanov@astralinux.ru>
     
    - ## drivers/net/team/team_core.c ##
    -@@ drivers/net/team/team_core.c: static int team_port_add(struct team *team, struct net_device *port_dev,
    + ## drivers/net/team/team.c ##
    +@@ drivers/net/team/team.c: static int team_port_add(struct team *team, struct net_device *port_dev,
      		return -EBUSY;
      	}
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |

