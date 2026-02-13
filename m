Return-Path: <stable+bounces-216017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNJsCrSVjmm8DAEAu9opvQ
	(envelope-from <stable+bounces-216017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 04:08:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C0F1328EB
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 04:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C39C23013FE3
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 03:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50054238D27;
	Fri, 13 Feb 2026 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtSCZ9DA"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A05225788
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770952110; cv=none; b=U/RWoy1YEvB0HS3ZnH1zTn4GsRJAVXG+t2nyhbOwdDx2M95vcxjkJ74JbWmG41N1g/ym0t7hstjA7Rr/jNvfZE8d/0yms9muv3eSAM5FV23uJCr/4PacfTGGMJSa87oFt7X2eyJ4cO3uKEmYOBjR8Hcqp+5bf5LcLH1xAlVa5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770952110; c=relaxed/simple;
	bh=vQxdkryUEJ+pArY5kJMAR+7YlXlMsv2XI7L1MiRhw0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNMpr/rSvI7FwyxVoesfzWXU/IzfHST53Tn4bk20b0k/ifD/P4N2fS/8ls0PSDToKuMIgoUKv3sCMyrmflE+LfMPNxWo9vO84ll9/Inmj+5Oy5WEaL3a47OKM7RS9xA4meWvHyIdHnZeD4eAY3D3sSEkKkVazk+R/L6cA9epXnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtSCZ9DA; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b7da62b487so909079eec.1
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 19:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770952108; x=1771556908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=YtSCZ9DA045THMGepf7V28Fp+wDm/QerM22NuPI7igCAcuj5khUC+EfN7x05pXM3yE
         H1R/SqzNa4bM1Kh2IW1bitfhCZVOoRtuY9u+3YuTFUIxryGYTFzWKCGV0oHiq1rAv5Ic
         z9JtjAdVIUouEEqhDSwBgVBZffj6fdMzp4coHrdIcD2ifi9Zhv1cc1yHsD8tPhGgl+kB
         GN9ZX9iuJfVGBWR3tCJ6aVjdyZKHK1qa4uXwctWb638qWBHdVYKEGNmkt1wPFR3IPQJo
         vJNzWjgfpXVqDnoVpj/LTarNMHwsKhEfzpBTID2sr9hgP+bzwdeLIXxYrMZSanX/6oU9
         IYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770952108; x=1771556908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=BmqV9NnzdgPxfiRzu3+eUbx1UHOJaYqH5IFdNVAHrTYo/6KVZhKCCSQb2d/gI7UD+2
         zNu50RTyTI2YM8twFdoqafgtUbx3tB3HT1kJ4YaD8ufgQvVh2SOiGbn9d7sV+78tu76g
         PQAe1U9I8fDjj0/vND2MWLXejL8zg3eZtcEpctpi6MzP+36Pnyl4WLlo+DZGJuOJ1da4
         Rxap3umFyWqwiKb41UBbVNYxfQ/4nUzwg1I2QU+Xkdb6Bm8490RxFgx3qrZLYY3F03XR
         KS64VnJ4GwPx2rA1zLPpGX6ctlpFKnFySKNOqNaNkZXLzZbrvuVM81KxqPnl/+6EjLxA
         90Cw==
X-Forwarded-Encrypted: i=1; AJvYcCU/mYSNYJRXMLImn6WiGpWDn1k0WxTjYNNrEaQl3z0x7/8M2VF4hHM0XbQ+KBDrikl1WXQXpxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLX0uiiK/ystbVcOS23uloMLpRBSyhzfdfndbOPH1Xwx+YL8Sp
	9qOszN9HYbBBUgdv0SMsATEGmCtPwnl1JfAqaas0jnzPN7u23rKRp4IQ
X-Gm-Gg: AZuq6aK7F7p0IQKY+1eM2xJAQiW3SgZDTQ1HE+1pesSSnuIAKFEXOmZ1TWRGWA5g3Ez
	DlN3s7K9qkBr3qJ5WxQZXwoXnSEd3614k4pDLFMd6lf5o4FsIo6H6sl8ghbddFv9Qie1Fn7rHxW
	H/RbYG+b0WkKfQwDir6lgRwS1sRUZrLA813mhpdKMFeE/9AEj2lfzpsgnTRflYtOumhGhTrdu9b
	jLL+QNvIaCQR2F3ztSprGyqbJ7NmAVvK8/Ul2S7pae/QAWsd1NGa+8VBPJLPPNKTcWbdgPFgLV/
	0T8yCg4WGpvjUHt2+HvWtQfhMPhrxg56NIZrfAY+p7OYLsVXVJqkkg54YSuPGCqbE9Vl0NaJaTb
	w9HGDnSQ4LOVhM+nbmpMQGPjgpBBcru2ymrr00IWxORt0UONA99lC7Q7Hi3uZaRICMvngOIg5Kq
	Vra94X2NoAo12LGD3UYu7/qvngQ5XhqbWMdmQNKFCTZqpcPe9WPtKhWxcBZ8qFucs1AqNhhoyDr
	XkM+1DVYJZffS9FrBOtxiWYwQ==
X-Received: by 2002:a05:7300:a984:b0:2b7:b41:bbeb with SMTP id 5a478bee46e88-2babc596a9amr119468eec.43.1770952108127;
        Thu, 12 Feb 2026 19:08:28 -0800 (PST)
Received: from ubuntu.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcea9b7sm4639377eec.25.2026.02.12.19.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 19:08:27 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/1] Bluetooth: mgmt: Fix heap overflow and race condition in mesh handling
Date: Fri, 13 Feb 2026 03:01:36 +0000
Message-ID: <20260213030136.5997-2-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213030136.5997-1-maiquelpaiva@gmail.com>
References: <20260213030136.5997-1-maiquelpaiva@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,holtmann.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216017-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47C0F1328EB
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


