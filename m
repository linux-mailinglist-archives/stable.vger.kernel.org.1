Return-Path: <stable+bounces-241479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INgQOHxT8Gk7RwEAu9opvQ
	(envelope-from <stable+bounces-241479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:28:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7918B47E0E0
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E75503040946
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 06:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEFA345CBF;
	Tue, 28 Apr 2026 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hGWQ0HE3"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D035898;
	Tue, 28 Apr 2026 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777357633; cv=none; b=RJEiPLnKi6s0GX7+VOV5PdkGFr0lp12D2FtNP5ri3/TpWwUcPZsd7FVr8Mf+8/Utm1TcT1Dv+55+TCH8PJA+i0Bgir0bpzTwxnWvIukI+/GhuRRgMFK4pO1+dp8LsEp2vZyJVQ4TXYPF/DR33XlyV1UGRkBk8Y5VDggdp0agLgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777357633; c=relaxed/simple;
	bh=KsIAmnLob4ZTTe48Ql2J0gkqKjtyzI7gwllEBYwAv1Y=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=IdEoQI70JXhUZchwOhuObCAepC8woOgEk/zrl99um+iYQwHXjGRrA+Z21qFkz0wUpX4RE4VpuFeyId/cNWOgBWCVWXJuOaJWY9oKaidTqxUz6pmhBs2yMv+6dqeLxtk+RTIlwc4D1+e/obMuYvBqQU7vgNfPu37vF0+HHYJiT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=hGWQ0HE3; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1777357618;
	bh=bh06cfQ61YF2IrXdjHDgvS8aqVFo7eN3jtbRKO4oJL0=;
	h=From:To:Cc:Subject:Date;
	b=hGWQ0HE3VmH//TwaNNvuMAUOhNy1uQGRsoMilsoNvX3xCBLrpvmm4CgtwiPabXjGU
	 QepGCWa0IjmMnFuq6ng4ry3TX9bEhYsChbGf6Ipw75t0voE/cIRiEcC157lYKMmt0B
	 +SVTIFiPQivnseUYP8jJD7vcBRS4zs127Ksd+kwU=
Received: from xiao.localdomain ([223.73.200.233])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 6B699A2B; Tue, 28 Apr 2026 14:26:54 +0800
X-QQ-mid: xmsmtpt1777357614tma2lu1im
Message-ID: <tencent_50175A0490455C1D17850883F7C314503F06@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+/TTNrQSMJgix2+vW821Dulk8tk9pKkj0nT5kbns+yf0076v4WR
	 pzgd5eKWzKhfrk7Ow8kxLZ3TXW4wpzQ6iZDcvOyHGijalx9hQwMac7GtKH+3qxCp5j3xGP94pdmX
	 jKS2SLm69GR0DOj+miYpa4ATZ/KM6QosbvxKDYScSFLb7lV1Rohomv8bxqR6juHD1DQwr9IDrD0R
	 CBef7IMRa90RQjuDEgMTpkdgD+mlptTvOylUDTVKMpZzXFxJBxjyRo7eFlOLc6+o85NoTDDxXrje
	 2IVjX4CkfB1Isvlevtdn9dU82yYRPMp7APU8PrL7kqn9+mjv/tnQJ3iNFMDf0AbRizBw/sfccyJj
	 Nf+QsTruy+sp7tB0koFIcy6XVpAiGWYKWW4tAJuF1vmiNL6/ebFOmnZOCG0Mu5/heaWEoIkHXhdG
	 2cf4VOheXsjr8X6I/eOeu3VigAGKCU+T/+oytSaP6GjJnG0vPR6qo6X53UEw+Yvk7bi+Mb/OkXvU
	 WdJDvdwWdFqbeS7rMem2hePHWtQ/9D6zUtPb+JfhONBggRXeDto/fPkpfX71Ei2GaEAa0B35F1KU
	 ZojTdGN9C3QYz418k8Trc8TCwyZM24p9jldBTIZKQmVxov8A8wlpsYCfUoY8/Baez0sxcOcClDYG
	 uuSxzIBwUCqmOiMn/USYNunt9wPJghYzGR89VOGdfAfFIzqAX9HdwJbwiIC75fn0Yaqr7RsBZs3M
	 aY64oXH9Yv8kAn7KUz9imV7fqO37l/Ev3dwsFF67JHMKcvFjKiNqxqgQ8mun4xRAj3Rd+lq6jol7
	 9tRSt3UWnnYEAim1+18he3JAV5Xv3X9OWXbkbCNpinqZl4mJUVffanmjXKwjs7VzG6kln9yaQzEZ
	 X6mgNcpePc3COCPY/Pshqx0/m0pLKk5DopTPxwlLXHXBOpd5sCHFT1EnNtBO8L8IXbHaUnEmvDjk
	 Cgbmxe7RshBnj0JAgvkojB+vroRTt3eGdKV8ERxJM4jaF3Bh2WauK50T8b359Gaurb0fDwLjnjSv
	 MrCPJrsUK3d3Vcg+Ne+sVG1cpxtiDtGRxnOp57NOYqpK3bRl7XfQ66dcZd5FrN9lRToTVToww9hp
	 dTE7US
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH v2] ASoC: ES8389: convert to devm_clk_get_optional() to get clock
Date: Tue, 28 Apr 2026 14:23:52 +0800
X-OQ-MSGID: <20260428062425.1377-1-lazycat-xiao@foxmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7918B47E0E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241479-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[foxmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,loongson.cn,aosc.io,foxmail.com,perex.cz,suse.com,everest-semi.com,opensource.cirrus.com,renesas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lazycat-xiao@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,foxmail.com:dkim,foxmail.com:email]

Per Documentation/devicetree/bindings/sound/everest,es8389.yaml,
this driver does not require `mclk', so the DT node may lack this
 property (even the example lacks the `mclk' property). Therefore,
 the driver code should handle this situation by using
 `devm_clk_get_optional()'.

Indeed there is already null checking based on CONFIG_HAVE_CLK,
 but the driver will not finish initialization, as previously
 devm_clk_get() would just return an error pointer. Address this
 by introducing a simple conversion to use `devm_clk_get_optional()'.

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


