Return-Path: <stable+bounces-253403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OszK6I9Dmqr9AUAu9opvQ
	(envelope-from <stable+bounces-253403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:02:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A32159C83D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72A773017FBF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A223C13F1;
	Wed, 20 May 2026 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC/CUCJt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DD1A682E
	for <stable@vger.kernel.org>; Wed, 20 May 2026 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779317842; cv=none; b=nDEvX5/Z1OPnBrA+By6oA79f/4rx4xJmTsBuI1BRLskpp8c8fs6MAB/pwCqwwvkXxZlzgzSz364Y3iUYRC2CmHTbxMCAkKlxL9V3YinkOEriehAxrtbfXND8DQnDy72o0fU4fmonwxRKuvnq7gjIa2Rjac0Sx+hG3uxJGn2E3Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779317842; c=relaxed/simple;
	bh=9WDmz4mIk7d37pNF+Jf3V82CnN2ksLJhxTsJcZyYoPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pp03E3SK31CeqALWy/iZXoBLT67cuw0PLoLDjs0UNaE+sp40wGIissPhPUs8YdsxGwa++ngDPdplfn4NaHhCA0XJIiJDDKa22g83G0ZsW2j419cKzal10wlWk00jFoNqB65jzW0GhSr6y1JI5aOt9aCdeIP59lNhAE1ouKIkU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC/CUCJt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bdbac72ac1fso86984666b.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779317839; x=1779922639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5LTi7OvRi2audUUcgHNeX3CP0k1T7QcTMVWKqi+l/s=;
        b=SC/CUCJtKH32blGUdu8kFVrjcjBGb45otHujNLAnY0itPJHnV7NEcWihQUoVZiDAyS
         tmxfhH2uLd18VS/c636hFzr60VDqmibXz3eZRh/QLhamHy1NCzTKHdlYNtJOlDpeq1TE
         4oulgBryY4e7e2mLvZhA2IsnMPzkDjbgFY1H6eH17cq1RBG+k5/KUE5uFQi521eXwuCn
         zu924dxshEHNdL0rC1MoUQYMCOUGY0uYUlyHMoqWRT+vYs2A0L+i6Y4CKTSJrhJFAn/H
         z211wZlr5KHqIHiJIrB+0DagwsjwNVW3eQUo0dW2JjDUgk/uD0GKa5xXqEnvBBGJpEHV
         xaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779317839; x=1779922639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O5LTi7OvRi2audUUcgHNeX3CP0k1T7QcTMVWKqi+l/s=;
        b=i5KlxdUAX69VbyFs6iSJQv8OenVnrWaqNVFEZfTumGtsnTmEf/K0GbCqcfsNL+j4ct
         Hu/BYJKcLbz/X8VHscaiopOLP1UgMC7mFPya8aab2w8k0Ef6JkJ3tDmgd3eeN5J46IhW
         a6aVGB9fBjZQcIoAe8yTWKpeSmDVoYFngy9oPYIC7d6R4aS4SiqEgxKeSkBubTE5wdjZ
         vLSK4HEMojTJR1Bk+fBWBzeyN3uB4H6YdSmkrFYDIb7lN8FPV4QKK4MBKAtdAmhsKbpz
         4HSbOvs1COyKnDPWf1YyqGKroYwKxZU+Cqqa/iMVNfP3/n9xm8MfPuFgu89zlGfhu8r4
         GotA==
X-Forwarded-Encrypted: i=1; AFNElJ8Z2cWseeWPj63QItlhxlD4ditAqw0Aj6SLQtpagQnQgeHxbpFEeAnD2bn22sfE2JuuP9n4+s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKIAsaPV9x0qMNrpSNg8d0MoOGrWbFn+mjmna5arl/+r4LRgc
	O3mjs6WSVPNlvKCj8fRQKajSN8FMJHwYI36tQC+1SqqVw1YooqB9Vl6S
X-Gm-Gg: Acq92OGTLsHIaJJqG/BSbhzeGXWOdPyijaChKD6WPML7ucYhq6b1SCC7Y2M4cn3tmvL
	CZusNnUfdNUGyQUVjHiwletbL1xxkWEJdnhvGi6d2RhwLG+UTiMcpQhLumUNZpyFSdjcyMjOu6y
	L9tDHMKBJCez8xzkRAwmBZXG/veb1cMURJu1JHehex6Ry8fHUaB3FT8lMvY7sElxljQexifsESA
	3FQX1CEODaILohLwHss66Ul+pK3uo/64mQVZEkf0YKQdMURyNIZr50qIOOznJK+5BR9govlaqf0
	GwWdZVIKU7aNoyIfezs4zBoYoJHgthEW/JkDJ2I5UQSCdAkl2mVe/vjDg4U8llfh+Toe8po1Pw+
	85eW2ZTVF6foCzcSyzeob+LiW9pej5lWrA1CXPBVG9Yu1nZKdWf2qymBrMTLwA4enpw5ZEVtUW+
	k6naa5LLiaSCbUTBAV0KauVhMM9PN1LTEs0AYGj+pteKgi5s3Rv7rqPWiFt+H0/wSSxUU/I3r+T
	PkvFQ==
X-Received: by 2002:a17:907:3faa:b0:bae:d29c:4e28 with SMTP id a640c23a62f3a-bdc12aa6420mr10795366b.12.1779317838922;
        Wed, 20 May 2026 15:57:18 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ded99dsm903754266b.30.2026.05.20.15.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:57:18 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3] Bluetooth: HIDP: fix missing length checks in hidp_input_report()
