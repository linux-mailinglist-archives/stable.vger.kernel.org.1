Return-Path: <stable+bounces-245237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D3tIRzqAWpHmQEAu9opvQ
	(envelope-from <stable+bounces-245237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:39:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B0E510549
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B93C307FDCD
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5166A3FE37C;
	Mon, 11 May 2026 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYKxhRM1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA813FE371
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510069; cv=none; b=ugGtrDwiCS3NOMuB29Qcv8CV/mz+ClnWz7LwcejrGuGF4yBZMCTx52cF1bNOlynf7oIMGyNQlNTm2oJy80VuHJ1Qqjne9025XE7Pot3nc0GwrFE3Chy1PGn1he45Ewq8V+qD7de+LY+e8ZoN/zvSIJ06GwQbBoa8N3x1vF958BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510069; c=relaxed/simple;
	bh=xVmk1h/F3OP1l3EftzIIS5KA56VtR1Q3Ps96g1qfUZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0eMr9TQeVYTL8fuXhg2Zz/y4N7Y6l1nTiMtqfv2A+FKFWoMMehC9DLQ3Wq+mC1SNtvyayDb/iI2iRgE3JtrvgEcHmGqs4VbStRTPy/54YwgaRe4o+CkeBaC3HSe3L31ezxJEvQEmsHLUOQClPjWXb/dx2La3LrQRIqyN6ARuOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYKxhRM1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e97863425so43334191cf.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510065; x=1779114865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FK+L0K6qz3weg/2Imd9GJZb86R+Jgq/G536dW6Nnm4E=;
        b=PYKxhRM1yGwH0z7yLss2oIYCvpe0m+dE20r1eSh00nH+Enpb3Y5eBdWohrwAXcgd8G
         WqC9bFvFRw9a6DHtBGvrNwz/ML0ciwniFptNG8mu/wl+f8g57Ienl660S06M1W5Yfx1F
         MOdRamJENLi4WsOX2jxqRzWSi1cWZUs5UKSyO2qouEee696c/drhPV9O86qP7DQ8GxiF
         H0WKAjQp4aKhfSlormg0uG27Wp6hSG+egAUVwTcz+96nM+8jvkYt7V8wgVavZem+2ThF
         0hbfiVJIC1Kv4Mi9CZfAHYGEkCTyStYA4UPCEDILSy4uEkfWLmYMcyoSPtsiAxpnJ4cu
         Sfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510065; x=1779114865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK+L0K6qz3weg/2Imd9GJZb86R+Jgq/G536dW6Nnm4E=;
        b=qcn2+7fMAVXM5Uix52pzMWqWbJxO1nVtYoBTEfLvJqb7+eZe6hV8ehya6d46M8e5GP
         joYyCTjdWzbYu/oAoIU4duRGdEvJVffxMD22MrNWdi0YZtaUqe8PdEqK+YOQsQfNgqQ0
         DEbm/XBG5GGnDHKTgf/H+9NEp0/A4EcUGrfCqDhF+RcV30YtXSog6q9wzbK0CwFO4Xl3
         HzdHKEWtRPCK8zy11bqsU5Snt9Xx3b9pzEcz3u+zr42GHgOXoAT+XXolCSm2kvrblJ9R
         nAgG0TAmZb4xv47OT/3AtfLsF2ENex6rKXEdOWMUMclfLWltUBlx7KToTYJQeEqC98QO
         VoOw==
X-Forwarded-Encrypted: i=1; AFNElJ979aJ6EJGD1GPqiehcLZj3r5WTDLv6lSmo7BkFXXQGooy7HJKbp68B6LWPSjsFOiJ9y+C2/5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaL1fbxQFazMT613jNUdRdlR/VtjMEFHjrUjkunsKSG1V3wAM4
	kBgSzTVS4oS/3vgN4YZeG0tfr7Lw3r0tCeASzmAtstcTtc0QpxgFcLBz
X-Gm-Gg: Acq92OGhwkFEHt8ROQLALYvKzFpJ8Ch4lTqvKZ9L4/aatbhtyy87rfII9wV9B+KXNhB
	rD+3XE4gOML5Vj2DMoGy4tMFmjO9unPJa2LH75gXUMAez3ddgbdKdK+oBDWCGULxVuXPpYOd8JC
	VMOXqHfKkGIV33mhcGTXanfgOj8MgO4yVYlT87UNVR1SceWp2/2kcsV5V2oTMRp4usiQu7eDZIR
	AgwBoDxKZXplHD0j2LRBduLdrVRYk5DqSCMwlz5erupk//IfmqXyPGhxv7Gf8xZPE3t+8uNjBx9
	LjLi6bLc75wGa11oGYIKyi1HFtcoTD3PzVOmEZOHjLIvTT7dFsJZx2vJzHKVHWdpvmGBTTCBypY
	+XXSvbqv+fg44H3XJipAA8O3J+hmV0f3PkypMlXQ/uutpphyzEwPQ4U4/TMtU3C76jC6IxLWZmz
	sxLyLco6Zh60cnRR6Y6ERXovITUrtMwNkXJFJvVizbcJovrTL+EZzwZXuMKeaK8e6IHA4XBl6lC
	EkdBQmvmkEYXpLxzbsAMZ0yPRaqsV2vlydwWwBbX4E=
X-Received: by 2002:a05:622a:d5:b0:50d:2a76:43c5 with SMTP id d75a77b69052e-514619de7e5mr335557531cf.2.1778510064939;
        Mon, 11 May 2026 07:34:24 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:24 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: 
Cc: Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Aaron Esau <git@aaronesau.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH 0/4] Bluetooth: hci_sync: fix TOCTOU UAF in cmd_sync callbacks
Date: Mon, 11 May 2026 10:34:00 -0400
Message-ID: <cover.1778506829.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5B0E510549
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iki.fi,aaronesau.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245237-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Four hci_sync.c cmd_sync callbacks share a TOCTOU bug: each receives a
struct hci_conn pointer via void *data, calls hci_conn_valid() at
function entry, then dereferences the conn without holding a lifetime
reference. hci_disconn_complete_evt() running on hdev->workqueue
rx_work can call hci_conn_del() -> hci_conn_cleanup() -> put_device()
between the validity check and the body's first deref, freeing the
hci_conn slot. The cmd_sync work item then reads or writes through
the freed pointer.

