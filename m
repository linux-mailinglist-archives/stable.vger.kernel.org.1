Return-Path: <stable+bounces-235354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P52LLVo12myNggAu9opvQ
	(envelope-from <stable+bounces-235354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:52:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E033C7FA0
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFACE3014949
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F5337F8B8;
	Thu,  9 Apr 2026 08:48:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E033030F;
	Thu,  9 Apr 2026 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724518; cv=none; b=uu7jdmjkvnML8bV5K/GR3WP2CKaQTXGIg3UUvUbk4BQPJeu0w33dxrx1vJNSf2BJuQfBRo3BWVgRF6R/gm6+fHu3PuiKH4a62ZLW/mrr7Z8DFbgRMozyT+2+ahnvTr8k2JcxS/SLIRg8GCvZp7e6bqMrgLtMqrw3t4oZOkGmZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724518; c=relaxed/simple;
	bh=5S/5OtkxkkJObcqL9GnYv2tKi9bnZ7uu0Eiwsn4oiAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g+a94cUSMN/EznrExvm/YZX2MM1bleY8MPZxwXhLOT0Qart5YvGYfByI3YZVFtiA74xmD96nhf1j812/Zmb5ueesK657kdRKBuqTY9VeLMcjb4jlcCxX9YH235cPZdfy5143bSuvjqukkL+AFBpFb5ElO7tXZBKjyBgTSM1Uun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowADHWQ3SZ9dpAeYJDQ--.43265S2;
	Thu, 09 Apr 2026 16:48:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: it6505: fix use-after-free in it6505_parse_dt()
Date: Thu,  9 Apr 2026 08:48:17 +0000
Message-Id: <20260409084817.470401-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHWQ3SZ9dpAeYJDQ--.43265S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryfGFW8tw4fGw4UZF4Utwb_yoW8Xr45pr
	sIqa1Yvr9rZa9xKay8AryxtF9aya1DXFWrCF9rCw4avwn8X3WUAFW7CrZxXFy8uF1rZw1a
	yr4vkF9Fgr1Ykr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe9NVDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoMA2nXPWqtFQAAsS
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-235354-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ideasonboard.com,kwiboo.se,gmail.com,lists.freedesktop.org,vger.kernel.org,iscas.ac.cn];
	NEURAL_HAM(-0.00)[-0.270];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04E033C7FA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In it6505_parse_dt(), of_node_put(ep) is called prematurely before the
last access to ep when reading the "link-frequencies" property, leading
to a use-after-free if the node's reference count drops to zero. Move
the of_node_put() calls after the last use of ep in both the success
and error paths.

Fixes: 380d920b582d ("drm/bridge: add it6505 driver to read data-lanes and link-frequencies from dt")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index a094803ba7aa..4155b5e67c2d 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3361,13 +3361,13 @@ static void it6505_parse_dt(struct it6505 *it6505)
 	}
 
 	ep = of_graph_get_endpoint_by_regs(np, 0, 0);
-	of_node_put(ep);
 
 	if (ep) {
 		len = of_property_read_variable_u64_array(ep,
 							  "link-frequencies",
 							  &link_frequencies, 0,
 							  1);
+		of_node_put(ep);
 		if (len >= 0) {
 			do_div(link_frequencies, 1000);
 			if (link_frequencies > 297000) {
@@ -3382,6 +3382,7 @@ static void it6505_parse_dt(struct it6505 *it6505)
 			*max_dpi_pixel_clock = DPI_PIXEL_CLK_MAX;
 		}
 	} else {
+		of_node_put(ep);
 		dev_err(dev, "error endpoint, use default");
 		*max_dpi_pixel_clock = DPI_PIXEL_CLK_MAX;
 	}
-- 
2.34.1


