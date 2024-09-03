Return-Path: <stable+bounces-72926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725596A962
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 23:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F3E1C2455A
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 21:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ECB1E8B6B;
	Tue,  3 Sep 2024 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAtH/gj+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF71E8B60;
	Tue,  3 Sep 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396450; cv=none; b=te/38NZpurf81BHKhNrcSTB3x0uJa++NL+CA10eMkBn88cZCVIY/PjfEVH9IX5OleJ60EoES+WdOoNUI1Ti9REqUAU1CjRruJljCIA0UNxIr5qD+9cUL65ZsCuV0dKB0kZLhaX1mBQ7OS4qJfvc6apxLs0FFX9UU2Oh2blRWUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396450; c=relaxed/simple;
	bh=2l6V/xAgmqYJbUAyttYeN1cUcpBYiQ7bcEal4EZJot0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0vvurB+0U8/fDKe3mcsGW1S8o32Ijp5TpKC6/JnfHxTbQacHp/KN2hNgqtk8XDHcxMm58gRz+wgSLeuJEAxuR9imAxn8ovOtjb6yDbJQdrd8pTEE7pCUAJD2bY8bCLb/mzSUFIdg9okzscZI02+Uo35J1rNPZLSgA0fqjUXLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAtH/gj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED28C4CEC4;
	Tue,  3 Sep 2024 20:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396450;
	bh=2l6V/xAgmqYJbUAyttYeN1cUcpBYiQ7bcEal4EZJot0=;
	h=From:To:Cc:Subject:Date:From;
	b=PAtH/gj+bmzobDU20drBGm9dX+hVhfLGw+q6YcxQEZQ6LolFKaaDTLTXM4l2w8ZG3
	 LxYR4CuvBbyhwG/Lia4FlaaaJn708HhvW4+95BuQKULM479y/AP5uApKEm9/UZ9n2/
	 fclDdndhRmD58NM0BvFgZvUo8jOH8G3VZ5zLmsp+AXtyuujDx4Jx89s0qcVDiPff5p
	 6eXmfZ5VFEkh0mWhrqgC0ZvDrVuyxT2Y/yjrUYNBv4Bdl/gp2fXSpBGFi4ydVZxpJb
	 rAzj9E0Ipyk0OfnAOBg1Zca55cccErOOm0m+KQKzXaz+kOJK4iCRqh4Cq7O4xhE3BV
	 kOR9tpp3gEaWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hongbo Li <lihongbo22@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/8] ASoC: allow module autoloading for table db1200_pids
Date: Tue,  3 Sep 2024 15:27:51 -0400
Message-ID: <20240903192815.1108754-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.224
Content-Transfer-Encoding: 8bit

From: Hongbo Li <lihongbo22@huawei.com>

[ Upstream commit 0e9fdab1e8df490354562187cdbb8dec643eae2c ]

Add MODULE_DEVICE_TABLE(), so modules could be properly
autoloaded based on the alias from platform_device_id table.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Link: https://patch.msgid.link/20240821061955.2273782-2-lihongbo22@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/au1x/db1200.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 5f8baad37a401..48243164b7ac8 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -44,6 +44,7 @@ static const struct platform_device_id db1200_pids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(platform, db1200_pids);
 
 /*-------------------------  AC97 PART  ---------------------------*/
 
-- 
2.43.0


