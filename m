Return-Path: <stable+bounces-244932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBRZIf77/mlW0wAAu9opvQ
	(envelope-from <stable+bounces-244932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:18:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D92104FEF80
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F3053010BB1
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78A139EF2A;
	Sat,  9 May 2026 09:18:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFBA18EFD1;
	Sat,  9 May 2026 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778318315; cv=none; b=LG+6eXGYcQ4niJZOE1K5wgYt+Axwi3IrateLgn3FbAZTHHce6eBjaJ5VKgAVWMs9o8AlV6eCwko3vhstaCJaaiRMrBasT9cgz1lnF1g6IYh1LfZtxjUcFyffVVObohgwnWKEUy9+RZJYDSNTSJ8fkp+jSX7TQ96rOzQJY72/wBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778318315; c=relaxed/simple;
	bh=NmrSk7zhfQFEH8f7bH1xmg81YzHhBPCNFpczcW1eHVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JRT96D6xzEetdOfub75cgPpTgkIxMDH92Lf1VdvkVrxxaOuxZ+/Ydzh2kpe7tk5KgLGOyASvox1/GKhAZSOirkG9M8IDFnkR7sLEMhyB8DkaC2Esvdkqdt8bpv+JWZ2RklWwWTjA5Yr8PpIW0+7kEUdOrfTxsBKwyss/7crV++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAAXvWjg+_5pxa6xDw--.15480S2;
	Sat, 09 May 2026 17:18:24 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: linux@armlinux.org.uk,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/armada: fix device_node reference leak in armada_lcd_bind()
Date: Sat,  9 May 2026 09:18:21 +0000
Message-Id: <20260509091821.963513-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXvWjg+_5pxa6xDw--.15480S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XFWDGw1fZrW7KFyDXFy8Grg_yoW8Jry8pa
	yxCryYkry5GF4Skay7CFWq9FWDCaySqas3Kr18Gws7ur43Xw4vyr1j9w1Ygw1DAr97Ca47
	AFsrJFyaqF1UCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjJ73PUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoCA2n+2cZ9hAAAs9
X-Rspamd-Queue-Id: D92104FEF80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244932-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.450];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In armada_lcd_bind(), of_get_child_by_name() obtains a reference to
the "port" device_node which is passed to armada_drm_crtc_create().
On success, the reference is transferred to the crtc structure and
released later. However, if armada_drm_crtc_create() fails, the
function returns directly without releasing the port node, causing a
reference leak.

Fix by adding of_node_put(port) in the error path.

Fixes: 9611cb93fa65 ("drm/armada: register crtc with port")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/armada/armada_crtc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index 0900e4466ffb..dfca664847b6 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1035,7 +1035,10 @@ armada_lcd_bind(struct device *dev, struct device *master, void *data)
 		}
 	}
 
-	return armada_drm_crtc_create(drm, dev, res, irq, variant, port);
+	ret = armada_drm_crtc_create(drm, dev, res, irq, variant, port);
+	if (ret)
+		of_node_put(port);
+	return ret;
 }
 
 static void
-- 
2.34.1


