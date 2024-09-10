Return-Path: <stable+bounces-75682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27223973F65
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D897928E36E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608F61AD3E1;
	Tue, 10 Sep 2024 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkGi6NBg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49C1ACDE4;
	Tue, 10 Sep 2024 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988960; cv=none; b=FRG1donhoX8i4Rw137lR4avd1cdZ1r/ZFOfA9Df0TyumjaxVkqTw3R0JkPCOkEdsa4JkKn5BZuZ4jR3Kq6OVmK/y1DYiI2ooHFsIZrgU8I087GMcYTre+iBCQDSCL7Lnp2Oa69nmORgfxEooxJCTrzrIX0IoLwfLt4qJf3PXfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988960; c=relaxed/simple;
	bh=0OjB6Sc1p5YtedZLLX1wZKVFYQugNgt1v2e4bVCToao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EisqC6cj61AFzJCEluvf5HETOkMgFosRUwLoeuPGAioE7hy5I7OY+3HtgyUHdUVYByMsx3NIj+QzhPzGtWnUAXlXvJMfSHdlmVjn3RZgak1tL2goiG34U/wwRl/b3bJsKwXZU8OxdqKhr+soqt4B/0r9frh/e3UP6lvxOZN+zzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkGi6NBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED04C4CECE;
	Tue, 10 Sep 2024 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988959;
	bh=0OjB6Sc1p5YtedZLLX1wZKVFYQugNgt1v2e4bVCToao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TkGi6NBg0DRYE/NUyZARNcDfSO5JZOYfAve4+zWMwu+ap28c8L+xRgvdH9CgYis6H
	 Hzh5XJjMkfer4Jq4z+nc1tOlV8eDYjSgZmYkj8zVXC289DQZsXsAweBKF5tkMiRuV/
	 zfnD2Zr8DqO5MOcTOPNVdGvfRPbFDdEcZ/Ky/HWufbBmgkk1p4v7autMoF6dN7H5KO
	 VGlIFLI3ajfqilkJhMMjE0wsPWPsWpN+JnwcxruuUFsdWdjDKel0U/NISY9vPqFGyf
	 czdKMTYTU1V6lPoDslixO12jHemWEcd/GqiSuluqfHWqcCa/rbTx1ESi5WC6HyaPGT
	 sGQczuMnVQQ9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markuss Broks <markuss.broks@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	end.to.start@mail.ru,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 10/18] ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)
Date: Tue, 10 Sep 2024 13:21:55 -0400
Message-ID: <20240910172214.2415568-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172214.2415568-1-sashal@kernel.org>
References: <20240910172214.2415568-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.9
Content-Transfer-Encoding: 8bit

From: Markuss Broks <markuss.broks@gmail.com>

[ Upstream commit 283844c35529300c8e10f7a263e35e3c5d3580ac ]

MSI Bravo 17 (D7VEK), like other laptops from the family,
has broken ACPI tables and needs a quirk for internal mic
to work.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Link: https://patch.msgid.link/20240829130313.338508-1-markuss.broks@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index f6c1dbd0ebcf..248e3bcbf386 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -353,6 +353,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7VF"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 17 D7VEK"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


