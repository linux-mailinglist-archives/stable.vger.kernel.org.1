Return-Path: <stable+bounces-163675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CD1B0D5F0
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DF63AC318
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 09:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8172DC348;
	Tue, 22 Jul 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDYDRt07"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FD23AE84;
	Tue, 22 Jul 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176385; cv=none; b=oAtIxfhAR8fkx3Hso/PDfwFtzgA1/LlGnNN68mF8fk2kKiV3+cxWwhupV8m9DqlIvCaToSjq0MZIlxQUEBUhiTMo21IWtwvqKmTMo4oVCQhtbyroTWswY696ncbXwdiqK6/lfMNpXbI+mCZg0zhVHT9hdP3ejTZ/JDqiSb/EJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176385; c=relaxed/simple;
	bh=5vnNECADTxAOgPhQ4LLy+ss4yNtSv0kIIcuhLrkYt0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lpvQQYrQFOt1nG6oQOans5pu871771OlAWciZ7/2GfZQjABTCrXshwXL09nukTzVJCTlxM8Rir7wD6WVPcjuJlr534Udq8wPAERA0ERNQ4E+KwtuljRdXPL42o1nNDZKildxJI5lbYl92lnR6nSJB7KfL0blPH831QPtJJ16kIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDYDRt07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A777C4CEEB;
	Tue, 22 Jul 2025 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753176384;
	bh=5vnNECADTxAOgPhQ4LLy+ss4yNtSv0kIIcuhLrkYt0A=;
	h=From:To:Cc:Subject:Date:From;
	b=NDYDRt077GzA3pfTzc+6kAbMU8jVwXRQrZJp9Ubcq1qnpVvfXUTsJPaRAJBuku+rv
	 YtchbNEhk7ci/wtEK+umbmfvpcOA3hGeq9FAfMmPyJh5/53RLfNyMt0LwBVmuve7te
	 DbvVdXDVtQ16cLoAVDyhxxZ59GgjaEpKxL3Sht/Ie5YiY9rCChsBTUqvHdaoVAKBRG
	 8MMUlBq4qqFWnjThstx3pLV24uwLq0L4UQqIkZp7ZQBQIGOjamqJyTCKm8mDpCA1s5
	 Ah6S7ZVYQEJygY1ozv9d6iYQekThT4gcEpp1+D1Zh4Bl65nOeKVCNmn4BDDbk8s0KS
	 YYnPo+0vhe4KQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ue9GH-0000000005N-2nDo;
	Tue, 22 Jul 2025 11:26:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH] ASoC: mediatek: common: fix device and OF node leak
Date: Tue, 22 Jul 2025 11:25:42 +0200
Message-ID: <20250722092542.32754-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make sure to drop the references to the accdet OF node and platform
device taken by of_parse_phandle() and of_find_device_by_node() after
looking up the sound component during probe.

Fixes: cf536e2622e2 ("ASoC: mediatek: common: Handle mediatek,accdet property")
Cc: stable@vger.kernel.org	# 6.15
Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/mediatek/common/mtk-soundcard-driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
index 713a368f79cf..95a083939f3e 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -262,9 +262,13 @@ int mtk_soundcard_common_probe(struct platform_device *pdev)
 				soc_card_data->accdet = accdet_comp;
 			else
 				dev_err(&pdev->dev, "No sound component found from mediatek,accdet property\n");
+
+			put_device(&accdet_pdev->dev);
 		} else {
 			dev_err(&pdev->dev, "No device found from mediatek,accdet property\n");
 		}
+
+		of_node_put(accdet_node);
 	}
 
 	platform_node = of_parse_phandle(pdev->dev.of_node, "mediatek,platform", 0);
-- 
2.49.1


