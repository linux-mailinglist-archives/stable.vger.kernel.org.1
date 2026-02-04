Return-Path: <stable+bounces-213712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGc9G2dfg2lzmAMAu9opvQ
	(envelope-from <stable+bounces-213712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:01:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB2EE7C69
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDF393024298
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDDF286890;
	Wed,  4 Feb 2026 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rixtfD1f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823AC29AB1D;
	Wed,  4 Feb 2026 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217254; cv=none; b=mNhcbSb7TVgZtAHcb+3u/YQvdUpkD8s/GRBpAVBWCndWxPoo5rBZMTqo6NO3EAGLWg7iX8v/mJ26TVVXUWGl/VznsQbHrZoXm3XOlErow8i6nf1D8FwaK32Dm9q+ZOnxyF+eCsU4gb1TNWTfdQHbXb0IF8ItlJ0t3gzYlWwFNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217254; c=relaxed/simple;
	bh=YcnbICUNa5VEg/i/nlPS8D0K34atlrmHQ0eZTTwNM2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbRO7unWw/XF40/euj/hJkqqt+RE98unJsjp0FPzRSNcDMpMQ3I/zbaUOB3mZSoxfblAoB6l29B93QlAjipidDSJWlDw3lbFKJjmF2CbTaXb/h/yPkMQPm82HMTLyzo3C88gWl9tbgAcbVzRRKElpWNaAPW3CKmTnVIV30H5O+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rixtfD1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A072C4CEF7;
	Wed,  4 Feb 2026 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217254;
	bh=YcnbICUNa5VEg/i/nlPS8D0K34atlrmHQ0eZTTwNM2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rixtfD1fbWx0tPrFIUJDhdEDQR/OetxDZEmsVdI5BMuC54/FzbZCFiKbrq7zSrQPx
	 fL8ECthIN1bHAng58wpS9QKew/pUQ4XajbdU6mg9U0Jh+K+SRdCcV3N78rbwHzsL60
	 boXuxu2aGqZVE31eCLUBR+knLDXu2YpU9APP1pJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jia-Hong Su <s11242586@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 135/206] Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work
Date: Wed,  4 Feb 2026 15:39:26 +0100
Message-ID: <20260204143903.070542933@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213712-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[s11242586.gmail.com:query timed out,luiz.von.dentz.intel.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2DB2EE7C69
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Hong Su <s11242586@gmail.com>

[ Upstream commit 0c3cd7a0b862c37acbee6d9502107146cc944398 ]

hci_uart_set_proto() sets HCI_UART_PROTO_INIT before calling
hci_uart_register_dev(), which calls proto->open() to initialize
hu->priv. However, if a TTY write wakeup occurs during this window,
hci_uart_tx_wakeup() may schedule write_work before hu->priv is
initialized, leading to a NULL pointer dereference in
hci_uart_write_work() when proto->dequeue() accesses hu->priv.

The race condition is:

  CPU0                              CPU1
  ----                              ----
  hci_uart_set_proto()
    set_bit(HCI_UART_PROTO_INIT)
    hci_uart_register_dev()
                                    tty write wakeup
                                      hci_uart_tty_wakeup()
                                        hci_uart_tx_wakeup()
                                          schedule_work(&hu->write_work)
      proto->open(hu)
        // initializes hu->priv
                                    hci_uart_write_work()
                                      hci_uart_dequeue()
                                        proto->dequeue(hu)
                                          // accesses hu->priv (NULL!)

Fix this by moving set_bit(HCI_UART_PROTO_INIT) after proto->open()
succeeds, ensuring hu->priv is initialized before any work can be
scheduled.

Fixes: 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during initialization")
Link: https://lore.kernel.org/linux-bluetooth/6969764f.170a0220.2b9fc4.35a7@mx.google.com/

Signed-off-by: Jia-Hong Su <s11242586@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_ldisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 4692b9bec4692..46b37d825d185 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -684,6 +684,8 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 		return err;
 	}
 
+	set_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
 		return 0;
 
@@ -711,8 +713,6 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
-	set_bit(HCI_UART_PROTO_INIT, &hu->flags);
-
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
-- 
2.51.0




