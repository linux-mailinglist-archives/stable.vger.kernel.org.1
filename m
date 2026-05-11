Return-Path: <stable+bounces-245242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENscILPqAWpHmQEAu9opvQ
	(envelope-from <stable+bounces-245242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:41:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F9C510669
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E4D130ABE1C
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F3401497;
	Mon, 11 May 2026 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/WCly3B"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398F3FE67A
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510074; cv=none; b=ZFlHp2EVQmlolnJkEIJ5rGNDRofLt/cq+VUF/bfNbcdc1KPKguc7Syl4lQtpDilbeUvEwHSQXtAElLM+aR5NPYGhijSGsnazWp5MMvAwSBrB3Y0mjCKdqsVagag1tdMYjZ+apbF5FBqRXAvsNOyOJG+qMOc+bYIGnX/94/yGAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510074; c=relaxed/simple;
	bh=SLCjylkoYyrSymgTADQUnZN5X5pHLMpZcZL0BMK5TuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXZa9r6vttOxEhYf3m5pKBr4Hh18HSgcHDPAEn2bfzGtLIaGuz31SaNySY6Pbjc/LUehtOOdg0WctLnmggq2TWdaIt/IG5pBzGTirmgivqWNgQ9lNWL6y1RJTdguPQBm4GSI+qsW4xdtOxVMb7otcw5k6ze3hLIemKnk00g5ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/WCly3B; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50d6b9bca48so55436001cf.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510071; x=1779114871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS/XEaKHIMFF8jDxzt8KXTwiFVllSXPL3p6YrwJsG/Q=;
        b=J/WCly3B7JLxicixynYiCWpTtpaneFRMbAl+9aWqJ9vMOcIMtUgGEf4Iji4ZlS/tr/
         R2kRuxP0WFnLm1BarlPszdS7FuXwzUrOwM8f/XjoUCuYVYEOvMcg5DMKhh8kDCg4vl3L
         xTpoBMghkSK5J0TbTu5ptROEUVYxVZEJXcWkvAv08DQzytY1HRSYRgKgWQ+XbPuPPWqA
         yTDLyNdLcLxkjXNDIwglLztupKvP0cDS3Q2kHQnSQ8GHNA7TQma9RqvGcUS/Ub3TD8PP
         6gzS8G26RLusqmoW0YRpNG4jyhwlkJDa0g9OTv0GnRwULubFjQ8HTHKrXNUVv3hC6lFw
         1eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510071; x=1779114871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KS/XEaKHIMFF8jDxzt8KXTwiFVllSXPL3p6YrwJsG/Q=;
        b=sa2bnra3JlCfj5DraUON/9Gf2ns8odi5CuEDzpF+d0ivIs8Xrct68+5hOzhqaeBJT+
         x6Tlkb8HTzpcEUQSmKs8ZkaHLrNc0VIX665k0rmJ2ijx0L3/qNITTwX9y/+qyU54Aq9v
         Xg7g8WLlCLN0gy8mlHFm3cp+Zq7AOpvtgjI/YkJJEJ6XtsjuPM4IGBwZn45LrmhsFeAF
         zldF3Y2JdKV93lJybE4Y1GhZ8yTrUNXjld1tAUxAGjWmhZLMmIcIt+OkfLGwQ+/Hy4kj
         XbP4lqVq95JNxl+Yiu9EcXqMq7PVVAiVSLVB7D7kay8YDJTTOr9+LHVx4wNFyRepsqZ3
         78kw==
X-Forwarded-Encrypted: i=1; AFNElJ9QyKP1iQXfITqc/v3lduKg+/f7TRTqdz/KMhqk4+A8vrw71U4jVjR19cmDVjJ8FqGZRj3QJ8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLIKWpWlGxo1r04J976qBzOQHZRmqccdj+lgya9OobX8wlOjA
	wrFjyY29yfIIbuwd2vr6fKjWS3vuQfbdUBLqZoMGItqnoPzYXVKn9Ldf
X-Gm-Gg: Acq92OEDRuIegSHSJ0DRL+2hoPET4IpJdFyGVxv1/tPL4bOQdnk/jjegOhwS0cu45Bc
	kKrsBFoifjaRHSyDLGgEu3U0Mx7z3PNCj8V3EJWjzFqnMMtJgtBpO7k7QuL0TkgBcsWynur1tna
	J8gHiWyCyjMozNymSfHi3GEdx/7zmID+hVFvi817yVVTyOqngwnfaZdfqU5qAIPHdTVsjqAt9xk
	oWqUwfvRKqWICq489wN7YexlUk+Sb/69lIGCdECiVgYBuAC0+VIbf97eE6edJVwltjDLSmLoWRD
	riqUkrd/5m/V5VXipTsQVG+C9y0U0N5xEMmunLFR6M06K3ZjeqdTK3xafkzwe1YpS1uG8FfkxbX
	/KXp3hT1QiNUwXXyj2VH7QQsrwUhlmfG82Z7iCEygnzaEAgUIiiJbjmLM8D7umlg+gj60LhvCnx
	KWrHGYWToPk0xeEGIMcH/pMC8yIiZljO0mCu1bKHko1GJf2BHb5T991/GK24/pgRReiN2ykO9XR
	59WuLCFMddfSKUTPo4sla7kAeQizgDqw1O9lMxliaw=
X-Received: by 2002:a05:622a:13d3:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-51461f9dd67mr340927431cf.37.1778510070473;
        Mon, 11 May 2026 07:34:30 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:29 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Aaron Esau <git@aaronesau.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH 4/4] Bluetooth: hci_sync: pin conn across hci_acl_create_conn_sync
