Return-Path: <stable+bounces-58801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E9F92C022
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403B728277A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D9619EED8;
	Tue,  9 Jul 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeHNrylf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4E19EECE;
	Tue,  9 Jul 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542115; cv=none; b=qusO3o8WClvHWlCb0s6/11rYxXiaE7DabF+/IOpcPlhyDICPoRRmLjjNyuuwfHuoLop+14bBr+mt3g3TaRCW8zw/TylqmnYh8PXARXoO9WQeVF4vDQ2HuQuWicSCxY4H1NSAMzQcf+qpJ1A2mCdD2W94TD5TE9xT3BIcEa8NsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542115; c=relaxed/simple;
	bh=x4j+mPJIwJCDbaZ9DjFvkJ8ODGnYpHCdSfBKribIdbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtMnfovdDI7wevSD3GxcLJ83WNU1fD0rxa7fQlMsOknCg8+LOvPLsuVE5b/FjAzquG8+uiKmlCFnJ4QvCVZZAPt4+tBNCGhpZAMdoNBrmPQ7F7AIF8F6cpvxU0UsM2J0Ri3CPA/njfbMjgkiRLecdx4PO9zzLZMue7qfkERkcRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeHNrylf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500D9C32786;
	Tue,  9 Jul 2024 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542115;
	bh=x4j+mPJIwJCDbaZ9DjFvkJ8ODGnYpHCdSfBKribIdbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeHNrylfNef6+3vNEK4chCDE85vUheVuPkL0TSIp+wcpcl8IZMLuTp/555bdvPzsn
	 QkfEfd1Cy2Wj58s4JfnqU0vrZpT4Acxr7+S7adoPk+3gu6BNYY/JDQz36ozGJ8YBEZ
	 Rd/0GrAMCKdj88YTBah/1MA1Pu0lEOTjYQZsbew2GHSr4tIfSyK6sxK0ZSUbYvpJxL
	 xtIDdLl6RK2GqFiKPgcwAk7Nzb9+S4HoMEdby7xkM57TQGOryKW7JV5g17wJ7g2ERm
	 ntQMSOi46os08QRtDFOCqOWCPACInQhoiJu/pveNo16+fK9fMG7YFJ58/9wxUtqfzF
	 9scHTWcmADfgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vyacheslav Frantsishko <itmymaill@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	me@jwang.link,
	end.to.start@mail.ru,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 39/40] ASoC: amd: yc: Fix non-functional mic on ASUS M5602RA
Date: Tue,  9 Jul 2024 12:19:19 -0400
Message-ID: <20240709162007.30160-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Vyacheslav Frantsishko <itmymaill@gmail.com>

[ Upstream commit 63b47f026cc841bd3d3438dd6fccbc394dfead87 ]

The Vivobook S 16X IPS needs a quirks-table entry for the internal microphone to function properly.

Signed-off-by: Vyacheslav Frantsishko <itmymaill@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20240626070334.45633-1-itmymaill@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1760b5d42460a..4e3a8ce690a45 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M5402RA"),
 		}
 	},
+        {
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M5602RA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


