Return-Path: <stable+bounces-216020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ApjCuezjmnBDwEAu9opvQ
	(envelope-from <stable+bounces-216020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 06:17:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA8132F98
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 06:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A62C130D24CF
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 05:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33EC28FC;
	Fri, 13 Feb 2026 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYcNfkRW"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61717BA2
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 05:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770959781; cv=none; b=uszHZoyqhqZemqvvIXnU8KkcYb1UVNUhvHKkM6VZJ3Jx9mM47fNySkaLYFbOXak9VnAC7hQ1IVdLNmj05W2cympib6eJfgDhgfsCDbfGx1+UNzMo890BOJkNhSOmmxUwHaSyNI5TeEOfXiB9LjE9SPSDxs5h5J6EYT6YulXQUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770959781; c=relaxed/simple;
	bh=vQxdkryUEJ+pArY5kJMAR+7YlXlMsv2XI7L1MiRhw0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmIRG8eJqD757WYeNbfbix7xcXRm+1/d6wUN5Hkhn8YjqwIRC8X49EN2deF91SCcjb0PiMXFccmFgfGm/ClyjOM5iyUYAP1TpEEEIJFNC1br7vg4tZ1pXGwZI5VsD6f3FbB+7BFRPZvRLc73JQzeznWtkV6V6lSuRII88W23ofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYcNfkRW; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1273349c56bso796592c88.0
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 21:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770959778; x=1771564578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=fYcNfkRW+alZCoaq5tzCZXzoMQlTe9PSusCqc8oOUM2ZcKUNHMX6gSXi35ZcxzwNnt
         f8P3Em33k+aDrml+Bee5SIBk/ruSVR8au0sWTx8JbMLitU4uKE5R/iEKTdEG98aQ++4d
         hD10UT5ZN7j0borF4JvcOWkcSxdJjqB7s04GQCfMKT5lViycsCNteB4muocLb+sh/g8M
         aMtlsUa/8UblUb5FU/MJh4YwsIZkt6m9SnfG6oIhD/v8+HeDny0gXZyBxBX5fpAUi7uK
         3f/XSL7XOLmjRSj79fJJmSeSOY5E24PJW+pDUxJa/jfqfg/qq8FpFoyOS5rW6PHxPB34
         LaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770959778; x=1771564578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=Kos/nrw/mJBcWKFWS8uzM2Cf6B/nH0EipGoi+srJkLniBau5EsUswj381uBMbrLx4b
         XqSzR+CKkaYv75lQVQEx61HRgMGicowsz06TRfUGbqXKEG3JLHrU6ANwwgjzIeEwo52E
         tYbPEM+OE61GvioaJiMzF6P3v+pC1g0WcV3J1c0xx9IDPQYhZH3fh4NqQys3kkWtJO4Y
         jXV+CnbMk8Q88TfDRZTTWm0Ns+LtASqQHl0D0ivmFs06CgSOjgtiLnnJ0fsryQB6qaff
         J0eUopgujrHclcvmbnulH2sR1IhM5aACgdPEf8sUVYo3SourEHHdKKVqu/K4aJF9W8ZG
         Ed0A==
X-Forwarded-Encrypted: i=1; AJvYcCUq7TzN+XWOLeOmfpPugsDEY4wzCc/K5Xyb7lO0OHxZuNIFiBo9PaCPspG8+3pWHYiU03zHXlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjai/F4+ygLE3kHQS2cUjbHX/xgXQk377qQNGa0eoPQQsaQFAA
	+iJrMweAFpKC0fpoCGCTdOAglG18Ga3Q/3CHTQUzns4TJ4Njzw6cGJE+
X-Gm-Gg: AZuq6aLGxEhi9BOJb0KG9d1k0kz0B+HuuKn0Psw7b3GASVzRGTO1xpyeDsYB9vE6BQw
	s4Nhp314Jqm/0HLX0qPtVKI0tM8nNZnfT433gmNPTiRPNkOLBOD18s5tues+roWz8GoZXfRw0rL
	IHJP6zVjfXtq6cupDFMYZwdq0MEKWr4g5Vk/m6ZcQeyBpap3owdVKPNaCshjMTHKYuYLc0N8uFg
	hBlkgi/oqD6Rdi3maBiqCVJqRFCh8tej7xJsckejNyW/jGgHoMZliIR8ikIuTlxXG9mW339OmN/
	fif69FZ1gMmWEpQhErivpXV5Wp9NYlQCTIAS53hKMSwlMU76HHjpMaxjOYiadUI+sJXujpRjl0z
	KCYC0+xVM1ZoncQvNON0TL2nzpK4KjcR7cL6Vi208+nG48qn5tvIFnydL3LcWzsqS7/GhopIyVy
	9Sw2u2u1oSPfFys7MUnpCK9rQLWn/350FRXVmTs5G6P2eA8U7fJ50jMP7krTeFiWcIA7BDRpjhv
	HhP7tSy+h5XtQO45Ylte5zAHg==
X-Received: by 2002:a05:7301:5784:b0:2ba:964f:fa67 with SMTP id 5a478bee46e88-2babc47f313mr251923eec.24.1770959778187;
        Thu, 12 Feb 2026 21:16:18 -0800 (PST)
Received: from kernel.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dba2ef2sm4958483eec.3.2026.02.12.21.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 21:16:17 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 1/1] Bluetooth: mgmt: Fix heap overflow and race condition in mesh handling
Date: Fri, 13 Feb 2026 05:15:25 +0000
Message-ID: <20260213051525.10945-2-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213051525.10945-1-maiquelpaiva@gmail.com>
References: <20260213051525.10945-1-maiquelpaiva@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,holtmann.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216020-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maiquelpaiva@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFDA8132F98
X-Rspamd-Action: no action

This patch addresses two issues in mesh handling:

1. Heap buffer overflow in mgmt_mesh_add:
   The 'len' parameter wasn't being validated against the 'param' size,
   potentially leading to an overflow. Added a check to validate user
   input.

2. Race conditions in mgmt_mesh_add and mgmt_mesh_find:
   These functions modify or traverse the mesh_pending list without
   locking. Used guard(mutex) with the existing mgmt_pending_lock to
   protect the critical sections, as suggested by maintainers.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
---
 net/bluetooth/mgmt_util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index aa7b5585cb26..eee4bc05f6e5 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -397,8 +397,7 @@ struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle)
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
-	if (list_empty(&hdev->mesh_pending))
-		return NULL;
+	guard(mutex)(&hdev->mgmt_pending_lock);
 
 	list_for_each_entry(mesh_tx, &hdev->mesh_pending, list) {
 		if (mesh_tx->handle == handle)
@@ -413,10 +412,15 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
+	if (len > sizeof(mesh_tx->param))
+		return NULL;
+
 	mesh_tx = kzalloc(sizeof(*mesh_tx), GFP_KERNEL);
 	if (!mesh_tx)
 		return NULL;
 
+	guard(mutex)(&hdev->mgmt_pending_lock);
+
 	hdev->mesh_send_ref++;
 	if (!hdev->mesh_send_ref)
 		hdev->mesh_send_ref++;
-- 
2.43.0


