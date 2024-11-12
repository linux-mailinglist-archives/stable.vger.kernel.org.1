Return-Path: <stable+bounces-92489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 907789C546A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F3D1F228E0
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0539521440C;
	Tue, 12 Nov 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+MTIo4U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B0F219CAC;
	Tue, 12 Nov 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407788; cv=none; b=qCX+FulZMTyZfLt2JQgnwuPfcCPSb+cJc+XduIRikGfQbQVXJTmeIM2Ctu4yA6tzCpXcb9lYYWHUFLjPnbHagKEdyJQXaQPT6qWyAuVuqmmV/G9KCJNCkT+krehZwWmd4jgoHHLgShQtOzZvYUxEKcyZr06QPK/jWaQyXZ+7gxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407788; c=relaxed/simple;
	bh=yGDh+ZKCJBy3z/TjOba01atLX/dVHFi6Xu0obPA3+Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPnChpB2sFYXX+FQdQVZC8dJmW31FefrRgsrO/nbkE+qOpk2pvEsTD0VU9sk4forCqvaUVfYgj6judevift7qz9LVPTMkCFF7J+ndwfwiriFJBKn7QnVFTUgVZeb6gj7bV5+gHxXrj8iyZFwR99+kaZgibpRAfYPCHO99ShNudg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+MTIo4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA348C4CED9;
	Tue, 12 Nov 2024 10:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407788;
	bh=yGDh+ZKCJBy3z/TjOba01atLX/dVHFi6Xu0obPA3+Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+MTIo4U3Q7cZ7NsD2zdZXeDW5CsMQdgF5PSNHvCsqOVrqCNL5ntwnkJvXiGZam7n
	 EkfKyY7XqHFz+/ihk+92G11wvlysOhzs9KumdUrP5uJ0DpQbXkDL7Jiu+qmy0ezD2l
	 u8XVGE1XSZzP1a5dMTXmH1HdmpGppGvm+rF/N8Or4cGR1L71fizx1+bd7xTYYQi38E
	 69jP0h58tuUsxu9FsbQGDItChpkL9cQdzC1zHbUV265rtQxvMi/IgDEKRpRwgAo/p0
	 jh9CwGRtAXP8FXzxC+L7EHdfmGqa8Et64+d+J4iNLvoX5vnevmhJ9V8zLBarg0mBtv
	 r7a9+4pZy/SQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Petri <mp@mpetri.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	end.to.start@mail.ru,
	me@jwang.link,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 12/16] ASoC: amd: yc: Support dmic on another model of Lenovo Thinkpad E14 Gen 6
Date: Tue, 12 Nov 2024 05:35:54 -0500
Message-ID: <20241112103605.1652910-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
Content-Transfer-Encoding: 8bit

From: Markus Petri <mp@mpetri.org>

[ Upstream commit 8c21e40e1e481f7fef6e570089e317068b972c45 ]

Another model of Thinkpad E14 Gen 6 (21M4)
needs a quirk entry for the dmic to be detected.

Signed-off-by: Markus Petri <mp@mpetri.org>
Link: https://patch.msgid.link/20241107094020.1050935-1-mp@localhost
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 601785ee2f0b8..167b007865a6c 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -227,6 +227,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21M3"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21M4"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


