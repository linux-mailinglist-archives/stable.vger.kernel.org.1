Return-Path: <stable+bounces-145023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C7CABD0F3
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FF81BA15E4
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 07:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC6258CD9;
	Tue, 20 May 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCdUz7yv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB841DF75A
	for <stable@vger.kernel.org>; Tue, 20 May 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727550; cv=none; b=hujuXOhUHRnxD8bA6DjLeuZ7lYw57eILsIWCQFC5Fcz1UQ7HjtClBGHqHrUUF7cRWgYmbYNY3VpPuZoEGndjWnEaqobaq2ITCT7GOIhnPpx9CzGs4JGS+2lXGjs208w4OujJMnwET4H5rBnCCsmbNVYqAOlmvKUKIBi+BbMqecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727550; c=relaxed/simple;
	bh=LH8YWyi74LwgXlVx7e3u3WODqXI/uwI9BZjjS1UiA/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snTyEy7QQttZaARseWyjS/JPd39RdnIjFXPqFv3w8MEIB38GzIpI2Ca8n5OMfmx7YhIki/DJL2vW74LcYE5ti2w9ftJdoEc35kUyQRK+l5gZ71RoKMPgLjvL/T/CCd4mSjIwXj8QaPclYuhuGgB1yeBKZzoV/R1lo5NWPnJnd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCdUz7yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F6EC4CEE9;
	Tue, 20 May 2025 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747727550;
	bh=LH8YWyi74LwgXlVx7e3u3WODqXI/uwI9BZjjS1UiA/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCdUz7yvGsnRaBBhgoaXHMsn9fIhVVAzFKcEtD3mAGp07PN7D7qFKspoxtvaM3UfR
	 JbL2aweEnPlrBly8nFT/S0yGLeY7pb/xiwyyoDZwD4R3k/x9/shOoaMqGENPCHoy8T
	 7jWJzLdWRmbsgqw0G0zjJc2jWAOs7WmBTgNjuhzA4TQbsL/F7ag4vDXrCXYGs8TZpl
	 VX+iWT+zCmU5XlNywzsHhAOpo29+TARRc598Uxq4Mncjif+/YZokTWehZehZurzEKT
	 GrG6i5mNxQC2Sf41I1WnDtiw197qvPZa3UwfbUYrLV4PaeDA8+xCMxZKNpHsUdfp6B
	 tN8GumvVWxjzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] ASoC: q6afe-clocks: fix reprobing of the driver
Date: Tue, 20 May 2025 03:52:28 -0400
Message-Id: <20250519181507-f25430726c7d0ba2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519011658.3642339-1-Feng.Liu3@windriver.com>
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

The upstream commit SHA1 provided is correct: 96fadf7e8ff49fdb74754801228942b67c3eeebd

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Dmitry Baryshkov<dmitry.baryshkov@linaro.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  96fadf7e8ff49 ! 1:  d9d9536eb5aa4 ASoC: q6afe-clocks: fix reprobing of the driver
    @@ Metadata
      ## Commit message ##
         ASoC: q6afe-clocks: fix reprobing of the driver
     
    +    [ Upstream commit 96fadf7e8ff49fdb74754801228942b67c3eeebd ]
    +
         Q6afe-clocks driver can get reprobed. For example if the APR services
         are restarted after the firmware crash. However currently Q6afe-clocks
         driver will oops because hw.init will get cleared during first _probe
    @@ Commit message
         Fixes: 520a1c396d19 ("ASoC: q6afe-clocks: add q6afe clock controller")
         Link: https://lore.kernel.org/r/20210327092857.3073879-1-dmitry.baryshkov@linaro.org
         Signed-off-by: Mark Brown <broonie@kernel.org>
    +    [Minor context change fixed]
    +    Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## sound/soc/qcom/qdsp6/q6afe-clocks.c ##
     @@
    @@ sound/soc/qcom/qdsp6/q6afe-clocks.c: static const struct clk_ops clk_vote_q6afe_
      	.unprepare	= clk_unvote_q6afe_block,
      };
      
    --static struct q6afe_clk *q6afe_clks[Q6AFE_MAX_CLK_ID] = {
    +-struct q6afe_clk *q6afe_clks[Q6AFE_MAX_CLK_ID] = {
     -	[LPASS_CLK_ID_PRI_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_IBIT),
     -	[LPASS_CLK_ID_PRI_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_EBIT),
     -	[LPASS_CLK_ID_SEC_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_IBIT),
    @@ sound/soc/qcom/qdsp6/q6afe.c: int q6afe_unvote_lpass_core_hw(struct device *dev,
     
      ## sound/soc/qcom/qdsp6/q6afe.h ##
     @@ sound/soc/qcom/qdsp6/q6afe.h: int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
    - int q6afe_set_lpass_clock(struct device *dev, int clk_id, int attri,
    + int q6afe_set_lpass_clock(struct device *dev, int clk_id, int clk_src,
      			  int clk_root, unsigned int freq);
      int q6afe_vote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
     -			     char *client_name, uint32_t *client_handle);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

