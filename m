Return-Path: <stable+bounces-223160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMgMOT7aqGnGxwAAu9opvQ
	(envelope-from <stable+bounces-223160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 02:19:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73B209C19
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 02:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48F283012AA5
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 01:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A1A237A4F;
	Thu,  5 Mar 2026 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN+CeqbN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0121CFF6
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673590; cv=pass; b=VjFi00ZwNXK3dse5b7ussrgsKbIfaIRNwqfiWdo9JuPiFHv68NSgrqUiG6J1FFLm15cvZ4ANbTPywldlNLOQa1CtR9sZKA8ObLRSo+gelqiFSahnSxm/8/MgOSzeqyl4vO6xzCbcH9nEueJStpFbK/OTivocxcrbV0uiOCW1B/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673590; c=relaxed/simple;
	bh=2aT1PTMN9e98irX0/im0YZHkqcaEFpN5vTzEtdJm+ZA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=myXfQXhcLuMon1wPjrx9VBLwRJx7DKuGQ2HGNrAAp0H0OvpwiOW8cqdeJ+8bOSA/ttcy7Iq8QpQT695r71Dw6gY56udklkEt850dN8XESx5Ld6MalcsTHXgT3HqElV6dY4bISGHefN4fPHIp6BECTzQ2Ajs2H+VT6iptzIUwnWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN+CeqbN; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-660b497adaaso3486849a12.3
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 17:19:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772673587; cv=none;
        d=google.com; s=arc-20240605;
        b=EFZ/9im1VBAkDNsfD79pUTcTUECt8nXZW4zvVLLRy9ftwlisBNNOaHZhQ4Dl0upDRP
         Cc8PNHnVKg+lKJEybpT8KmfRafSUWvlRXjdWexwgCVY4wf5uL1fO4guglNIroQvxnzhY
         kFG+8C1y0EzGNByZTDl4tZzyavKJJpW5Uknks7mH2UnKG8+kmHgHKjr+n8nuHrbdQIhi
         BsWFyLaqHe1PhdXgVpEAcq8HcSifAgf2kmzz6843XqkDFoMv2DglW3T+WI6MzxPJ9m7d
         jHv23mlPrDBkbc5HaJQ3/piVW/CrbpFPitfkNQcvooiQpV6U+jEUI0zaMwP1bdSD/+zD
         NsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xl0zrJXwVeV0t6VLgMqVNiKRObk8dHKEiJyMxdYAKAw=;
        fh=KwTIvHOBB9TPo3iHja38fLJCkj39HNoJ9MxPLKyFPjs=;
        b=MqEnuf0Bekb62YBcKYLGUtlbQAqPI5oK1gGUkkewqTtYyFS50UyIsYcjAJ05liNoUM
         By9q1cQamTPSgfIcBrsCgytpgc1a8uPeQxCLertEedTHyGqgjTFu5gL4N0aKbgiM3gWW
         4O1JL4zLggMToHyIG1TZJcroQvNBcfLofAzQH+ee3xQswvExjp7Th0loEk0sCWwykwz1
         gwyMx4GjbVNGrOgMclukFTbLMkTcMAAnXAB+/4C+mA4hwjooxDmp2O/DP+JL1iUJeqsS
         b1M7k3EnCFcryPDoD8o1hOS2mJDdtiS8/NIhZ5IGCRDEMEgt4YD523Eq/w9KHeVBqRBn
         sjwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673587; x=1773278387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xl0zrJXwVeV0t6VLgMqVNiKRObk8dHKEiJyMxdYAKAw=;
        b=IN+CeqbNGXY3xT8juy88vEqx52LhDZoa33GWDXidv6sDE8p4gJbrOvyrDpQISXCOMv
         /tOH0N7uocXWD8qGQPBs16qkNg/DAjll3r1S88aI8s0edTP91ugBFfj/L2snEFKJHW0c
         i+jmN5sB2l9K7QvSjJrK2RPSj99LRgdm0NPxZUtptB5EZ7Hl1ezX/ay7k032VK/Cufgv
         VJH4oKpwpoCBMbDKRbCfUVLtHLZfdo2Qhyun1Eg1ojpIgcG05LWrnA4Bjgpp2Q0jg9UT
         P9gv9FrN+h2t2xYceAmY/KoF18OIMCx8WGY01wncGtVHCPAr03ckbhMMhxEu1FgAWtn+
         tp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673587; x=1773278387;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xl0zrJXwVeV0t6VLgMqVNiKRObk8dHKEiJyMxdYAKAw=;
        b=RE7HQR4LyWtqnQCGBtXHDEO0StPILbzPgbOjaVm+0Wgk1SIbKKJXEEnhyo4DiRgg1q
         A5IsSRmud57Mw9/5BRilLjt3Y41fvVEkAKDr8qSLeQb/rhMcgaMtUhrmNHw3K0FH8BsM
         W4xf22aUlPu5lOGvX3jLVPRYUy1/8D5CT8KIsN1iffJO3XkQz5ZYfI1klfo5dVSOp8QZ
         1bBdRQjBE06Hweq7Ej39W5XndZ9E6qtH0Rb52T7BF9OQaperJVvU3A5y7F543adYzzNs
         yT3ahV4r2ZVQsIHwW13rarZuZ/oWREO7qSJm69FooeENfJ8r/JH82VLkmnRneq2zE3Do
         /R8A==
X-Forwarded-Encrypted: i=1; AJvYcCVZUdBF5B3uM5lqfmpmPJ4O/OMx41LTfqhz4Zwb1MnLBZpA1E4t49OQUkyIL6T4RFiQqw2vaW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFS343/6PiJK4rSi/tmgQwItVQUfANwjvW/GgiqcGdY06CA8kA
	vnohV8Mxzj6v4NG2HUv+QAHfUJGJFGb84i8hwts7IDf8JO6kUkqQ7N3zojWj1ZtebiOseMRYk4q
	yhj9NJ/HAOIdHtKxmT9X+Tn0zEIbxf+8=
X-Gm-Gg: ATEYQzx0cjWiM30PqXJNxcArRLi3R3M4uRKebVM2pMHPIxYPJejEMOosQXtQvOSSXzw
	Llu2UUdw+AJQMNd9TGyuNl5lIrd8E/Hpm1QG8VmP+TRzH2/rEg2R5tyj6FJTTbKVDXH/ZucyCTZ
	4CbNV04YCcOsKFLjJZa6UEtTdsLaS2Bh9sVvNhL9ORXll5EPL+w5prUqPtdWwKcaat4Hi6HiBxS
	xOJOxqZq/AB4T7xHL9jiB4kdWy560gzGwT1zo1yjzEjTZtfXnrrqzWsGJyko9z8W5qi2Cxa6LLz
	9QadQa66rYkjhNCnYegu0S/e260HZl/huxEK8Adoz5ROglVWxeouMop7q9ZDSW1nOsrMVhcgYHf
	mt9GwEyo=
X-Received: by 2002:a05:6402:35c2:b0:65f:8e80:4108 with SMTP id
 4fb4d7f45d1cf-660ef897451mr2663635a12.11.1772673587054; Wed, 04 Mar 2026
 17:19:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Zen <kai.aizen.dev@gmail.com>
Date: Thu, 5 Mar 2026 03:19:19 +0200
X-Gm-Features: AaiRm50JGIdOkGQ3NRTab-_nEMQNQRYwipDm_Jfj3Hk3CQYx7gz64Retw-rTZ4A
Message-ID: <CALynFi7dq+5R+TRYa3T-9ethQ_TKegBtiv1AAAG5Lfb9oMto2A@mail.gmail.com>
Subject: [PATCH v3] Bluetooth: hci_conn: Fix UAF in create_big_sync and create_big_complete
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, stable@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7F73B209C19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223160-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

create_big_sync() and create_big_complete() are queued via
hci_cmd_sync_queue() with a raw hci_conn pointer as 'data', but unlike
all other hci_cmd_sync_queue() callbacks that receive an hci_conn pointer
they lack an hci_conn_valid() guard.

If the connection is torn down after the work is queued but before (or
during) execution, the work dereferences a freed hci_conn object.

Race path:
 1. hci_connect_bis() queues create_big_sync(conn) on hdev->req_workqueue
 2. ISO socket close() triggers hci_conn_drop(); for BIS_LINK timeo=0,
    disc_work fires immediately on hdev->workqueue
 3. disc_work -> hci_abort_conn -> hci_conn_del() frees conn
 4. create_big_sync() dequeued and runs on req_workqueue; conn is
    already freed -> slab-use-after-free

The two workqueues are distinct (req_workqueue vs workqueue). The only
lock held by create_big_sync is hci_req_sync_lock; the deletion path
in HCI event handlers holds only hci_dev_lock. No shared lock prevents
concurrent execution.

This is the same bug class fixed for hci_enhanced_setup_sync in commit
98ccd44002d8 ("Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync"),
and for hci_le_create_conn_sync, hci_le_pa_create_sync,
hci_le_big_create_sync, hci_acl_create_conn_sync. create_big_sync and
create_big_complete in hci_conn.c were not included in those sweeps.

Fix: add hci_conn_valid() guard at the start of both functions. In
create_big_sync the 'qos' pointer assignment is moved past the guard
to avoid dereferencing conn before validation.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
v3: Rebase on bluetooth-next HEAD 50003ce2; no logic changes
v2: Regenerate with git format-patch to fix malformed patch fragment header
v1: Initial submission

 net/bluetooth/hci_conn.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a47f5da..e7fe9cc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2119,10 +2119,15 @@ static void hci_iso_qos_setup(struct hci_dev
*hdev, struct hci_conn *conn,
 static int create_big_sync(struct hci_dev *hdev, void *data)
 {
        struct hci_conn *conn = data;
-       struct bt_iso_qos *qos = &conn->iso_qos;
        u16 interval, sync_interval = 0;
        u32 flags = 0;
        int err;
+       struct bt_iso_qos *qos;
+
+       if (!hci_conn_valid(hdev, conn))
+               return -ECANCELED;
+
+       qos = &conn->iso_qos;

        if (qos->bcast.out.phys == BIT(1))
                flags |= MGMT_ADV_FLAG_SEC_2M;
@@ -2196,6 +2201,9 @@ static void create_big_complete(struct hci_dev
*hdev, void *data, int err)
 {
        struct hci_conn *conn = data;

+       if (!hci_conn_valid(hdev, conn))
+               return;
+
        bt_dev_dbg(hdev, "conn %p", conn);

        if (err) {
--
2.43.0

