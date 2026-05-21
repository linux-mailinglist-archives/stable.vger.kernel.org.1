Return-Path: <stable+bounces-253426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEfpMm9rDmob+gUAu9opvQ
	(envelope-from <stable+bounces-253426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 04:18:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C8359DFC4
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 04:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEDA9303E2C7
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067E30EF80;
	Thu, 21 May 2026 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="VArRJ4uR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GFM4Sm3S"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5428466F;
	Thu, 21 May 2026 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329601; cv=none; b=Vem6qvpy91QQOH5J5aEj/Ox84OSaLpsTL2QfC/q82w+d+Kuxw06TUxTTuWcFnluebUxj2RHr7hZsK/FnC6QxgdcJp/HK1UOy/uBpXJaAfuwCkpUTFueyyNi5dVmcbzH2CHTTQ8IbRB13RrEXxOjdOr9He43c2EUbniHYBPNy7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329601; c=relaxed/simple;
	bh=g8mUTIwdiEHd46G/JW+yaKTd0VlwlN3y9tRC7Ca8Aiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByeqSpe0tbAf4qtzWPFSkcKMkPjfJub7gNr6qkSDIF9p8xIRLz4tg3YlsP1eaqHJ7T59EuaMQW+iEhLzdm19CzcdH4SQiRpnmO0zjDrA20rX/Z/MHhJFt2h9rDRrUFvd/g6lQVh/R7eq2P3AJN0jWjX59+wTNw3lo2xK16yB/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=VArRJ4uR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GFM4Sm3S; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C8D11400077;
	Wed, 20 May 2026 22:13:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 22:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779329598; x=
	1779415998; bh=g0lv0Hzofa8+PjIMDt5oMg0YxY+z8T4VJvkwbW2gweI=; b=V
	ArRJ4uRYrDrBXklNJhe8NVmaQ63M8L37JWhWUqjXyisoboXPM4Tfiw3ZwhIdGe2D
	WsHlMMFoERXzCWtbxSbx5n3NkgzOOciW0OnZprnCvjXBHTQYARtEKFZpeA4Vun9i
	CRrdu86HxkhD6Raw9ycYElSNSXzFMQCYlSg0RRof9TM3oRNfxfE5y7CQ+lwV5u0h
	CDF5XXFNu/RPwpuYzB/SR6xdkgOISP6nfgQbi3xNIWJllswDdiVROEfGZcXgLFcr
	HDboUUD207YZThSq4VlRUlW1fKPbtrrrVPz4RAIFaOQPN37wUlqBjiKnGAEo2gq3
	ajk8qtRf9laoqDFLpIesQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779329598; x=1779415998; bh=g
	0lv0Hzofa8+PjIMDt5oMg0YxY+z8T4VJvkwbW2gweI=; b=GFM4Sm3SR3gz02dj3
	v8bdvLv7rMA29iHog6TfTYqavf7L2A5FC/gHCT7xx7CqS3yR0hZIkKKSIG3xn5Bc
	GxQ7mxjNdBRI8NqLxwT9ktajYx3pEA8U+MySUTA7s8asa6v2K4uZV+0F5IkcGdCJ
	Z+uwf9rOxj0kQ1Ryr1uoneYiV+cVmtgAtCD5YncujCzZoZRvHw+o02MhC99GskqK
	rnY+vLUCWdLJVQ9Bhj9C6J4PXxIro5O3bvnY2TU1D2fUMgV7h64reBwqnNPoF7PA
	EOW+yrDyxflQGDxriQXAYnfzrqHCdG9fn2/4K3fGxBUREwutGatIxc9g4m9dxDix
	J6zTg==
X-ME-Sender: <xms:PmoOarfWBbks_tno8oB-EuEo51vfmOEqd9nCQnE0TjRKQViIS5GjEA>
    <xme:PmoOaisAui5wRVKE77IAHJDTXXYu66U4ChnlPpVAFPRWydX2ct4rlagSicgJlvWW2
    j0aV-5A1CvldpnWFE2V-RwNfE9Guko1ERBEaYWvxDUbAwMzpuZqKo4R>
X-ME-Received: <xmr:PmoOaklxEqg1mM991D8HpJJ6HM00M3kpty-dzN8N5najE2xm_e5T6kcw82OqYe8axzpD5vs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuihifvghiucgkhhgrnhhguceo
    ohhsshesfhhouhhrughimhdrgiihiieqnecuggftrfgrthhtvghrnhepkedtleeiteevue
    etudevjeefheejueevffejteffvdehlefftdffleegleduvdfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhsshesfhhouhhrughimhdrgi
    ihiidpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    lhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehsrghf
    rgdrkhgrrhgrkhhushesshgvtghunhhnihigrdgtohhmpdhrtghpthhtohepshhtrggslh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsshesfhhouhhrughi
    mhdrgiihii
X-ME-Proxy: <xmx:PmoOaswr6uLYS-5DxW7ooD11UKY6EaqESpOeNSCaljLcaxq9cTVOcA>
    <xmx:PmoOauM1V5_qIEf1ezR9WpVB2RH5u0qKEL-ADu8jrl_2f8qb-NMX8A>
    <xmx:PmoOagolQbFJ9zw4iusskQMvWTUw23GkYNWcou4jxqWMbP4bTsCt6g>
    <xmx:PmoOavEb_xntPVIfZ8KaoKatD9pyUVwB_Ew-rjYE8CHGVwKYdFFxyw>
    <xmx:PmoOavJLAKGWEICFHceO_dyjkJ2CNb2acAD7cO4dDthqt5Msjzwe5qw3>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 22:13:18 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	safa.karakus@secunnix.com,
	stable@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v2] Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
