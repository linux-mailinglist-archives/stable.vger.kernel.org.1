Return-Path: <stable+bounces-235298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJtPEooU12kSKwgAu9opvQ
	(envelope-from <stable+bounces-235298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 04:52:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7EF3C5BCD
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 04:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54D3C301E3E5
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 02:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C136AB72;
	Thu,  9 Apr 2026 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G60PAVWB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YaK8ZsWs"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38EF28686;
	Thu,  9 Apr 2026 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703049; cv=none; b=WwNQgbkTI2OqKODtcSXOf8HBUZsz+IQP2zSMfN92Bv+SbTDjjy8udrNc7sr870+3pwPxTOWYlEO/sjxVoltMphZS1WQaHRIi7w3f9HQmjKKjig64P9bQxrRpEjCVi7ckf/eu0nVWuRZ/DpHuyVRoDIMt4CVznvsv14LuhhRtNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703049; c=relaxed/simple;
	bh=5J5ZO6fBKGSx8kRLsewuIHgetXG4DNnuNKeDnEdeSL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J6cQP3XWUQwNRVLusYwfmGIlf/BcYvv5h4qkf+dqVzCH72qBSFCsC4iNhvjTqACZLl5MuhcsUfMrQWP0jkNbcNNVwx4IY6b3cVEQvQdYfEvmEFBhc7wp7QrZA0+kNF3DcDEg1O8kk8wwDgxZALarAuXNzCI4nxjd01JMK5u1oCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=G60PAVWB; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YaK8ZsWs; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4frkvV17YzzB12V;
	Thu,  9 Apr 2026 04:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775703046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pffMbmSi5wWfzvmmZ19zBe3ASxdB2Pb24bLa/ZO63cc=;
	b=G60PAVWB3rClMPUhUvDATFIeEh/6a7M2W3xxyTpXiSQRNtSedWXDdMALE93vjyzhgeFPqa
	1ka/WBaO3K+Pra0mo62yblLLQyBRLHuFAG4hY85L1BovUvRh8RcxTRXta9XPRhmo7fJcEk
	QHen7Hxb8WCfuqkPP7lJF2Ix+VsNkhmWzBihZccXHOa+JkQ3w0QRNLJ+wmEgvO82ej7N0x
	X5wEndRXaMdNTIFauPbSeaUOVJWVfhjjGhUtDgT4aeq7O7ithWMemV73Weagsq+NuLyDsZ
	UGavlouYcnhVFrTJrqaxLzN7u3N1uds/lAfoY/dShTeaRI+DtnCF3kBJB0IOLg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=YaK8ZsWs;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775703044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pffMbmSi5wWfzvmmZ19zBe3ASxdB2Pb24bLa/ZO63cc=;
	b=YaK8ZsWs+GlKI8nrLchTNB+pHwLAAgMMHDUP9oaM7X3I2WWwFT17fW3m7d9tp+Nl6YZbHh
	mU0lETsHpZtbMTNfVoo7NI7QxdxO2tGRGfu5cJSqGzXZMatKEDvJHrA5ktpv0kcAddNR6G
	w33mj9etJJEhaSYwxFW5Z4kdSE8Acrcs46P3mcm2YByVD2zoxB9URCtzmN1OjZainoeiOZ
	56ga7f0bCpQeiRsLSiqV7P4e1VDZXkt9uVmg75C2iaGK0VFenftYF5knKbviY7JD400ZI1
	MBRHUDnoiNzGqM0vFpgeguqO1NIw3vQ06ZIPPwPdYCzULeJQjhKnWonmEbdI4A==
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
Subject: [PATCH v2 net] net: ax25: fix integer overflow in ax25_rx_fragment()
Date: Thu,  9 Apr 2026 10:50:26 +0800
Message-ID: <20260409025026.24575-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 35ib8kudtt1jz7rqdyz1rkbsa6k8ye6u
X-MBO-RS-ID: 5f4dc865e5cefd5ceb9
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235298-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yaina.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid]
X-Rspamd-Queue-Id: DB7EF3C5BCD
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
With AX.25 segment numbers limited to 7 bits (max 127 continuation
fragments), a fragment payload of ~516 bytes per fragment is
sufficient to overflow.

Fix mirrors the identical bug fixed in NET/ROM (nr_in.c): check for
overflow before adding skb->len to fraglen, and abort fragment
reassembly cleanly if the limit would be exceeded.

Cc: stable@vger.kernel.org
Cc: linux-hams@vger.kernel.org
Acked-by: Joerg Reuter <jreuter@yaina.de>
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


