Return-Path: <stable+bounces-238017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHa1CDEF32lLNwAAu9opvQ
	(envelope-from <stable+bounces-238017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:25:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA53FFF98
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F33330880B7
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B82318BB8;
	Wed, 15 Apr 2026 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innora.ai header.i=@innora.ai header.b="hr+eH8YW"
X-Original-To: stable@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9852D838E;
	Wed, 15 Apr 2026 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223415; cv=none; b=eiFPoB5Eg2zwTe7tNbs1R6/9BKIXztJBOkNdarfS5u7//WMclx/5WbkZhA8ERj78PkQQ679orD8eHY4vvG9IHsSCAIbEGijIwGHs0MSxfptjKFh/+YrR5g9reAOHYP/2G1RZn7ZwgRvj4yIHILtB9i7jM8bD8DIkyp7r959NbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223415; c=relaxed/simple;
	bh=79NnhI7bCDmrrvdPYqDMbIEhlBfu3SM9O4PlX8ZvELM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHozMMbxpk36ClB8+P4FnY9dJ04fhvW2Ha90M8fsIy/plFq2gIIfPzmrb7FSagvWfLFIDShmcEIxAHWo2BPVI0/OUGe0ZUma0uNkqOmBU/JzEqHKKy9+WDOCOh/Mh5ljDCaiySGrJ1bIs2De1YAh9YtEP3w3As6IktXlk1VlU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai; spf=pass smtp.mailfrom=innora.ai; dkim=pass (2048-bit key) header.d=innora.ai header.i=@innora.ai header.b=hr+eH8YW; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innora.ai
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innora.ai;
	s=protonmail2; t=1776223410; x=1776482610;
	bh=79NnhI7bCDmrrvdPYqDMbIEhlBfu3SM9O4PlX8ZvELM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hr+eH8YWvlTx+v+v3B+FwTHcXdeUMshnDgbjtgyFc7pfgI0eoL9veDIE9vP0zrjgV
	 4f+Pw6EPG8LvadtHhF/n21OOplJOBfxJEf7q16HXnCRl2W0Hd9NXVEJBvxhwenhmMl
	 9Jo1bCQI3izu6EehYxjiLRlOQXn7Xk/65Qc7Pqx+hkasLQutmHiMOL8hBnM/xu0VWJ
	 jv8qbzHSTcx3fYpcRNaV1OAx/oV6dgkAb71W54b462O6NFLvRl+ZSH44PT+ou76g1C
	 JiiN/+A08GMICzQLEx4en1RwoDq/OuggCO4rm7AE9j9gDK2Q2Qn9jyBYGvuFyAjYeo
	 5lLUKOTpPaBCA==
Date: Wed, 15 Apr 2026 03:23:24 +0000
To: linux-bluetooth@vger.kernel.org
From: Feng Ning <feng@innora.ai>
Cc: linux-kernel@vger.kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com, Feng Ning <feng@innora.ai>, stable@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix ECRED reconf rsp channel teardown race
Message-ID: <20260415032318.78543-1-feng@innora.ai>
In-Reply-To: <20260415004725.39215-1-feng@innora.ai>
References: <20260413044730.86315-1-feng@innora.ai> <20260415004725.39215-1-feng@innora.ai>
Feedback-ID: 140578448:user:proton
X-Pm-Message-ID: f3e83abcf2bacc3f195dc8187ed706236a2c5589
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[innora.ai,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[innora.ai:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,innora.ai];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238017-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[feng@innora.ai,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[innora.ai:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,innora.ai:email,innora.ai:dkim,innora.ai:mid]
X-Rspamd-Queue-Id: 77AA53FFF98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ECRED reconfiguration response tears down all channels that were part
of a failed procedure. The handler iterates over conn->chan_l while
holding conn->lock but l2cap_chan_hold() is called without first checking
whether the reference count has already reached zero. A concurrent path
(socket close, timer expiry) may drop the final reference outside
conn->lock, causing a use-after-free when the response is handled.

Replace l2cap_chan_hold() with l2cap_chan_hold_unless_zero() so that
channels whose reference count has already been dropped are skipped
safely. Add lockdep_assert_held(&conn->lock) to document the calling
requirements.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credi=
t Based Mode")
Cc: stable@vger.kernel.org # v5.7+
Signed-off-by: Feng Ning <feng@innora.ai>
---
 net/bluetooth/l2cap_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 77dec104a..191c38b4d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5466,6 +5466,8 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap=
_conn *conn,
=20
 =09BT_DBG("result 0x%4.4x", result);
=20
+=09lockdep_assert_held(&conn->lock);
+
 =09if (!result)
 =09=09return 0;
=20
@@ -5473,7 +5475,9 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap=
_conn *conn,
 =09=09if (chan->ident !=3D cmd->ident)
 =09=09=09continue;
=20
-=09=09l2cap_chan_hold(chan);
+=09=09if (!l2cap_chan_hold_unless_zero(chan))
+=09=09=09continue;
+
 =09=09l2cap_chan_lock(chan);
=20
 =09=09l2cap_chan_del(chan, ECONNRESET);
--=20
2.49.0