Date: Mon, 11 May 2026 10:34:04 -0400
Message-ID: <a586369f30357a4efe549f567f0629ba5ee0e7f9.1778506829.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778506829.git.michael.bommarito@gmail.com>
References: <cover.1778506829.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D4F9C510669
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245242-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,v0yd.nl,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iki.fi,aaronesau.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.941];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

hci_acl_create_conn_sync() shares the TOCTOU pattern with the
three sibling cmd_sync callbacks just fixed: the work item's
void *data is interpreted as a struct hci_conn pointer, validated
with hci_conn_valid() at entry, then immediately written
(conn->state, conn->out, conn->role, conn->attempt++) followed by
a memcpy(conn->dev_class, ie->data.dev_class, 3). If the TOCTOU
race fires the memcpy lands on a freed slot; the three dev_class
bytes are sourced from a remote BR/EDR inquiry response, so a
successful exploit can land attacker-chosen bytes into the heap
object that reused conn's slot.

A KASAN slab-use-after-free splat in cache kmalloc-8k at
conn->state confirms the bug on linux-next tip commit bee6ea30c487
("Add linux-next specific files for 20260421") with the synthetic
harness driving the conn->state write.

The existing queue site at hci_connect_acl_sync() passed a NULL
destroy callback, so the conn was never pinned for the cmd_sync
workqueue dispatch. Introduce create_acl_conn_complete() to balance
the conn pin and convert the queue site to the
hci_cmd_sync_queue_conn_once() helper. The dequeue-on-cancel path
in hci_cancel_connect_sync() now looks up the entry with the same
destroy callback, keeping the hci_cmd_sync_lookup_entry() triple
match consistent.

Prior art: Pauli Virtanen's PATCH v2 8/8 at
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/.

Fixes: 45340097ce6e ("Bluetooth: hci_conn: Only do ACL connections sequentially")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/hci_sync.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 47ce9ba63fe2..9a133de16f63 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6994,12 +6994,21 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 					conn->conn_timeout, NULL);
 }
 
+static void create_acl_conn_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	hci_conn_put(conn);
+}
+
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
-				      NULL);
+	err = hci_cmd_sync_queue_conn_once(hdev, hci_acl_create_conn_sync, conn,
+					   create_acl_conn_complete);
 	return (err == -EEXIST) ? 0 : err;
 }
 
@@ -7054,7 +7063,8 @@ int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	case ACL_LINK:
 		return !hci_cmd_sync_dequeue_once(hdev,
 						  hci_acl_create_conn_sync,
-						  conn, NULL);
+						  conn,
+						  create_acl_conn_complete);
 	case LE_LINK:
 		return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_conn_sync,
 						  conn, create_le_conn_complete);
-- 
2.53.0


