Return-Path: <stable+bounces-228532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ExOLHZPwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:34:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E82F4C2B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DE6731B7B9D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A779A3B19A1;
	Mon, 23 Mar 2026 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o6Yj7Cn0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694443AC0C2;
	Mon, 23 Mar 2026 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275380; cv=none; b=X9b5Q+uMJw6nMOXvTqmWV4t2B+D0oTUUEuZxGFptU/FC7EWnwjPFUHQMz4npBYmMwFJhw+SK33z4EAzepm/y/j3dvPsi0CZBdU/jRNX4PiyO7aX39HxWLAqK2PYZa9X/LK3E94UmO/RaiQZd4S8W1oOO4o5ju7S7s3eCH2Ra3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275380; c=relaxed/simple;
	bh=gCwLCwQV7at4rZYVfUhOydnmWQIiOWil/J2Y4yjLQT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bo2b8s9keUdwjgmQHOIC/HAVYScUsGaJXwFBXxOx5dgtybdGvt4gJzE050sQ0DCCUb5YxjUuK8KMFoKXiJaBix55ZQRzZSSIhXQP/P7cl3cTDwwf5fjleYKFvh2uOylFKWscHzSZDKhru19/dZJpyff5I4tQIJIpiNUUVQE4DgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o6Yj7Cn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0512FC4CEF7;
	Mon, 23 Mar 2026 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275380;
	bh=gCwLCwQV7at4rZYVfUhOydnmWQIiOWil/J2Y4yjLQT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6Yj7Cn0gAdbgVU+/h3LWGlHBbMlX9tkORTD97n5vcaXJvkdT9/hXL1nVNjlOj8ZE
	 6FSYZOh/wpMw5rz3BuAUl/3yIYAUhqJVfrOQIVfo9ugJkMIv+4VI/07vpJj8xuXjyS
	 pPN3Zpg1NYCSnh6GmGqc7EcCFVZf8qWqlLGpjjNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 078/460] ASoC: amd: acp3x-rt5682-max9836: Add missing error check for clock acquisition
Date: Mon, 23 Mar 2026 14:41:14 +0100
Message-ID: <20260323134528.601079275@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228532-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 123E82F4C2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 357dfd016bafd..6c4716565ded0 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -94,8 +94,13 @@ static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
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
 
 	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
 					 SND_JACK_HEADSET |
-- 
2.51.0




