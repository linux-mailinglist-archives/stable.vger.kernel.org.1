Return-Path: <stable+bounces-72914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D3396A941
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D212B1F253B6
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769D01E6330;
	Tue,  3 Sep 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2aP/dq1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322201E6327;
	Tue,  3 Sep 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396394; cv=none; b=q/UACRPwG4XBaL7wVQ0E3zvgA+dYn4PupTaPg7udifQiE1mrdRZcpmM/33qqyx/z3A1Rjes0MAdqaJZdfriyR4ectVA5GcZXq75y/6AFBAj3EGLARGf+yZxlYZbcIDXmT+p20Lx2dQKMEr/IDeIqNoR2svsIk0kV92pOGoFSm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396394; c=relaxed/simple;
	bh=2l6V/xAgmqYJbUAyttYeN1cUcpBYiQ7bcEal4EZJot0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTlxoeg+hGKxijrDQw6KchP42E0q4r6iy9V7pCKSy04v5slDWhV5Dur5r745xmSRjqKIdm51Cg80W3CAgFRYYmMMjPTriGoy7J1CwAyaGunKoqU4US9trpFzt6APu1p0QCKOCDn2NvZLNBznDXC0327l+Xk8M/iHNfWY3DSKilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2aP/dq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB0AC4CEC4;
	Tue,  3 Sep 2024 20:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396393;
	bh=2l6V/xAgmqYJbUAyttYeN1cUcpBYiQ7bcEal4EZJot0=;
	h=From:To:Cc:Subject:Date:From;
	b=q2aP/dq1wHJCl6Oq6Ou7d8rqs/BbJABxhg7/K7ZGbtTK6bO4Ex14DR0hsZ/SjEd+2
	 Q46q3Uh3hEU8vAVKrtb3Nwh3r8ky8lZPn6BeINsnPYbiuWgEkk8xYxqpgzzV4Yk2Cf
	 srLkutmfOEYrJsWg6TnNYwSWQJgOHNY0Pqw9y1alVngl4joCM40lnUiGBs42qs10eL
	 3N20wGXPacASvC07lm8Y110+jEJIx4qiZPRpSCEthLuKCWQgK7rpxzgYeX1d6ddXDu
	 UeW601VsuFc/b058OOHWHmj3g09sydRmZlHZyUqQAHk+rGhy7mKcrzvRRcqVKwuMl/
	 vOr0hrEU3v9Xg==
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
Subject: [PATCH AUTOSEL 5.15 01/12] ASoC: allow module autoloading for table db1200_pids
Date: Tue,  3 Sep 2024 15:26:45 -0400
Message-ID: <20240903192718.1108456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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


