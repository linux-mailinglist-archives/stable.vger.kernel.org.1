Return-Path: <stable+bounces-72899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA4796A917
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40921F257C0
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB101D017C;
	Tue,  3 Sep 2024 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re+SZIRJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBB1DB929;
	Tue,  3 Sep 2024 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396323; cv=none; b=HCXDyoxwbV41kncgtxFbdSKSp+Sc6OvXmgDXUatSeHUfXCvblfKKs/fmFVWJIpbIVkCI3lrl6BillpZqaEcwn/wanAbZqQH0cjW8kRI1vUX/V4tef27nCEIf10EoNORa3r6pHipbX55Ml+5LryKvKPi7aT9VkPeRpBNzgCxMJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396323; c=relaxed/simple;
	bh=JHC3XbwnG6RXQ82IjQxBRIYsd3Y84WiLIaIjpFAKb5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQzLZLBiGEqHJYognsd1zsdgRY8oHxkbrsUkTcCiFDCqUoz8HNcUuNXKpgGcLePgHpgeh4f6Dh+Q4uB8XoIH5jMS2N+nZ4vFcyqiOqmqenO44rjGiZxq9VlcowN9jbfwAITjcn4Bw0ld6KDw3PWJUo7LdH/joDeKDUQyT/JpRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re+SZIRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1A0C4CEC5;
	Tue,  3 Sep 2024 20:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396323;
	bh=JHC3XbwnG6RXQ82IjQxBRIYsd3Y84WiLIaIjpFAKb5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=re+SZIRJWU/gDPuzrGs5fXsCaxhN1dPPPMDsDPC38V1pR9SpNTVkt7z4JHJdav1WM
	 vTWer3Yy5dH0iEiys7qPmEeQWPQ8PeKrwapqGWInPJbKM2TPLbsRghyG3CJZ8+0Lo2
	 T5o1JLs4auZ/sKj+wCfe3BgqtePODpTUokVfKMSVgwu/+i7kz6inutVUlHH2kO2TWi
	 7nJK+NCbCnaHCOu39fjm1eMN+6RKIlngcpmrqJv2XG60oWZR3e6Ubajqi5DmO8m0VQ
	 0TAGT821d5THR6NYy7Osawq3m81aEwarZOrDDIQq7uKsIpCavMlH7PGWyzJozdZkz2
	 kei5BrysCfnww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hongbo Li <lihongbo22@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	emil.velikov@collabora.com,
	cristian.ciocaltea@collabora.com,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/17] ASoC: allow module autoloading for table board_ids
Date: Tue,  3 Sep 2024 15:25:17 -0400
Message-ID: <20240903192600.1108046-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192600.1108046-1-sashal@kernel.org>
References: <20240903192600.1108046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.107
Content-Transfer-Encoding: 8bit

From: Hongbo Li <lihongbo22@huawei.com>

[ Upstream commit 5f7c98b7519a3a847d9182bd99d57ea250032ca1 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly
autoloaded based on the alias from platform_device_id table.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Link: https://patch.msgid.link/20240821061955.2273782-3-lihongbo22@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp/acp-sof-mach.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index 972600d271586..c594af432b3ee 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -152,6 +152,8 @@ static const struct platform_device_id board_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, board_ids);
+
 static struct platform_driver acp_asoc_audio = {
 	.driver = {
 		.name = "sof_mach",
-- 
2.43.0


