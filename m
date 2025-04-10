Return-Path: <stable+bounces-132138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF45CA848FA
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C07817DF57
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF0B1EBFE3;
	Thu, 10 Apr 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5784aMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988711EBFFC
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300405; cv=none; b=qtfkkGIz3/FyZl4nUQjJxBDlbscG2xTONSg6Gu8Q7dNveD9FLx9+1CZYtv50LtOb0qUwis7Ovsxu8wO3HAWRES1ycXPsf0pNY5JhDYYAfKBEl1qB2Q7LoVZ4Wvh9/xg6UrGvcrI5VDAhkWE+GFHnOSlGHrfQMIADziVdqMvP5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300405; c=relaxed/simple;
	bh=uCr614YXqsxNVwgpXZw6z0IfyGpCOXKja7bQ7KIJDWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3sifvACbczeIsYTz1xBQMfUaTv+Mu/VRCJFE9kYwSDziCOD5oqBDo901XWNIqSrjL1duWrytNjRiO21KBjw8MGsH8UgqYysn5juRaF2fV/ZVsmfhDGCE+RHNtUnBom9vrICRy7xS5WziNycftgHoFRW3BMAG2MN+UiPGdwQhnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5784aMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCD0C4CEDD;
	Thu, 10 Apr 2025 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300405;
	bh=uCr614YXqsxNVwgpXZw6z0IfyGpCOXKja7bQ7KIJDWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5784aMn+kVka3gbZ+Muvi+RWi1qF2AyABVIIlCdq55MJpG1AWiapysLYsx67RKu0
	 MZOu9qCO6OQW1NlY9tFuahCRzXGRAEbBGpTHx6aD2eDKe6J71yPb3hnOvsb1bqm4SQ
	 jG8kqaHVU+4/Ri5oXOZ32YcBc8Qgf1fcSIZmL0ejEaP5EZ5a0/KY/zstDeEj649oQI
	 CBIjvnABB2GhcvKuBcjUEPWG4uvmw2AJXAuWR3iHdzWjHxJxR3giCk5w+L5bN+fBxs
	 cwqiEX/lJxzTHs4PtEAvAm9mtc0QgbREvWcXwwKUsdVxHom2p8cwJ/Cask0HBDqHQC
	 RCO/8RwtQWtIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anshuman.khandual@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y 7/7] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
Date: Thu, 10 Apr 2025 11:53:23 -0400
Message-Id: <20250410103455-659c9646ff1e221a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408095606.1219230-8-anshuman.khandual@arm.com>
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
ℹ️ This is part 7/7 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 858c7bfcb35e1100b58bb63c9f562d86e09418d9

Note: The patch differs from the upstream commit:
---
1:  858c7bfcb35e1 ! 1:  9192406053a3c arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
    @@ Commit message
         Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
         Link: https://lore.kernel.org/r/20250227035119.2025171-1-anshuman.khandual@arm.com
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    [cherry picked from commit 858c7bfcb35e1100b58bb63c9f562d86e09418d9]
    +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
     
      ## Documentation/arch/arm64/booting.rst ##
     @@ Documentation/arch/arm64/booting.rst: Before jumping into the kernel, the following conditions must be met:
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

