Return-Path: <stable+bounces-254440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG1lBB/5FWpxgQcAu9opvQ
	(envelope-from <stable+bounces-254440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:48:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 605DB5DC1E7
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6F143046D58
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5002D9787;
	Tue, 26 May 2026 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="gSLtwMiD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85118C02E
	for <stable@vger.kernel.org>; Tue, 26 May 2026 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824902; cv=none; b=qIoqbbC6iHuvd6KgSaiatcaHafpTPiGfwnFkvOeB5otMLefiTzUwF2/vveIE0R717Qm2Wc1Z/anGSeSX4bt4f5FFn0/UKZow1/VHrhmKzOc8Nb0ZNAZ6TyRgU1OyX4XwNnvcpvzE2uSG5XCVG1e5vKua+urvntcbN1rS9BtFPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824902; c=relaxed/simple;
	bh=GP/ClzRFrxzRKrwi6HTclnbsgEnaK6VITku0Ery4FvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQQQOzeNtG+vQv84GmOIbFZB5Suikhvm3y8sh8tyxRgAx6g52ytaiEMhK6dOowUsAczhQXh2k3skaUKguWwM2DgaM7Fds2VRGQTbhLPNlwP+4tHiTMAohFkUJTrHJtD9TZ4PYCrSX440alUAAj611bcQo7+4SfXpab/JdveMOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=gSLtwMiD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490426d72f7so43218465e9.3
        for <stable@vger.kernel.org>; Tue, 26 May 2026 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779824899; x=1780429699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/Gh3D868F7R6hzwm/lRWoQqdGX6ghyM671WkjN3eI4=;
        b=gSLtwMiDbjrxY8iFsAjSkK783JXJtCnUSaYthtVM26Udx/rymgrJMsmG7TXoaCPpzI
         KdEZmk/duo82xmqD2EHC2fq0pD/gqmXaAH4ot4y2YQ5SyekoPZDSdC9zXv0KFI0gaYT3
         RFlmgIxGlo4TldQA9h8nr1fjE70ln95A3DyChVu9RUQXggTQhNm5ugToWK6hNutpXbVq
         SzInbjuR+XJhaFF8QvO4ndX6/6xYQ8o8V4qWXUIZpOjviL4pth7y0EZv5FqhH2jwjgDn
         T6LUt0G4QG+4b7nv9F8h8qNGXXKizeHh8s1Zg0OHK6ne7TwrePgXwruCb/gksBMXK/Uu
         XF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779824899; x=1780429699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/Gh3D868F7R6hzwm/lRWoQqdGX6ghyM671WkjN3eI4=;
        b=fipILO/TA7sYUgTVHzHqgcew+GLOVuTPROReLtUaJAhmE35W+3OWYo6Owssd95BFf4
         0mU4tWa3kmSRsrQIp9iI90VMZC8LRjR5u9edQZoKVesFfbZaw0+eDy9NnU+FdzyNhPxO
         iMdvDBOkQiiFN0DAM3wDAHxGyd6k+Qc41DYbKWoTZQzTFaag+BKllCg29sQdWXWcJuGP
         64JP99aX/1RWf3Jw/orNiiWgsj6RlnOWPSie5OcmmpJLqFhNRdwplPa/BHAjHf3hp+W3
         uQ5pycZ2v1DmLlCTmzDgDAzpW2vbuJ9nVD24rYB0qI+i2SuiJ4rfULywr0mdypwZ3rXr
         JEBA==
X-Forwarded-Encrypted: i=1; AFNElJ+o6f6IiS0UIsbIvewMvCCD2fk8Z4/DFhWONowhMUdDmXMq3L+AcZvYzH/NORdrXGJY4g6GLe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fTdWfyvjMU9HrInQgHHuCltVDJiWDWpr9WB1/ZETmXCHrVCQ
	PL4TLim5m1MeOqklDMOrwNkSKdG5CNpL1s9yPkYhpYw7QeLovsMGsH6UiRZW0cHUlZlA
X-Gm-Gg: Acq92OFrQLRmiAWnw3dqwU3ABpZV2XVIaspQ+4N0huLaxqeKE3EQrGrJpAFyugzKE4G
	ztDfbmj/zsh6AdZJCFlx3Ds1U0CrqiCQU66/rspfpmac1zqKvUK23ncv6H7ZBdwqhvIs+FSqAty
	s7dIY97+7wOUT1NuGmrvP+79IFN5nFNkz50XlZ08gkSG6W1yWD04CqC0AGyYokYYT0ThRjZLqZm
	WWIle4tH5vL7KbRMMx3y6DZlPqhDCPN4/S5xueGI5Gz8IV8YJJx9roKdqYfOTBm2DmCG/5v/0mf
	oyGEsA17/iahyty2zLmGtC9ckORdawhI2zoSRRBmrFvWJpsksSAGMbGUroeyQfKW7B3au8S01qm
	ZoF1BzlWclAXVj+JaZ2K+6RFKfXlDPGJmo/8I8LJbf9N6wRuHp9qBjJefK7YmNmBKR87kY82uMD
	Z5y9RiQ4Z54FbHN6dmfZiLg4rhvy9UGm2mGAyGqeK2xs/L+jQJO9JIUZxiRpXw4R2womMyorNQd
	uROpAdd6u5xyQEGjxfkVjNBdVFTRtuBVhnFDhKFLYl9VOyPmSNlEG8=
X-Received: by 2002:a05:600d:6450:20b0:48f:e245:394e with SMTP id 5b1f17b1804b1-490426dd0f7mr233796095e9.27.1779824898555;
        Tue, 26 May 2026 12:48:18 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4907e683746sm2790745e9.2.2026.05.26.12.48.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 12:48:17 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH v2] Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync
