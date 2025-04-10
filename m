Return-Path: <stable+bounces-132161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E993A84908
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3429C2DC1
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010B71EDA12;
	Thu, 10 Apr 2025 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jk9GVcdM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB461EA7F1
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300490; cv=none; b=T/9pRK25SVJOe6pDD48Mt9/cP+lfWVxTSzeWkdOMbFvkvWsES8fyGdfoI/zm/g9FKB096uYpkOF3+kR8/fg/gqKtu7Lxod85D7PgUZd7B/Lm24YW42z5rL15UQvzTYUjQ7jCD6QsTsiaflz7Sjo1sLXonzYyLMHcUV8QMNYcSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300490; c=relaxed/simple;
	bh=C0cw1gpBQVBgQAjMsinrW5jpk3USu31QnWXdKCcVpSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6xHNbjkTAxxtOzW4Gf14p8vBWL065F5MWxRzZJHuVsyGQpYKob+8XzkWCcBzTpahG6ErRl2+pM7XyFQPg7EoRIjB8X0q8bkXdTnlvj/8jlQVjhlL6CaAAyZi8RPRQ77Z5vw7hZioEicjF6qEalAD4Vu9+FJFBSu66vl3MmPNCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk9GVcdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062DCC4CEE8;
	Thu, 10 Apr 2025 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300490;
	bh=C0cw1gpBQVBgQAjMsinrW5jpk3USu31QnWXdKCcVpSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jk9GVcdMUhQn0ZMLFr2iqQ6vWGi9lEXT+7dwBGyug4IqtvJxLm7NobDME+TOKFwcz
	 sQS8r7LNcxrIrMkZJltgH0MnYEPJWYOpmCHCnJYIuH9fSQnIK8HfLdMP788LJITn8W
	 mxL3W5Xa0ubIj5VfxJuCSx8sh/6mJLlYR98IBwwk3Hk05g44EFUsBM2fiJkGmXmJk9
	 9QC3JmrrUtf68/18Lm7z2JsdbE5FLMK8tJ84n53LwqWCxH94lC9s0EcjBcR1EIa8Xw
	 rSG8R1mVx9EDp+Am7Ny+337r8ZDBBYEzkCf5pEx08A0lExWke+Pe607p0Yo2o+KXBY
	 FjtYrw4oBKAyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] drm/amd/display: Add null checks for 'stream' and 'plane' before dereferencing
Date: Thu, 10 Apr 2025 11:54:48 -0400
Message-Id: <20250410080323-7189455e0f8c2920@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250410065208.848340-1-Zhi.Yang@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 15c2990e0f0108b9c3752d7072a97d45d4283aea

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhi Yang<Zhi.Yang@eng.windriver.com>
Commit author: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 10c20d79d59c)
6.1.y | Present (different SHA1: 5e84eda48ffb)

Note: The patch differs from the upstream commit:
---
1:  15c2990e0f010 ! 1:  23cc38e759775 drm/amd/display: Add null checks for 'stream' and 'plane' before dereferencing
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Add null checks for 'stream' and 'plane' before dereferencing
     
    +    commit 15c2990e0f0108b9c3752d7072a97d45d4283aea upstream.
    +
         This commit adds null checks for the 'stream' and 'plane' variables in
         the dcn30_apply_idle_power_optimizations function. These variables were
         previously assumed to be null at line 922, but they were used later in
    @@ Commit message
         Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
         Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
    - ## drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c ##
    -@@ drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c: bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
    + ## drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c: bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
      			stream = dc->current_state->streams[0];
      			plane = (stream ? dc->current_state->stream_status[0].plane_states[0] : NULL);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

