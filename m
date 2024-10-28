Return-Path: <stable+bounces-88992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7149B2D75
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779A61F22BB0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AE41DB522;
	Mon, 28 Oct 2024 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQdfIee5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950F1DB36B;
	Mon, 28 Oct 2024 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112683; cv=none; b=aSlnHWpZ0H53NvFsEzBj07BhODjfuViEA/MlNoVJWDEdX2eXzN6XLQ7TRB9mmlobJ5zpeyxL3s9zqod2g3yQZZ4VkmRSCmv+ZzO+Xn0V3G4dOvYgbp2qfLoLpJY24o30NP8aIQ1JedvvDdY4Zh4mwn3ZSSU6JN9KsiTNBvXSL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112683; c=relaxed/simple;
	bh=HXTxS6ADywcQJThCirWeri6sM4EdeHPpQjlnOys1l98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pmknqgc4kjAE2BlUROyKvSwVPFkxuDuKWYDuzX2KirKFjbAOJIPPwQETEgqfBmMbjK6NHnBIn8TEK3qMauEBix5xK6iIMw7Bqt+j0ryzDCB8lv7KRV4ojMYaqIYfQMeCEJJbQP1z0gUfqSEhxYvFpiZPbyaPDWZnPOV07dcvHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQdfIee5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CFBC4CEC3;
	Mon, 28 Oct 2024 10:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112683;
	bh=HXTxS6ADywcQJThCirWeri6sM4EdeHPpQjlnOys1l98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQdfIee5J9KSrDvuXdWDloBCLTa7JJqVhQANHsvkkFcp/wzCN2Q/gIj5RD8ogOfPF
	 JbM9u4dNcQihIxrnsMBXyT7A2aytHfzjQogoBIPoPSvLXFz+3DE7RUpWohFJahQ7yF
	 4lNHXRU7XtI8alxtG2kvA4mm2eSDi8C1FsBIYTajFQqUZfM9KRULf4rG0Y3u75QFlk
	 7EPYG6ge7r9SDndWugHq0JlGXvlBBuk8SjCW6etTXau8q3epYR8hBPIw0JKkree2wh
	 EPfhA5rv5DgVCMi9xQQupYdQ7nymlff6G+Cq3Gzz8DLYRtysJDwu7SB5/8CGtz1cD1
	 tJFmddMaBwPcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilya Dudikov <ilyadud@mail.ru>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	end.to.start@mail.ru,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 10/32] ASoC: amd: yc: Fix non-functional mic on ASUS E1404FA
Date: Mon, 28 Oct 2024 06:49:52 -0400
Message-ID: <20241028105050.3559169-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Ilya Dudikov <ilyadud@mail.ru>

[ Upstream commit b0867999e3282378a0b26a7ad200233044d31eca ]

ASUS Vivobook E1404FA needs a quirks-table entry for the internal microphone to function properly.

Signed-off-by: Ilya Dudikov <ilyadud@mail.ru>
Link: https://patch.msgid.link/20241016034038.13481-1-ilyadud25@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index e353542dcf636..ffefe45c464d0 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -325,6 +325,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1404FA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


