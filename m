Return-Path: <stable+bounces-127205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88838A769C6
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B91C165C1E
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D881239082;
	Mon, 31 Mar 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CacBY1qD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F88221549;
	Mon, 31 Mar 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432939; cv=none; b=e/NlIdc26pbqO8ZrS4+Pyh6YoCsWVeragP31xn4vy6IpRdcQHnehj69UdeVmZAS4ONA6Po6Fh0Hnn9AiFxsAC8mIJyyDzKwq0o/lf2RlCdoNooMO2IVR/SzRLlYW9WGiEal15BHO6mSrXXgeNnqBSHra6C30c+PlM+SdnMhkKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432939; c=relaxed/simple;
	bh=nWXOps5CrRXmBicJhgPk48unPrActNaIFOJJYkRY0jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=He6CGPAEv+yxvVV78eKcCbTQNm45iKZCpmwQ0wl0Jt73Tp90SFR1li/RmEasj4r3XEWyLoZEwSTfGDd71PHjeoK5iom9cCxiZM3rdnlm2QGwi0p7ppSkz3WH5va5i8jL/GyamRYYU2zXEqYo0xMIg+96SA2DH5Vp9enD2cmuyok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CacBY1qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FD7C4CEE9;
	Mon, 31 Mar 2025 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432939;
	bh=nWXOps5CrRXmBicJhgPk48unPrActNaIFOJJYkRY0jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CacBY1qDKhTCSTtr7Wzu5udRsGW67B7Tj0a4zI1TonQ8mKuB4ccE6jB+E596464//
	 lRMBq2ITO9UBiHjNXXZfk623shiwo4PwY5SMX1hmj+Dj5zvgFIVp0YKOei4NNMhiV+
	 HBzATu/52fa4PEkg54EWuYJrO+DBq1Ws+7CG7hpxPPUTts4Ip4lQMe6ng45bAg3ITH
	 bn26QrE8DkXxJQupShN1sI1yilKoGwhjLY5rS5b6TBx1aM9Xr8KoMAg0S+uErcalaf
	 wwrCHxDhtEYFrmcn01A2HvXntj4nStddmPIHozPSlU/N/hTjBrk5RlNUSycQfy7h01
	 nuo8xwYLVOlhg==
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
Subject: [PATCH AUTOSEL 6.12 13/23] ASoC: amd: ps: use macro for ACP6.3 pci revision id
Date: Mon, 31 Mar 2025 10:54:59 -0400
Message-Id: <20250331145510.1705478-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145510.1705478-1-sashal@kernel.org>
References: <20250331145510.1705478-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index 39208305dd6c3..f9759c9342cf3 100644
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
index 5c4a0be7a7889..aec3150ecf581 100644
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


