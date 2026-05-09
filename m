Return-Path: <stable+bounces-244928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIFtNRTx/mkdzwAAu9opvQ
	(envelope-from <stable+bounces-244928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 10:32:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE2F4FEB1C
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 10:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BE7F3013AB1
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971938B7D8;
	Sat,  9 May 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="plr0aj/p"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C938C2AA;
	Sat,  9 May 2026 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315535; cv=none; b=RRUe7vjW82bdMcXdtudHKVWjNHAGAbue4hVQSWZWs2ZR+w3PoWbmPt4umw2b2MKr4WaJE1G5kdfxcBeAbS8YpMCRvZx2nymM12kNiFk0aiXV8fr4stxn8pThz1myszdT9r+VWYqBv+/ETGDuiWoue01grVHTH4brwGmTdOWKbio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315535; c=relaxed/simple;
	bh=2cTZOBsaXJfrbAo4fOEuHNXivIBOdTy6k1+K9HbUPlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=il5A4CBQjy2MdDyByf2ij0fsBPFKvywiyd/Tq/3EM53lkA9sL/ncLd5SmhY226te1fTq8xz0Olm6YqGDMl3dmB9Fnau1uWVaQAMQApQvAvK/fqJgqGMrE38tr/XRa1FPzehdO7IUsGlYjtms13rJxrwfIuKs20nqpC7+dIPbcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=plr0aj/p; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778315496;
	bh=75MRJG5bCdCuYUUYQ1VLQaZYT1JvZx/IDclUGNtpMZM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=plr0aj/p1zu85v5ZlOl1vb52P1xOplPgdpI8EJ5nojEv2iMW6Bzgjo2P1tcQbs3Vh
	 7BhmebZ8mkm9Nbuu/dMG+X/gLXhdq1mq4XodqjH2alKwX7ijs5Wr4ufZEgXjXK6wYv
	 Uyv6fuKCo8Zn7Y2bSLqcLNfHRp2bKH7lfYoqoTOw=
X-QQ-mid: zesmtpip2t1778315490t0b0601e2
X-QQ-Originating-IP: WKyQ1VWGg6tDwd4YJBZsrdbq0C5nmV/jkB75ohFGVyM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 09 May 2026 16:31:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6282689411101105919
EX-QQ-RecipientCnt: 7
From: wuyankun <wuyankun@uniontech.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wuyankun <wuyankun@uniontech.com>,
	syzbot+da2717d5c64bf7975268@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: serialize close flush with write_work
Date: Sat,  9 May 2026 16:31:24 +0800
Message-Id: <20260509083124.291207-1-wuyankun@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MNbA5mkmBXEJDSEEpAV1tdC3p2zB8TDfUMvVn8oBTumV44efhmTJehfb
	pcBY4r0SqGJihy6I9Uhpj+XomKVeFoKyFLD2Eh/7j4LybwEDjQ0+NnBivgHdbe4vYv5W2Ca
	MsV5H9HlSvgAwk76N1mw8S1K3wWz0vtfktddGYFQmLis4y0z26w9TsujQVYW9wA0k6LVxI8
	UIF4717ZBqqeF5M9gZA6lOENoygOn7jDQM+I41DrUf+hMCOdKphAW+ukbyUfEVBOaaO04oQ
	MELRjzTSa1vDUEANbpUYzW3LfvEweEy1g1kQnmYiY6AXX7xsyoO45X7u5y82Q2dcvx31XsZ
	9E8YXIV671g+zZDCMg5ypsTrWVrIHFw4dw9icDayzywswMKYAXmYAkHTaTZ8W5jHMDth/Ac
	iywhl3nCZN5aDhvcNQQcDOaYX23l/zwtotCDnzEVnfuyKWBZLTz7XjKvcpiKbODGUYkCWFf
	UG8lkKygh3UqT2CLuPRQlS4jjBqA7ea5VnC+dfyGDF7H7LdElHCeoYoJg9NZPVPEs/eKbKZ
	HjFEDTHToTDPwtiZ89C02HKchtxuHSMWbsMbApuHkP4RatZzxAxfFSWkyJ+FR/ebj1auvN6
	eslRmX45PIngxq05FJ9OXMmSfxYzMHBUeSzNMc/Xp+GqTtLqhZM0/rs1CYiCmwiZHpqqO6P
	5Py911BEtIiplV5dosqYfYDCjX9ZIsMNzAqzAm/bUUv/DH22vldCoM07py6cNZqtQLxFNZP
	2bTU31P3s3fAqixa6yVHQLdyLmFGgiCE0WFy1NmuG2lzbogfe5km51RoxfM44WcrZLSiJ/H
	MAPX26kHXiv8FQ2Z5Z48+LtkvMVMIzhHyNiZzxjmnF7V/bMMPq/SZFCN07kE4EGJDRT+8qY
	0EMN9jnxwki8/63H6YtyADNKJSDIE4PxZy801ABAiwGLDO8HJ/AZ+zH26x8kz6MrzBXXsCJ
	QHoA3CarK9uZBEsW1IsOtERg/gR+8T0VR2V4X18hyGmalZ0ws0G1d4oj0FM1/JmqE+UrOPN
	+h9nc8n9wM9caEluHRMo4rbpFq7kU=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 3AE2F4FEB1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244928-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wuyankun@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-0.962];
	TAGGED_RCPT(0.00)[stable,da2717d5c64bf7975268];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

hci_uart_close() calls hci_uart_flush(), and flush may free hu->tx_skb.
At the same time, hci_uart_write_work() can still be running and access
the same skb (for example through skb_pull()), which leads to a
use-after-free.

Fix this by canceling write_work before calling hci_uart_flush(), so the
tx_skb lifetime is fully serialized against the TX worker.

Reported-by: syzbot+da2717d5c64bf7975268@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=da2717d5c64bf7975268
Cc: stable@vger.kernel.org
Signed-off-by: wuyankun <wuyankun@uniontech.com>
---
 drivers/bluetooth/hci_ldisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 275ea865bc29..51cc9af0f7e8 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -263,8 +263,11 @@ static int hci_uart_open(struct hci_dev *hdev)
 /* Close device */
 static int hci_uart_close(struct hci_dev *hdev)
 {
+	struct hci_uart *hu = hci_get_drvdata(hdev);
 	BT_DBG("hdev %p", hdev);
 
+	/* Ensure write_work is not touching tx_skb while flush frees it. */
+	cancel_work_sync(&hu->write_work);
 	hci_uart_flush(hdev);
 	hdev->flush = NULL;
 	return 0;
-- 
2.20.1


