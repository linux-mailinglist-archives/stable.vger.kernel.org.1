Return-Path: <stable+bounces-98619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A677A9E4944
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EBD1881F3F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB202212B17;
	Wed,  4 Dec 2024 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNYUpWPQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2F212B13;
	Wed,  4 Dec 2024 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354893; cv=none; b=ZqzWly9i+eX3uHkUkRmzImjUFjIqYJxFWtwDxj4620ae+A0fpNWC3xzRmx4Br56TbzvIE/qWNEWXxdYqtuHAMwtTMRep0IiUnQTb1w99Ld683YpdPJK1xPEoUNIu6fp6KYKbFeWGz+z2PyffGpg4ovmBy1aQnO+1bEc8h9PWq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354893; c=relaxed/simple;
	bh=W87FplIABexkJs48nxrjVhKtNDBEPuMzTUbjtoyjMpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTWRFkmudOTVhPMG/8sruLcJ9kkZUcJeHpv0BaDV/d/mtW2Q1m7mz3lbFWlQm3lIwpq+T/rsKETIQjd3CXRvcFYCZLP3jK1fID84wVtgDufgkzF8J1ZofiNNq2kyFbUqH2xD9QXN5t/1mG3eI8yhrcnEKlUoomDfRRxhoRZhOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNYUpWPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFE9C4CECD;
	Wed,  4 Dec 2024 23:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354893;
	bh=W87FplIABexkJs48nxrjVhKtNDBEPuMzTUbjtoyjMpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNYUpWPQSkn2JSORdbjchtWUrC77jUK6G5F0/hxrFh8aqc+glp7vqX6ElATi2W3fn
	 pixIyE2ARjwMeu+dDeoOyaO7P+TXWcEDfxjwHOTVNw9vn81Hjzdn0c39wtiZSye6gl
	 oZ2ORhTVw2gHF11+oF1ZfnTvaTbdAFmta3i86Ep+muGYFQofIvZHxqEvcvcq75ER76
	 cZ7RiBfEOx59RUFz2hs3HVMXUhdE2lWq8/pj3Gdlgumqq8axQlKP9xf68soJ0MsByi
	 /SX5iSxMcTg8D/Z9jMkHahBsX1cm9UrwHgfYg5AU9CR7UQMCb+JFJvlra5Qvw9ZZ2+
	 MVxRvNoAb18hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Far <anf1980@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	end.to.start@mail.ru,
	me@jwang.link,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 11/15] ASoC: amd: yc: fix internal mic on Redmi G 2022
Date: Wed,  4 Dec 2024 17:16:05 -0500
Message-ID: <20241204221627.2247598-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221627.2247598-1-sashal@kernel.org>
References: <20241204221627.2247598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Alex Far <anf1980@gmail.com>

[ Upstream commit 67a0463d339059eeeead9cd015afa594659cfdaf ]

This laptop model requires an additional detection quirk to enable the
internal microphone

Signed-off-by: Alex Far <anf1980@gmail.com>
Link: https://patch.msgid.link/ZzjrZY3sImcqTtGx@RedmiG
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 2436e8deb2be4..1b9834ee5d461 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -409,6 +409,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Xiaomi Book Pro 14 2022"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TIMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Redmi G 2022"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


