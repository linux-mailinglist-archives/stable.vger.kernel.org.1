Return-Path: <stable+bounces-145686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F189CABDFA6
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 17:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4433F4C0564
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085C92627E5;
	Tue, 20 May 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIY+taZG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48122D9E3
	for <stable@vger.kernel.org>; Tue, 20 May 2025 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756338; cv=none; b=ObA6+wnhGdi8554TCLNwQdnyQQZG88M3Km/k7HoTBc8P8X0FRVyyDKHfAHyVknoyxoiHNhM/XGuJRra5OL5UVObHW3FoiCwGkQu27XGWBFj/9iXOGJGAyxA8DykWUjk7dwS5k0KftOxL/o2YlKMMM+78g0aDfHdGboGVkDDBLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756338; c=relaxed/simple;
	bh=VW8Y6gEW+IpgNV8LUEXVvdbxy1S9rgt1ohuFJRwqlYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azzpo0fat2zdXRk7TNjtJpyKOYhAzH9Iux4tlMoRsO8ht3zeB+4rckBWsaS9Nensa6RkUucQj6bolbV8BzGnZlJsu20iVjqZVQTr4vqhqHcU+GLlDFCAJG12npuzKwU9EedFHZTBLNEC8W6DWxFS1WujE0ts+sdjC4GRerRCjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIY+taZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E2EC4CEEA;
	Tue, 20 May 2025 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747756338;
	bh=VW8Y6gEW+IpgNV8LUEXVvdbxy1S9rgt1ohuFJRwqlYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIY+taZGIhytRxKSQg0G5waMKqvwrlNbfCS3TTM0r73bGBdMLDn7z35j6ji/nrE0y
	 QBaON4vt3x9c6OHfBKj8zG1jpNRbH+JCXTHk4BNYieqKiMbJ+gZ1EuL2rMOs8ftrnT
	 BUx9RSNSmG5Z7NlVkTForcT45A9xc1nYybib3B6EVEvdPKSuLJOKAYqHTSPIqO5xKt
	 O+9zGIxgxPHly7QZK/Zk2lGqR5e3MWqwRj4pRiXUYBV8+OUY5yW8a3NYMfZCTrDtDe
	 /wSHgk68CJv4Ww27Rgpys6/CjCZOl1xdArwb2rHWlEgB7TBks95iudfwkG0lX3Icu1
	 6HjC0ZphfQpwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net: decrease cached dst counters in dst_release
Date: Tue, 20 May 2025 11:52:16 -0400
Message-Id: <20250520115112-ad13b07a8a439271@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520082931.1956136-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 3a0a3ff6593d670af2451ec363ccb7b18aec0c0a

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Antoine Tenart<atenart@kernel.org>

Status in newer kernel trees:
6.14.y | Present (different SHA1: e833e7ad64eb)
6.12.y | Present (different SHA1: 92a5c1851311)
6.6.y | Present (different SHA1: ccc331fd5bca)

Note: The patch differs from the upstream commit:
---
1:  3a0a3ff6593d6 < -:  ------------- net: decrease cached dst counters in dst_release
-:  ------------- > 1:  331011557e401 net: decrease cached dst counters in dst_release
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

