Return-Path: <stable+bounces-120563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6024A50751
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30B217533D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BD1250BE9;
	Wed,  5 Mar 2025 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ubLd/Fcp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74332505A7;
	Wed,  5 Mar 2025 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197323; cv=none; b=iSCN2/1nj2jlGNYERX3bOfO1DCeBXZ6vD4uC5bIPCbK+c1kiLHTODbzyX6Msje4AdWr/VAOeHHMjrrkWdXw7foL2jFsBDj/VWvfSD5L/MJryRok3OefdIg9aJiVEpxSE8qtlgsKJdnxiCIG16tEh14rSrqcxQfN3yH0LcH1foNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197323; c=relaxed/simple;
	bh=JdbrmXWm9CKTMGWsLiBIEtS2PC3kYfCQ86ZFM9Co0D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/w3wbYunuzsbPsORX/GxVxUfW2Oh/CWereGJLXQWdEmfJre3SuxtS153hUdS5CyXot+DmnCGyn0ds5DQlh2MKRKuc1NFYEqWUu0pYvh5QGnTZuCwOjZeqRc1H7b2mhfqgbSMtuToYGm8p6+1z4hOG0mgVUaJsF/QaRjEmul/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ubLd/Fcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4F6C4CED1;
	Wed,  5 Mar 2025 17:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197323;
	bh=JdbrmXWm9CKTMGWsLiBIEtS2PC3kYfCQ86ZFM9Co0D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubLd/Fcpp092UejeX7wn+GPR9C18/GfgOiTJ/3hjGB7UDpUj1FATjfPCKmB52MmOf
	 hF1lkni6cQlQ9Ie9NTI66c4yRaHQOF5AixEI0MVFwg+/gkXng/PxCcREET6fsSFqe9
	 E+RpFSeIkp5XlO9j2LjiHLdleFpLBlJFAPKBCIaY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 117/176] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
Date: Wed,  5 Mar 2025 18:48:06 +0100
Message-ID: <20250305174510.158244876@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit b25120e1d5f2ebb3db00af557709041f47f7f3d0 ]

L2CAP_ECRED_CONN_RSP needs to respond DCID in the same order received as
SCID but the order is reversed due to use of list_add which actually
prepend channels to the list so the response is reversed:

> ACL Data RX: Handle 16 flags 0x02 dlen 26
      LE L2CAP: Enhanced Credit Connection Request (0x17) ident 2 len 18
        PSM: 39 (0x0027)
        MTU: 256
        MPS: 251
        Credits: 65535
        Source CID: 116
        Source CID: 117
        Source CID: 118
        Source CID: 119
        Source CID: 120
< ACL Data TX: Handle 16 flags 0x00 dlen 26
      LE L2CAP: Enhanced Credit Connection Response (0x18) ident 2 len 18
        MTU: 517
        MPS: 247
        Credits: 3
        Result: Connection successful (0x0000)
        Destination CID: 68
        Destination CID: 67
        Destination CID: 66
        Destination CID: 65
        Destination CID: 64

Also make sure the response don't include channels that are not on
BT_CONNECT2 since the chan->ident can be set to the same value as in the
following trace:

< ACL Data TX: Handle 16 flags 0x00 dlen 12
      LE L2CAP: LE Flow Control Credit (0x16) ident 6 len 4
        Source CID: 64
        Credits: 1
...
> ACL Data RX: Handle 16 flags 0x02 dlen 18
      LE L2CAP: Enhanced Credit Connection Request (0x17) ident 6 len 10
        PSM: 39 (0x0027)
        MTU: 517
        MPS: 251
        Credits: 255
        Source CID: 70
< ACL Data TX: Handle 16 flags 0x00 dlen 20
      LE L2CAP: Enhanced Credit Connection Response (0x18) ident 6 len 12
        MTU: 517
        MPS: 247
        Credits: 3
        Result: Connection successful (0x0000)
        Destination CID: 64
        Destination CID: 68

Closes: https://github.com/bluez/bluez/issues/1094
Fixes: 9aa9d9473f15 ("Bluetooth: L2CAP: Fix responding with wrong PDU type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2a8051fae08c7..36d6122f2e12d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -656,7 +656,8 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	    test_bit(FLAG_HOLD_HCI_CONN, &chan->flags))
 		hci_conn_hold(conn->hcon);
 
-	list_add(&chan->list, &conn->chan_l);
+	/* Append to the list since the order matters for ECRED */
+	list_add_tail(&chan->list, &conn->chan_l);
 }
 
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
@@ -3995,7 +3996,11 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 {
 	struct l2cap_ecred_rsp_data *rsp = data;
 
-	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+	/* Check if channel for outgoing connection or if it wasn't deferred
+	 * since in those cases it must be skipped.
+	 */
+	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags) ||
+	    !test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
 		return;
 
 	/* Reset ident so only one response is sent */
-- 
2.39.5




