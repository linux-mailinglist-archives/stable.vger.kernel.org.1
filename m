Return-Path: <stable+bounces-72942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B790896A98D
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 23:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FF5B232A5
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 21:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658211EB258;
	Tue,  3 Sep 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5nQVivi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0571EB253;
	Tue,  3 Sep 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396532; cv=none; b=qnsvSj3SYp5zr13zpc/BT0ACoC+SOuaVO4fIbDn1vLIkyxFeKv34YtHkVXlQVRc36VFIUnrb6zeOIgzMQqZcOMDfSnocNfxSXNIqSpH0GKjMR01iqr3n5U4VhNrtXzSiFCo7Yds14rbawOYJHJ56kd5uGhfKoY9ENcCzp8GyZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396532; c=relaxed/simple;
	bh=iwF/iAtE6DjqPteDb0c6fqdLg0qoT9cjRDPaxMWSH5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+f6KwAexIEZH7I7gocbWRB2lwt2w6Yk+fv/90mZVji+SNQqGa43dQl9fD5PUE89Jmnkc5arbwPeZ5gg1L0eJNDvtS8RnKGOnTjit2CtT8ECaxKQMxIBxITNlw0TkXJEjoUbVlzfH0zs/hB4ILOJuThD8xXkZOaDMV8sQ3WWoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5nQVivi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCFBC4CEC4;
	Tue,  3 Sep 2024 20:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396532;
	bh=iwF/iAtE6DjqPteDb0c6fqdLg0qoT9cjRDPaxMWSH5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=D5nQViviYHZ88D3pqiwOI1NCsM9Bejlrh+A0l0gtO8I7WFoxuewoqesGyrLVjUlsM
	 3eSNqe7wHVLBcitRljUtGK6m2YJM61RdLh+1VyP9b1+uX8rVVesu/3nGbqnE98HqZa
	 ZwmzIw2AaJAPOQo1lEe+vRID4/uHwTOLimdCRk7YwPAc+va3rlPBoeD0/qWef5w+mh
	 wHm0MUSjk/q4rZ4t4v6TRMEYSr/3v5T3wAmFR40Rt38nIl308PwnAixQFjGUC9q0Sg
	 nxSGQstdy3Y5ZQpRPwFpk+1X6lGqBgoyIjFxMzPkhHXPWkTuJH1183mB+ER2DlgQqH
	 629j24CY5AmjA==
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
Subject: [PATCH AUTOSEL 4.19 1/6] ASoC: allow module autoloading for table db1200_pids
Date: Tue,  3 Sep 2024 15:29:21 -0400
Message-ID: <20240903192937.1109185-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.320
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
index 301e1fc9a3773..24d16e6bf7501 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -43,6 +43,7 @@ static const struct platform_device_id db1200_pids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(platform, db1200_pids);
 
 /*-------------------------  AC97 PART  ---------------------------*/
 
-- 
2.43.0


