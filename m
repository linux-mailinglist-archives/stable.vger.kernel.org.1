Return-Path: <stable+bounces-216027-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJoFMnzRjmnJFAEAu9opvQ
	(envelope-from <stable+bounces-216027-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 08:23:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392AF1337F1
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 08:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84BCC3046070
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680442D5432;
	Fri, 13 Feb 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO8olS4E"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB632BEFF1
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967363; cv=none; b=BWtSR5cTtIOHGBkoJaYbeEbUFN3HLoKAXLOQvnbHTQtiwrMiO4O7HgGn2wsayRSqQRWc1M4R3tbrr78gqkycyDSaCfnE/jbaSw6KgavztmyWJcpK3YPCD0lcfcM5XY88EITFsZrEiZOVkFM9rEeoMbAescnyUq7rWs66Fxl1vPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967363; c=relaxed/simple;
	bh=vQxdkryUEJ+pArY5kJMAR+7YlXlMsv2XI7L1MiRhw0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nP2l8BRwpvNZXtJMHTliyG/wAvp+Ehs+1Y4wuSzHg9WSgfg81psMvK4I6R5DP+gabKKtHhZQQb7Arr/+18w877tAG+sgXDK2bRqfyFrGPnfMREIoLl1K/pRCimH6oIa9HuSl9VNHmQ+Xm35ZJ40FYKrYhEBfm4Qz0ApwHJyJ1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO8olS4E; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1248d27f2b9so980775c88.0
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 23:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770967361; x=1771572161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=iO8olS4Egzz5d/LXwrbzV/MvyXGAoOe/CSN3jLD6Qo17e7arkMePTsWghpEOC429l1
         2ojmlPkb/buD6ZssJqAXfb2A+r23eK8p4TpEPGmwTTm5jingzuetoD7Zg0qgoxalCqSy
         tl1RR9Le51ogklDomT+c0XI4MuQnZbQ3A02dnkfJmAcN7W99qm3x6RSy8Pif8n4rWvWd
         nIk048blXiNE3snHIPSSHBPwX10rxkn1TBtcEIZVjdsZrO3rpxjEz3SyjlI2xpkzYog8
         alN1hv+YLHyJ7iD3tJzCQvPe0d8fLiEc6P9ozzgcyE64Aw87Q/3n7ejbzOdUFGw60vP1
         FP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770967361; x=1771572161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbsk2agQ8f3m0QH5WZrAhx9x+dI3Pqe/kCYQZSQSePA=;
        b=I0HjVTijz6EnbsuW+B3JnvADveRKEz0fwaNYL2utYMqETywMIIYyHkzwQmsG7HZ3Ju
         QbX4V3mIc4VezMcIWw5+N91LWCgR2cpSTfufVUwoHVSiErgU4BHWzB3DVlACDfy3BGp+
         UZhRhXWBWipsSEV4ATQh1XPsaW4sbSuE3tIsSvb1gQRN25pzG7zK9S7Xnfzw91KIuYCl
         Q/vzI9FFVBgcwzU7Y6EYkcVEvupBfoWn5c3Cs4wsDB0HqzKRM2VqE3fLhwZ8Dbff9YR0
         WOvDeaExgXzfciS09faj1Li3Pm8tHaMVMkf4IkAWKeklur0o3JIjy2ZZfDPAUq/q6wmp
         nBQw==
X-Forwarded-Encrypted: i=1; AJvYcCXB5ixwHO31TeIUV3uIx8wUUFu585q0KmP/dikQd9D3IgKHaTcFAu/T+W4ru1VbajBwfM8W7nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztayoBxk5Q2CQp3ypW3mfpSnMo8eKGd4A7i+BhZ5fi88KcZjxR
	ydhT77FleefQGTK8RE2mGg9/H5+u0CgnxrUoD+SrpSNBR/R6reF2R4ht
X-Gm-Gg: AZuq6aJDiWuKYCxevmBZCr/NT/mfvi8XyUaqRtoCyivHRda/NqltQUvGm+K1rS381PE
	5Va2kQifJh5zkXyejVHoSgX6xPQhZ/ibsb4lCmEFZx7bBmpGVZHHw1735MmyZid0DhvfexVpZYC
	OgdnYQeJSxpbC0xZpFmGDRiaf+mj8OLHFrrCOEHG0yH9pDwbqFJSYpRajW3JCzn0kQbMbEitff3
	SbDSDH5IEhxOYqL/vefGArCPd3psZJCBpBKWO9GLaF6vOezlQv/PD7whBlh43WHVldiwCmNGP6R
	u7DvscFZ/kTZQn+839Mkw/gN1CpF3ILq6RGN7/IU7Zp5t7LlomCWaLDMeWhhVh7keIo0F8IzK4O
	WFn+fnevWTH+3yNNRcVNtJXlwMxpHkAuLjtHxHYKk2y+BD9zbnIcJbePPFtlB0wn/kfjGEv5a7Y
	fc5vfUGW1IuXecnAE6HVTonUimi60AsPisE+1fFQ7XNRzFqjoFJlLZ7eUaM83in6OmXn5EB7x/w
	sj0rj1TrsLaN6AEsDBlMt022A==
X-Received: by 2002:a05:7300:aca4:b0:2ba:7d5a:a817 with SMTP id 5a478bee46e88-2baba0df10amr535163eec.26.1770967360517;
        Thu, 12 Feb 2026 23:22:40 -0800 (PST)
Received: from kernel.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcfe6b7sm5898148eec.29.2026.02.12.23.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:22:39 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>
Subject: [PATCH v8 1/1] Bluetooth: mgmt: Fix heap overflow and race condition in mesh handling
Date: Fri, 13 Feb 2026 07:22:05 +0000
Message-ID: <20260213072205.18404-2-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213072205.18404-1-maiquelpaiva@gmail.com>
References: <20260213072205.18404-1-maiquelpaiva@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-216027-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 392AF1337F1
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


