Return-Path: <stable+bounces-124132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1451BA5D90E
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 10:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF00C1895B73
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D561239083;
	Wed, 12 Mar 2025 09:15:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7A41DFE09;
	Wed, 12 Mar 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770931; cv=none; b=Bs3YJaEf5iZqzj1aL4bWvmpS6pGJdh/OjbTNY6danM+ZzXKyoyzBDC516DW+4K1YpARNsa59d6o303rO0aErkX0y5vSm3RuI2rmvzvHenz/kUpuZ1+IsCFVQBC5FscJ210aIwnuG1Oe/NlI/R+5PegYQyygTQguY/CkHssMXOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770931; c=relaxed/simple;
	bh=l7jMbZfBiFeALlL27WJ4EFhnmaU6KMCEYHn0gqy7FzQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jXSd+w1RPM1eMgn2PE1jfJo6woU2QAemlfq8M4ejcpnO76/Cpm1x5wk74Jv62Nczn335qOBJC/guHBE69ekYu+PQR2Oh82fnp2LdhS3oOs7Mo2iTg3yjZ2sN5bcW7FcXWP8TBhef9XjRt7fcsI0trgFxcEC2fZc9GM74MV1GcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (188.234.20.53) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 12 Mar
 2025 12:00:14 +0300
From: d.privalov <d.privalov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Dmitriy Privalov <d.privalov@omp.ru>
Subject: [PATCH 5.10 1/1] ASoC: ops: Check for negative values before reading them
Date: Wed, 12 Mar 2025 11:58:29 +0300
Message-ID: <20250312085829.52758-1-d.privalov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 03/12/2025 08:41:23
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 191694 [Mar 12 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: d.privalov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 188.234.20.53
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/12/2025 08:44:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/12/2025 6:37:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Mark Brown <broonie@kernel.org>

commit 1601033da2dd2052e0489137f7788a46a8fcd82f upstream.

The controls allow inputs to be specified as negative but our manipulating
them into register fields need to be done on unsigned variables so the
checks for negative numbers weren't taking effect properly. Do the checks
for negative values on the variable in the ABI struct rather than on our
local unsigned copy.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220128192443.3504823-1-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitriy Privalov <d.privalov@omp.ru>
---
 sound/soc/soc-ops.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index a83cd8d8a9633..a1087dfee532d 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -316,26 +316,26 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	if (sign_bit)
 		mask = BIT(sign_bit + 1) - 1;
 
+	if (ucontrol->value.integer.value[0] < 0)
+		return -EINVAL;
 	val = ucontrol->value.integer.value[0];
 	if (mc->platform_max && ((int)val + min) > mc->platform_max)
 		return -EINVAL;
 	if (val > max - min)
 		return -EINVAL;
-	if (val < 0)
-		return -EINVAL;
 	val = (val + min) & mask;
 	if (invert)
 		val = max - val;
 	val_mask = mask << shift;
 	val = val << shift;
 	if (snd_soc_volsw_is_stereo(mc)) {
+		if (ucontrol->value.integer.value[1] < 0)
+			return -EINVAL;
 		val2 = ucontrol->value.integer.value[1];
 		if (mc->platform_max && ((int)val2 + min) > mc->platform_max)
 			return -EINVAL;
 		if (val2 > max - min)
 			return -EINVAL;
-		if (val2 < 0)
-			return -EINVAL;
 		val2 = (val2 + min) & mask;
 		if (invert)
 			val2 = max - val2;
@@ -429,13 +429,13 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	int err = 0;
 	unsigned int val, val_mask, val2 = 0;
 
+	if (ucontrol->value.integer.value[0] < 0)
+		return -EINVAL;
 	val = ucontrol->value.integer.value[0];
 	if (mc->platform_max && val > mc->platform_max)
 		return -EINVAL;
 	if (val > max)
 		return -EINVAL;
-	if (val < 0)
-		return -EINVAL;
 	val_mask = mask << shift;
 	val = (val + min) & mask;
 	val = val << shift;
-- 
2.34.1


