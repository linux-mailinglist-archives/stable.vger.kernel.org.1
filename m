Return-Path: <stable+bounces-5358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B8580CB5F
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B8B1C21201
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C10147780;
	Mon, 11 Dec 2023 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pv4QoFA4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA038DD0;
	Mon, 11 Dec 2023 13:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F17C433C8;
	Mon, 11 Dec 2023 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302716;
	bh=cxnve05K/VRYJl8jpV68XU1TGjaNM2S97d2vtX+mAx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pv4QoFA4GUdNp+p0/JjgdS2cLfaj/DR+kNwA/UJUDO4HhuCS9eGZ/ZPg1TeZfnPiA
	 nnHamQg5Q7gCzRGf5R4uLXzMAuBqhnL9297R03oqsdOjKCRMI6enfZpVB1l2SOCRTJ
	 GyB37Va89H0KDXwrFKqVKXQyNXZIR5wt/GCvkuDubz4wK8zEYAx59ilVZvJiq5+6Ok
	 SDu9ItLjWHD+c9VTOApEhGtbMWLtD2lElNC+v1gzGbfkFSEz6sOd/EOxbsiNJ9jysF
	 4RrrvMrrbBbkCemKSQXuGKFISChhjL5kF+1K2ajRIPe5ZvV0fZZumqVQPXMDQModhf
	 Q9lufODq8x5nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matus Malych <matus@malych.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	jeremy@system76.com,
	git@augustwikerfors.se,
	Syed.SabaKareem@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/47] ASoC: amd: yc: Add HP 255 G10 into quirk table
Date: Mon, 11 Dec 2023 08:50:04 -0500
Message-ID: <20231211135147.380223-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Matus Malych <matus@malych.org>

[ Upstream commit 0c6498a59fbbcbf3d0a58c282dd6f0bca0eed92a ]

HP 255 G10's internal microphone array can be made
to work by adding it to the quirk table.

Signed-off-by: Matus Malych <matus@malych.org>
Link: https://lore.kernel.org/r/20231112165403.3221-1-matus@malych.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 15a864dcd7bd3..e2a510443bf1c 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -367,6 +367,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A3E"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8B2F"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.42.0


