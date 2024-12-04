Return-Path: <stable+bounces-98644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B529E497F
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA06169D55
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FC4217F2A;
	Wed,  4 Dec 2024 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7zDz8z+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B7217F43;
	Wed,  4 Dec 2024 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354994; cv=none; b=HAekSIFA77T0BVcpCh+rK3Rk3EgoAanF0+FKb/nS3R8Ph6x8fmv7aps5iMMS99OF4Kt6uaPI5eWnT7xPQtyX/pcgRGOfEE1Fm07obAHAUAtB4HfFyMMUQS3MyxupXNpCKhTCUcXScFCuGHHiwJvuXgnJNGuqYpvXoIBk2w7hXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354994; c=relaxed/simple;
	bh=xVthd2Efv+euOfB3JB7vBx75vkvCuLDFLtjmimVvwWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARHqWrs50jyeFA691u0hHFKwndCK5nPnk/GlzV08L6AD2uGUycArNxgM70mxxTHIl1aBahi/bmN7yPTnJNd4I3cI0COyvynmdhehlWE18O+GIC5bEARO5AO3LVoGmobbamYX29G5w2qLjxyub0STdH8uTZuCRGY3iNomUtggwUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7zDz8z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6158C4CED2;
	Wed,  4 Dec 2024 23:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354994;
	bh=xVthd2Efv+euOfB3JB7vBx75vkvCuLDFLtjmimVvwWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7zDz8z+2OcBzQZkL4es9Fkth1cc3iuqwvtgsHaMfZptHu5KsBFuwQHXRlBcRlMs8
	 jL3UMKKY4ZziJqhUKacm2tTOjDnqFjNPxPfQRdE3ovoka0j1w902C6jKSsGeXGLnvj
	 A6HJz9hk7X0ncTSmIKQjPLwtQAxZzybWvrJqf8pDJQBlhNJfwSXWeASVhIacqKzS9v
	 n0xxd1dpSClO7lVYkW/hVc6Xu2yJ1Lfor0Anw4n5NFhZ80X/IVN4raupf69soaFulv
	 6YevKWK7wWn7viY43rcJ4sPr8oojRJAejgCmnw5Ns8Dn6VrTWK/D26IA1x083UK+G7
	 rMk9i5BgTrt5w==
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
	me@jwang.link,
	end.to.start@mail.ru,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/10] ASoC: amd: yc: fix internal mic on Redmi G 2022
Date: Wed,  4 Dec 2024 17:18:04 -0500
Message-ID: <20241204221820.2248367-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221820.2248367-1-sashal@kernel.org>
References: <20241204221820.2248367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 08f823cd88699..f87333cb82e06 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -402,6 +402,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
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


