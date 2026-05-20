Return-Path: <stable+bounces-252940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAGQJ+sqDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-252940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:43:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1520F59B3A1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5654633E0D6D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DD1348C47;
	Wed, 20 May 2026 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MW7SI+qd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C863A5426;
	Wed, 20 May 2026 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301987; cv=none; b=oxp/DAXKP9myDRCMhYib7w2OV2z0hCrSKsW4tOdeC1TdjOrqF7UeojjKGtb5Cv3BsmZ5waORA8F3tfMeVPBKHK9o+0OUSfuOfOhY+T3E9Aseg2vXpUq9OwpP0zMR+Hj+fJwMe48YKRolcz9cIVNXhZ5NZInPK/TnSrXk5C4LsfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301987; c=relaxed/simple;
	bh=E7XIDsfsBIW6kRr7xznp7blg46uNvK/jIVy8tQa9cko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj5eBWWkNfuqbIB68M3AzWTTnCCKuONwT0QBLkaSIIXYj0MuXvXZXZy/U0DCLPKQopbB9wAS/LcTsDOSOQ2yIAgqwS9lL2mpiWzNnCL3SgGBhk+uG8a3bz7Mu5vGbXz8Axk9LWem3WD0CDhcjF7tC1SbKueEX3efDcTLZqqNeyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MW7SI+qd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB361F000E9;
	Wed, 20 May 2026 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301985;
	bh=8axdLrB+9EFsqSapBvHaQD5xOatW1jdH01AH+91kl8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MW7SI+qdF03xKvPzrGujqhrblNT6eJC65p1BndSbSQjqkpbn+6WqryODI6lLn+roz
	 oVv2ZRlXvkyhrk+o3/UiRTsvX0rdO2BuLRFrrRJPZSElWWR7TBBLiSwleVnL6plFFd
	 q3ktz9E8GXEWpk+sUW5caDbZPs+n56q1CsUmymrk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Rissanen <jonathan.rissanen@axis.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 078/508] Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error
Date: Wed, 20 May 2026 18:18:21 +0200
Message-ID: <20260520162100.300397564@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252940-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,axis.com:email]
X-Rspamd-Queue-Id: 1520F59B3A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Rissanen <jonathan.rissanen@axis.com>

[ Upstream commit 68d39ea5e0adc9ecaea1ce8abd842ec972eb8718 ]

When hci_register_dev() fails in hci_uart_register_dev()
HCI_UART_PROTO_INIT is not cleared before calling hu->proto->close(hu)
and setting hu->hdev to NULL. This means incoming UART data will reach
the protocol-specific recv handler in hci_uart_tty_receive() after
resources are freed.

Clear HCI_UART_PROTO_INIT with a write lock before calling
hu->proto->close() and setting hu->hdev to NULL. The write lock ensures
all active readers have completed and no new reader can enter the
protocol recv path before resources are freed.

This allows the protocol-specific recv functions to remove the
"HCI_UART_REGISTERED" guard without risking a null pointer dereference
if hci_register_dev() fails.

Fixes: 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during initialization")
Signed-off-by: Jonathan Rissanen <jonathan.rissanen@axis.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_ldisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index e38f3c4458c90..85baba91aaa97 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -689,6 +689,9 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
+		percpu_down_write(&hu->proto_lock);
+		clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
 		hu->proto->close(hu);
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
-- 
2.53.0




