Return-Path: <stable+bounces-229704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMMUJmxswWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:38:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F92F87B9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EB0E31F0B67
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CF53BE148;
	Mon, 23 Mar 2026 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUAeD0ph"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0613BE140;
	Mon, 23 Mar 2026 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282642; cv=none; b=oScvuP5kXveu59xNeUOnXgPUjrE6zNFjVOdwBuMo24Dcm1veyH1jd4jugW1F0fAviYTovlzuk+TJiozbaMwY6AAknlFyMVgWWc3mFb8svdVZ4R+60T73wZcjq4uAKLJPSak9ZeqtwnaAjyO5eOAO3PGZbBkmwYZScp6Ezo6QoYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282642; c=relaxed/simple;
	bh=1j7LZTI104M0fx+Njx3gA7S6y1b8Lfn4yc2ezctwjRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7xs+6LmF7XJiDW0w9+WdPRDcxoF3X/WZWfRBnaPLgmLg6YO1CrR+tmQnqbyJaVJFbH6QtKwJIVKPluc6OHrI1irJXzFnhinUhGbdpXF+lgq3/p+0xD27CgVGIlmVMYUXPOz9fqQwFkWp/4DfbU2ldlZbI/g86bBx6yHAl+vJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUAeD0ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232E7C4CEF7;
	Mon, 23 Mar 2026 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282641;
	bh=1j7LZTI104M0fx+Njx3gA7S6y1b8Lfn4yc2ezctwjRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUAeD0phG+CBqWDTfYANK/aZgJYf4tAB1VxM2bU18X6SPT/cBHjloPuItR72L4Dz9
	 G+C74XJOGg1qT0NZ19Yd3YuLOz/XXjqwIrFVIhDUq32iLUasufXpPsp/687e1GU0Y6
	 s/aiQypey3wqgfkRtfp1VDXKDryTzq2Pdwhj2Tr4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 189/481] ASoC: amd: acp3x-rt5682-max9836: Add missing error check for clock acquisition
Date: Mon, 23 Mar 2026 14:42:51 +0100
Message-ID: <20260323134529.804188869@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229704-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CC4F92F87B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 53f3a900e9a383d47af7253076e19f510c5708d0 ]

The acp3x_5682_init() function did not check the return value of
clk_get(), which could lead to dereferencing error pointers in
rt5682_clk_enable().

Fix this by:
1. Changing clk_get() to the device-managed devm_clk_get().
2. Adding proper IS_ERR() checks for both clock acquisitions.

Fixes: 6b8e4e7db3cd ("ASoC: amd: Add machine driver for Raven based platform")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://patch.msgid.link/20260310024246.2153827-1-nichen@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 0543dda75b99a..a557de7e39410 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -83,8 +83,13 @@ static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	rt5682_dai_wclk = clk_get(component->dev, "rt5682-dai-wclk");
-	rt5682_dai_bclk = clk_get(component->dev, "rt5682-dai-bclk");
+	rt5682_dai_wclk = devm_clk_get(component->dev, "rt5682-dai-wclk");
+	if (IS_ERR(rt5682_dai_wclk))
+		return PTR_ERR(rt5682_dai_wclk);
+
+	rt5682_dai_bclk = devm_clk_get(component->dev, "rt5682-dai-bclk");
+	if (IS_ERR(rt5682_dai_bclk))
+		return PTR_ERR(rt5682_dai_bclk);
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADSET | SND_JACK_LINEOUT |
-- 
2.51.0




