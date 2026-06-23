Return-Path: <stable+bounces-267934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pe+lNNx0Omrc9QcAu9opvQ
	(envelope-from <stable+bounces-267934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:58:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B26B6EC7
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:58:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=P6OoiXkL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267934-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267934-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80127304DCF0
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153DA3D5246;
	Tue, 23 Jun 2026 11:58:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB593D47BD;
	Tue, 23 Jun 2026 11:58:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215893; cv=none; b=tH6Pi7CbGyXweXkKFSCINTlaNr5rdsD6Ryq+rB/c/Y2IkfWWIeJktpTUrWwNgHCH+Y6gGt+ZgiSy+AzfEYI24gzAbwmV8usDuCBwSpDT0OKv4tsSzGQpT3WFDIXUZtlloeXEvTl+WH4NpSkrRiGelz+g9kTo49tQkWsv+tfKQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215893; c=relaxed/simple;
	bh=lwmTLKLGBmd5rzYhUjXuVqa8X0+dsB4HsqU5oOyOrPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUEX5vrjX01yQ5EOlzoir6MHUWE3KEEffhr+YVvUvSX2DmZo4rRb8aCaOcYQEGaBVcaHOLLu6xdw2dLXOYKPRKF8ySd81lXVvxxlkW6vBD+6H+azy5jrcVDUGjTj4NypjIQpYE0J7yA5PGLjTDxfjUrpVtVnqibua94Q8Dit1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P6OoiXkL; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Jy
	qaO8kPsSCsSS6QqHxsmEpq9UNz19yAQVVRi9X8TRg=; b=P6OoiXkLr9gihEQiB4
	tUtBNanoJzvJcaXZ0p8MyTjMR94VKYZLHu/xfWkkqHLr4MkweRWwkp9ZkLbE07rL
	jyfCG5SZXhoLoW7XO3iqbqVvSM5A+MLbjPYQnsL26rhkXrnDmRwp4h25TZpfr22T
	W6BTsvZ4ehEcJsrh6Zpa3SBLI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXvxObdDpqHqw_FQ--.64734S2;
	Tue, 23 Jun 2026 19:57:17 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	kees@kernel.org,
	horms@kernel.org,
	bjarni.jonasson@microchip.com,
	lars.povlsen@microchip.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: sparx5: unregister blocking notifier on init failure
Date: Tue, 23 Jun 2026 19:57:14 +0800
Message-Id: <20260623115714.2192074-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXvxObdDpqHqw_FQ--.64734S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3Gr4rZr13GF13AFWxCrg_yoW8XF43pa
	y5uFykCr18Kr45u3Wjkw18AFyDWw17KrWUur1ft3s0ga45KFZ3Ca4UtFyYqr10k3sruasI
	qayDZa48u3yDC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zibdbUUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxR1t22o6dJ2TwAAA3E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Steen.Hegelund@microchip.com,m:daniel.machon@microchip.com,m:UNGLinuxDriver@microchip.com,m:kees@kernel.org,m:horms@kernel.org,m:bjarni.jonasson@microchip.com,m:lars.povlsen@microchip.com,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-267934-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 381B26B6EC7

sparx5_register_notifier_blocks() registers the switchdev blocking
notifier before allocating the ordered workqueue. If the workqueue
allocation fails, the error path unregisters the switchdev and netdevice
notifiers, but leaves the blocking notifier registered.

Add a separate error label for the workqueue allocation failure path and
unregister the switchdev blocking notifier there.

Fixes: d6fce5141929 ("net: sparx5: add switching support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index 644458108dd2..dac4dd833127 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -765,11 +765,13 @@ int sparx5_register_notifier_blocks(struct sparx5 *s5)
 	sparx5_owq = alloc_ordered_workqueue("sparx5_order", 0);
 	if (!sparx5_owq) {
 		err = -ENOMEM;
-		goto err_switchdev_blocking_nb;
+		goto err_alloc_workqueue;
 	}
 
 	return 0;
 
+err_alloc_workqueue:
+	unregister_switchdev_blocking_notifier(&s5->switchdev_blocking_nb);
 err_switchdev_blocking_nb:
 	unregister_switchdev_notifier(&s5->switchdev_nb);
 err_switchdev_nb:
-- 
2.25.1


