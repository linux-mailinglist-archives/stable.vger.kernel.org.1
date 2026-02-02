Return-Path: <stable+bounces-213055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOsTHpiCgGnE8wIAu9opvQ
	(envelope-from <stable+bounces-213055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:55:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB1CB4AB
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 589F3300F9C8
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5A52D7813;
	Mon,  2 Feb 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LHIWYKXr"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B527AC57
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029387; cv=none; b=HvfhC0TgHOTkcsXxIQalSLQ2BgMVR34A0Y6p3p40uYXHFc1cpG7vhwAnLe4/0x970cAPwOYesOOevebOMSXPFGvyZSRZU9NZqDVbRb9GgMQa7FYN6ARbCmTDOVZj1NAztHBTyXGgCntvTIlAS51vmY5wUnGIZ65YlQ2tJTclK58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029387; c=relaxed/simple;
	bh=8EmWrJzdfnu8N20ykOVeXuUcxkw3hPqqJqGJ1XLu+lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4LJkDOtQwcJ7CKFJR11mJQyYxLV6U4MfsIlKrZIONeVv78rVjhpw9M8zLWgt82QCG7G9VKY5/9QVjrat6NUOGAck6vL0AUlNasB/DxBktAgix+fVjbIdiB5JYFLWCXJeMOeXEG9BgxSjCvNB7bF1cDikmVWpop60+7+j9R9+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LHIWYKXr; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=oH
	N6oA2Gtn7XTtbECxKm2Qkq3v1TTUTrqRK4YBUU74Y=; b=LHIWYKXrnS9GRSaaz+
	0Xu9S/MFNRwmXev0nM5hU50qy4YAwaP5Gr4pOGeQ14UtHUf++CuNKr6+uxEtDM2x
	qAID4EebWP9bFLVoOhjJfQwZdhc85r8PpYvmC++u9YG6lQQvvHtdx+FqLEpegtBo
	9HCzix87CrL/oBZ6D9JvlqlZs=
Received: from ubuntu24.corp.ad.wrs.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAX3wYigYBpl1lsMw--.49151S4;
	Mon, 02 Feb 2026 18:49:23 +0800 (CST)
From: jetlan9@163.com
To: stable@vger.kernel.org
Cc: Ying Hsu <yinghsu@chromium.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 5.15.y] Bluetooth: Fix hci_suspend_sync crash
Date: Mon,  2 Feb 2026 10:48:57 +0000
Message-ID: <20260202104857.4134-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAX3wYigYBpl1lsMw--.49151S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw18tw13Wr4xJFykWw1rZwb_yoW5JF45p3
	43KF4Fgas7Jr12grWqqay8ZFyrGrZxWrW7ZFZ3Kryrtw45tw4kArW3Xry3tF4UArZ5JF95
	Aa1Yvry8ua1UAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pREJPXUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCwxPmr2mAgTN51QAA3u
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-213055-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,intel.com,163.com];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org]
X-Rspamd-Queue-Id: E1CB1CB4AB
X-Rspamd-Action: no action

From: Ying Hsu <yinghsu@chromium.org>

[ Upstream commit 573ebae162111063eedc6c838a659ba628f66a0f ]

If hci_unregister_dev() frees the hci_dev object but hci_suspend_notifier
may still be accessing it, it can cause the program to crash.
Here's the call trace:
  <4>[102152.653246] Call Trace:
  <4>[102152.653254]  hci_suspend_sync+0x109/0x301 [bluetooth]
  <4>[102152.653259]  hci_suspend_dev+0x78/0xcd [bluetooth]
  <4>[102152.653263]  hci_suspend_notifier+0x42/0x7a [bluetooth]
  <4>[102152.653268]  notifier_call_chain+0x43/0x6b
  <4>[102152.653271]  __blocking_notifier_call_chain+0x48/0x69
  <4>[102152.653273]  __pm_notifier_call_chain+0x22/0x39
  <4>[102152.653276]  pm_suspend+0x287/0x57c
  <4>[102152.653278]  state_store+0xae/0xe5
  <4>[102152.653281]  kernfs_fop_write+0x109/0x173
  <4>[102152.653284]  __vfs_write+0x16f/0x1a2
  <4>[102152.653287]  ? selinux_file_permission+0xca/0x16f
  <4>[102152.653289]  ? security_file_permission+0x36/0x109
  <4>[102152.653291]  vfs_write+0x114/0x21d
  <4>[102152.653293]  __x64_sys_write+0x7b/0xdb
  <4>[102152.653296]  do_syscall_64+0x59/0x194
  <4>[102152.653299]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1

This patch holds the reference count of the hci_dev object while
processing it in hci_suspend_notifier to avoid potential crash
caused by the race condition.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Adjust context ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 net/bluetooth/hci_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7ed5d6e47e4f..cd4d931368a0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3706,6 +3706,9 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 	int ret = 0;
 	u8 state = BT_RUNNING;
 
+	/* To avoid a potential race with hci_unregister_dev. */
+	hci_dev_hold(hdev);
+
 	/* If powering down, wait for completion. */
 	if (mgmt_powering_down(hdev)) {
 		set_bit(SUSPEND_POWERING_DOWN, hdev->suspend_tasks);
@@ -3757,6 +3760,7 @@ static int hci_suspend_notifier(struct notifier_block *nb, unsigned long action,
 		bt_dev_err(hdev, "Suspend notifier action (%lu) failed: %d",
 			   action, ret);
 
+	hci_dev_put(hdev);
 	return NOTIFY_DONE;
 }
 
-- 
2.43.0


