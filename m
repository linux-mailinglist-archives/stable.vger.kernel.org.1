Return-Path: <stable+bounces-245146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKdvNk6LAWp4dQEAu9opvQ
	(envelope-from <stable+bounces-245146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:54:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F26FE509A28
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D66003014DAB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02D63A1CEC;
	Mon, 11 May 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CTeWUnmG"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639A39D6CF;
	Mon, 11 May 2026 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485520; cv=none; b=khwHD4nkVNTN8VeJFf1iSw4RFCosHC4tX9YDe5TOZ7P9qMH8Z6LteTAw7loiRxQgE5AaV4GuJota5ws9k/sReFq+S8G71ByXep8/Ik1R9Vp4g3PGJ1gVtHTFXSFbowAtjv82QAmj0M71bSi4WuPhR7i0xDialndr8Ma9lvdCMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485520; c=relaxed/simple;
	bh=we7bDcYHyM4vvTRkKsYJdqaefM9npKcFZep6t9qfIX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFd4yC6zfuCRJs8v/U1t1LynQnv4n9DxJV3E1AsJdI/z79lE8eBN/dPp8AWFSOwmrG9s7Vvtp3VAd3w+RCce2Ro4YoBsXeOHK1fzCsYRJyUiXxE9nAc6LDMPv9rf2A4aM3/PN4OYYvc5jqfdqBUO4E6jlKzh2wjhNwG4JyziVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CTeWUnmG; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=e6
	B2TNfS+lqCmKP8g9YRNEeG1V52LEUWeodH6lN2dgo=; b=CTeWUnmGoZjYQk9mZz
	Hw/SZquXAn8dKqnFm5u6gmidoNJsQqKi/l1lwpFc1Mju318eraDGV5h3iVtKZTuw
	ixjPpHYUYqOiCARUkGKx1ShknB+1zJxRHaVSo3v5Hhm8y3bgD9RERdcAeoFYpB7e
	lxfbkhxAtNR2HZhIbUzyP+ZP8=
Received: from China-163-team (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3fwTniAFq_EfPDA--.33180S2;
	Mon, 11 May 2026 15:44:42 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.12.y] Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
Date: Mon, 11 May 2026 15:44:11 +0800
Message-ID: <20260511074411.49809-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3fwTniAFq_EfPDA--.33180S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1xGw4kAr47CFW8KF17KFg_yoW8trWUp3
	9xWrWrCaykJrn8Z3WvqF4xXF48CFyDWF129r48WrWYy3Z5Jr1Uta1xCry0qF1j9rWkGF47
	Za1Fqws3WFn8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pM7KI-UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7As3AGoBiOsk4QAA3d
X-Rspamd-Queue-Id: F26FE509A28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245146-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 00fdebbbc557a2fc21321ff2eaa22fd70c078608 ]

l2cap_conn_del() calls cancel_delayed_work_sync() for both info_timer
and id_addr_timer while holding conn->lock. However, the work functions
l2cap_info_timeout() and l2cap_conn_update_id_addr() both acquire
conn->lock, creating a potential AB-BA deadlock if the work is already
executing when l2cap_conn_del() takes the lock.

Move the work cancellations before acquiring conn->lock and use
disable_delayed_work_sync() to additionally prevent the works from
being rearmed after cancellation, consistent with the pattern used in
hci_conn_del().

Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Minor context conflict resolved. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 net/bluetooth/l2cap_core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 128f5701efb4..307f7fe975b5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1756,6 +1756,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	disable_delayed_work_sync(&conn->info_timer);
+	disable_delayed_work_sync(&conn->id_addr_timer);
+
 	mutex_lock(&conn->lock);
 
 	kfree_skb(conn->rx_skb);
@@ -1769,8 +1772,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (work_pending(&conn->pending_rx_work))
 		cancel_work_sync(&conn->pending_rx_work);
 
-	cancel_delayed_work_sync(&conn->id_addr_timer);
-
 	l2cap_unregister_all_users(conn);
 
 	/* Force the connection to be immediately dropped */
@@ -1789,9 +1790,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		l2cap_chan_put(chan);
 	}
 
-	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		cancel_delayed_work_sync(&conn->info_timer);
-
 	hci_chan_del(conn->hchan);
 	conn->hchan = NULL;
 
-- 
2.43.0


