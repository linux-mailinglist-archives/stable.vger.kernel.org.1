Return-Path: <stable+bounces-67590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5C3951229
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42A41F2363E
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C67914D290;
	Wed, 14 Aug 2024 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUpjmb07"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317714BFA8;
	Wed, 14 Aug 2024 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601740; cv=none; b=bbkeKrZCqb9a4khrRlb5MhbvZIwDQ7hE9u6Sz7EUpqHHeHVqR4VXljyz+nFa8gK4rbUMvJtk2YaTBc6LZGi9ymypvvAgLwAkq6UmyDhXc5of+g9GhgjnKFeN6NmZGwBBFevn8a9nQ36nYLUxWiK52eiJ3s+rPtOU2aTcK6Vj/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601740; c=relaxed/simple;
	bh=vqpGVm8dGbEXlxnCRI/pCgKM30W1bYi0qYfwZYVyTN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/wh9ii5blFNnsh3ciIhnem6Gn8xRAHgMNfKz3NIs4Lelx27QMPmA50k1fom9QKGCYmjwW8w+67RjdYz0jrvr8GzDpE189mdmowofIz766Hzl0fJgLE6yViNz6lgj0gh2yUaIVq77IitAWgL4K9aISTtZXCDpZmXdJS5mWL/T3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUpjmb07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE40C4AF0C;
	Wed, 14 Aug 2024 02:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601739;
	bh=vqpGVm8dGbEXlxnCRI/pCgKM30W1bYi0qYfwZYVyTN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUpjmb07wdL7ccA/xL7Nddm3bm3ypKZ0KSUEwDtyo+7NNheo5jxSk8O6d52tfqbOl
	 YyWAuj6gd8/h7yxminGhNmYZepsMQqxxN3wcMRjDaqwOFC7BzkuKYezIaK5bOL1EcK
	 Rw0ZrvgoStuyoFs2U2Iza/Tl0b1zd/B1aZ/nsND/skC2NBcuRjAGdLXtPmMhLlW9i+
	 KyWrYmbX1lpEEGn13YTpZAuw00KP80vachEEMQ7ibSMiUhOY5tDQf5EQc1PyGlxYaD
	 czIUOvcfl7GKIGBXW/7xqzTF/8iBE9QnD3JC5mV/DihPej2ttksYZy6kK+iltoD46e
	 ehVBlKCohL3jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Krzysztof=20St=C4=99pniak?= <kfs.szk@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	end.to.start@mail.ru,
	me@jwang.link,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 4/4] ASoC: amd: yc: Support mic on Lenovo Thinkpad E14 Gen 6
Date: Tue, 13 Aug 2024 22:15:30 -0400
Message-ID: <20240814021532.4130407-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021532.4130407-1-sashal@kernel.org>
References: <20240814021532.4130407-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.104
Content-Transfer-Encoding: 8bit

From: Krzysztof Stępniak <kfs.szk@gmail.com>

[ Upstream commit 23a58b782f864951485d7a0018549729e007cb43 ]

Lenovo Thinkpad E14 Gen 6 (model type 21M3)
needs a quirk entry for internal mic to work.

Signed-off-by: Krzysztof Stępniak <kfs.szk@gmail.com>
Link: https://patch.msgid.link/20240807001219.1147-1-kfs.szk@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index c438fccac8e98..d88d02fac6728 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -220,6 +220,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21M3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


