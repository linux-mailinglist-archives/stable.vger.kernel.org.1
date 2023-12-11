Return-Path: <stable+bounces-5411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CAF80CBE1
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FDEFB21230
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B9847A46;
	Mon, 11 Dec 2023 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtlycSUU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB624776B;
	Mon, 11 Dec 2023 13:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006DAC43395;
	Mon, 11 Dec 2023 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302925;
	bh=Y/fWPy6eOLNeEEr/tPtHhud0WX8Ihu8eVmaHugAenks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtlycSUUw8BXX4CJbTTqf/F6n5pxhiiKaEwcl1opaXhvQmSmgcniRrhukpPaPp40w
	 ac9IrfbF0G+Mmle3tdDY19m3BJ65KCQqoJev/mFHKXiEKGohRZldVgWuekxlaONctW
	 U7sR+mhw5drJjmPAYHxL9/kOMGrp8PWfe87HDfK6rYkQMAAw0i075ftBBzDFiUR9ms
	 OILFtX2p26kmawoIUhw2iT4Ynzd8akAxbFbSYJfXMDTKpHNKCdUJtGO/3sFeZbtQr2
	 afnmbA181Kvi/hecug6uLpzLYOu9Uwi2x+3AlhC1+4Lma1PnJH4iaRUbTzWsFwiUeT
	 zyi2Qd/N8eOJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/29] ASoC: cs43130: Fix incorrect frame delay configuration
Date: Mon, 11 Dec 2023 08:53:53 -0500
Message-ID: <20231211135457.381397-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
Content-Transfer-Encoding: 8bit

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit aa7e8e5e4011571022dc06e4d7a2f108feb53d1a ]

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231117141344.64320-3-mstrozek@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs43130.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 1fcbf2ffccfff..0b8ecd917a086 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -579,7 +579,7 @@ static int cs43130_set_sp_fmt(int dai_id, unsigned int bitwidth_sclk,
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		hi_size = bitwidth_sclk;
-		frm_delay = 2;
+		frm_delay = 0;
 		frm_phase = 1;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-- 
2.42.0


