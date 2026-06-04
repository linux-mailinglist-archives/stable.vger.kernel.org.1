Return-Path: <stable+bounces-260363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vNd2DapMIWo7CwEAu9opvQ
	(envelope-from <stable+bounces-260363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:00:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 824D663EC0D
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:00:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=JI15J6X2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260363-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260363-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61CD5301DB8A
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36D636BCDD;
	Thu,  4 Jun 2026 09:52:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071B380FEC
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 09:52:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566754; cv=none; b=RsLEG80sKpzeESwqMJKHJAabQd93Lu3c869ctIoySwYnLmMiwd+2Xx4bCejZOwYFBojhgWr9DmdOQJvhJ4+SCI04ZoU++W1+UEQtTUdHZxl9F8fHz4IGSaWZn9G3R70jRWE7JmnRTBStqQSl4GlgHkTWveAcay922xP2FE57jnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566754; c=relaxed/simple;
	bh=Qri2tQQoikuTBDh/3QB/5DNH1tS3MxYe/EMDCMuTcGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLDiZpHo3PxqGgW07F1K68DYk2jQRxgqYrt2UY/UzEQWqNO7K1GHVZ5tDQ+uXv4yTXL12/s7Y9AQTW4+8CKZVfWwry7L265PDa/I1gTzui5ZudSEtDWb6eIlUAvKalhADRKhlpiQ2cdtovSkyC/4bJl8bNKYuR5WVH1kVcc3aYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=JI15J6X2; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso6197175e9.1
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1780566752; x=1781171552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwxSLyn6dJRTg6X7nSil4L1bPyMT0DjhI+T1x/a8iIc=;
        b=JI15J6X2fT+PkK5uk7YjwDWamakEP8Wio84KiYlPdDlZqYOQCEp24qzVnPlkueuP+3
         d5HhVtkfS3KH36LanB+HEVXJMQrofbkd09SOjiZSChcL0Ikyv1dpk1ug/mQ0dPZWg+13
         z0QhjpYFaNI/6Jqu/B4EZDlK66MmgR366nWZ3iHx41cX/eA8kAYHofErckrcPCRxVgBr
         yumnGGT5CdZv4Uz3qqDA8nJIkk33MBX7Qsrzat/xaHbB3B8DntwWY4YC3I+sZpqvmms8
         akVO/Z6cliInFdDG9g1lGyTNXb1IEv1d2H6I2K1NUPYf+h1fw0KOhK80ccfP+PWhzRGM
         oprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780566752; x=1781171552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VwxSLyn6dJRTg6X7nSil4L1bPyMT0DjhI+T1x/a8iIc=;
        b=hOLf3gThciRxDH7xXpzoHMCaYwdUklZVHeHGjsfPVObdc44zYkbR2ApT8mlZpClnpt
         ElSvI5vbSxcoE1f5VrojquJSV4+/3cjT1q+JDfNAR8vAO3Nu9fLs/hY3dq8t3BrgUQCP
         S8nSQiX68whmiu/cJm9HaQynatucZNmtTi+KqpycIFmenLSJcnlfjfZuGX8FRfMn9ETd
         YDyrlqbHPxZfj5Hrj7el1EpVvYcNM+c9+uXxiRHEaCc0RCr3Wjxf7Iimc4nlzJUHXSHW
         WLL6B+cVixjOa5E2H35NUtngXR3+Vb8trEW2eUYNMAlQtI+0RZ71zTXE8Oy3iu8dJtKS
         9NUA==
X-Gm-Message-State: AOJu0Yw5PMR6Ftptkh13FXaOyqZ/AaQVf1qu6LZzuuxAhQU25/5693dW
	9JUZzDeyAiN2qkklbUui6C8kuS6JGcpKSHx+QFbcYk6lbO/66llbMHDNOUoj58Ucv+Mxx0perKF
	JNDYy3zsb8aI=
X-Gm-Gg: Acq92OHsGHzPZvbEgWNgae8tKj3hfYt6NTO+WgzC1Pds5Kpp5fAevgyH6zVAM2UCbOW
	mC5Ko1ylkGYKd+EAop8YhJ+B5mJMVpGU32jcsR9TiL5wFk2IVVgEsgh6Tqx5moSzUDaIcufdEMy
	3lqFwrvVmZeF/IPVgq587CozwNLQw6UJrIOHD9QnYTRg0GV/M5Prs4c+LrGaJtJlhAnYiGWTNcS
	5xoDIwea5ZoPOyv1tspyykPjZ3pcwMtcZ/mKbK7fH+FqsNmlUy7HlX1IbQEBoM9RQsTEkThixxv
	J+jXOF8WtDZ/f9y8HcxT41BGRofoIbOvjUYs0B2GRFdX9ZqkucISPWb7F+aG181lr27ao4EJykb
	3OsuuJZGI05+F0HS4jnpD8JAR3DLQtK5A0o0tulORYccvVS6lSWDnt//o+u/4TAzxmbIxXPUlwJ
	koL3WERjuL2ukhLiPhf9l1avA+W3y0YyZ+MmOcfM2uUUVzCU+H0IFrerAJPckl89EeQi8fDsg4e
	29Br1D50mq6FIdVCZBO8MrLHtoy31XPGhWOYHvhj7FQMeBaFw==
X-Received: by 2002:a05:600c:198a:b0:490:bb45:79ee with SMTP id 5b1f17b1804b1-490bb457a7bmr68183905e9.0.1780566751314;
        Thu, 04 Jun 2026 02:52:31 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm65784445e9.3.2026.06.04.02.52.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Jun 2026 02:52:30 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: stable@vger.kernel.org
Cc: luiz.von.dentz@intel.com
Subject: [PATCH 6.6.y] Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync
Date: Thu,  4 Jun 2026 11:52:29 +0200
Message-ID: <20260604095229.69087-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060418-factsheet-oversold-deba@gregkh>
References: <2026060418-factsheet-oversold-deba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260363-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:luiz.von.dentz@intel.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[0sec.ai:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 824D663EC0D

hci_le_create_cis_sync() dereferences conn->conn_timeout after releasing
both rcu_read_lock() and hci_dev_lock(hdev).  The conn pointer was
obtained from an RCU-protected iteration over hdev->conn_hash.list and
is not valid once these locks are dropped.  A concurrent disconnect can
free the hci_conn between the unlock and the dereference, causing a
use-after-free read.

The cancellation mechanism in hci_conn_del() cannot prevent this because
hci_le_create_cis_pending() queues hci_create_cis_sync with data=NULL:

    hci_cmd_sync_queue(hdev, hci_create_cis_sync, NULL, NULL);

While hci_conn_del() dequeues with data=conn:

    hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);

Since NULL != conn, the lookup in _hci_cmd_sync_lookup_entry() never
matches, and the pending work item is not cancelled.

Fix this by saving conn->conn_timeout into a local variable while the
locks are still held, so the stale conn pointer is never dereferenced
after unlock.

This is the same class of bug as the one fixed by commit 035c25007c9e
("Bluetooth: hci_sync: Fix UAF on le_read_features_complete") which
addressed the identical pattern in a different function.

This vulnerability was identified using 0sec.ai, an open-source
automated security auditing platform (https://github.com/0sec-labs).

Fixes: c09b80be6ffc ("Bluetooth: hci_conn: Fix not waiting for HCI_EVT_LE_CIS_ESTABLISHED")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
(cherry picked from commit bfea6091e0fffb270c20e74384b660910277eb6c)
[doruk: adjust context for 6.6 — open-coded cmd struct instead of
 DEFINE_FLEX, num_cis tracked via cmd.cp.num_cis]
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/bluetooth/hci_sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a41cfc76e..7cba461b2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6631,6 +6631,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		struct hci_cis cis[0x1f];
 	} cmd;
 	struct hci_conn *conn;
+	u16 timeout = 0;
 	u8 cig = BT_ISO_QOS_CIG_UNSET;
 
 	/* The spec allows only one pending LE Create CIS command at a time. If
@@ -6703,6 +6704,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		set_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 		cis->acl_handle = cpu_to_le16(conn->parent->handle);
 		cis->cis_handle = cpu_to_le16(conn->handle);
+		timeout = conn->conn_timeout;
 		cmd.cp.num_cis++;
 
 		if (cmd.cp.num_cis >= ARRAY_SIZE(cmd.cis))
@@ -6722,7 +6724,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 					sizeof(cmd.cp) + sizeof(cmd.cis[0]) *
 					cmd.cp.num_cis, &cmd,
 					HCI_EVT_LE_CIS_ESTABLISHED,
-					conn->conn_timeout, NULL);
+					timeout, NULL);
 }
 
 int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle)
-- 
2.53.0


