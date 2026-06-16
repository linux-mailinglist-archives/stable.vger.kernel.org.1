Return-Path: <stable+bounces-265480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6L5uLLqJMWoZmAUAu9opvQ
	(envelope-from <stable+bounces-265480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:36:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8C16934FC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:36:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=uH0G3DR1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265480-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265480-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25651302EAB6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808B47B432;
	Tue, 16 Jun 2026 17:36:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143546AF3C;
	Tue, 16 Jun 2026 17:36:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631413; cv=none; b=MQjBHszVaeemQswuXO9QS+XYQYYYL2w3VCIOBZ8Ey9gatS9gsDPf1r2T94Ea36mZLvTHY+2VtNv9tdn+kQx16UFxsPqMK8GNVxkudlXmBaK1dgtgCcgsuhHpetL0NESYoM8EG/E+sbolDCMn19dqf5hvPgyLBJo5IK25STqHBz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631413; c=relaxed/simple;
	bh=Etf3EkTx81CSUDVmbk7j7G7q9HhzE0J7yPNdRXePCfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7FLqTFpmUk/XTdpq4DHpM1BiwSWkejjdSOhEP0Kb6czjqnsiCKRNvxXXRr+TfJKYtDmd4Z6XHLVHNN40XLTTxsD8+OZcVSo5K2TDgneCo/uzxpr8crW6T2fcBEsHfccm0MJ0VGIZxE5cuX1kIJpd2zprhdFFCYSF9hFC5XLv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uH0G3DR1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AF41F000E9;
	Tue, 16 Jun 2026 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631412;
	bh=Kkf/R9p99l/vnPPx7je9mcgjklXpt84WEeCbjxb3rhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uH0G3DR1N17+hpB6w63nfUnDXXup/qyrHmMIItA3osbM2S7xZ8RhmTNGe02sDjE3i
	 lSBxGMGN/w5lmgi6AgBm8vA7LABW95J6kvV5d2dOmwMAtV9ygCbCHM5ASzcq058Or2
	 N1gKuI61XSk6AwcFOsbL2APJltfuZxLqRhjQioZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com,
	Bharath Reddy <kbreddy.rpbc@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 217/522] Bluetooth: fix memory leak in error path of hci_alloc_dev()
Date: Tue, 16 Jun 2026 20:26:04 +0530
Message-ID: <20260616145136.184551162@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-265480-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com,m:kbreddy.rpbc@gmail.com,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,m:kbreddyrpbc@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,535ecc844591e50588a5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,appspotmail.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D8C16934FC

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bharath Reddy <kbreddy.rpbc@gmail.com>

[ Upstream commit 37b3009bf5976e8ab77c8b9a9bc3bbd7ff49e37f ]

Early failures in Bluetooth HCI UART configuration leak SRCU percpu
memory.

When device initialization fails before hci_register_dev() completes,
the HCI_UNREGISTER flag is never set. As a result, when the device
reference count reaches zero, bt_host_release() evaluates this flag as
false and falls back to a direct kfree(hdev).

Because hci_release_dev() is bypassed, the SRCU struct initialized
early in hci_alloc_dev() is never cleaned up, resulting in a leak of
percpu memory.

Fix the leak by explicitly calling cleanup_srcu_struct() in the
fallback (unregistered) branch of bt_host_release() before freeing
the device.

Reported-by: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=535ecc844591e50588a5
Tested-by: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Fixes: 1d6123102e9f ("Bluetooth: hci_core: Fix use-after-free in vhci_flush()")
Signed-off-by: Bharath Reddy <kbreddy.rpbc@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index cc7d4a8ed8ce24..b1886e517a78bc 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -81,10 +81,12 @@ static void bt_host_release(struct device *dev)
 {
 	struct hci_dev *hdev = to_hci_dev(dev);
 
-	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
 		hci_release_dev(hdev);
-	else
+	} else {
+		cleanup_srcu_struct(&hdev->srcu);
 		kfree(hdev);
+	}
 	module_put(THIS_MODULE);
 }
 
-- 
2.53.0




