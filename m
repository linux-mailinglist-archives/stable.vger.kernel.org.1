Return-Path: <stable+bounces-92072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC39C38DE
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 08:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AC21C21601
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 07:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020DF158208;
	Mon, 11 Nov 2024 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="QG8CdJMn"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1112CD96;
	Mon, 11 Nov 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308921; cv=none; b=T5+X1vbIhJNFfcfoK27L6h/kuDOwEOvPUHarILo6UQJ5gN9skpUM3pjowYeN9TlRYQOYRMMlq2Urn+y4GvrYU0kCeMC8N/pTbhOHrqM6fEWHpjagTOrV6zqurUA8zMdUIES9gc9gCf2cduabv0hMtfFmKKLKkaKvMfOcw9di38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308921; c=relaxed/simple;
	bh=CF+dsPmzpeaGkHWSxUIfz417GGQpHf/URlnUcDoYaKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3Mi323hKdS57lu/rIE36nz2sD87jLXzRKkTtdomOIxM9xvLE8H0UhOKGCCJNXPj5No4FK2Fv5o4ghlDi3nz9fd2qFMPU9nXvdN+U/Hm4WYoO8uyHtp9nMalCvSFD6h7AtTF9bCmGl/orGn9o4AFv4bLRjHNGqzY8pCJmea4fCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=QG8CdJMn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731308906;
	bh=8QmHvcr3CTzmdCYPM9bROAh3NfDJoXeenRMxcgM9Pf0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QG8CdJMn3zEP5EZh7XqJw4JagpcS3xGhz8iktbqESfW5rhSLCSoGgTkCx3qzzEMH8
	 3QzdTeiZUO8GuSBe3DmQ7kNR6S2yVg2CuYirskdUA/pXw2VuUe35kuYptYWYOYwz4/
	 93mKb+rlZcsm5EdHJLBgffSWUmbky0RPd6N1zAYs=
X-QQ-mid: bizesmtpsz13t1731308901twad6f
X-QQ-Originating-IP: juPvBCg34Fqg5XG77NBytrqnY/EBevF7QSKBR9Iui0o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 15:08:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14504911163131532168
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: jeffbai@aosc.io,
	broonie@kernel.org,
	wangyuli@uniontech.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	end.to.start@mail.ru,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1+] ASoC: amd: yc: fix internal mic on Xiaomi Book Pro 14 2022
Date: Mon, 11 Nov 2024 15:08:04 +0800
Message-ID: <2948220EEF71E78E+20241111070804.979792-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NV9lVvsB36OpD6PKvxpVWu4dppLkFHolSzsoGioiIcMhKQh5QVAg3xZb
	9mg/D82suvpSyGJy+7m+feSO0Icqtvghjno1IcD4YotLyPbNaMpPcEHUDm2C0Skm/tJnBqC
	42G10zCvvUrjhqVdIUL+5inWUL5Njn4eKorv3psgWIuPsWiRGPI7WVRnQuy6kPQPI7dGRx0
	rY9YL47umjF5Y3R8vH7ksvUMPTsz8n9ssllgYh2ChbjFB69Ib2/6Rc1QV30/Y5qZDR6R8eB
	2L+pSUmwV+3a/VH8XBC8pgjgpbFtl5T+vUHI4SSSbutxSVkIKA5+y2Qv3VIzfTUjLydYISM
	JxOB8JjG8b+F5uWJM+8/cobPsGI/XwAABM6WPpQXiPzlrA8bgiessTD+HxWWZGtoCN5Ufde
	ZOaS9I73FcHTpB409jFR40DsozE02wTiX0pIkpt6bTtMz5IMj1uDLZL2PszDU0fDtCx7YyG
	CjJ4d0UgpF42PJThZ4vBuki00PeiDjKW16ee6yWBz8KyWfXx0QFL8aLcpvKSV1QdP+QvQC4
	ev9jSxM4WTLlEYonDuCHnAP2Hyd4mjqVj7/s+eZlyJPNu+K7ZBj1YkYgy4n2Kg1Ba7AEKrs
	eAe5BlAWtKTPobYBVmmR05EQBCOTPQ3M/YljKvH2lOBx2B61LT+TZE6K8ioj/Q+ubVzliTx
	VDtKiL5Tm3Z5wCcvPe+HtX+I8BcC8Rg/7KcyjpWIYp6CIytbUB8V2isXqahbTaqD4Ettt0B
	HYeSwxvUNTjDNPHnyA+/mDG9DFbc1DRcys9P7MfFm9AokFlqrlXvI5c04e8EXjiwL8LoRVq
	8MF/ZufFO5tj5ZvDTqOAmc3Xo3QxgNAwv6638/Elpx0nxGBuJTqTdiDIPjOEUm64ctHuqyr
	BkarpBHTEq4HKQ2ndARiHRgArVHnOkKk5blPlcfY+Lhp4t1eq2RrnvNwTWoxsvc312xMRm0
	EIz7Huj5OPTmm7R8svg2IFopHkbafCFvuOq5LC4hInJLWHcEAGc9phFjg5t9D3BjhaBqYLo
	AHhGVqF21ssNej7j7TvdWp/noAECA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

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
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 76f5d926d1ea..e027bc1d35f4 100644
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
2.45.2