Date: Wed, 20 May 2026 22:12:20 -0400
Message-ID: <20260521021249.3258069-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CABBYNZJiCTJrde9rYT=NQAk_RUv=ugeAUPnRg6vsjvU5hW4NqQ@mail.gmail.com>
References: <CABBYNZJiCTJrde9rYT=NQAk_RUv=ugeAUPnRg6vsjvU5hW4NqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,secunnix.com,vger.kernel.org,fourdim.xyz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253426-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oss@fourdim.xyz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fourdim.xyz:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fourdim.xyz:email,fourdim.xyz:mid,fourdim.xyz:dkim]
X-Rspamd-Queue-Id: 31C8359DFC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

l2cap_chan_close() removes the channel from conn->chan_l, which
must be done under conn->lock.  cleanup_listen() runs under the
parent sk_lock, so acquiring conn->lock would invert the
established conn->lock -> chan->lock -> sk_lock order.

Instead of calling l2cap_chan_close() directly, schedule
l2cap_chan_timeout with delay 0 to close the channel
asynchronously.  The timeout handler already acquires conn->lock
and chan->lock in the correct order.

The timer is only armed when chan->conn is still set: if it is
already NULL, l2cap_conn_del() has already processed this channel
(l2cap_chan_del + l2cap_sock_teardown_cb + l2cap_sock_close_cb),
so there is nothing left to do.  If l2cap_conn_del() races in
after the timer is armed, __clear_chan_timer() inside
l2cap_chan_del() cancels it; if the timer has already fired, the
handler returns harmlessly because chan->conn was cleared.

Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
Cc: <stable@vger.kernel.org> # 0b58004: Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_sock.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4ed745a9c2cf..025329636353 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1512,6 +1512,10 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	 * pin it (hold_unless_zero() additionally skips a chan already past
 	 * its last reference).  We then drop the sk lock before taking
 	 * chan->lock, so sk and chan locks are never held together.
+	 *
+	 * Since we cannot call l2cap_chan_close() without conn->lock,
+	 * schedule l2cap_chan_timeout to close the channel; it already
+	 * acquires conn->lock -> chan->lock in the correct order.
 	 */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		struct l2cap_chan *chan;
@@ -1529,14 +1533,12 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 		       state_to_string(chan->state));
 
 		l2cap_chan_lock(chan);
-		__clear_chan_timer(chan);
-		l2cap_chan_close(chan, ECONNRESET);
-		/* l2cap_conn_del() may already have killed this socket
-		 * (it sets SOCK_DEAD); skip the duplicate to avoid a
-		 * double sock_put()/l2cap_chan_put().
+		/* Since we cannot call l2cap_chan_close() without
+		 * conn->lock, schedule its timer to trigger the close
+		 * and cleanup of this channel.
 		 */
-		if (!sock_flag(sk, SOCK_DEAD))
-			l2cap_sock_kill(sk);
+		if (chan->conn)
+			__set_chan_timer(chan, 0);
 		l2cap_chan_unlock(chan);
 
 		l2cap_chan_put(chan);
-- 
2.54.0


