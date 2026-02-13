Return-Path: <stable+bounces-216023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEEGHFG/jmmzEQEAu9opvQ
	(envelope-from <stable+bounces-216023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 07:06:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CFA1332A1
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 07:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A8B030E8E71
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 06:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01402264A8;
	Fri, 13 Feb 2026 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1KvAnRX"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9092673AA
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770962680; cv=none; b=AI0YjDseJfeaBFDcyRGIxew6O6Bty087BEN+LLLS8+Ur0KmgnwAxo3kVAOKPku9dS4WEztsHhkQpHiri2KrIjlUgEl5NoJLIT0u1M4dcDa3sZYdG+NAR75yc2YZbb7E7lMISC8V+6w5lqyvDNQOFO1uChJ1GgWPO8cX/l4JCDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770962680; c=relaxed/simple;
	bh=vQxdkryUEJ+pArY5kJMAR+7YlXlMsv2XI7L1MiRhw0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYor1AQhE3O8n1GMFibcyorzCdFMd0x8KehA54LB9C7nbwslNC1Zc+mBQN+BA4pH0//ao+gEIDPF6Zs7LAg82vazvud7nDKvFGD9G5kmrkCpD9FtxRb+c8abGzljqp19K7OQ+Yoo0DaxWEN2G/3kkXrxi/+uOBxQxTJfG5JMOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1KvAnRX; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ba94dbf739so681688eec.1
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 22:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770962678; x=1771567478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=N1KvAnRXtNCeDd6avdmZNqC6fd5VXrKBg+Z1E/2UihIPKBPazS0hkNHC7jF1xFBl4z
         3lyvVeIDulK7XGEI10QZmBdCcsPE6b2l/wxyzSEssl38izDnu58XX4TqqgHhetJlSo0v
         HNhKwul3TitlpV8AVRBj1geaQPc5LWvMehRL/tEfGWr5zVfI3WDFGotfElX7yz1igp1+
         VxNT5m17Q3GKXGJznU1M1cGA1wBFzVNYRSn5+AQKsluh0C866pzbPUzMsYlK8U5KAXW/
         zYX50mAe/614YvUeKlpU0qRqAEQA7DBjfXwfO7NXu514HV2zKQEocdtYJPgsOgDYD6Ef
         Rgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770962679; x=1771567479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=xRR4pWk9KSevPd/GAeg85fKe2jJn/EYIOFhOoWHPEK/xVFS5dlxBh+19oW7NSv/eP3
         1pq2gz08fcVv0oStpB4a+bLKCHXJtj58XUKcp3JBOoJKlM30nr+sbny1p+LU4gTpVcfS
         3crprmKh9y4aOe9WNr45cW+J4aKUzHrx3BvtES5dvNmIoLAxX1h2SYxOpwuByRfKBGit
         yWe9i+o9Fxrgr2htLWpGu3KjnhKiRAo++MgNeZ0Ef4IHxGMwfKbxIjkeiUHI3NluSXEw
         sIWSYCQ+RmEWSGTH9d0OCEJBFT1H2To3e99er+xB6APVabqsO3XTpnMHvLn+lKbYFvix
         h3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCULoRwCliSRHCUUBwvFB0lB2noOLo2WgZ8G3/xb4yy/ZmzvrZu0XIy4OUJaw6b4ZvgF0Yq718w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtzeTM9CANndcloRaLonQxqtwSOHapB2UdCJY1eN5rA+3+DZVZ
	nuIUm39AoPbQoDb8Jq7NQhKW9bp7NrRdlP5B4DWKbVIKwGMrzy7Rfzmp
X-Gm-Gg: AZuq6aLhSFWLBFd6qrCJ/zgIEcVIbKQKHED9bg08IrnXUmSsBSAlTTk+ZwaeR8MkcUt
	ciqjUnaRvDhDtlfHf9N2YpKFO3FrAEprWN/dUdJthxJ84M/W16JMn7l/C+UiwdZKNRUeXWsZ2A4
	z4GN7V6q7QWbQUM86H8tz6PVKYcVqeKpJ90qm1p2M6LZP1iH/ctza2MN31jbXOfttFgU2+WeSyt
	GYLNzbWM1ZvVORvaF01yJNlr4E6VL3N+WNOH02aRYfzrP1Ko7+2iWpTrfSj/m+Z7GrYhdSwz9iI
	89UKPKUCL0blvirqvxx51CPtpxi9Zxs0D6f8aczV0WKp1fnXDe8rNqz5Sh2IRr3xcsepxkznQCK
	A0ch8n30PKfBh9KL/IrDsZuTOsZ/pKLeEQ/nAr7/zdvcDr0lfKdW0402GiSf92dM2ergSoitm12
	uTDe3/CiQHQuDooYdb7NBCKv/ZH/6cHf3U6J8RJMssXoUHmPoHD1Rwuvdhmshb2/7OfZqsGVfQU
	q/YVFtHHjPnwEg5bhzfn4tCzg==
X-Received: by 2002:a05:7300:6ca1:b0:2b7:a27f:3a6a with SMTP id 5a478bee46e88-2babc3aa2f4mr230438eec.4.1770962678519;
        Thu, 12 Feb 2026 22:04:38 -0800 (PST)
Received: from kernel.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcead76sm4803025eec.27.2026.02.12.22.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 22:04:38 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bluetooth v7 1/1] Bluetooth: mgmt: Fix heap overflow and race condition in mesh handling
Date: Fri, 13 Feb 2026 06:04:01 +0000
Message-ID: <20260213060401.14200-2-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213060401.14200-1-maiquelpaiva@gmail.com>
References: <20260213060401.14200-1-maiquelpaiva@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,holtmann.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216023-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8CFA1332A1
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


