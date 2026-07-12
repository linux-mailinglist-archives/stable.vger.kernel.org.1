Return-Path: <stable+bounces-273499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ShbH7akU2r4cgMAu9opvQ
	(envelope-from <stable+bounces-273499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 16:29:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A052744FD3
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 16:29:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273499-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273499-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C495F30034B0
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9241C23A562;
	Sun, 12 Jul 2026 14:28:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BBA2010EE;
	Sun, 12 Jul 2026 14:28:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783866534; cv=none; b=j8uifHGA8JDMONBknj4p8zV7Wqhmc1BsjwPzGGfbKCxKFKqMJrdERWq4dCNRCWjdW/XEAvFoE1SEpPHXDEg8Lvifk7kgr4LSRJqMPSyqch4yXMZ/M1vjEcKav7/G2+JS+zYCE/sd3QIJcDvMv3aey3NG7AnWBLdiMeIkJvnWZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783866534; c=relaxed/simple;
	bh=DFlad54vnxB7zbml31XlvwTNCCtOAs1+xuTz+3JvUQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8JUSSWeSc8XQQJIJSWqKYCm38ojcwKbeWeiM+BpHNgGz9iuSm2IJdFaPmXM4xRE1X9DlgFAmH+yvgVr0Re4OelTdxzRY+u4GBeaBSgRR7C40Tsn2ej+/PpCcRLy5GOewKMTpAKbrtVBzwg8GnELr2b6wsa5j8iraum5c1sh1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBX5eCJpFNqnaA+AA--.30790S3;
	Sun, 12 Jul 2026 22:28:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgB3fDaIpFNqK5hCAg--.58344S2;
	Sun, 12 Jul 2026 22:28:24 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	dingtianhong@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH net] net: hip04: fix RX buffer leak on build_skb failure
Date: Sun, 12 Jul 2026 14:27:29 +0000
Message-Id: <20260712142729.2057636-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgB3fDaIpFNqK5hCAg--.58344S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?+WTCrgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZwMXD6r00PqHAEpMgJrOWlB3cKExD1+OvwRHCV177ujW8w2
	3QlJ4zOWQZ6fMa/hwJ6p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7CF18Cr1fCFyfJrWxAw1xXrc_yoW8ZrWDpa
	yrGFWrJF9rtr17tr1DXw4IqF1rAan7Xay7WFW8Zws5ZFnIyr18ua48KFWUGF45Jr92qFs8
	tF4j93s3uryDW3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273499-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[zju.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fanwu01@zju.edu.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:przemyslaw.kitszel@intel.com,m:horms@kernel.org,m:shenjian15@huawei.com,m:salil.mehta@huawei.com,m:dingtianhong@huawei.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:fanwu01@zju.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fanwu01@zju.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,zju.edu.cn:from_mime,zju.edu.cn:email,zju.edu.cn:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A052744FD3

When build_skb() fails in hip04_rx_poll(), the driver jumps to the
refill path without releasing the current RX buffer and its DMA mapping.
Installing a replacement buffer then overwrites the slot references and
leaks both resources.

Keep the current slot intact and return budget so NAPI retries the same
buffer.  Also free a newly allocated RX fragment when dma_map_single()
fails.

This issue was found by an in-house static analysis tool.

Fixes: 701a0fd52318 ("hip04_eth: fix missing error handle for build_skb failed")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

 drivers/net/ethernet/hisilicon/hip04_eth.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index 18376bcc7..1d03039b4 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -594,7 +594,10 @@ static int hip04_rx_poll(struct napi_struct *napi, int budget)
 		skb = build_skb(buf, priv->rx_buf_size);
 		if (unlikely(!skb)) {
 			net_dbg_ratelimited("build_skb failed\n");
-			goto refill;
+			/* Retain the slot; return budget so NAPI retries this buffer.
+			 * Refill would overwrite rx_buf[]/rx_phys[] and leak them.
+			 */
+			return budget;
 		}
 
 		dma_unmap_single(priv->dev, priv->rx_phys[priv->rx_head],
@@ -622,14 +625,15 @@ static int hip04_rx_poll(struct napi_struct *napi, int budget)
 			rx++;
 		}
 
-refill:
 		buf = netdev_alloc_frag(priv->rx_buf_size);
 		if (!buf)
 			goto done;
 		phys = dma_map_single(priv->dev, buf,
 				      RX_BUF_SIZE, DMA_FROM_DEVICE);
-		if (dma_mapping_error(priv->dev, phys))
+		if (dma_mapping_error(priv->dev, phys)) {
+			skb_free_frag(buf);
 			goto done;
+		}
 		priv->rx_buf[priv->rx_head] = buf;
 		priv->rx_phys[priv->rx_head] = phys;
 		hip04_set_recv_desc(priv, phys);


