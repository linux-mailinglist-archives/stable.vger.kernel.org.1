Return-Path: <stable+bounces-140162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D43AAA5A3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE08B46606C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3086315FB8;
	Mon,  5 May 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9dUEsfE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C428D845;
	Mon,  5 May 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484255; cv=none; b=C0qigq8stxUirXZouS0wTfRwVUwvteB0OAsbSH/eIVjqJ0ZP1MIF2baI7kETzpRUMEILSa56GcLng2JF3E6rDAUgm6Atnox22hJqYYOGYJXReaf9y6uZu75AZltmw0aPHmenhq8fF97p3yoTZOH8ApJ9ADJFqhHcdxTEfYw337g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484255; c=relaxed/simple;
	bh=z+fMMvtWpwcVSNZK80WDtwzO/qfwNQN/M5Kp/sFKa8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QA5P15l3jg0V6ZcbRbSHTgqAWodCpdi61MB3nq+3dh2shAEeGAszbBum+xmVzPx3XmH2FqgBzVhQEdowHRwfDRZa0Pe6CZd2Ye6Lv58f1kFvPwfqXpO/2GIfQeA2hOf6kBXHeOnXuDGrzfyBZoivnaFHzX+cbQyrMf1A5RnpTk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9dUEsfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C9AC4CEE4;
	Mon,  5 May 2025 22:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484255;
	bh=z+fMMvtWpwcVSNZK80WDtwzO/qfwNQN/M5Kp/sFKa8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9dUEsfES/cV/TKo4lO1BafJ5fiA2WeKry29S7pQ6mv3BTESKDXmrcMGu72SDJm9q
	 eWp6Lsq5sNdyncHsko8ZkqM7Z7BAs2y65QgygWdp/jsV0XEYODUe7jmMvq8CTKVV/2
	 TgcwyzoGbdKcRQKbwAG6gehlqoOs8WCtPz9mcGiRDd9cBSOVXgKEdS1nxTpLBFwvNP
	 0i5BaAcPfXzXpzTdPinlvEwTn1yMh5FtmzdIYO1b3fUf0TdTr/P7U2uvJes8oF5SeC
	 WYK2cgIsbHSbue2n1yP85wQZkU7ZzMEK7f6hECcGMLcqPu5r0vXy0gRl2xYQNjC2i2
	 g6escOy15CMKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 415/642] ASoC: tas2764: Add reg defaults for TAS2764_INT_CLK_CFG
Date: Mon,  5 May 2025 18:10:31 -0400
Message-Id: <20250505221419.2672473-415-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit d64c4c3d1c578f98d70db1c5e2535b47adce9d07 ]

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2764-v1-4-dbab892a69b5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 58315eab492a1..bc0a73fc7ab41 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -634,6 +634,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 	{ TAS2764_TDM_CFG2, 0x0a },
 	{ TAS2764_TDM_CFG3, 0x10 },
 	{ TAS2764_TDM_CFG5, 0x42 },
+	{ TAS2764_INT_CLK_CFG, 0x19 },
 };
 
 static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
-- 
2.39.5


