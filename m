Return-Path: <stable+bounces-233952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMVgAGiQ1mmiGQgAu9opvQ
	(envelope-from <stable+bounces-233952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:29:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4373BF8F3
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75A813072E2E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2913D75DA;
	Wed,  8 Apr 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JZxKBpxI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gSwTV38M"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D23A8744;
	Wed,  8 Apr 2026 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669145; cv=none; b=KUluTBqzxhaYV0QI9fR+cJNp7402YQ8XBQYhM4bAnxDQ0PlRyhTrIdmHKcEV850IDG/oCOvPt3qa3c+4FvvBKkrEQkip97zVaGsAlzrm6ABJfenMekpAvbJAL5fVO59HggMlxg9GxVAsqCvUw0yO+Jmuam4CfNExhU9xgQ4meQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669145; c=relaxed/simple;
	bh=ot1KVTZnXZcUxJIpol/i2ytidhgDKLb91yaFFYtzrSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rNnCCQU5KKOyoH8Diddwr56zIeAhs2/ybwOffx5xls63JxUb68S3YPuSoqvuEBNucguJ5wmSkuRVCBMYABskho4tyCmRwKXg3y9I3KjPJPDk7cMZJGtXNSawX/IwA6o6ueDu7j1yG6403eoouapM4z54EoY+84J4CRMzYncLGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JZxKBpxI; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gSwTV38M; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4frVMV20WbzB11w;
	Wed,  8 Apr 2026 19:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775669142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kT13ZUtTLZv4hnmBJjWl4jvqjMLTj/qnsK+u4sO+FDo=;
	b=JZxKBpxIYXw4GFSbXeNM2/dx0ZhyMwqV6Ew5swpwqq8AOCghVEEoP3OjZlw647ZqDn7COA
	EyN6nWtaKDFc8w/BNnwW07bDs/AIefvbEnLcKxLaBYRE3t8nzr8GvsukzKawcRb8DF46ro
	1YX61AtEQhTSko0dbg6oKgl8o8dgbXwrSI84IaJUWH157TooMPfD02hJ5wMLZRZF85isTs
	uXsSQZc1v9NUAW4kDAV6M1ECL73j9uJnQRjsxCFEZve6LO/Szl0U4azdad8FnBe5uzHP6b
	GjCAxMgTlda7wwT12xrJQEK2HRQg/ir5qNMjhaDAt1l3eZZdYHBNflWG4tx0EQ==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775669140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kT13ZUtTLZv4hnmBJjWl4jvqjMLTj/qnsK+u4sO+FDo=;
	b=gSwTV38MH9GJJJHzK18+KV42orqZJH2G27KvzVDh0Yenc0wICroJ/A9SpyAkZBjEvQkuhI
	hHqMygSUwIt+rEkCK1+VMLBFy+ttwxCJGtAIbQsGaP/bLHNI+fOr3f+yxTeZU+sVQX6who
	zs5ndcnJQFVY73EGPHMBFgykchFNEN++T8l38vrAOG3I7SrYfkSJ88gFXrpoA3XqOtvpZW
	vSXIBisCSR4z60ya2o5ZdQbx9DW5Lr7itLMy+UVrF69k1n0fD6sf9/3wGfb+NNZfeSMzJq
	ui2mH/LaiXKkOTB8FTTAQ0hgHUeRTiqe5KZUQIy+AJw+HCEwJ63Y/SfxpIEajA==
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jreuter@yaina.de,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH net] net: ax25: fix integer overflow in ax25_rx_fragment()
Date: Thu,  9 Apr 2026 01:25:21 +0800
Message-ID: <20260408172521.281365-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ob97oaxaox1sbha7g397ai6mgwyxh754
X-MBO-RS-ID: 5f10e2ebca1b331472e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233952-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid]
X-Rspamd-Queue-Id: AC4373BF8F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ax25_cb fragmentation reassembly accumulator:

  ax25->fraglen += skb->len;

operates on the unsigned short field 'fraglen' declared in ax25_cb:

  unsigned short  paclen, fragno, fraglen;

When fragments accumulate with a combined payload exceeding 65535
bytes, fraglen wraps to near zero.  The subsequent allocation:

  skb = alloc_skb(AX25_MAX_HEADER_LEN + ax25->fraglen, GFP_ATOMIC);

then allocates a tiny buffer.  Every skb_put() call in the copy loop
that follows writes far beyond the allocated headroom, corrupting
the kernel heap.

An attacker on an AX.25 link that supports multi-fragment I-frames
(AX25_SEG_FIRST / AX25_SEG_REM mechanism) can trigger this by
sending enough continuation fragments to wrap the 16-bit counter.
With AX.25 segment numbers limited to 6 bits (max 63 continuation
fragments), a fragment payload of ~1040 bytes per fragment is
sufficient to overflow.

Fix mirrors the identical bug fixed in NET/ROM (nr_in.c): check for
overflow before adding skb->len to fraglen, and abort fragment
reassembly cleanly if the limit would be exceeded.

Cc: stable@vger.kernel.org
Cc: linux-hams@vger.kernel.org
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 net/ax25/ax25_in.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index d75b3e9ed93de8..68202c19b19e3f 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -41,6 +41,11 @@ static int ax25_rx_fragment(ax25_cb *ax25, struct sk_buff *skb)
 				/* Enqueue fragment */
 				ax25->fragno = *skb->data & AX25_SEG_REM;
 				skb_pull(skb, 1);	/* skip fragno */
+				if ((unsigned int)ax25->fraglen + skb->len > USHRT_MAX) {
+					skb_queue_purge(&ax25->frag_queue);
+					ax25->fragno = 0;
+					return 1;
+				}
 				ax25->fraglen += skb->len;
 				skb_queue_tail(&ax25->frag_queue, skb);
 
-- 
2.53.0