Date: Tue, 26 May 2026 21:48:16 +0200
Message-ID: <20260526194816.65669-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	TAGGED_FROM(0.00)[bounces-254440-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_SPAM(0.00)[0.334];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 605DB5DC1E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

This is the same class of bug as the one fixed by commit
035c25007c9e ("Bluetooth: hci_sync: Fix UAF in
le_read_features_complete") which addressed the identical pattern in a
different function.

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: c09b80be6ffc ("Bluetooth: hci_conn: Fix not waiting for HCI_EVT_LE_CIS_ESTABLISHED")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Closes: https://lore.kernel.org/linux-bluetooth/20260525162438.96881-1-doruk@0sec.ai/
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
  - fix commit reference title ("Fix UAF in" not "Fix UAF on")
  - fix Fixes: tag title to match actual commit
  - add Closes: tag per checkpatch

Link: https://lore.kernel.org/linux-bluetooth/20260525162438.96881-1-doruk@0sec.ai/

 net/bluetooth/hci_sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index XXXXXXX..XXXXXXX 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6700,6 +6700,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	DEFINE_FLEX(struct hci_cp_le_create_cis, cmd, cis, num_cis, 0x1f);
 	size_t aux_num_cis = 0;
 	struct hci_conn *conn;
+	u16 timeout = 0;
 	u8 cig = BT_ISO_QOS_CIG_UNSET;

 	/* The spec allows only one pending LE Create CIS command at a time. If
@@ -6773,6 +6774,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		set_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 		cis->acl_handle = cpu_to_le16(conn->parent->handle);
 		cis->cis_handle = cpu_to_le16(conn->handle);
+		timeout = conn->conn_timeout;
 		aux_num_cis++;

 		if (aux_num_cis >= cmd->num_cis)
@@ -6791,7 +6793,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CIS,
 					struct_size(cmd, cis, cmd->num_cis),
 					cmd, HCI_EVT_LE_CIS_ESTABLISHED,
-					conn->conn_timeout, NULL);
+					timeout, NULL);
 }

 int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle)
--
2.45.0

