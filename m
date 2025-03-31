Return-Path: <stable+bounces-127154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09142A7694D
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082361890DCA
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A07822540F;
	Mon, 31 Mar 2025 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT6CCTi5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15199214818;
	Mon, 31 Mar 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432798; cv=none; b=dtSCxESoLCMcPTv9u7OXVepCeTvtWKkDFQ1NAz4epbvd31VjSFBUb1sFs/cS1uHv8+BfocwV4I4iT/j5dCWmjg+pOhM/0bSBX9LS1HexSf7blEwNElKH9zGr41wxP3WRK6y7pnPZHtB8eall66IWQ420FekiblgkAIUQSvTDdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432798; c=relaxed/simple;
	bh=0LJdgguMi0We6lrTakf8gcKH2u1OohuUr2cVkweiHVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/Pe7WtMuColL/v/2piYq6ydyfd4Rixe0lCAUWt8hxZ5B4M+vqMz1MyaOQKmuRZjbD9SA97hycnZuDRYUpbhPCw58HEYosvASZRhuHB+i2+LkWq/nLNG7tONdZC8W3ChuWiMqSNGt/9ykYW1PR/jkK3Ta3bGrAq6XvJwxXJUYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT6CCTi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7EAC4CEE3;
	Mon, 31 Mar 2025 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432796;
	bh=0LJdgguMi0We6lrTakf8gcKH2u1OohuUr2cVkweiHVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pT6CCTi50yoLlRiW1rc/0FgxZWwratRgty7mkZ/zi4cJutciqaGAEDrlUFa0FgRxt
	 NBiAQMD7RaIYlFcVWsZqF17P9h3qzaaWqFEX56WWSOCFI4VvL3x+GdLEX41tqlyWw2
	 sh7Q9kgLX89N/Ade41YIHPyaHi1gClXwFI+Id1aXrPZ/NvkbeAq0QE35y0is8YgqwK
	 KVA5hV5zPJEr/8iMPPfsBdmoAUhffzQIf8cOeSWml+p6JlYu/fQz+6DUuCMjoqo1Hd
	 af2IZQiCRquLTEl5YXFepd9Kw8DB/dcRShSePkYAl7h/GCiDg2UxttLEuo7GR8DbSV
	 IgJw9eAp5Tcag==
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
Subject: [PATCH AUTOSEL 6.14 13/27] ASoC: amd: ps: use macro for ACP6.3 pci revision id
Date: Mon, 31 Mar 2025 10:52:31 -0400
Message-Id: <20250331145245.1704714-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145245.1704714-1-sashal@kernel.org>
References: <20250331145245.1704714-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index 8b556950b855a..6015dd5270731 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -562,7 +562,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 
 	/* Pink Sardine device check */
 	switch (pci->revision) {
-	case 0x63:
+	case ACP63_PCI_REV:
 		break;
 	default:
 		dev_dbg(&pci->dev, "acp63 pci device not found\n");
-- 
2.39.5


