Return-Path: <stable+bounces-58766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D27B92BF99
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9931F25B90
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303CB19E812;
	Tue,  9 Jul 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkivjuzy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49119E83C;
	Tue,  9 Jul 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542017; cv=none; b=PW2YtQ/CC+1/d4Xnm49M9eKnHClJRFuq47VZBBY45p2EqVpYibC6Zw+YbI78IUS4NJShjMNjv47rat0rgBw2SV+D++xqihto3WLigwDgJpjfSUeWh0JGIF4MDdKQ6Ehez6NWUiO2YlcyEfy6rAmL38uYriKZqn2r43M6ycreGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542017; c=relaxed/simple;
	bh=J6YqJEMNS75IDVq0o/B5Lwfkpd8jPScozUX67ZONyfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMZTB7/1aMeC2E1lRcRundxSTCSFDDWms0UTKgX+bApLbHtMiaPcnmC1nDIJMYhipLmEFhtVlPN6LpDlJPKD5ldKG5V56gpU9EA0XiSyd9U3GjnkhAYOv3F4yiMrxG+eGoWv61bClCUCmx09ynRRxyprxtPNhWOXnyLpCoZ8IAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkivjuzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8DFC4AF0D;
	Tue,  9 Jul 2024 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542016;
	bh=J6YqJEMNS75IDVq0o/B5Lwfkpd8jPScozUX67ZONyfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkivjuzyK4HVoqpgLWo9BKcrNclv8vC3D8PmCRYmMVr+yDPl/kD4EB4GAsZfq96Bb
	 98+LXUmKBQP8JAOqh7RrDB/HZXO0Te9g8HHqq9t1pMRB9LmAjClv3ncvyQtSXgn82g
	 xV7sh6Y7kUfnSThz3sBLLT3rLOHEuNJxioc6hg6p3Cv3Pyk+ffixhqbLRX5pnOKaRq
	 CYd/tpl8p0MGhmRIRjLyifUo8vZQQeSl370HnNvdse/wXyvXn9rj7+Co3ISHxEe3gO
	 tt108AD31FTiyrn4VOMWCa49AkJvqHDtF/Ftd/RkT46oaKgRbNWUKff9/bowv2VfJg
	 IY/HemO8AWoBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Yu <jack.yu@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 04/40] ASoC: rt722-sdca-sdw: add silence detection register as volatile
Date: Tue,  9 Jul 2024 12:18:44 -0400
Message-ID: <20240709162007.30160-4-sashal@kernel.org>
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

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit 968c974c08106fcf911d8d390d0f049af855d348 ]

Including silence detection register as volatile.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://msgid.link/r/c66a6bd6d220426793096b42baf85437@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt722-sdca-sdw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index 65d584c1886e8..0a14198f8a424 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -68,6 +68,7 @@ static bool rt722_sdca_mbq_readable_register(struct device *dev, unsigned int re
 	case 0x200007f:
 	case 0x2000082 ... 0x200008e:
 	case 0x2000090 ... 0x2000094:
+	case 0x3110000:
 	case 0x5300000 ... 0x5300002:
 	case 0x5400002:
 	case 0x5600000 ... 0x5600007:
@@ -125,6 +126,7 @@ static bool rt722_sdca_mbq_volatile_register(struct device *dev, unsigned int re
 	case 0x2000067:
 	case 0x2000084:
 	case 0x2000086:
+	case 0x3110000:
 		return true;
 	default:
 		return false;
-- 
2.43.0


