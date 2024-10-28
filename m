Return-Path: <stable+bounces-89016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009689B2DBF
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CD3280A7A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0351DFD82;
	Mon, 28 Oct 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCUbFRnQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65781DF997;
	Mon, 28 Oct 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112743; cv=none; b=pbNIsy1yqnFSlHKUqNrRqKXBtkfoqkDJno7mgZ1NjqtaCFr8rI0+iugKDf9TmKZB4xc7LGYKzJV8JPBoRXEpNBKZlczPk1Q4Z+yPJi1noeuT5EpLE7n3eWgra/7VDvVg2enBhvZK5CoHhL82rCvO34T1sRp0wEaV1hsUTK3AmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112743; c=relaxed/simple;
	bh=PrX2Ua5t6psIY7oyPUrtdTSYCqZqUaSu4orn2RxDDvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diAY4YLqjyLTGXLU8RPva6lXA8JokptMG/RM1uJU68sETUSPoTiRTDROk+iJD/9jq984KDsscT+5OwDeQ8G3pqzwe3Q63WHtGRvTAm7rZSbKECCn5dl5/whSSEYZ6UF03/hCLmU0XxntkCDYwkJ9LshndJgLBuJZt6gzlmmREOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCUbFRnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532E6C4CEE4;
	Mon, 28 Oct 2024 10:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112743;
	bh=PrX2Ua5t6psIY7oyPUrtdTSYCqZqUaSu4orn2RxDDvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCUbFRnQK2N8NqVEiIXLz/MRFk3Ikz1VNyFvlWBgRUGnD/kd1sySq/vqZQeRBrWJh
	 MoKhMWVmkBJpqRA3kZjhgRfnICu/8e5jdoeM7dtYXjm/Qbv+9sOlXPro1zeBjMqE+G
	 UsoyFXaeFpsdpIlf/+cb5MOH6H1xYh2Xd6eM/eqyYoZgFkDlY+PzE8IUxQxttry298
	 u+nNjF9pksi0VkKhGOJEv6pZRSkyuiEALcPpEqqZm+U7lWTqSx1zP/zGk+ubxg8mAg
	 vZTah/D0nVkpaTcvoEs6AGvYpCdf0ljCebPHuC2SyzzFfbH3tEEYlL0cP2GXxCuvMW
	 GKzvSu1rcqdzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Heusel <christian@heusel.eu>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	end.to.start@mail.ru,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/15] ASoC: amd: yc: Add quirk for ASUS Vivobook S15 M3502RA
Date: Mon, 28 Oct 2024 06:51:58 -0400
Message-ID: <20241028105218.3559888-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105218.3559888-1-sashal@kernel.org>
References: <20241028105218.3559888-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit

From: Christian Heusel <christian@heusel.eu>

[ Upstream commit 182fff3a2aafe4e7f3717a0be9df2fe2ed1a77de ]

As reported the builtin microphone doesn't work on the ASUS Vivobook
model S15 OLED M3502RA. Therefore add a quirk for it to make it work.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219345
Signed-off-by: Christian Heusel <christian@heusel.eu>
Link: https://patch.msgid.link/20241010-bugzilla-219345-asus-vivobook-v1-1-3bb24834e2c3@heusel.eu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 248e3bcbf386b..d03e95844c3a8 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -339,6 +339,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M7600RE"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M3502RA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


