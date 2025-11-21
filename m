Return-Path: <stable+bounces-195444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB9C76F99
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 03:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E6D135DD0E
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 02:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7F9221F0C;
	Fri, 21 Nov 2025 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1nICPpR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97151BCA1C
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690649; cv=none; b=GIVbcJyayrjP+8I0CpWX0niWLyE/USNk+/slXLMYys3tw1FhksZYSzWHJfOKI5Ct/hmJkt8srP9rI+vkdH/ZkStG5PFNHZIka/wAv9UEBkjsQIXvvQWnLyCt8ADKI74OXS8Wv97zna3qj7+4Kfm3emQpxRCr6V3DHpG94p3JDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690649; c=relaxed/simple;
	bh=pUe0MlFCIsXKtb5mpRziBcPLDuTG27fgs0a4kdL3A4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r26FclRL0rDLQNAKcyOEmp7Rz4gCZmGakAZ8SkltHZsqg+/tURSLKkSmyjim/5VHXCAq2P3nCuVeFvSx7ImBuRcp0pJtAUk2Dkl7D+12hbQy7qlmAVSjmX2xwyKCd0xmwOz7JwxUsbiNXEqak1XM6wO/Kp26HivH9gBc81a2zTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1nICPpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D75C4CEF1;
	Fri, 21 Nov 2025 02:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763690649;
	bh=pUe0MlFCIsXKtb5mpRziBcPLDuTG27fgs0a4kdL3A4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1nICPpROwDOkV8uVWwVMFnILBt5pJHARW50oJ/tS9xzWEYvdW+cV0Zrf2lxY2kKn
	 yahosgwhI7QcYuBwNA/fAuIHiFjTw2Fy5AIXKXQke2YqP2D/uScc7xmgGe0bfIIAFZ
	 BY7GnE0dVmdhvIuO3K+EKF6XMBkBjpWroB0MppPIkUdK8rJw3o8rBSonPi40aAqh/G
	 Wzv53wKie4xp0T2q/BhL7azNhqHXL6L6Sgk08C4YSC1BxOp7zAsmxE9oytLInbQDk/
	 NXriQfQPlMs0i5ZrKoWRLHBrgcNAOTVcPlQj+WUabqcm+rEKv4HQd/YQMurrppxBqI
	 SZU4pOV5nIoGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] ASoC: da7213: Convert to DEFINE_RUNTIME_DEV_PM_OPS()
Date: Thu, 20 Nov 2025 21:04:05 -0500
Message-ID: <20251121020406.2340125-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112057-rubble-coleslaw-6ad1@gregkh>
References: <2025112057-rubble-coleslaw-6ad1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 2aa28b748fc967a2f2566c06bdad155fba8af7d8 ]

Convert the Dialog DA7213 CODEC driver from an open-coded dev_pm_ops
structure to DEFINE_RUNTIME_DEV_PM_OPS(), to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/0c001e0f7658c2d5f33faea963d6ca64f60ccea8.1756999876.git.geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 249d96b492ef ("ASoC: da7213: Use component driver suspend/resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7213.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index a4496cc26902b..ae89260ca215f 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2247,10 +2247,8 @@ static int da7213_runtime_resume(struct device *dev)
 	return regcache_sync(da7213->regmap);
 }
 
-static const struct dev_pm_ops da7213_pm = {
-	RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(da7213_pm, da7213_runtime_suspend,
+				 da7213_runtime_resume, NULL);
 
 static const struct i2c_device_id da7213_i2c_id[] = {
 	{ "da7213" },
-- 
2.51.0


