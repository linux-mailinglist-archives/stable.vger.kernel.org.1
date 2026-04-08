Return-Path: <stable+bounces-235095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JmWGKeq1mmOHAgAu9opvQ
	(envelope-from <stable+bounces-235095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:21:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B95263C2CEF
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB7531B6A69
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6554E3176E4;
	Wed,  8 Apr 2026 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ju/wf3fN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DE337B81;
	Wed,  8 Apr 2026 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674557; cv=none; b=B9oUFNB9zNDsycqsYcWzYSccpx4YtWm9/Ffryjdfl5ULabToD0SareLs3Ox7rF9l5Te6UdUOVwxTO+xdLGAJwgVV5w1MF75P9Oyo7WyOVZ2LdS8khvZ4nyak47cpFKLBwM2npI3bNpfbrQqpiCeAV2jE0WUpt7V1rhyL7P3/vPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674557; c=relaxed/simple;
	bh=QumxolMapkAMesT9Tdj4YMFm6RSfc6F3EHqcF6l6k5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnUpFbjotX28SDEN8dbFishU2i2wAFfqJwbnXvEQ1Ws+afoC8SyHSYq928qZLYI16bkHrQZIJCsAzoojViL50yhy2qERbpqN8ld9Hai5Ldx8hT0egESVtDwj/llbHLHVa5qeXt+Ea7O/ysahusrBLZnMIiORisHk5aB4b82yiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ju/wf3fN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4575CC19421;
	Wed,  8 Apr 2026 18:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674556;
	bh=QumxolMapkAMesT9Tdj4YMFm6RSfc6F3EHqcF6l6k5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ju/wf3fNYPg3zIfP0/Um4iXXBKiLl5t9LhFPHwT18QFgjBDhgT5PLi8KOcoUe0NM9
	 6vr1SJ1pbu7oLJyW4B/fhegiVM56ofSewkO+LCVtRGRySzSMDt860CfVFqOm3s1lq4
	 5acXfWzQLxEu/ftBg0ymufFhEWLTnSda7GMSg8Jc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Rissanen <jonathan.rissanen@axis.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 101/311] Bluetooth: hci_h4: Fix race during initialization
Date: Wed,  8 Apr 2026 20:01:41 +0200
Message-ID: <20260408175943.185749041@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235095-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,axis.com:email]
X-Rspamd-Queue-Id: B95263C2CEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Rissanen <jonathan.rissanen@axis.com>

[ Upstream commit 0ffac654e95c1bdfe2d4edf28fb18d6ba1f103e6 ]

Commit 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during
initialization") fixed a race for hci commands sent during initialization.
However, there is still a race that happens if an hci event from one of
these commands is received before HCI_UART_REGISTERED has been set at
the end of hci_uart_register_dev(). The event will be ignored which
causes the command to fail with a timeout in the log:

"Bluetooth: hci0: command 0x1003 tx timeout"

This is because the hci event receive path (hci_uart_tty_receive ->
h4_recv) requires HCI_UART_REGISTERED to be set in h4_recv(), while the
hci command transmit path (hci_uart_send_frame -> h4_enqueue) only
requires HCI_UART_PROTO_INIT to be set in hci_uart_send_frame().

The check for HCI_UART_REGISTERED was originally added in commit
c2578202919a ("Bluetooth: Fix H4 crash from incoming UART packets")
to fix a crash caused by hu->hdev being null dereferenced. That can no
longer happen: once HCI_UART_PROTO_INIT is set in hci_uart_register_dev()
all pointers (hu, hu->priv and hu->hdev) are valid, and
hci_uart_tty_receive() already calls h4_recv() on HCI_UART_PROTO_INIT
or HCI_UART_PROTO_READY.

Remove the check for HCI_UART_REGISTERED in h4_recv() to fix the race
condition.

Fixes: 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during initialization")
Signed-off-by: Jonathan Rissanen <jonathan.rissanen@axis.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_h4.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index ec017df8572c8..1e9e2cad9ddf6 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -109,9 +109,6 @@ static int h4_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct h4_struct *h4 = hu->priv;
 
-	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
-		return -EUNATCH;
-
 	h4->rx_skb = h4_recv_buf(hu, h4->rx_skb, data, count,
 				 h4_recv_pkts, ARRAY_SIZE(h4_recv_pkts));
 	if (IS_ERR(h4->rx_skb)) {
-- 
2.53.0




