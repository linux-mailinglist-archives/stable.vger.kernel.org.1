Return-Path: <stable+bounces-252280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC2PDacSDmoJ6AUAu9opvQ
	(envelope-from <stable+bounces-252280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:59:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AAD598FB4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B06923166FD8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076DA3F23C5;
	Wed, 20 May 2026 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qmP4QpeN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8636CE19;
	Wed, 20 May 2026 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300262; cv=none; b=IkFs8Od3gGo0arJYXeKMOchr10tmpPWbn7lZXBxkiyM4AxfgZgbIxORAF4lVkXd1fOJAj9p6hIgV5Syx/0ldlilTUzdzGnipex/YTxP7pK5p0JsRFWnGQ88IWItF7kVsIM12zqbfK9cZ7Jz3E713nUwNkzrBNK/GhY9sXb4iR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300262; c=relaxed/simple;
	bh=dMZGoeSRBbMDChr1LK97/5ftlyFVXWHafTA5nvKG61k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoDwmXQGu1VewtqtR2rYny/IQd+5+uPpsjfQIknCc5qaL47cprhzXJW9jjZCrRDYffy8uBW84KenME+cxrEwBsD0YKId7nAz7Du1/9ElMHZfTtKnspsIE96eJlqh11REILKNOPtWkudklTgO78ijQQQdvAO9v7/uZXCdEXgHSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qmP4QpeN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ABA1F000E9;
	Wed, 20 May 2026 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300261;
	bh=onvH6+CiPa2IoEBA7A14j3JWjRJ/Pvj11gzBtN1ge3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qmP4QpeNU9GHnGtrYl3KmgWEahyHUZLnkE0itJmaaXxKVraKF9y5gDlNjm44+8Ayf
	 UAKZ5xnaATPvz3R9iKY58P8vdUYGVUMQIVunFvSZQA0GXB7hTJI9e1GWhncWE3gyiy
	 SAQtzhXuWgPzKLHIKrrLVGGM4m++nuXHwui1WzTk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Rissanen <jonathan.rissanen@axis.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 107/666] Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error
Date: Wed, 20 May 2026 18:15:18 +0200
Message-ID: <20260520162113.540865845@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252280-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,axis.com:email]
X-Rspamd-Queue-Id: 49AAD598FB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 436ee77d4bf2f..0d06b83816d1c 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -692,6 +692,9 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 
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




