Return-Path: <stable+bounces-148240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED06FAC8EB8
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 14:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316E2502BEB
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0778125EF99;
	Fri, 30 May 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW7xYIkS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2423024D;
	Fri, 30 May 2025 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608839; cv=none; b=NvqQ5nMU0PK9NyXVbrbU+WasG7/5hw4kkVt1yFznK2BSxW42i/zTXGK/xxGDJer5euHj5B5cdlyF3GU0UNACSadrMaTEj4eJBqBX2OJvIWTH41mOFGi44xP7Nn641jiN589CgjZOVUMjb4iqVgknjX/cW6h0i6ByQjuBUw4Q5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608839; c=relaxed/simple;
	bh=uCxD+eksescoDfXConVH1/D8OmnsdjZjQ4VVXaywoPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCMhmLPkLPLmmJFa6GdaI9s512shFSxpZaKxnK+l0WVJ9BFhdXhtBW7DzlVr+0JBHku9pv7dVMs572zW/VA/MTs/1cHr4DqSBS3DN5ZhiUWWOJggGx9KS2dsMUOjrpPuf0i6ZwtFM4Gl8Yn+1RFw/9GgX19OZYrVSk3lXpEEp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rW7xYIkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFC3C4CEF0;
	Fri, 30 May 2025 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608839;
	bh=uCxD+eksescoDfXConVH1/D8OmnsdjZjQ4VVXaywoPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rW7xYIkSxKmsujtyChLsCf8MDbDNrih4WdQ0Su5RMv5n8iU1J2TjcQShrP6CF8tRw
	 Pk7UM0ciQSBYTws1tIvk07M5o//eDVfTxcoBy6GhDGAYPiTUDli9r0xBBSWUwJc3oz
	 WnTIOxclLOGYguOnBR96IzfKcPi5OBryStrLLe/hLIETAh1nm+OavYbsR0f92XEwmf
	 UcBOvb3U7OBpzl8y4LMt3thdVR4bgNytP5ZjPMmQ4Cc+viEMaYNqHMdiYYXV8XE0mf
	 fyQ/mLrRI4H4JcaBqxGmXQRZVFtNPIJ2HcZ/76tzSlN4mMYVYcedngBuMiPVEEW0jo
	 6+LscMAiGgHjg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	alsa-devel@alsa-project.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 20/26] ASoC: tegra210_ahub: Add check to of_device_get_match_data()
Date: Fri, 30 May 2025 08:40:06 -0400
Message-Id: <20250530124012.2575409-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124012.2575409-1-sashal@kernel.org>
References: <20250530124012.2575409-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yuanjun Gong <ruc_gongyuanjun@163.com>

[ Upstream commit 04cb269c204398763a620d426cbee43064854000 ]

In tegra_ahub_probe(), check the result of function
of_device_get_match_data(), return an error code in case it fails.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
Link: https://patch.msgid.link/20250513123744.3041724-1-ruc_gongyuanjun@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees.
**Extensive Analysis:** **1. Nature of the Bug Fix:** This commit fixes
a critical null pointer dereference vulnerability in the tegra210_ahub
driver. The code calls `of_device_get_match_data(&pdev->dev)` but never
validates the return value before using `ahub->soc_data`. Looking at the
kernel tree, we can see that immediately after the assignment, the code
accesses `ahub->soc_data->regmap_config` and later
`ahub->soc_data->cmpnt_drv`, `ahub->soc_data->dai_drv`, and
`ahub->soc_data->num_dais` without any null checking. **2. Severity and
Impact:** - **High severity**: A null pointer dereference in the kernel
probe function can cause kernel panic - **User impact**: Systems using
Tegra210 audio hardware could crash during device initialization -
**Subsystem criticality**: Audio subsystem failure affects multimedia
functionality **3. Code Analysis:** The fix is minimal and surgical:
```c ahub->soc_data = of_device_get_match_data(&pdev->dev); +if
(!ahub->soc_data) + return -ENODEV; ``` This follows established kernel
patterns and returns an appropriate error code (-ENODEV) when device
match data cannot be found. **4. Consistency with Similar Fixes:**
Examining the kernel tree reveals that other Tegra drivers have already
been fixed with identical patterns: - `tegra30_ahub.c` already has this
null check (returns -EINVAL) - `tegra30_i2s.c` already has this null
check (returns -ENODEV) This indicates that tegra210_ahub was an
oversight that should be corrected for consistency and safety. **5.
Historical Reference Analysis:** While the provided historical commits
all have "Backport Status: NO", they were primarily code cleanup and API
migration commits (switching to `of_device_get_match_data`), not
security/stability fixes. This commit is fundamentally different - it's
a critical bug fix that prevents kernel crashes. **6. Stable Tree
Criteria Compliance:** - ✅ **Important bugfix**: Prevents kernel panic -
✅ **Minimal risk**: Two-line addition with well-established pattern - ✅
**Small and contained**: No architectural changes - ✅ **Clear purpose**:
Prevents null pointer dereference - ✅ **Subsystem confined**: Only
affects tegra210_ahub driver **7. Risk Assessment:** - **Regression
risk**: Extremely low - only adds a safety check - **Side effects**:
None - failure case now returns clean error instead of crashing -
**Testing impact**: Improves robustness without changing successful code
paths **Conclusion:** This is a textbook example of a commit that should
be backported to stable trees. It fixes a critical null pointer
dereference that can cause kernel panics, uses minimal code changes
following established patterns, and has virtually no risk of introducing
regressions. The fix brings tegra210_ahub in line with other Tegra
drivers that already have this protection.

 sound/soc/tegra/tegra210_ahub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/tegra/tegra210_ahub.c b/sound/soc/tegra/tegra210_ahub.c
index 1920b996e9aad..51043e556b3e9 100644
--- a/sound/soc/tegra/tegra210_ahub.c
+++ b/sound/soc/tegra/tegra210_ahub.c
@@ -1359,6 +1359,8 @@ static int tegra_ahub_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ahub->soc_data = of_device_get_match_data(&pdev->dev);
+	if (!ahub->soc_data)
+		return -ENODEV;
 
 	platform_set_drvdata(pdev, ahub);
 
-- 
2.39.5


