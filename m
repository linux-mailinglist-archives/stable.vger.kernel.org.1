Return-Path: <stable+bounces-127181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC340A76983
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9C81631D2
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587221D3E8;
	Mon, 31 Mar 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0NRa8eK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627221D3E7;
	Mon, 31 Mar 2025 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432874; cv=none; b=Bh8sjuCmT1gC2ilnKZbitg/kCeJ6PQ/PRqK50gLZJh9zJrtft7TJqpZcfpdruIokCDIg/X+toRVzzz5kePTm0y5p8WazwWAdx9IhOFOX/jI+JscLSpYaHmkSX2jLidlyn6KGN5y1wFsFv9D8YRqbuavFOMCoc7eh3Ccfs9a34J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432874; c=relaxed/simple;
	bh=rx1+O9JUgM8Bj5soMdbdw0ZiAQ/YPOKVrNK0GALxoUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NocrgOAyNa1F2mdJjgFELKQ4H8LsiRRP24IGhu2Z2NCDxB+JHPm73v/lOkH0Cg+39dxSVvZ9T+cXXrHmX4kZ09JaYdiCgnk34eLONsLcgW1PjmPdVNiSX+w9pZy7nlHN02hvw9OVe85wzOAspNsg0lzrEg0sLRU9MgaGwvSoWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0NRa8eK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85045C4CEE9;
	Mon, 31 Mar 2025 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432874;
	bh=rx1+O9JUgM8Bj5soMdbdw0ZiAQ/YPOKVrNK0GALxoUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0NRa8eKqwNVp41Z8XtVXfoC09/PHhrQr8rtTlqO/MrRZEd/cn3gtj9HvITTvff4O
	 gOggacH/Gp3RrVQpIqP9ceGqsAGiSwUpd+uqjIuuvEyNdNvFtO38GtdmpiCenTU8zT
	 5VmXs/eEQ9Qm/dBw2gIetJKgDNrKK6tm9qqkNvzee394dWVPGqVVR/3+OjvrFjV5/H
	 1lYErLwIS473ke0mVBecYP3YKLK7uiKi6TTOirJFsEE5dcNl3IgjPlPMm7Z8cHF8o0
	 4AvARW+AhqLAZa1uR3miZGPBqcebf8vvpxZZ7wW4CyFoQq4MWWD+VEApPGsyQRVcfe
	 UiR3sv6lAgSfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	vkoul@kernel.org,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 13/24] ASoC: amd: ps: use macro for ACP6.3 pci revision id
Date: Mon, 31 Mar 2025 10:53:53 -0400
Message-Id: <20250331145404.1705141-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145404.1705141-1-sashal@kernel.org>
References: <20250331145404.1705141-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

[ Upstream commit 4b36a47e2d989b98953dbfb1e97da0f0169f5086 ]

Use macro for ACP6.3 PCI revision id instead of hard coded value.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20250207062819.1527184-3-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/ps/acp63.h  | 1 +
 sound/soc/amd/ps/pci-ps.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index e54eabaa4d3e1..28d3959a416b3 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -11,6 +11,7 @@
 #define ACP_DEVICE_ID 0x15E2
 #define ACP63_REG_START		0x1240000
 #define ACP63_REG_END		0x125C000
+#define ACP63_PCI_REV		0x63
 
 #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
 #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 4575326d06352..b0b4a47cf7c25 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -559,7 +559,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 
 	/* Pink Sardine device check */
 	switch (pci->revision) {
-	case 0x63:
+	case ACP63_PCI_REV:
 		break;
 	default:
 		dev_dbg(&pci->dev, "acp63 pci device not found\n");
-- 
2.39.5


