Return-Path: <stable+bounces-231429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JLzLxPYy2mILwYAu9opvQ
	(envelope-from <stable+bounces-231429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:20:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2829436AD39
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54A10313CC32
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292333EC2C7;
	Tue, 31 Mar 2026 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdWqdmNp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42C3FADF1
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966448; cv=none; b=YZga1+FDGeEchnqU05M9bftuZeloAGWQuI8zpMZ9HrwQYZmwzoaZD+B3FiVd/d4CLA0kUT5HkSUAPHJZw6FslLF8WA708zt6urssNrszEzCsYckLNnWln+oEnteWsq4oOXxw9ca0uiarfpfVEXLYneweDGmafQd4U1dnVuzY+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966448; c=relaxed/simple;
	bh=szt0w8DbKoVg8ulmw8/DZSgLzId9BVRNgZALH0Fp2+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQxyMMgB7CDyMYHxj2cujYJy+IYCPAeeUcLbFRPqI8Ir/Xd+M8LvdocW0DKcRiQektZBCMNrQdGBHlwfV8K1kw/V37Xk8qV6kRzkv2Pn/+dBe7mijLBTD6UZEzRW77VnPmSfGenJtrEepFVi2cYvAivcwZPdsIiaDif1SKlbtv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdWqdmNp; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12713e56abdso2321059c88.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774966447; x=1775571247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEznFt8iy4PfjJKzwmf2yqiGR9CX0VFuj03I+QP2lL4=;
        b=rdWqdmNp7hATISPen2+LCGDpYEYZI8wsDj3r0IqBdJqDLSeSSXboc+rbZ0dc6ZkjuD
         zAnasqWSLGb/Astl0TWfET0wrRaeeu0gDKTabdUgz+vS7pEEwD4lg4XSdORzrMN7HkD4
         gjLcnXUbAi9Nq4eB7zxL4Acst1eHFoMdJ0L6ypHgm5E+DOS+d2NkRRGwt+blTm0w+uvQ
         IBxAEm7YqthSQ5P0va8CsZvBZBM9T4iOK70hFj1uP2Y78byP7RQX7R1y+lUr+9noIFyc
         svPSc1Yq4Goc+XJt7aJbZ3cqmctAGom9RB+pWsXpyj+5blzFhQ+0JOObd76dYIC0BMDP
         CHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774966447; x=1775571247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEznFt8iy4PfjJKzwmf2yqiGR9CX0VFuj03I+QP2lL4=;
        b=qQHvGj8FpCKWOXP9/pamAxrx65eTclC4wK8HwVKyGdhLB/LkaZSYXKYrNSJ5PiTUN7
         hkN2s7oyR3ynLFQ8D8xjgqMKWe4wXqkiSM53V1zE0ZNdahPVvQbQErnilpoUizIAHwaz
         nZkmevHwI6+CueutCfhjsHap98GjLaWnfJsIl+T6qV4nR1aBo383WH5d+W6AW1NNctBk
         lzg2nZaGwahU3Iftwjp5ON2t0FYY6Sq4KFAF3lR7Mb+btBj6Xqbujn6cGlD4+2sazjcO
         8C0EnoFuINiHAKYTryczZQAl/rtqvRfIRgcMBKdEdjhG1h9Os3nc+D5Uk/h1U26F1Ll+
         wW2g==
X-Forwarded-Encrypted: i=1; AJvYcCXhccyb7Gl+7omcgedRxifVf9ZBMl5QPfyf5VD6EIRvweMF0qzlDo1qg9YIWz2EwPAtYYi8RP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IYPB/n7UT8K8xSze4oraHUo9Z8LrQZ6v21bSLbuLSAe5GScI
	ZILpQ0TlACfX2EQt2CSrZQN7O1DVRWCfTcCSMDjWPFySdhqvDTHlAFzv
X-Gm-Gg: ATEYQzxpVdh1UQA5ucCjTcHiDN5z3YuD2J+9OZoga6GY5dmJ/Y9YSyhtTB0gbWEf5XB
	UxVI6yCkMGrjQwngy/t4tg8NgSpqriD6Zat8M2PG56VAcDzEE1zfG8eQ6QrJjaxqADUrsucC0LR
	o8stQ77qWylGns1rEvFZ+7WD3DVQ8AvR/EKCIYZT+Za5dUYNtolXAFt1rm6+Z6Rx6lPCySZlGlv
	6Mtir/3wf5AVMe5Z4HWjZtvj+8jsd9hyXyV/2jbjSmZ8juMEQf7KFTeHLfOzCmm3fw3VdjIwSgi
	er7kxHCAkOGUEa0/r4I/ZzaneNxdzxPl/Vd9PbtS17lQ5yo1jRN9GMzKgRLo9Zu+7vE5q3V/mn2
	WPrpd0nSr02nw/ctMr2a6qeS3I30c1dudvzgXvvqLWlSHWUBG8lLRwKxedzekIYltyQRwURb9jI
	G5BO9ReNXMvsnS+FMO/p8eAobIWNq0xUwUBEUnS5Llg7Xx9YEeMBee71Oo/7UHm0kj4A==
X-Received: by 2002:a05:7022:e29:b0:128:cdb7:76e1 with SMTP id a92af1059eb24-12bddea1884mr1707333c88.13.1774966446399;
        Tue, 31 Mar 2026 07:14:06 -0700 (PDT)
Received: from localhost.localdomain (104.194.93.216.16clouds.com. [104.194.93.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm15471461c88.7.2026.03.31.07.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:14:06 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	hkbinbin <hkbinbinbin@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_event: fix OOB read in hci_le_create_big_complete_evt
Date: Tue, 31 Mar 2026 14:13:58 +0000
Message-ID: <20260331141358.3244105-1-hkbinbinbin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231429-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2829436AD39
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


