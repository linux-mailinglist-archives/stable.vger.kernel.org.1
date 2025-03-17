Return-Path: <stable+bounces-124632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F855A64EAB
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 13:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8588C3AE0D2
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BBB239096;
	Mon, 17 Mar 2025 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI28MNuk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590CC238D5B
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214249; cv=none; b=PemAYkD9IyKf6qziBZQQZ7mtTX9XATEMMqQEqlrvKeCyZSjK51+9JPcJVQ2yAOnNFv5cvtt9KsA7pGlowZrGsUnXU7pqy/kXaZ8dm/v+zwzOYRSb2FGWWcOqTRwKwphprGteg1lO7hh4o1Engq848BQPcr6ms8FvOi8uKbZ8yoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214249; c=relaxed/simple;
	bh=9/fqn+y3qqzDn7rlqOIp2H5LA/i/XOZ/UM8t8hlcihg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBLvDK7X4rnSZGYbEwa+l/1iRDiDdVRrc4xasH8GFiYlLap2mmz2vrAXvb47vdY20tg/8c7tQo072m/IBbB10wfAJ/k+ZkBYidyiOTqI2RAxXC681T57XkJTTPG5TgVE8YfTlm4H3MFBKIAa4+4/xYhfse6jh0pNIkJGS+sdlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI28MNuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4009AC4CEE9;
	Mon, 17 Mar 2025 12:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742214248;
	bh=9/fqn+y3qqzDn7rlqOIp2H5LA/i/XOZ/UM8t8hlcihg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bI28MNuk7VLXWiFBDoilBHYdCekMg6O/XTYTphtnFOIoW7ma9/pWYZG+mMGdGjV/Q
	 UD4eBfMS1l4Tic38eNY0fmPm7VF8PkmN65IgAiTHIIMRwO4vTH3an5U2GNpkyTwAI5
	 yK9AmuR+0EAtqqxdsYeoRP4IBuz/tMQzJ60Uue5I122aJI2W/arQ5mm9d4txkPY8t1
	 gj+vOxYmb17vrq6Jcps4Kr9RVZFgxP/4LDy7dHxr28IF3S1QW70Z4oPfTZa0u3gAJD
	 0vx3AVLQkSX+si13+mR8G5xUot85Zp55TROfz2xcW/h5PdYBsQf9Zv1d0XOivHLb9C
	 cCmOcID74NJDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	arighi@nvidia.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
Date: Mon, 17 Mar 2025 08:24:06 -0400
Message-Id: <20250316150913-6ff46fbd4a74ade9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250316131821.44867-1-arighi@nvidia.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 9360dfe4cbd62ff1eb8217b815964931523b75b3

Note: The patch differs from the upstream commit:
---
1:  9360dfe4cbd62 < -:  ------------- sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
-:  ------------- > 1:  e6f4df3e8bc2c sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

