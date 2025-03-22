Return-Path: <stable+bounces-125827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA59A6CCE5
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 22:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5441756B9
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 21:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976A31E51EB;
	Sat, 22 Mar 2025 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG8xA+r1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5895886338
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742680312; cv=none; b=I2o/nMka5OK77CLS7UW5OFPK4rpWI5BmFmshVrBx1xUWIVsstLbH6eLNgKZM4j/dKbTcLtPio5N/BJb+MxqfiQARW109+tBomWEdy00VOEZ+OCDO5rovoNliTV2b+xUHofU2jog3GYEqF4lF3Amx0M38SSwXH0A27l8nZNOoDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742680312; c=relaxed/simple;
	bh=ctDeZY/KqwGDnXObLyk/YskYry10beSAszsFB/azwJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aL7OBYbSKMRO1nkt9QQbLqVqlamVBllEB64LnjsmytebFTQF0e7gg+JJBaCd4wg34vhjRHNO4jjsQWOKhvE9cRlDhY9nzX27lbu3WMO7rPAVR4HkzMeBXWbVwkxpfeAgec4huntrRvYQo90Gu8Cff6ZzZIaKgGOGOxmdysPKS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG8xA+r1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C280AC4CEDD;
	Sat, 22 Mar 2025 21:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742680312;
	bh=ctDeZY/KqwGDnXObLyk/YskYry10beSAszsFB/azwJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iG8xA+r1zPNqdjxLfWsMNVee9WiUBk3T5gjZO9s/0bG0FYP68AtnvbYWpbse7vY+H
	 7tMpWpJhZNOrDTMzeNvh2OZzilaHDLeF3cENf/EJxl01sfEBb3lcPCNSiVVi8TDmtK
	 Ghcqw2MIstgy2dfsyCVoxt1DLp6X46n4sCV0Nj0lqTXMcEk9rLebNq4ttt3GuZu9lJ
	 LzlaKxfyF8mVRnTZ5NKmZAMfs+17RY+OhoMel9+Vtyi6D6gY7QzAMLW5Lzv6l+knZv
	 Qb0ebWfmo+YWDeeJNRnFj8MbWS/D7erbsTyTM1NgqrNIm1MVn2UMoIRB/8Q8P4RAvi
	 jWfP/zosaFrjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function
Date: Sat, 22 Mar 2025 17:51:40 -0400
Message-Id: <20250322094727-d0aad0626788f0af@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_AEDE0F1C493C6B7F1C1E18D586255ACD9A07@qq.com>
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

The upstream commit SHA1 provided is correct: 045a31b95509c8f25f5f04ec5e0dec5cd09f2c5f

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Miaoqian Lin<linmq006@gmail.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  045a31b95509c ! 1:  e3c2c38253c60 phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function
    @@ Metadata
      ## Commit message ##
         phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function
     
    +    [ Upstream commit 045a31b95509c8f25f5f04ec5e0dec5cd09f2c5f ]
    +
         callers of tegra_xusb_find_port_node() function only do NULL checking for
         the return value. return NULL instead of ERR_PTR(-ENOMEM) to keep
         consistent.
    @@ Commit message
         Acked-by: Thierry Reding <treding@nvidia.com>
         Link: https://lore.kernel.org/r/20211213020507.1458-1-linmq006@gmail.com
         Signed-off-by: Vinod Koul <vkoul@kernel.org>
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## drivers/phy/tegra/xusb.c ##
     @@ drivers/phy/tegra/xusb.c: tegra_xusb_find_port_node(struct tegra_xusb_padctl *padctl, const char *type,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

