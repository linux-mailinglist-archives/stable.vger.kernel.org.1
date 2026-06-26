Return-Path: <stable+bounces-268975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L1p/Fv+bPmoPJAkAu9opvQ
	(envelope-from <stable+bounces-268975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:34:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4745F6CE88F
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:34:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268975-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268975-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9FC8305810F
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9558A37F737;
	Fri, 26 Jun 2026 15:19:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD137AA83;
	Fri, 26 Jun 2026 15:19:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487177; cv=none; b=JWFdFRjg4gsZ4cujj9BK81vNI3jxjScTBD0bTIpBh3iANZlJFty6y2d/heSr6RPrcjV4VA2ordiTNKwPIVVFScmiUFijMfGd5anG9P/0A8fXrMcB5IPXgdMqTdRYxD7mefBU5PLATYH9SK7bwbsYrWa7HAR6uua6gFetnJVhaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487177; c=relaxed/simple;
	bh=fsBIl9+VFmFi+x6950N71RCRRrK7rINYchzBfOyh/no=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KNRSWlCJyTB0eFZIr0zGWvVMTJO7QhyTR6IxuWUU/lcMMrPNA8+CerQyminmV5aqGS02W6ua44MvNodcARmkyfHCzNBR/Uezdd7Cgi2Kcx4LVuiXDj8xCGyywfwvZaSMYaPkXn/rgr5OmHDQLd+LwaoFay7y/KiSniyIBA9eg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAHqdF+mD5qe95rAw--.16626S2;
	Fri, 26 Jun 2026 23:19:28 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: net: marvell: orion_mdio_probe: fix clock reference leak on extra   clock detection
Date: Fri, 26 Jun 2026 23:19:26 +0800
Message-Id: <20260626151926.51342-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHqdF+mD5qe95rAw--.16626S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWUtrWfCryfKFy5ur48JFb_yoW8WFykpa
	ykKFyYyrWfAF13W3WkXa18Xa4Ygw4rta48GrySyanavw13JF18Zr1kG3y09rW8JrWkZ3y5
	tr1UAa1xuan0vrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5dgADU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIKA2o+ikUorgAAsR
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268975-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4745F6CE88F

The code calls of_clk_get(pdev->dev.of_node, ARRAY_SIZE(dev->clk)) to
  detect unsupported extra clocks. If an extra clock exists, the function
  prints a warning but discards the returned clk pointer without calling
  clk_put, leaking a clock reference on every probe.

Store the returned clock and call clk_put after the warning to properly
  release the acquired reference.

Cc: stable@vger.kernel.org
Fixes: ea664b1bdc19 ("net: mvmdio: print warning when orion-mdio has too many clocks")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/marvell/mvmdio.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 3f4447e68888..4e5b5c5f7301 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -339,11 +339,18 @@ static int orion_mdio_probe(struct platform_device *pdev)
 			clk_prepare_enable(dev->clk[i]);
 		}
 
-		if (!IS_ERR(of_clk_get(pdev->dev.of_node,
-				       ARRAY_SIZE(dev->clk))))
-			dev_warn(&pdev->dev,
-				 "unsupported number of clocks, limiting to the first "
-				 __stringify(ARRAY_SIZE(dev->clk)) "\n");
+		{
+			struct clk *extra_clk;
+
+			extra_clk = of_clk_get(pdev->dev.of_node,
+					       ARRAY_SIZE(dev->clk));
+			if (!IS_ERR(extra_clk)) {
+				dev_warn(&pdev->dev,
+					 "unsupported number of clocks, limiting to the first "
+					 __stringify(ARRAY_SIZE(dev->clk)) "\n");
+				clk_put(extra_clk);
+			}
+		}
 
 		if (type == BUS_TYPE_XSMI)
 			orion_mdio_xsmi_set_mdc_freq(bus);
-- 
2.39.5 (Apple Git-154)


