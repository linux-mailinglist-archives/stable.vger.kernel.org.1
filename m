Return-Path: <stable+bounces-124825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331FA67763
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DF03B9FC5
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDF420E6F9;
	Tue, 18 Mar 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi9OwqTk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574E1586C8
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310781; cv=none; b=WmhxcGf0I69xp1KzbakmnUgXtOxe2afODrC6FAyDhU8P19E4AAFunY839xWaDS6hYx9fqSoJV/RYUaxscTJqrqmGtih91zfyShxPsI6jMTIbQCUgmxL4wO7LiKuh6rOiGH1yPJjAiv2R1M5yE8L2iVNgUBugGtasaNTiPvM+P4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310781; c=relaxed/simple;
	bh=yVhGS7pzeL+zqhDyUWy5816hq+xJ61bvY4JMY0D8O98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyuphorUaiKQGMDeGdCLdiGkg0k70qBiqa9fMnjINItwNi2ZL6lvRYR9asuW9vBHo7tq9VbsMSQzRrUCFKYi7ZxMwCtrUstcyP4T4dTsZh5n7k0gasCbm0prE/4MHbCcjtoOPumDpg2+/tpfy1XXkC9anMAqkhR9eT0LuuyexTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi9OwqTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFD1C4CEDD;
	Tue, 18 Mar 2025 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310780;
	bh=yVhGS7pzeL+zqhDyUWy5816hq+xJ61bvY4JMY0D8O98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pi9OwqTki9QYAsXUI15Ndg21OpFso5aQIxGV+4ALbFhc9g8iRlcNWpxcVOM0HO6xB
	 ov9GVqutXwenjwP/ZYevTL0ifAZeGX3IKwWEfPkoOe3FZbkyeJr3s23Cqd1u73ONGR
	 VbyVRn+WKdDL30ZpZSCJOrn/Msyx5yyPui32ETW9mt9B6SmAlT/aaxmE578MU/jvdT
	 PZ9zpfkp3z4ndVL97GSwfBaUVkdoAfheCfOK5ll8xNdvNIuPHs44Z83Hw/75jGD0ER
	 39U2x9qQ/YAai8R4rT3IzkPzrlqjnfcvCy/qyIo0paDvDtewtRiIeVLXe41o1bSm1E
	 7XPLps7gu/zoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/mediatek: Fix coverity issue with unintentional integer overflow
Date: Tue, 18 Mar 2025 11:12:59 -0400
Message-Id: <20250318083858-1b355b0baaaae6d4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318011519.3924779-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: b0b0d811eac6b4c52cb9ad632fa6384cf48869e7

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Jason-JH.Lin<jason-jh.lin@mediatek.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 96312a251d4d)

Note: The patch differs from the upstream commit:
---
1:  b0b0d811eac6b < -:  ------------- drm/mediatek: Fix coverity issue with unintentional integer overflow
-:  ------------- > 1:  81185a14fd7b0 drm/mediatek: Fix coverity issue with unintentional integer overflow
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

