Return-Path: <stable+bounces-222972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHTaK/2ep2nTigAAu9opvQ
	(envelope-from <stable+bounces-222972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 03:54:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC91FA189
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 03:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14D8F3029BA3
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 02:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F0C3537C2;
	Wed,  4 Mar 2026 02:54:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2363A3537EF;
	Wed,  4 Mar 2026 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772592886; cv=none; b=quuoNFT8+S7TOWhhyBgr8otN6cCGV9Esgp0ilGzuc1I9yfvaGSaDRHEoBqYDLobljscfEUchHjqF1wMnO7MBzgOu+cahFU5ZfVAMHVZ/5PmGHhfbWQjU2oFgvNUHKenIxEhdF1bfVsotXo4BrJd7OU+UW5sb/vzheP/JJIyPxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772592886; c=relaxed/simple;
	bh=fiTd00dCuEpxM61Ccx8EMhWY1AAsWnr0ZGzqX4q5Kc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZiZ1lb9XadlCq4pp/zfp3k8eazmTRPWzfj8l9Osexf/P/obl5sm10AKmHAWVc5+t0n4Y2LFTln+dAUifLUi3mvZCS2keM7ZUlpCezZ5uwsR8PWbOCyBn6sZuht1uhjgZ6gu9baCSIv9/y6+w+oACeH2eYWzxO3ezz6bXV8aJnxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wC3LOzRnqdp0w4DAQ--.1182S3;
	Wed, 04 Mar 2026 10:54:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgAHv4XPnqdpKd+XBQ--.8647S2;
	Wed, 04 Mar 2026 10:54:08 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	heiko@sntech.de,
	romain.perier@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] net: ethernet: arc: fix use-after-free in probe error path
Date: Wed,  4 Mar 2026 02:53:03 +0000
Message-Id: <20260304025303.145493-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAHv4XPnqdpKd+XBQ--.8647S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?9b13/gXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVF/U4hEbTTFSw5kpxcvjRYKPstlloiYtLMimIxxPCeK937RxSFJIG2LQyB39D0JCgNO
	NV74nIx5vQQu6S65pzJdUyKHqvPLYcUGaa3joYPu
X-Coremail-Antispam: 1Uk129KBj93XoWxCrW8ZF4rGrWxWrW5AFyxZwc_yoW5GF13pa
	nxAF92krWkGF1jqa1DJa1kZF4rtw4UtayYgFyIkw4fuasIkr18G34I9rW09ry5ArWkCF13
	ur4DAryUZFs8ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==
X-Rspamd-Queue-Id: F1EC91FA189
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222972-lists,stable=lfdr.de];
	DMARC_NA(0.00)[zju.edu.cn];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,lunn.ch,sntech.de,gmail.com,lists.infradead.org,vger.kernel.org,zju.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	FROM_NEQ_ENVFROM(0.00)[fanwu01@zju.edu.cn,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

The arc_emac_probe() function calls devm_request_irq() with the
net_device as the dev_id. However, in the error path of
emac_rockchip_probe(), free_netdev(ndev) is called before the devm
cleanup happens. This creates a race window where an interrupt can
fire and the ISR (arc_emac_intr) will access the already freed
net_device structure.

Race window:

    CPU 0 (probe error path)           CPU 1 (interrupt)
    ------------------------           ------------------
    emac_rockchip_probe()
      arc_emac_probe()
        devm_request_irq(..., ndev)
      [probe fails]
      goto out_netdev;

      free_netdev(ndev)  // freed!
                                       <Interrupt fires>
                                       arc_emac_intr()
                                         ndev = dev_instance
                                         priv = netdev_priv(ndev)
                                         // UAF! Accessing freed mem

    return err;

    devres_release_all()  // Driver core cleanup
      devm_irq_release()  // IRQ disabled too late!

Fix this by using devm_alloc_etherdev() instead of alloc_etherdev().
With fully managed allocation, the devres mechanism ensures proper
LIFO cleanup order: IRQ is released before net_device memory, thus
eliminating the race window entirely.

Remove the now-unnecessary free_netdev() calls from both the probe
error path and the remove function, as the memory is automatically
freed by devres when the device is detached.

Fixes: 6eacf31139bf ("ethernet: arc: Add support for Rockchip SoC layer device tree bindings")
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/ethernet/arc/emac_rockchip.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index 780e70ea1c22..a695ea6547c8 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -103,7 +103,7 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 	if (!pdev->dev.of_node)
 		return -ENODEV;
 
-	ndev = alloc_etherdev(sizeof(struct rockchip_priv_data));
+	ndev = devm_alloc_etherdev(dev, sizeof(struct rockchip_priv_data));
 	if (!ndev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, ndev);
@@ -240,7 +240,6 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 out_clk_disable:
 	clk_disable_unprepare(priv->refclk);
 out_netdev:
-	free_netdev(ndev);
 	return err;
 }
 
@@ -258,8 +257,6 @@ static void emac_rockchip_remove(struct platform_device *pdev)
 
 	if (priv->soc_data->need_div_macclk)
 		clk_disable_unprepare(priv->macclk);
-
-	free_netdev(ndev);
 }
 
 static struct platform_driver emac_rockchip_driver = {
-- 
2.34.1


