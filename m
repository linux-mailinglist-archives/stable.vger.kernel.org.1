Return-Path: <stable+bounces-92536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A42289C54F2
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1786B3208E
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBDA226B63;
	Tue, 12 Nov 2024 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdlSWAc/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492A2259FC;
	Tue, 12 Nov 2024 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407854; cv=none; b=cdqyFr+9YuCRJ8nV2DE4EA2wTG1564IqQuor9rwj/puFikLF2ZLdMJDJlxfP+gv3X3bjwHmudm6IN0PckOFI5Qv7cOCXiLIZeS5M1AKU5IRR3QyJqbwrnQQVNynbPBIRayxwXmGKNdiwQo5mIUyqHR4kb6UrMGQsAnsZHKSXkEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407854; c=relaxed/simple;
	bh=5nhxbUVd4BMr9CkDzwLpNS+nnqHfjA6LXhET1XmuVlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsMVtJugG7mkTcH820CJLnyHLtQQ2oAKlG+sITG/pnUn1GQzH56TBZUgL0F9qnVDkMFEMlqMztvuQOCJ4UJ9VtiHODGI+6JsUFKiOXUuvHVpklMEU7F6gXWQ5m/JOGufRvAPaM4YcO+MxE3sHtcRJ2jCmVFMl7Mr2Bvd3GHce6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdlSWAc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A794C4CED4;
	Tue, 12 Nov 2024 10:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407853;
	bh=5nhxbUVd4BMr9CkDzwLpNS+nnqHfjA6LXhET1XmuVlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdlSWAc/dh0nu9wJhI7e+HqBucusiro3qee9iQlq10HCS3WZTa3hc1KkfiFzCH0Aq
	 foYvU4t32vRnOzykAulxLqZsL8whu2NLf2O/Y33H+n6B33x2YJ5m9g/gCZP9PZLdh0
	 WRKadhS5W4mQRsSE3elTKo2DtsP+3AoSIMwjjO3wzqncXVan4sohJub7T9H1GDX3Ys
	 crpT45wyAw6ZpksNkINowKCbafWosRzHr+mEhXBnTFffdNpxJ4DUe/jhR6OQgZnilo
	 HzENclSyBn9ucN5dnKVDjEtSQZsWFLvAzamvJLUGXtp2Zg+k+McG/oMSaNwuSxHwDo
	 XTARcGTZUqFGA==
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
Subject: [PATCH AUTOSEL 6.1 08/12] ASoC: amd: yc: Support dmic on another model of Lenovo Thinkpad E14 Gen 6
Date: Tue, 12 Nov 2024 05:37:10 -0500
Message-ID: <20241112103718.1653723-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103718.1653723-1-sashal@kernel.org>
References: <20241112103718.1653723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.116
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
index de655f687dd7d..589428b8b21a5 100644
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