Date: Wed, 20 May 2026 18:56:43 -0400
Message-ID: <20260520225643.35683-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CABBYNZ+Oc=LU6d8_xK9_a9yk-TFyaE=0KsNvAwKbNZVs1EJpWg@mail.gmail.com>
References: <CABBYNZ+Oc=LU6d8_xK9_a9yk-TFyaE=0KsNvAwKbNZVs1EJpWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253403-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2A32159C83D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hidp_input_report() reads keyboard and mouse payload data from an skb
without first verifying that skb->len contains enough data.

hidp_recv_intr_frame() pulls the 1-byte HIDP header before dispatching
to hidp_input_report(). If a paired device sends a truncated packet,
the handler reads beyond the valid skb data, resulting in an
out-of-bounds read of skb data. The OOB bytes may be interpreted as
phantom key presses or spurious mouse movement.

Replace the open-coded length tracking and pointer arithmetic with
skb_pull_data() calls. skb_pull_data() returns NULL if the requested
bytes are not present, eliminating the need for a manual size variable
and the separate skb->len guard.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
v3:
 - Replace manual length checks and pointer arithmetic with
   skb_pull_data() per Luiz's review
v2:
 - Add Cc: stable@vger.kernel.org per Greg KH's note
---
 net/bluetooth/hidp/core.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 976f91eeb..70344bd32 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -179,12 +179,21 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 {
 	struct input_dev *dev = session->input;
 	unsigned char *keys = session->keys;
-	unsigned char *udata = skb->data + 1;
-	signed char *sdata = skb->data + 1;
-	int i, size = skb->len - 1;
+	unsigned char *udata;
+	signed char *sdata;
+	u8 *hdr;
+	int i;
+
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		return;
 
-	switch (skb->data[0]) {
+	switch (*hdr) {
 	case 0x01:	/* Keyboard report */
+		udata = skb_pull_data(skb, 8);
+		if (!udata)
+			break;
+
 		for (i = 0; i < 8; i++)
 			input_report_key(dev, hidp_keycode[i + 224], (udata[0] >> i) & 1);
 
@@ -213,6 +222,10 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		break;
 
 	case 0x02:	/* Mouse report */
+		sdata = skb_pull_data(skb, 3);
+		if (!sdata)
+			break;
+
 		input_report_key(dev, BTN_LEFT,   sdata[0] & 0x01);
 		input_report_key(dev, BTN_RIGHT,  sdata[0] & 0x02);
 		input_report_key(dev, BTN_MIDDLE, sdata[0] & 0x04);
@@ -222,7 +235,7 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		input_report_rel(dev, REL_X, sdata[1]);
 		input_report_rel(dev, REL_Y, sdata[2]);
 
-		if (size > 3)
+		if (skb->len > 0)
 			input_report_rel(dev, REL_WHEEL, sdata[3]);
 		break;
 	}
-- 
2.54.0


