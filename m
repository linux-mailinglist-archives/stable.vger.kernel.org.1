Return-Path: <stable+bounces-92487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F79C5469
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EB7284F69
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E1D2194B0;
	Tue, 12 Nov 2024 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWHVFUBi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A42194A0;
	Tue, 12 Nov 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407785; cv=none; b=KGb4ePbyeo7lgkgqYS71+711Tpr1bL8nFUzKK0lsnd4qqIN+e8Cph2hAY7Ajg0Rrpz4Y40+XOcG2W7+rMTIBYojG0B2H1eiFNDRp01pAz6lSVoHJKwNkHORwUfzRBRWRmgX8qieVqRcx11A/uBDmxOMy81jOhS77AS8sgLKsQVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407785; c=relaxed/simple;
	bh=7GwKY79ccA5xjg6JepkJmgD7gsArv5j4lUSLgyceZGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czl9MfSU6U0l7zd+5u/iUdYEM8Gh3/6yuIcpSwjifJPW3mT9b/KOsNHdyJTUNg85ElZvJEF9LJwDrcsmxgTORbu15TwYLrYs57P+LJI1/U98lBepKMs57jWuCLzC3PxeKxDUiWV0DEDs02NH2S+XybLUGlh23Wnw/hdMfAnfJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWHVFUBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A5BC4CED4;
	Tue, 12 Nov 2024 10:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407785;
	bh=7GwKY79ccA5xjg6JepkJmgD7gsArv5j4lUSLgyceZGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWHVFUBizaerxGIhv2WZObQd9FTPNVE5ERm7JDZsOfTcJTYPo4yXeWKOqo52Ha2Gn
	 SVTbviirAFzbwkahsuxvbcy61Qw+YVk8iejqS7PhOxIGcPkm2ccKvIDpK3UMZb0Ms9
	 nhgw9tz7DaxrE796rN7eddFD9I5OBeQz9DxqDo/TrsKheTDQ2cMOhHYflYp9CX01fI
	 is3LaMyypUf7NVjzbQyegh09S5eR4fJ7Gp1I9rayF80/hXKb0SEpFpRbxDX/EPdC87
	 9EmX7hQznSK4mbXCRRChJBaV8CwVWCozKkPz0c9PjK1hLehJLoZaQ0BvMzExz0YABh
	 9G9P19KVQMzAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mingcong Bai <jeffbai@aosc.io>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	end.to.start@mail.ru,
	me@jwang.link,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 11/16] ASoC: amd: yc: fix internal mic on Xiaomi Book Pro 14 2022
Date: Tue, 12 Nov 2024 05:35:53 -0500
Message-ID: <20241112103605.1652910-11-sashal@kernel.org>
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

From: Mingcong Bai <jeffbai@aosc.io>

[ Upstream commit de156f3cf70e17dc6ff4c3c364bb97a6db961ffd ]

Xiaomi Book Pro 14 2022 (MIA2210-AD) requires a quirk entry for its
internal microphone to be enabled.

This is likely due to similar reasons as seen previously on Redmi Book
14/15 Pro 2022 models (since they likely came with similar firmware):

- commit dcff8b7ca92d ("ASoC: amd: yc: Add Xiaomi Redmi Book Pro 15 2022
  into DMI table")
- commit c1dd6bf61997 ("ASoC: amd: yc: Add Xiaomi Redmi Book Pro 14 2022
  into DMI table")

A quirk would likely be needed for Xiaomi Book Pro 15 2022 models, too.
However, I do not have such device on hand so I will leave it for now.

Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
Link: https://patch.msgid.link/20241106024052.15748-1-jeffbai@aosc.io
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index ace6328e91e31..601785ee2f0b8 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -381,6 +381,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Redmi Book Pro 15 2022"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TIMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Xiaomi Book Pro 14 2022"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


