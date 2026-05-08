Return-Path: <stable+bounces-244707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFYNKX+k/Wl0ggAAu9opvQ
	(envelope-from <stable+bounces-244707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:53:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ADA4F3EB0
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13BC33016CD4
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522535CB9C;
	Fri,  8 May 2026 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViV0FGD9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2EB2D97B5
	for <stable@vger.kernel.org>; Fri,  8 May 2026 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230396; cv=none; b=N23JgDMiSd/C38HE2ewgsg8LGfQkmAv+4ypsY63rYyjyJ9Hyu2DUBMXUZ4hFKxjWRTNnq3yTKcpGcEjtg/u2TkwA6Cj7pWvgdw4PeWkWDgER0ydHNd+am2WtGfnfH1T/bFwJSlYU+aeYh9S9vCgKIoCGyXCsapU4UuYk5w+yAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230396; c=relaxed/simple;
	bh=c9epRKiYhaGspONM8KWKVGgkg5mJffga5eNI3KZzYj0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qlcXinMhmt2DsUQm4SwFq4wro1tdDmLTyl44MHb+YH6HPjvSt6zUz32v1y6lD5ffVruRP8um7KTsWmylG91798Om55H3ZyiAWWTNitgVZ6877uny4fjH55iC+zFCpPE9mLe8NAS5QeUEPzLskprRdDGzq1ChU+x2PeRiSaZYC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViV0FGD9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83945063f70so1300445b3a.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778230394; x=1778835194; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ri1HIxFfdPDhQYTOtlv8tdzoC5QvHDL1O0z7T1+MFXM=;
        b=ViV0FGD9Jl9zN1VC2sxfiKgJDTZAQH+EeUHFY7VqHkh3RTGkIA9/IqVWl7+HNlvu4a
         D2rsBSJqpqcaTKH+m6fAaiByJltEDc6kNLOBv53Sk2NT902a9bnCuP1zDKmP+pMeEDd1
         VdDu+mfSUAydowKbGOxVuJxhY3Sopn/QhKLoZmbW1oa2YirsxlwDm6gKxuQKA7425WuD
         KXhIp8anio9ZYqkTJGpAnHwK8zs8c/mJHTocnf61vGCJgStZD1PxoB04+wY2XO37Euz8
         sYYbcFal24QnjHSmEQ/P5avjVm1xA7l008X1PgCez8XbUl6sj71wk1fawjex6O4IULXv
         rlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778230394; x=1778835194;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri1HIxFfdPDhQYTOtlv8tdzoC5QvHDL1O0z7T1+MFXM=;
        b=RZ/8vdtJ++SqQ/AVuXCExl+217VK0067w17ehuelauO2LFhdLxGPMvWx6ioZb3ikiO
         znbwGEvgUWUeNJwkiq/66xw+13OKQZ5RHnNK8+X1VXh6b2+Wsdun5/LJQMHcgRllbLxV
         BOR7Fs3Qg7S+kgKYpfccjWoevLlDcHJVfNqA81IHu2RbkWg/xLsZ+OJm0LD+KCVl3S9F
         iSO5clZe5gMGVJl5nkXXQpEkykrIVpWY3ZFCOJ0URNQOAQQ8+056AyCMdwVbn1y7NdgX
         BEYs+IKlmNM/7WHlmqeave2OmMQLoSAwgGsBhM/LHOleKdwJGhR+8YjB28PIknNSrAhS
         /+rA==
X-Forwarded-Encrypted: i=1; AFNElJ+JnXxWp1WplvhYhP+2XgJt1eM4Pa4PpPKvd0/AuNY2tllI3RnVKuYNhSvhVVFkKWzzz9br25k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtoe6DvqgLHe6/j7MVUuUYO0M5aM1PS7rTvgHzibJKKCJt13Az
	tcfMYC6qv/MEIaPZgXqvPAQsrYUz5ynHA9eon9EPvJKIIxjCOU690w/r04ktiF+p
X-Gm-Gg: AeBDieveECJ93ar3YYkvfADsleCPEpjQF+U9zo06fa/U4xvF1qKcDaCGF52KibnWkag
	XWLaxhXTD2eSEVkQN/ekIzAPmdr2+89DHRLdyUO1iownj+scuOuHeJ4ZYw2GyBcQTWlmzgsjlUh
	Bnv9XKoajRIqJGuK6654S0zW7V+FmhrQ5rwIVsoVk06KgLtMOjYzXsPv5bc+vBYZwgd11rFM+PQ
	o2AbZbPW+enpQu2hZnPoPA/TgZU/cmneziCUnCX6S2DeknDrvAuwdOw6M5SwM8T6r1rEpRxxRb1
	64inVsZVyJk2BG+mLfU8GagqZoDdDmEBzBCznkzsjuMzfrSVdoElwSqWgo0XTEfyt52cAVZ8f0M
	qRov5tx2xlFryRoja18yDV+booS3kRyqavwKwzOuN8uaZeVWZd7f+znhv+l9HBg34i3DqhGSmV7
	7Ld/MwRSB+cQZDdog12m5liihwg3itBMN+WrRR50cWOds=
X-Received: by 2002:a05:6a00:3e1a:b0:835:36f5:17c9 with SMTP id d2e1a72fcca58-83bb65f38bfmr5369559b3a.2.1778230393951;
        Fri, 08 May 2026 01:53:13 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f03bsm11851171b3a.9.2026.05.08.01.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:53:13 -0700 (PDT)
Date: Fri, 8 May 2026 17:53:09 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, qingfang.deng@linux.dev, jiayuan.chen@linux.dev
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when paged
 frags are present
Message-ID: <af2kdW2F1gJ9U-Gg@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 47ADA4F3EB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244707-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
handler in rxrpc_verify_response() copy the skb to a linear one before
calling into the security ops only when skb_cloned() is true.  An skb
that is not cloned but still carries externally-owned paged fragments
(e.g. SKBFL_SHARED_FRAG set by splice() into a UDP socket via
__ip_append_data, or a chained skb_has_frag_list()) falls through to
the in-place decryption path, which binds the frag pages directly into
the AEAD/skcipher SGL via skb_to_sgvec().

Extend the gate to also unshare when skb_has_frag_list() or
skb_has_shared_frag() is true.  This catches the splice-loopback vector
and other externally-shared frag sources while preserving the
zero-copy fast path for skbs whose frags are kernel-private (e.g. NIC
page_pool RX, GRO).  The OOM/trace handling already in place is reused.

Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v3:
- Use skb_has_frag_list() || skb_has_shared_frag() instead of skb_is_nonlinear()
- v2: https://lore.kernel.org/all/af2F1FU5d4Q_Gn1W@v4bel/
Changes in v2:
- Use skb_is_nonlinear() instead of skb->data_len
- v1: https://lore.kernel.org/all/afKV2zGR6rrelPC7@v4bel/
---
 net/rxrpc/call_event.c | 4 +++-
 net/rxrpc/conn_event.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index fdd683261226..2b19b252225e 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -334,7 +334,9 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 
 			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
 			    sp->hdr.securityIndex != 0 &&
-			    skb_cloned(skb)) {
+			    (skb_cloned(skb) ||
+			     skb_has_frag_list(skb) ||
+			     skb_has_shared_frag(skb))) {
 				/* Unshare the packet so that it can be
 				 * modified by in-place decryption.
 				 */
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index a2130d25aaa9..442414d90ba1 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -245,7 +245,8 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
 {
 	int ret;
 
-	if (skb_cloned(skb)) {
+	if (skb_cloned(skb) || skb_has_frag_list(skb) ||
+	    skb_has_shared_frag(skb)) {
 		/* Copy the packet if shared so that we can do in-place
 		 * decryption.
 		 */
-- 
2.43.0


