Return-Path: <stable+bounces-132139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE5BA848E9
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B871BA1470
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E845F1EB5EA;
	Thu, 10 Apr 2025 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUoyhgDQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDA1E9B38
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300408; cv=none; b=dDdkmyMxFc/ZtZHyD694B07G44DRQd/cYrPDiX6GFSiskZ7Kf10RyMXExp3vdz6RX4XjpiYqWDJTNep09TSUaRrVItsot/S7CbmmWdEBKgRnLXgO3UoTHH6k6U9GJpp5AqRYAdbpQmfVW56RQ6/B5mENZEZDVQ1Wxp3eWp8pGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300408; c=relaxed/simple;
	bh=iyiWZg03hTUGCBx76FVHeGaRorvvtExZbMQThsvgflc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHCirgx8oux53tfpOugzBmu1fBHTGTQtbG1vuF1piTtdyymOsbCo1vNh9YHo4kXCA3qP+fmzasKcJsqk7wkQn9q+mEqA+P+6HJkgmozkkaL98yr5PCrDRlDEMQS/UnVpDAa5+0XiZr0MeVdRCQVxxkzz+CjS9SJLb/uYe0Z1VSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUoyhgDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00313C4CEDD;
	Thu, 10 Apr 2025 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300407;
	bh=iyiWZg03hTUGCBx76FVHeGaRorvvtExZbMQThsvgflc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUoyhgDQSjW6fpbns+3wCu2iMAJzcioqNWA4lFiAs4F8zHbevg8eMRTf4RqRP6ngR
	 PObyQWCxk9/lwa17jZxBRbE/301rhob7uVWsELFJS9O/MJ49UmurkvND9xoq5jfSZO
	 26TgrjiBLoSftjegdiLwRKt869aa98p6M+mTpKcJ5icDqKyE4P9/ZLfLx/LJ3UjyMl
	 gTb0GkAPbrmO5/iK83JVzKy/Mr/MKhT9JesTGZH47PMrg4Wi1KfM0lFgcQxdyrZPm6
	 OVOrNvR7FA39cd10wIcJBUp5WBv1Hnm2tBn4BHaMQW56DiIyDIkr+F1dTfs8so37ZG
	 wc8T29z5yp0ZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y 3/7] arm64/sysreg: Add register fields for HDFGWTR2_EL2
Date: Thu, 10 Apr 2025 11:53:25 -0400
Message-Id: <20250410100810-a16fb40afd6d2dc8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408095606.1219230-4-anshuman.khandual@arm.com>
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
ℹ️ This is part 3/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 2f1f62a1257b9d5eb98a8e161ea7d11f1678f7ad

Note: The patch differs from the upstream commit:
---
1:  2f1f62a1257b9 ! 1:  bbea5f070eb57 arm64/sysreg: Add register fields for HDFGWTR2_EL2
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250203050828.1049370-4-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit 2f1f62a1257b9d5eb98a8e161ea7d11f1678f7ad]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## arch/arm64/tools/sysreg ##
     @@ arch/arm64/tools/sysreg: Field	1	nPMIAR_EL1
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

