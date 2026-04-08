Return-Path: <stable+bounces-233953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKyJHqGQ1mmiGQgAu9opvQ
	(envelope-from <stable+bounces-233953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:30:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ECA3BF928
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2463530848AC
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D323D7D88;
	Wed,  8 Apr 2026 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QkD+sc7Z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u9V63QLt"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D63D75B4;
	Wed,  8 Apr 2026 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669171; cv=none; b=ZAkmHiD3olWZkZccSRq0m7EaI6JFvuIMfsHhbe3r0A/DaQdKlHQesRY/E+B09KJLMOvPjEUBa9e0OjuY8AKhoUUKz3RMj5A4xVlgrp4poSDOvHxK6e9Fx6eAGUXsbq1QVw/18IaZAn+ICtBoOqt0EcHhVg1cR8jDr1W9TS/kWv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669171; c=relaxed/simple;
	bh=HXv6Qfyh/87ciXBdlWLxEEivSqZv3G8fmPWNM5DrNmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DlkoEFXU0UvNbOypE+BIy8RPmZ94ik/geUD+Kl7LAe4a47394m93jCDgvsNFhD0Dxa36KTSb/ePZIEgV+7Xt4gpetLWF7qsJVtGbCY+x/5iqL/jXyX7oksA+ZumjLXZjUIsI4W5UW2iY3yIvTEpcpmaWfOIR9rZD+U6QAm+VeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QkD+sc7Z; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=u9V63QLt; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4frVN04DktzB11B;
	Wed,  8 Apr 2026 19:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775669168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kBwy39yOFjCmmlrsUB/j5yUVYN7ZkTMndF/TwEehldI=;
	b=QkD+sc7ZPfXsS36W74FQWd9xekYqmT4AlQ4+57k2f+ajbhGKWKkW3jZH5pyEwC+U4SilR1
	K4xkrrOq7xwN9+Qspk6KBn/nXPzOtYAOZOciXAvG4YZHa6ZiANkQkArika+Y1cEULUBIfh
	hpasw8I0f56qnJAzbshWUQK85HQA3adANZqwegiERxUm6ZMcoyZhN9HtML3cUrXOQGln8n
	H3KH3DDP1GKdtB0YOUCNxQJCMjpzG4TU3ap0EFnZZCBv4mYMrUhhuz3ifjWaGAYlaATrWu
	iuTGCjOAI1/8+q0+uaUDsybcSZVA7lXyLhPcJKgxI2Zn/vkbMJ1KWP2+7knoyQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=u9V63QLt;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775669167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kBwy39yOFjCmmlrsUB/j5yUVYN7ZkTMndF/TwEehldI=;
	b=u9V63QLtdxQwqYCy2NE0xeaUt2WxuDZalAFCnm1QY1k7XoBVfs+bYElhOLhEBnvq9EYLWT
	wA5tkAUqmkb5AG083kBKYo6mssjiXak9FVlO3u+UB6NEBc3IjMq4tkXm1Qmw3/V9muUhLO
	RKqdMYmmNAQT9oAgdA3jS/u8KpoAnfsdS65zpknG678Cazto37F9lxJc04d5U2i6Bz5Kze
	2w5+Ro9T6YQxJO9yKsfwb3vJm9zGSey4AC5Di7ZRGdXKwvGp8pY03oxfGJxdx7MB5eV5PF
	cMvdVTms8HbmobxqoYSl60G53OShdtE3l8LaWTnU02ucakcP+XJ4Kt1vkc6W3g==
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH net] net: rose: reject truncated CLEAR_REQUEST frames in state machines
Date: Thu,  9 Apr 2026 01:25:51 +0800
Message-ID: <20260408172551.281486-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p6d5zapacght43tfqwyp69uausasrq4s
X-MBO-RS-ID: 46b22fe8c2e2875f4c0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233953-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid]
X-Rspamd-Queue-Id: 30ECA3BF928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All five ROSE state machines (states 1-5) handle ROSE_CLEAR_REQUEST
by reading the cause and diagnostic bytes directly from skb->data[3]
and skb->data[4] without verifying that the frame is long enough:

  rose_disconnect(sk, ..., skb->data[3], skb->data[4]);

The entry-point check in rose_route_frame() only enforces
ROSE_MIN_LEN (3 bytes), so a remote peer on a ROSE network can
send a syntactically valid but truncated CLEAR_REQUEST (3 or 4
bytes) while a connection is open in any state.  Processing such a
frame causes a one- or two-byte out-of-bounds read past the skb
data, leaking uninitialized heap content as the cause/diagnostic
values returned to user space via getsockopt(ROSE_GETCAUSE).

Add a single length check at the rose_process_rx_frame() dispatch
point, before any state machine is entered, to drop frames that
carry the CLEAR_REQUEST type code but are too short to contain the
required cause and diagnostic fields.

Cc: stable@vger.kernel.org
Cc: linux-hams@vger.kernel.org
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 net/rose/rose_in.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
index 0276b393f0e530..e2680058196273 100644
--- a/net/rose/rose_in.c
+++ b/net/rose/rose_in.c
@@ -271,6 +271,13 @@ int rose_process_rx_frame(struct sock *sk, struct sk_buff *skb)
 
 	frametype = rose_decode(skb, &ns, &nr, &q, &d, &m);
 
+	/*
+	 * ROSE_CLEAR_REQUEST carries cause and diagnostic in bytes 3..4.
+	 * Reject a malformed frame that is too short to contain them.
+	 */
+	if (frametype == ROSE_CLEAR_REQUEST && skb->len < 5)
+		return 0;
+
 	switch (rose->state) {
 	case ROSE_STATE_1:
 		queued = rose_state1_machine(sk, skb, frametype);
-- 
2.53.0


