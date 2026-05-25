Return-Path: <stable+bounces-254071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJe5KjDVE2oCGgcAu9opvQ
	(envelope-from <stable+bounces-254071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:50:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 133D55C5C66
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C76300B12C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF22C0F84;
	Mon, 25 May 2026 04:50:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EEB222580;
	Mon, 25 May 2026 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779684652; cv=none; b=EUG2HWZtpHwTyj4UGZAJpAJyAWg+/BbnbjFN92tpBBT3jcCLjlaCxZ4at+kkDkoVgl/0WkDXLvki+H1K4dbdy3FUKyFUsWyigcv0T+pFAdms3R1X/C+Nepe7gtCOgNSNFQXb38w/1HOm0lNvpmZbQbZN2v14NiW4VQyuQQCtfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779684652; c=relaxed/simple;
	bh=xehnZ+jZ1A+OlQaq1vQaj6LXm/R/iY8KLlMC2q6SEys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZLp0sk20bYda4XoeVmwMKsUnwEG0QiKBPEddgQl+y8oEOvl+JLMyzn4ZDBG69SaUUcr+iJKXyvLzqUq8vb04HUx9563kUbt//NSZGg1NiwAmIMfvlRYd9Qczn1oQmmiKOmiccsa+fKUtAJf8BGOb5wIhocv4aSrNRV5+KjqCEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADXeGQa1RNqFJ2DEQ--.8881S2;
	Mon, 25 May 2026 12:50:34 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/mipi-dsi: fix of_node reference leak in of_mipi_dsi_device_add error path
Date: Mon, 25 May 2026 04:50:28 +0000
Message-Id: <20260525045028.3895931-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXeGQa1RNqFJ2DEQ--.8881S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW3Xw1rCFW8KryDGFyrtFb_yoW8CF13pF
	W3Ga45ZrWkKrsrCry8ZF18uFyY93Waya95ur4kJ3W2kwn5Za4UtryUtFyDK345JrWxAF1a
	qr9rJ34UCrn7Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqeHgUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRESA2oTokfJWAAAsE
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
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254071-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.880];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 133D55C5C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

of_mipi_dsi_device_add() acquires an of_node reference via
of_node_get() before passing it to mipi_dsi_device_register_full().
However, when mipi_dsi_device_register_full() fails (e.g.,
mipi_dsi_device_add() returns an error), the acquired reference is
never released, causing the device_node to leak.

device_set_node() merely stores the fwnode pointer without taking
an additional refcount, so the reference from of_node_get() is the
only one the device holds on the success path.  On the error path
the reference must be released by the caller that acquired it.

Fix this by checking the return value of
mipi_dsi_device_register_full() and calling of_node_put() on error.

Fixes: c63ae8a9686b ("drm/dsi: Use mipi_dsi_device_register_full() for DSI device creation")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 0390e14d3157..b54c10d92c57 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -163,6 +163,7 @@ of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 {
 	struct mipi_dsi_device_info info = { };
 	int ret;
+	struct mipi_dsi_device *dsi;
 	u32 reg;
 
 	if (of_alias_from_compatible(node, info.type, sizeof(info.type)) < 0) {
@@ -179,8 +180,10 @@ of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
 
 	info.channel = reg;
 	info.node = of_node_get(node);
-
-	return mipi_dsi_device_register_full(host, &info);
+	dsi = mipi_dsi_device_register_full(host, &info);
+	if (IS_ERR(dsi))
+		of_node_put(node);
+	return dsi;
 }
 #else
 static struct mipi_dsi_device *
-- 
2.34.1


