Return-Path: <stable+bounces-238473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABY8JvwJ4mmE0wAAu9opvQ
	(envelope-from <stable+bounces-238473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 12:22:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5E41A116
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 12:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ECA4314CB15
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4B33B5318;
	Fri, 17 Apr 2026 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="aam1SYji"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE23B5825
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421028; cv=none; b=EJ2RdGziunrmwg3T9N2NIftVGIZB4+MwNI3AjsuTGFVGCZcFXh0xAC/w9+wL+ZYSllOBSusnsezX1d4+ViPS6y8hF/znTFLEcIExOomdq5BBCru07ZvxqYjwhSlpFwlPqFwucBrUVeZlbTTzJz7lk/cWsmSMt+553IQpLgdP73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421028; c=relaxed/simple;
	bh=kGZTUbmhy4eiP4AtkmuUW5syAYqt5qNBlLYRQJxQV9E=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Iucha3/xlGEnciwCl/4STtnAJ4RFQ7yfxydOPjjuq3ASEprRtisLR26XNWGeznLCwbZAVHbPND/1Wyzws2XyBXPBGBMptLdDzSflL/DTR5iTMKXtWMZCPLJU3iQbNTFmtwW80391itbNZc1G0KI7K3ezxd40Y5AFs3G9qQkQwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=aam1SYji; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1776421015;
	bh=g0Efm9iDp3R7/iYHI4l7Hyn3MNRts+Fud7okjcZrse8=;
	h=From:To:Cc:Subject:Date;
	b=aam1SYjioD/yJTr8Etq9T3pHj/Wcnb9gvTeK7MMN8tp17dfJDLqFR0EEvArzbMCnf
	 tBLXSpFnEX5LJbaXqlbcpcpx92ogO/iyHx93LmCYrlhpArXVApx8/sAL4J2N+oxO8a
	 79SgBsxrwqEGvyRJ8SZ3BfquFjR6m/SsGt8MWA5A=
Received: from xiao.localdomain ([183.6.47.73])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 43596042; Fri, 17 Apr 2026 18:16:53 +0800
X-QQ-mid: xmsmtpt1776421013tsdrehsrg
Message-ID: <tencent_58B9FA4504BD09A6D0FB1DD1708162E26A09@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ25uzRAd8elQBdKwgGotjW0KwiE+crGko3Txc9T3mlP0OBouNPb
	 fqchIrqY6oQqPxm4qKjlW2XrLaBNylByC2mfE8s0jKsIPwx7ye/NdHeyVziGV8I/QN+BlYVwfivu
	 E1qyT8CnYImeqwiazw+RLJSokEvlsA1KXOsa85f8/DO3R75P5te9bgQA9BXfr2Vg8vaUq6t+3SMo
	 i6eDQt1nAiAOXZe/lLK5lJ0rTpFxs2gvaXxFl/VE8pEZ9SU6xkRG4DH5+KssDSEU1o4EX5x/c8g0
	 ij9b0wFm1WxdCbwrFmL6AjQ+qbxAoojI0a1OWGZiqluNVA525UlM0yihV6VinYYO0rDsqfd8kSha
	 9LIOs/4W1oPBXVRcGCOEv1C8Bblx8TQyKyNyWTWPVsAwUpNXbxy4/LkuNUy4ChOHy1KkOrzm/adw
	 ySlZB/0oel5JIBvY5j9uAmyZy57Oju/pKn6atgBLjmqvYAENWkBHKczkjm568eDzx7H7EHBN5zKJ
	 zblw3l5baE/SixzePX9ztcOr6K0w7s7NeVKHtAsoHCJ/ffH4HCXwVBkCgifg4rAkiQtgXHxPNBpE
	 7Zsdxgs8ONuVezz+wjbX0HK/KpM+llAFC+/VYF9k7DESCiw0pOQnV7xUX8J//IsEhRXTExvv6wci
	 85QDNm2th1hAhnuCnCQYOKpqwANI9CfATJugk6cirXQfBPfPcrSf2/xumG8T7Ls2IW7EdmDec5US
	 W2/Strw4yKtEGTCKWZ+aFaUwTbS65lGLoWXKlnabPvMsQWULt9XncecnjX8mWhWmRIibkEuEbv0g
	 IOq4Be3tNapWRh5QZAlbXQgHbnFooYUUnDs2FSAMIlAouN/siQU5D1ZJG9fw61UK7RjwcHYDW3hX
	 wnco7fqOxCsbyUaPOcEZ0meShHloh9RqGCQCyhsDDhmrnlaSD5i6HTe9TGpF4Rl3IYQxtEJo2b4e
	 n19XXvcQtDXJD74s5XChpAiGZ8XFx6VuFouuACFyaMHQ8ZjJ89tJiYQZWiz5iY0ohHKapVFI1lZH
	 7fxTHKYIjl6K+U7ft7LoFtn1uOGCcI5c0P3hS25Ike9F53lwAdaVbtjRyM0+rjqWRX3d7/88aK8T
	 XV3+Q6rq9IFK1A1G8=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Li Jian <lazycat-xiao@foxmail.com>
To: lazycat-xiao@foxmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] ASoC: ES8389: convert to devm_clk_get_optional() to get clock
Date: Fri, 17 Apr 2026 18:16:01 +0800
X-OQ-MSGID: <20260417101601.49048-1-lazycat-xiao@foxmail.com>
X-Mailer: git-send-email 2.47.3
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
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-238473-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[foxmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lazycat-xiao@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,foxmail.com:dkim,foxmail.com:email]
X-Rspamd-Queue-Id: 14A5E41A116
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When enabling ES8390 via ACPI description, es8389 would fail to
obtain a clock source, causing the driver to fail to initialize.
This was not an issue with older kernels, but since commit
abae8e57e49a ("clk: generalize devm_clk_get() a bit"),
devm_clk_get() would return an error pointer when a clock source
was not detected (instead of falling back to a static clock),
causing the driver to fail early.

Use devm_clk_get_optional() instead to return to the previous
behaviour, allowing the use of a static clock source.

Cc: stable@vger.kernel.org
Fixes: abae8e57e49a ("clk: generalize devm_clk_get() a bit")
Signed-off-by: Li Jian <lazycat-xiao@foxmail.com>
---
 sound/soc/codecs/es8389.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8389.c b/sound/soc/codecs/es8389.c
index 8d418cae3..449d9574b 100644
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


