Return-Path: <stable+bounces-273540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5DK/BR9QVGoSkgMAu9opvQ
	(envelope-from <stable+bounces-273540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 04:40:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E4746B3A
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 04:40:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273540-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273540-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56CC73055415
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 02:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7F035E1A9;
	Mon, 13 Jul 2026 02:34:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF13446C9;
	Mon, 13 Jul 2026 02:34:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910096; cv=none; b=lxZUjj9Z3DF4GeDF620BJZgofpuMvI8EfgO1cIxC65KbXADLmUNrEr/gBExK9pC9F+6Kk4qn5c5E7ZvlJMeBbm24pvWQuCboKXzBIHXbVP2LLIa1ikXy9UC+2wFN1Ftuvd3vD4yjJkLGdHmkHrFEnsBvuLE4w6k1lvAUFcg7sDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910096; c=relaxed/simple;
	bh=yCyzcjYOyBP6A69t64DraS4e5KLQJrhICUQotuZY/1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B+6DgIlSyVRGW6SBefJrXZXIKAOnro6tZfQD8eI7CTSCvamNlpkwYxfsZHBClc2LzYjsVq96QIsY3EEIxt8mGc1K/aLWOmiudj+rqkkpJyl2lSskkUnvR8AQrixIvGo39jMB5nyFhpHWOvNaoxDcEKa7HJc/IfLrTTegzNTMPok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 654535d27e6311f1aa26b74ffac11d73-20260713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7c16dff9-2e78-4b10-9674-d07c9c0f24ef,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e9c765c3a093e1f715bd5f72e70f1ee9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 654535d27e6311f1aa26b74ffac11d73-20260713
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1671177437; Mon, 13 Jul 2026 10:34:39 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drbd: reject out-of-range sizes when draining data
Date: Mon, 13 Jul 2026 10:34:34 +0800
Message-Id: <20260713023434.288279-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273540-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lilinmao@kylinos.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:philipp.reisner@linbit.com,m:lars.ellenberg@linbit.com,m:christoph.boehmwalder@linbit.com,m:axboe@kernel.dk,m:drbd-dev@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lilinmao@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lilinmao@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 564E4746B3A

drbd_drain_block() receives the peer-provided payload size through a
signed int argument. A wire length above INT_MAX therefore becomes
negative. The receive loop still runs, converts the negative result of
min_t() to an unsigned length, and may receive more than the single
allocated page can hold.

Commit bd910a7660d2 ("drbd: reject data replies with an out-of-range
payload size") addressed the same issue in recv_dless_read(), but the
error paths which discard payload data still use drbd_drain_block().

Reject negative sizes before allocating and mapping the temporary page.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/block/drbd/drbd_receiver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a8..38721afa0006 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1772,6 +1772,11 @@ static int drbd_drain_block(struct drbd_peer_device *peer_device, int data_size)
 	int err = 0;
 	void *data;
 
+	if (data_size < 0) {
+		drbd_err(peer_device, "Invalid data block size\n");
+		return -EIO;
+	}
+
 	if (!data_size)
 		return 0;
 
-- 
2.25.1


