Return-Path: <stable+bounces-83741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF1E99C26C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1061F23B9A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D554E146A68;
	Mon, 14 Oct 2024 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="NnVkluPT"
X-Original-To: stable@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B0231CA6;
	Mon, 14 Oct 2024 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892924; cv=none; b=NnipnYpkuVZYAEPX+m841JxfYySjIYmRoxmgGCWW/S3UfP7h3pwtpzpFNelnMcuX9fiVPYqh+BhCcXQ+jwYTOV9hhR/X3yVfee2g/FygIjB/xGw3tTDX2I8ug2uw2f0qW5ZFO972TrRQyHyEqamQE0Q6sDUlqKpGiSL7z+QSI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892924; c=relaxed/simple;
	bh=8QXd52PSDByTuMxAbtMLnunnTIIo8yWGgJnINtcoo5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kF20khZkp6ibmwDamXbu8Lcg+kaznQoD0wNWXRAxTSrMUsNhZuqxATXESmdWrdV+rHae8kdEEU7KpniG45LqflqxaOtqz89lFw79E7YER8WGWtxhJTLJf5oymEwPjayXrm2qx5IeWGj5hVqomXM7u0+kqRsZaeNFJ7SGYcnuehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=NnVkluPT; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 0581AC0005;
	Mon, 14 Oct 2024 11:01:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 0581AC0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1728892911; bh=nruzw+jdQvZ8QxnnUXsNHIRBRz7OhS6CrLOVWXYhdNU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NnVkluPTRVpHyt3x+41XDnPVVIQ0B4tzdg5WxH0gwZU9nlieb56Vd7DaUFEbwwEb0
	 eXlTqxp0T3XnAleJE2FGeJJs2QOWeZDFhCq/G29UQxFq8TuUvn0WJj9hpv/djsJkeV
	 NKa0BYBO3KxlT9Hgyag4MLki/ndJLP/vUasvA6r9T3q0wfferWDvqpn2nuEXxS5Z9N
	 cJmIAiWpcvgGrucZzRIxGdU/5/TcsVODIm7uKqc+iYFnUaAV38PXiovVNgAqs03g8B
	 svr+a5PlN5lmLycmSgC83KGh667GtMUT/TLJdjii6gq5Z2z/do1HsxMg0gAw9bkZts
	 /61Zhb4CwSZyw==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Mon, 14 Oct 2024 11:01:50 +0300 (MSK)
Received: from localhost.maximatelecom.ru (10.0.246.155) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Mon, 14 Oct 2024 11:01:49 +0300
From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, Ma Ke <make24@iscas.ac.cn>, Mark
 Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, <derek.fang@realtek.com>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 6.1] ASoC: rt5682s: Return devm_of_clk_add_hw_provider to transfer the error
Date: Mon, 14 Oct 2024 13:01:25 +0500
Message-ID: <20241014080125.28298-2-v.shevtsov@maxima.ru>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188410 [Oct 14 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;maxima.ru:7.1.1;patch.msgid.link:7.1.1;127.0.0.199:7.1.2;ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/14 07:21:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/14 07:18:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/14 05:57:00 #26750521
X-KSMG-AntiVirus-Status: Clean, skipped

From: Ma Ke <make24@iscas.ac.cn>

commit 3ff810b9bebe5578a245cfa97c252ab602e703f1 upstream.

Return devm_of_clk_add_hw_provider() in order to transfer the error, if it
fails due to resource allocation failure or device tree clock provider
registration failure.

Fixes: bdd229ab26be ("ASoC: rt5682s: Add driver for ALC5682I-VS codec")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Link: https://patch.msgid.link/20240717115436.3449492-1-make24@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
---
 sound/soc/codecs/rt5682s.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 80c673aa14db..07d514b4ce70 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -2828,7 +2828,9 @@ static int rt5682s_register_dai_clks(struct snd_soc_component *component)
 		}
 
 		if (dev->of_node) {
-			devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, dai_clk_hw);
+			ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, dai_clk_hw);
+			if (ret)
+				return ret;
 		} else {
 			ret = devm_clk_hw_register_clkdev(dev, dai_clk_hw,
 							  init.name, dev_name(dev));
-- 
2.46.2


