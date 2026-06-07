Return-Path: <stable+bounces-261160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pQ5tE0tFJWoxFgIAu9opvQ
	(envelope-from <stable+bounces-261160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:17:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C364F7B4
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:17:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=TXOFyXZn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261160-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-261160-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82DAC300336F
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF242DB7A3;
	Sun,  7 Jun 2026 10:17:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940794071DA;
	Sun,  7 Jun 2026 10:17:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827465; cv=none; b=WrOTo1tahahxh/2Kp/ZvQQcwEY2VExVIyeQlgABySUqu5caX49HT5rcfj9hl3oR+AfG6N4sm0bk+QuVLjMDia/xABpi4wRagEhaO83YfaY0oxhz9sZZagJt9OznKZHBGkbrYUha3yHAGYxzYswdIwLwesFshNsv1H4puJStbhgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827465; c=relaxed/simple;
	bh=ATOx6oS6cCL6NVwTOagWFiT9R8uZOyadfS9FSUE8dz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I98j0Utdz92d4KC3KAdLwY1wiw2Yd3ZLLz/rJVsmuQlSGuJ1VqKu71YPQfmcDrigA7KvgBKbRYcvrsw5dHp14GSV/JDwcg/groYRM6QGc6evQqVCRDP4ZIIYHKrLHEr1YktlOaYAHQ4P95RJAHeTt5tl0z2NES3q1T3H3hQAivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TXOFyXZn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4C61F00893;
	Sun,  7 Jun 2026 10:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827464;
	bh=YR1YZKPjp85GxxBrbY/ANVoVMNNbGkPFJmvvdn0mJpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TXOFyXZnE1dbuqZu5sgKtUaSS7etE1UjN1jM3jcaVZQMNbAgG8w7blK1DHdh1TxMG
	 3lm/RGJxBaM/LRIJ3Oaea4GZNW+gcRDzTLtlx3yBza//Jiv56xdfJOE+D3qNAyPjVx
	 y3YZFsxWM7Nm2Yr0ypL2SIo3l7yJqjO39mSfmVU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jijie Shao <shaojijie@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 076/315] net: hibmcge: disable Relaxed Ordering to fix RX packet corruption
Date: Sun,  7 Jun 2026 11:57:43 +0200
Message-ID: <20260607095730.406714160@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261160-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:shaojijie@huawei.com,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 152C364F7B4

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit 463a1271aa26eac992851b9d98cc75bc3cd4a1ed ]

When SMMU is disabled, the hibmcge driver may receive corrupted packets.
The hardware writes packet data and descriptors to the same page, but
with Relaxed Ordering enabled, PCI write transactions may not be
strictly ordered. This can cause the driver to observe a valid
descriptor before the corresponding packet data is fully written.

Fix this by clearing PCI_EXP_DEVCTL_RELAX_EN in the PCI bridge control
register to ensure strict write ordering between packet data and
descriptors.

Fixes: f72e25594061 ("net: hibmcge: Implement rx_poll function to receive packets")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Link: https://patch.msgid.link/20260525144525.94884-2-shaojijie@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 0b92a2e5e98694..cf0f14aa014cf8 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -420,6 +420,9 @@ static int hbg_pci_init(struct pci_dev *pdev)
 		return -ENOMEM;
 
 	pci_set_master(pdev);
+	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
+				   PCI_EXP_DEVCTL_RELAX_EN);
+	pci_save_state(pdev);
 	return 0;
 }
 
-- 
2.53.0




