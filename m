Return-Path: <stable+bounces-246438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KGJIbZzA2rf5wEAu9opvQ
	(envelope-from <stable+bounces-246438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:38:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8B2527E74
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58077321BB29
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272643EDE45;
	Tue, 12 May 2026 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ehilg97a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECEF2DE6E3;
	Tue, 12 May 2026 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609228; cv=none; b=O3NPK0k2YWrm+dNrz6MjT3o+G9nReT2tlyJzzX35oWOiIxQgPll5eGaRKjFgFozYMePOIOt2DYYQNE2GlmjRLAr8tYYFD/6AnmrOivNRWW+jnujp37FMPY5Xlp/mIb2WpQNWHWybXv8Oab5kdbbOSPQfjXfodoyx3cr/OKs/xNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609228; c=relaxed/simple;
	bh=mga2/kU+JmQjnw4T8XXPWZU2mOXVBtNVtCbg7oFttnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqW619Z9l9eMDi5F53ZR/6ev262wOnzd6huvsBlPfWHujiukdWEU2hh7iZpcjP6XmcUFnHZk4doPiPzeMNWMpcSFaYrHTNUQnBi7HWoxSnlvES9GNRQ6enxaMdubvJX1mXuY6K1hnFFgzerKa8M3rx/zwHMtG/2a5jJcaZEEVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ehilg97a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCD0C2BCB0;
	Tue, 12 May 2026 18:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609228;
	bh=mga2/kU+JmQjnw4T8XXPWZU2mOXVBtNVtCbg7oFttnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ehilg97agYhKFWYiKrSL6U2xL5PSpZjWztAq5Zzyo5tZS+cTOKR1ngG8K/culNBpa
	 4hzec8/8BBdKFS7m8Xgugv/nGb6PaQy1B2jxXYmzXSr8AZVm2Ms+YTFX8ZDYKojbWW
	 42g8r/158vnsR+Dxl0PovXP/DJ5FJjYQQcGS3CiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhiTao Ou <hkbinbinbin@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 7.0 073/307] Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt
Date: Tue, 12 May 2026 19:37:48 +0200
Message-ID: <20260512173941.662971167@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 1B8B2527E74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246438-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 5ddb8014261137cadaf83ab5617a588d80a22586 upstream.

hci_le_create_big_complete_evt() iterates over BT_BOUND connections for
a BIG handle using a while loop, accessing ev->bis_handle[i++] on each
iteration.  However, there is no check that i stays within ev->num_bis
before the array access.

When a controller sends a LE_Create_BIG_Complete event with fewer
bis_handle entries than there are BT_BOUND connections for that BIG,
or with num_bis=0, the loop reads beyond the valid bis_handle[] flex
array into adjacent heap memory.  Since the out-of-bounds values
typically exceed HCI_CONN_HANDLE_MAX (0x0EFF), hci_conn_set_handle()
rejects them and the connection remains in BT_BOUND state.  The same
connection is then found again by hci_conn_hash_lookup_big_state(),
creating an infinite loop with hci_dev_lock held.

Fix this by terminating the BIG if in case not all BIS could be setup
properly.

Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Cc: stable@vger.kernel.org
Signed-off-by: ZhiTao Ou <hkbinbinbin@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_event.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7121,9 +7121,29 @@ static void hci_le_create_big_complete_e
 			continue;
 		}
 
+		if (ev->num_bis <= i) {
+			bt_dev_err(hdev,
+				   "Not enough BIS handles for BIG 0x%2.2x",
+				   ev->handle);
+			ev->status = HCI_ERROR_UNSPECIFIED;
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
+			continue;
+		}
+
 		if (hci_conn_set_handle(conn,
-					__le16_to_cpu(ev->bis_handle[i++])))
+					__le16_to_cpu(ev->bis_handle[i++]))) {
+			bt_dev_err(hdev,
+				   "Failed to set BIS handle for BIG 0x%2.2x",
+				   ev->handle);
+			/* Force error so BIG gets terminated as not all BIS
+			 * could be connected.
+			 */
+			ev->status = HCI_ERROR_UNSPECIFIED;
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
 			continue;
+		}
 
 		conn->state = BT_CONNECTED;
 		set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
@@ -7132,7 +7152,10 @@ static void hci_le_create_big_complete_e
 		hci_iso_setup_path(conn);
 	}
 
-	if (!ev->status && !i)
+	/* If there is an unexpected error or if no BISes have been connected
+	 * for the BIG, terminate it.
+	 */
+	if (ev->status == HCI_ERROR_UNSPECIFIED || (!ev->status && !i))
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation



