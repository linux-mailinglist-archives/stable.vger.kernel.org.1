Return-Path: <stable+bounces-144366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A58C3AB6B37
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 14:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853011759EF
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FC727510D;
	Wed, 14 May 2025 12:15:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369620C016;
	Wed, 14 May 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224936; cv=none; b=UJNjd5iM4z7Ni0hQKeNLsimouoG1FSvZtqyCRqz2n4VyzXfdJSCSXVY53filB6fNYowgINbDeq252Talta3qgIc35sDaTE7reY0ER1l5i7P9fI5GJnGMp7bWE41tZLUUxtoFhULZJctHrOK/fwyqeB2svnGpj0ejpcNjxDphsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224936; c=relaxed/simple;
	bh=ZEtvNC+fDpJZ5ywYIZizTzTkNG6vdMAo0112fJ1kD50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUVCJqgyYywDsBBY0XqDRm6ETgTCvnX4Ihfhl86PoB4+V3q92btCAS4DaXttB2Z1WYCnEbFrZqcih1cN4glD43cFmxKrhHnXJaZuENbrOry0CHsrcV7VkWHk7XNuxo0tQoAs9mfEyE8XFy5INxXLITFmoLLRquRN8/7JguQKvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAAnyvoZiCRo8oIAFQ--.48875S2;
	Wed, 14 May 2025 20:10:03 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: Vijendar.Mukunda@amd.com,
	mario.limonciello@amd.com,
	venkataprasad.potturu@amd.com,
	gregkh@linuxfoundation.org,
	kuninori.morimoto.gx@renesas.com,
	peterz@infradead.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: amd: acp: Add null pointer check in acp_max98388_hw_paramsi()
Date: Wed, 14 May 2025 20:09:39 +0800
Message-ID: <20250514120939.581-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnyvoZiCRo8oIAFQ--.48875S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyUJw45Ar1xury3Jr1xuFg_yoWkAFbEkw
	1rWwn5ZayDKrZayry8A3yfZrW5Zw17ZrZ2krs7tr45CFZ5JayrCryDWFs5ZFZ7Zry8AFnx
	Z34kGr4FqwnIyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwCA2gkZJ93aQAAsj

The acp_max98388_hw_params() calls the snd_soc_card_get_codec_dai(),
but does not check its return value which is a null pointer if the
function fails. This can result in a null pointer dereference.

Add a null pointer check for snd_soc_card_get_codec_dai() to avoid null
pointer dereference when the function fails.

Fixes: ac91c8c89782 ("ASoC: amd: acp: Add machine driver support for max98388 codec")
Cc: stable@vger.kernel.org # v6.6
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/amd/acp/acp-mach-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index f7602c1769bf..a795cc1836cc 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -918,6 +918,9 @@ static int acp_max98388_hw_params(struct snd_pcm_substream *substream,
 						   MAX98388_CODEC_DAI);
 	int ret;
 
+	if (codec_dai)
+		return -EINVAL;
+
 	ret = snd_soc_dai_set_fmt(codec_dai,
 				  SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_I2S |
 				  SND_SOC_DAIFMT_NB_NF);
-- 
2.42.0.windows.2