The four callsites:

  net/bluetooth/hci_sync.c hci_le_create_conn_sync
  net/bluetooth/hci_sync.c hci_acl_create_conn_sync
  net/bluetooth/hci_sync.c hci_le_pa_create_sync
  net/bluetooth/hci_sync.c hci_le_big_create_sync

The fix shape used by commit 035c25007c9e ("Bluetooth: hci_sync: Fix
UAF in le_read_features_complete") and commit 0beddb0c380b
("Bluetooth: hci_conn: fix potential UAF in create_big_sync") is the
same one this series adopts: hci_conn_get() at the
cmd_sync_queue_once() call site so the conn slot stays valid for the
duration of the workqueue dispatch, with hci_conn_put() in the
completion handler.

Patch 1 introduces a small static helper hci_cmd_sync_queue_conn_once()
that centralises the get/put pair so it cannot be miscoded at each
queue site. The kerneldoc on the helper explains the -EEXIST contract.
Patches 2-4 convert the remaining three sites.

Each callback was reproduced under UML+KASAN against linux-next tip
commit bee6ea30c487 ("Add linux-next specific files for 20260421"):
all four produce a slab-use-after-free splat in cache kmalloc-8k
matching the syzbot trace cited in commit 035c25007c9e
("Bluetooth: hci_sync: Fix UAF in le_read_features_complete"). On
the patched kernel the reproducer returns -ECANCELED cleanly with
no splat.

An unprivileged process holding an AF_BLUETOOTH socket drives the
cmd_sync queue side (no CAP_* required); the racing freeing context
is hci_disconn_complete_evt() arriving via the controller, which an
adjacent attacker controlling a BLE / BR-EDR peer can drive.

Pauli Virtanen posted a series-wide variant of this fix as
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/
(PATCH v2 8/8, 2025-11-02); this series re-derives the fix on top of
current linux-next with per-site Fixes: tags and factors the get/put
pair into one helper. hci_le_past_sync is not included; the past path
uses a struct past_data wrapper, not a direct hci_conn *, so it does
not fit the same helper.

Aaron Esau's sibling fix for hci_enhanced_setup_sync() in hci_conn.c
covers the same pattern at a fifth callback,
https://lore.kernel.org/linux-bluetooth/20260330140347.906689-3-git@aaronesau.com/
(2026-03-30).

Build clean on UML+KASAN+SLUB (linux-next tip bee6ea30c487) with no
new warnings. checkpatch.pl --strict reports 0/0/0 on each patch.

Michael Bommarito (4):
  Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
  Bluetooth: hci_sync: pin conn across hci_le_pa_create_sync
  Bluetooth: hci_sync: pin conn across hci_le_big_create_sync
  Bluetooth: hci_sync: pin conn across hci_acl_create_conn_sync

 net/bluetooth/hci_sync.c | 77 ++++++++++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 16 deletions(-)

--
2.53.0


