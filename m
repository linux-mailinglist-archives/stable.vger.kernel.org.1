Return-Path: <stable+bounces-231428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGXRJaXWy2mILwYAu9opvQ
	(envelope-from <stable+bounces-231428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:13:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA8036AC35
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D6B9303656C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB6C3F7875;
	Tue, 31 Mar 2026 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2Vk1FjD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D573D8114
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966434; cv=none; b=ScxPU+9OeoTKqNM3A1Tj8oQF2L7ugRzGI8S/v1ijfiOhT1XJ3E9GAPmwPWk+VgvB+4c/jDne22j4DUBTsO4GXiQU4TRP8/b8zecnSMFWlaJqRcQMTw5jQS3WNjRRXZc7fr6bU6kCGTnIMKWjWwWSOmjHQYDORoRPuODzpwMsCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966434; c=relaxed/simple;
	bh=szt0w8DbKoVg8ulmw8/DZSgLzId9BVRNgZALH0Fp2+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgMzpKjpCgp2f5SruwpXUDeWn14wA3pZunFfzxBL/n7eJTd2VgPh2BMKWxgiQDXJu7jAnTeCfGNxiaPZD1XrBzJjUWOaAiu4YmoREbdl3nY8qHTvrtr+iXG6/v/L3c5NPBdoGq/QSc80VMrRi9uid2Mw10LgsXxhw9Erpkn+SD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2Vk1FjD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82ce09b4197so270381b3a.2
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774966433; x=1775571233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEznFt8iy4PfjJKzwmf2yqiGR9CX0VFuj03I+QP2lL4=;
        b=F2Vk1FjDTzGMeJEBLL5KZvhExnhpcxoYDh7jRxljDbOoJQDCtRLux08bljbzY2LbWk
         D64np2pqqgfEu6GSGXBjFWBXGgqeaUWAlsL1yOP8zsVTdgZ/Nf5rwR5BgBEyFqyorrff
         Q4Q0KUrJntSqpjZhqVtBGoI+g/Y1uHyfTQ3rmpL7QLkewfQL8gvD2LZX8KaQ5VbQ8gh1
         xnJRNhkLpx9M0Vdo/LIcUIjjO+ZoGvENH7uv6RGGTEcsljDFXBxeiPj6TXC/3ZRzv9oG
         3pCLeSfqANiQCrzq6Yd5jxSpI/a5NeHaLpraCfI1qndQRvgN1sS0p5I4D/aj3XQs2rBC
         pyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774966433; x=1775571233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEznFt8iy4PfjJKzwmf2yqiGR9CX0VFuj03I+QP2lL4=;
        b=EUAlXfJISMnQbOSOShc2wYPOXQAz1ZjnAnsYN+GD2BN79y7R9sK9rp2fGorMgJhLNm
         JSju7fgVBucpzN6B5WJ4H8drxYitlKluiCp4KofaOvKap8zOnNIRReoQjGGIyRPk0vkl
         9NYC1nnxTgwybC2neKqvrGzFphlvDJDNGbsEdNYIBXu0khpYw2r17+xDMMaBiTSUujPw
         cHxvAHQY8xNnq9zMNDjfC6ZPXDaQ9ZUm3vTIrgKWYc1XZwKihvyJBV9zo4M2FPQbhnyj
         oXG+AXoUOuR4HwPwIvwQbqH8K42VeF/LXye1PXhOrNVvLWxeU36PYP+P4s7nmSvT8vds
         Eo8g==
X-Forwarded-Encrypted: i=1; AJvYcCU9PfLotTgZa62NHKSkhkMxcUIgHesZ3hGb7UovXcuzMMw1vcmhSM8vNNQtvt2tKXq8PQBARuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyshp/DVjmuvRaPhSFTAfsFP8R1CMJKRFv7XGiewfecj8eAvqvQ
	ycJIM88uHcpzzwkCmo2KGdgGuHUNef9JN9chHgVpCJGeHF3XWDEBMMqw
X-Gm-Gg: ATEYQzy6ty06RITrrn4AjNuSClN4nl9Uq+ZtF/wYXVihKma/Wpv88CAvc3S9X0AGSt2
	gAFWRX8F1vIbe/0pm9+WC3Fbls3AatrRMoPxIXHeZat8w9h3WKJz5H4l1tGqwuzOqwl0XWMzxgw
	pQvu1nrkRnQuCzWAdoE8QAg007VDY2XvflLPTvTGpA+1IG6TNz8yfzvq7D3J07Ee9M8RoxpUBkA
	0sbladAy2ryXCxDBauy8ywc/gsSUlijlnPkI2LVlNJS76vRCmZSxlJ7K6JzF6ldI0RLlcmhZJ9w
	6vHVDNgA/PABdJS/PSHprBGDh/RisVb12pGOOLxjS3MotxhM41P/Y3FVnb/jjA+lJjByq7Xzh2j
	1CxSDGpdyt+pgryq5w7TidiymtZk7h6M+OC4IwgVRxUYAhuTs90UATfynKOuhyvMqi52PSqjpoK
	VgbT5/
X-Received: by 2002:a05:6a00:6ca2:b0:829:6f7d:3093 with SMTP id d2e1a72fcca58-82c960942d4mr15021120b3a.48.1774966432737;
        Tue, 31 Mar 2026 07:13:52 -0700 (PDT)
Received: from hkbin-u25 ([2406:280:1003:25b6::6da])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca847ff4dsm10630221b3a.23.2026.03.31.07.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:13:52 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	hkbinbin <hkbinbinbin@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_event: fix OOB read in hci_le_create_big_complete_evt
Date: Tue, 31 Mar 2026 14:13:32 +0000
Message-ID: <20260331141332.3243059-1-hkbinbinbin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
References: <20260331055032.1883139-1-hkbinbinbin@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231428-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hkbinbinbin@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3AA8036AC35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Fix this by:

  - Breaking out of the loop when i reaches ev->num_bis and cleaning
    up all remaining BT_BOUND connections, then terminating the BIG
    since a mismatch between the host and controller state indicates
    failure.

  - Properly cleaning up the connection when hci_conn_set_handle()
    fails, instead of calling continue which leaves it in BT_BOUND
    state where it would be found again by the same lookup on the
    next iteration.

Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Cc: stable@vger.kernel.org
Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
---
 net/bluetooth/hci_event.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 286529d2e554..64b5b497c491 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7085,9 +7085,15 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		if (i >= ev->num_bis)
+			break;
+
 		if (hci_conn_set_handle(conn,
-					__le16_to_cpu(ev->bis_handle[i++])))
+					__le16_to_cpu(ev->bis_handle[i++]))) {
+			hci_connect_cfm(conn, HCI_ERROR_UNSPECIFIED);
+			hci_conn_del(conn);
 			continue;
+		}
 
 		conn->state = BT_CONNECTED;
 		set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
@@ -7096,7 +7102,22 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		hci_iso_setup_path(conn);
 	}
 
-	if (!ev->status && !i)
+	if (conn) {
+		/* More bound connections than BIS handles reported by the
+		 * controller -- treat this as a failure for the entire BIG
+		 * and clean up any remaining BT_BOUND connections.
+		 */
+		do {
+			hci_connect_cfm(conn, HCI_ERROR_UNSPECIFIED);
+			hci_conn_del(conn);
+		} while ((conn = hci_conn_hash_lookup_big_state(hdev,
+							ev->handle,
+							BT_BOUND,
+							HCI_ROLE_MASTER)));
+
+		hci_cmd_sync_queue(hdev, hci_iso_term_big_sync,
+				   UINT_PTR(ev->handle), NULL);
+	} else if (!ev->status && !i) {
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation
@@ -7104,6 +7125,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		 */
 		hci_cmd_sync_queue(hdev, hci_iso_term_big_sync,
 				   UINT_PTR(ev->handle), NULL);
+	}
 
 	hci_dev_unlock(hdev);
 }
-- 
2.51.0


