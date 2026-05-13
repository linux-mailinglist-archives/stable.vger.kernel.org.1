Return-Path: <stable+bounces-246743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBTgGgMEBGoHCQIAu9opvQ
	(envelope-from <stable+bounces-246743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:54:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E2552D57D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA4B9303297C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 04:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2058E3911BC;
	Wed, 13 May 2026 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="mvC2MQrd"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6BA3EDE5D;
	Wed, 13 May 2026 04:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648060; cv=none; b=VQMVLgkFTnEE7w3eeOhYSXSbQG5pjmEz1v2Uuseqct93fHtuRiJCrojU5UjT8dRSZy4lSkTzDljgIRMK0yNZfKKUDvvpDScBsHUBxxs0q/gy8ScmTGDsnA77df70zLDUKH0BLJVi+7QXHPRTzp1jtR7DYi80XBKFV6MmyJllQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648060; c=relaxed/simple;
	bh=XYpw6rCkqj+Mhw43PGFGoD0pB2Oi0MaRB06nJOwNkOg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=tgNCNkwyqIUdVBVq5uoyjFudjyABatBbX6GfqOi85LD+BAyz2qHetIQCPZHI3w3NHbBs+3pT7pZFPqWwFh1gmnlx8UJtX4wliPh3CyWD57s6ygBKCiK0XlDAMFtk1zcUz6E1Z1wUA75QSTAeahbvyoe9bOCzy3RjAIceXVhkJ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=mvC2MQrd; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778648046;
	bh=unYS6C5TavL4Q58csPsAxiafXr6kgzCBwkUp28wjDYw=;
	h=From:To:Cc:Subject:Date;
	b=mvC2MQrdb0eEO/S4NAmC4+QnsFz+6tFgz1Nrbr/POAqVx9hQQOHX60mpnvlRcovWe
	 4/nH4UnhiM0jaQb2Yat3pwrRRxQs5DhQEhfbPh8wxClSWkuFmjhp6ds0kGiihO2DzQ
	 4e1/O/R32616+ddEpEBs0NUVu/4pZjGxHpJhx0Ms=
Received: from xiao.localdomain ([223.73.200.143])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id D2C1AE81; Wed, 13 May 2026 12:52:44 +0800
X-QQ-mid: xmsmtpt1778647964tenw4dk6h
Message-ID: <tencent_93212098B8302E17913CEFCD29E77E07B407@qq.com>
X-QQ-XMAILINFO: Npv5yIQT4nxMLQZdzyNPE62tthhwxbkFWhXzvQ/oJlERTbCEA3dEd6fNd2qpCI
	 JZs2GyP32HtjFyEP/oWYyTV1Y+OYWbFjSZUbg6uaUU3v4sAgvgmgpQ1P6uuFHFJePWXsyhCeuh8J
	 h3bgIeL59YhxbMwkQ2yrpvflAjIDO1mg1tf/XnIh9yB6Ygt3R0Xp1elTs5Qk+Q/Sm63vhPW3dYzC
	 OmJs4BBSJJE1pHaX1wIX4ALxwM5BjRsFcrVZ9ks6X+pUgt62iBWdvi1nqXG+vP4/mBINsH5aSaMq
	 yGxARdLHYVsMkC8PTTIZFnTO+lM+cfsEGxSwdUH9kz0mibD4yDuuYnhAgQ8Pc3tjPXIRrkFEipRv
	 UIIBKq/nrbkW/8HPWM7RGz+x2oQZqwHVg7a0ZqTWKj8gSHzK/E1jjPldE78WYiho9ic0XRHmxqZc
	 LOyRkXHNaHtI2HSJQAPFus0j9KqIcEnyGSsS8HYcHkbiyS8UI7Z0Kr9cx8NdaUYm1xB/6JTPs3QS
	 au82uO+X0bkpSP5GgWfK6J8+6yjVS3ljs+9bX+HcdGSAQ7P8w2aXl7dSUmNl5fRU/K9vPS7SOQ7Y
	 fBusAo7N1qhvz+Pv84j9QzIdes++j6/+rP02RJ/FuI94HORM/2/pchyu+YKuBULY66HWeY9miQl1
	 4NLA5ZgeWhEISVev4WT4S1xFjXdbo+nm+stZVkJoX1Xsslwk4FgrGa4GNiSa7dW8Y9lATW4n6Q05
	 droopaFt0YWDDQynbbCxbRmRDVW6di5i7FwJ8WFgu5y5UgmcI/S0TNXxqLYGBmV5QbdflkKa11KI
	 OZQNpt5ZivgvJRejXmc3b7Uo/0bfUMBKSACh88jMLH6gZMvWMy/gyup+fJPJYONNvC2sRspfXGUO
	 9GYgshRsBDwzYzKW6kq9uGAA35mXDc1rcVMDmwDr7eGHQ10T7vPyfsQHOgvMLxwMh1TKnEGB5j9Z
	 EXlkmU+gSz7YXBddduU1JYvoeXdecJq0PZv+HdWDDfmhPP0UWA8O6T7YjEwIHO+2rx5W65HSBi+E
	 kwCUc9BcW625Lh2xvrWpr6KvfOuC/5KOX5efeCD4mt2ApjyD2kaiEnmh8G5AM=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Li Jian <lazycat-xiao@foxmail.com>
To: linux-kernel@vger.kernel.org,
	broonie@kernel.org
Cc: lgirdwood@gmail.com,
	loongarch@vger.kernel.org,
	chenhuacai@loongson.cn,
	zhoubinbin@loongson.cn,
	jeffbai@aosc.io,
	Li Jian <lazycat-xiao@foxmail.com>,
	stable@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Zhang Yi <zhangyi@everest-semi.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH v2] ASoC: ES8389: convert to devm_clk_get_optional() to get clock
Date: Wed, 13 May 2026 12:52:17 +0800
X-OQ-MSGID: <20260513045232.1699498-1-lazycat-xiao@foxmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7E2552D57D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246743-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[foxmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,loongson.cn,aosc.io,foxmail.com,perex.cz,suse.com,everest-semi.com,renesas.com,opensource.cirrus.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lazycat-xiao@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,foxmail.com:email,foxmail.com:dkim]
X-Rspamd-Action: no action

Per Documentation/devicetree/bindings/sound/everest,es8389.yaml,this
driver does not require `mclk', so the DT node may lack this property
(even the example lacks the `mclk' property). Therefore, the driver code
should handle this situation by using `devm_clk_get_optional()'.

Indeed there is already null checking based on CONFIG_HAVE_CLK, but the
driver will not finish initialization, as previously devm_clk_get() would
just return an error pointer. Address this by introducing a simple
conversion to use `devm_clk_get_optional()'.

Cc: stable@vger.kernel.org
Fixes: commit 0319c26889f7 ("ASoC: codecs: add support for ES8389")
Signed-off-by: Li Jian <lazycat-xiao@foxmail.com>
---
 sound/soc/codecs/es8389.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8389.c b/sound/soc/codecs/es8389.c
index 8d418cae371a..449d9574b03a 100644
--- a/sound/soc/codecs/es8389.c
+++ b/sound/soc/codecs/es8389.c
@@ -892,7 +892,7 @@ static int es8389_probe(struct snd_soc_component *component)
 		return ret;
 	}
 
-	es8389->mclk = devm_clk_get(component->dev, "mclk");
+	es8389->mclk = devm_clk_get_optional(component->dev, "mclk");
 	if (IS_ERR(es8389->mclk))
 		return dev_err_probe(component->dev, PTR_ERR(es8389->mclk),
 			"ES8389 is unable to get mclk\n");
-- 
2.47.3


