Return-Path: <stable+bounces-235642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCmPNtYj2WlrmggAu9opvQ
	(envelope-from <stable+bounces-235642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:22:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E2C3DA584
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FF56300901A
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B83DB635;
	Fri, 10 Apr 2026 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVrdJUHj"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE863D47DB
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837988; cv=none; b=UrKWMvPEZMG1/vwRV9bggcu2FmhTj8CCGwG7rTSn0VtBEr72Z8PNpf58J8HnIxU3Br0vXdiAeA6stRtDPtgY27Hiex9LHnT5gmXwje78+HVCR1kkSgerRIFt9VpmXYtJwtl/nZJqBPjW0fVTcpcE8J8UMHjl5z65nBKpHy3O7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837988; c=relaxed/simple;
	bh=2sqkraGKOjrNPsVZIuk32nKx2edaLTfYst6vQGlwrmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V81rM8UCG74rkwee3rFS4hLb72SZ/KgDL1BCQ7q3eBc+Ymbf2jSQoinYcHxnunhqKxgE+tb3bH4puu/jDtRi/WYDgOIEQm5xCE+rYBYsycoFmjdzvZlcjLS3Iiyfw1u6/1c/r3TsyW54znIPLFqZOqOgp45TD9cS7NiGMkH58zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVrdJUHj; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d52c7f92b1so1598135eec.0
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 09:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775837987; x=1776442787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gOqRIDekvHj7WoWPfMJtNauE9B+cpTSvzavFMCjRXk=;
        b=qVrdJUHjQ56jzFk0WWSrBYiTb2wXflV6s1msRcrEt1ViP2zWrpX3FmGCXvUu/PMNEK
         RFtUVQwmRD+bbRaEKsinjnGooz8QDryAkGF80dfehY20LKwD+aI4Ve3WhhDy+NKMqRfC
         2ct6nBn0nkUSnlU+k9cT9/v7KNxMDnexqjy0daHEsvqOYl5hDIqJx19fGlPQt8ofvtT4
         T8duYP5kENVHC7Y1kZdgOmSEjUpuZFM+8nYNUTDYF/+OVPADxh6Ium/GYOZcGeaznhSF
         3v0l2h2qwGPIWWnWo3ICdnYcnjsOkqNq/q+pqsR07Rz+8qVCU8Q1fY6yf+XVJKgv/5LR
         PxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837987; x=1776442787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gOqRIDekvHj7WoWPfMJtNauE9B+cpTSvzavFMCjRXk=;
        b=PJkHuqqmdq0LkBh60FFQzKniGSzmkHzD23DED5diig07k5iPQgoj6kcTaWsg3g5tvX
         /2vI/wKpb8vS211u1SF8fSJhp75L2msUZBZoCaakRGFeDDqmLv6Hqhv4ze3ourmWILM5
         bSbZBszZGsCs5DDG/86gKEYVAVilVSCTJnIOvmKgPjM3XJTL1hok4+Z9V8p7rkPDsZAe
         GxGxDeVBpBn7pcWovxw38VNJtDKxrMLGnITI2cEofKfdgAbFV1W0v185dsCrZIz4gszt
         oPqk1gC8JaDv6uVg+JBiZszyIQ1Hq738jeLwi19UHL5d1dB16LMAouN+YiBjP328mRH2
         KAPA==
X-Forwarded-Encrypted: i=1; AJvYcCVHYyQZbnKZvaW1qpCoYhgj3uSbWRVETa1SLHGxKJYlqzcOb0R/ANs1V5oOS/DSIyV7KkY30sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylkhGsX+W3HEkE6K+yx3nzby1TQr63xsqZPF03MTGGETRsDxTS
	gwgTCywdxClyC9HOsAqlx5SLxUv+9e7Qp9Bb/LXJ8E1e+V/X2/2pLccT
X-Gm-Gg: AeBDievguh6hfFQhteHM6BLbK+cUbChQaE2PMdHXvre5FQIGG1WumPlG9gAjMsRBqM3
	w2P0aU+qn7L985B7ZUhAd0jVcySpV21BSLl9CODPQ2PDj2NTDyoQK1kIOQm1Xmi+I72UtvSXKiY
	gD2KMkgg51wmeiFWSnPsk+EqwYIxf2gIKWm3x5S3E/mNaz02QkyoY7etZtTJWJOfuywFzkS9vkw
	835JMf0Irqzjy1V9qTgvXDFezD5Z3soAZppgqW41cnIO8Jj83TY1fQVeWYh4PVEYI771iykO4o0
	ZS25ScofPqJTPCzvT7M7wLQHm2+mgo4cPV3/tNQQ+RzMHVRkNczVbdNufgS5Ud5EcAUP83LTL1x
	lEB5bgGxbyxc4bjig/Y9N+Zj0mBOQn1ILIT3ivLP6pEpYg+pTQAC+L5Zw9hnZikzDQsWlexZskP
	3COSwJbhiVm3MKI3XhuYRlhMdI9Lq4oj9ZXxH9BRK0KXEx9a4U+z6+594PHGDSQWpe8g==
X-Received: by 2002:a05:7301:19af:b0:2c0:bfe3:b95c with SMTP id 5a478bee46e88-2d5870ad63emr2521678eec.4.1775837986601;
        Fri, 10 Apr 2026 09:19:46 -0700 (PDT)
Received: from localhost.localdomain (104.194.93.216.16clouds.com. [104.194.93.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faab010sm4958395eec.12.2026.04.10.09.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:19:46 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ZhiTao Ou <hkbinbinbin@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_event: fix OOB read and infinite loop in hci_le_create_big_complete_evt
Date: Fri, 10 Apr 2026 16:19:36 +0000
Message-ID: <20260410161936.2589459-1-hkbinbinbin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235642-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54E2C3DA584
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: ZhiTao Ou <hkbinbinbin@gmail.com>

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
Signed-off-by: ZhiTao Ou <hkbinbinbin@gmail.com>
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


