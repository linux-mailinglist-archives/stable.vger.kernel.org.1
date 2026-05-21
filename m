Return-Path: <stable+bounces-253515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNuLHX34DmoSDwYAu9opvQ
	(envelope-from <stable+bounces-253515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:20:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A25A4AFE
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32182306885E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B413CC7F4;
	Thu, 21 May 2026 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEaG94iq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DCC3CF662
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365804; cv=none; b=a1TH2d7j/2Xg7vByJoccTkRDxor7/v9pkpK799Sbt5XPJ8IKyaqrzzy575MXn0hRe8xgdFu4HU/+8NgIBKIm1mhLY8MAqH2KkajZra+FktWGqtbo2YkgUtuNKgRyCxu+/6sb+gj7erCHNW1Y7V432ikUrEqbYXSCMt5BffG8gVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365804; c=relaxed/simple;
	bh=5or+4E41SL8THkCOjUNgbJumJMLhuYZOhSlFgnCa8cM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QplyxBj30lSgIc9Vlx1lx78XEg8sNZYMS9n62QB/R8lIuBYvWT+uj00eiBn30Hf3xliEkdF75pxEkDX/kjxb4idIW+3nBRwYQxKaGtmJh5agkw6+fmayBrhMfGRxzulq4MDCT3V4jBn++TGj0BZezVDwDGd2pVQayfdXJIkU8TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEaG94iq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36931e4f5e8so5213120a91.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779365802; x=1779970602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxP6h8dL5J030EST2E/d3Ecm7ut5abz34sAQXmwt+6s=;
        b=jEaG94iqo6YNvx1BYIjsaB89Jrw7KM4p87mkdLQojCjebIXrg8uZP1KDduWzQyCSXn
         2ElZWDUq/h/QnXjJoORaITBdbHJJpPC5yjTX2W1GyNvqO5jyJWHIEdVUK0Uq+MiR3J+v
         UyMmci5wzNu+MpveR+ZtkEKd38l/AjCZ9llTx6Xc7e3Xl/65I+fKd/veKYxM2GzmQirx
         tJfQnjv6pVK3quC3oKpyg/4lCTDHqMjNkgNrwFBS49FTk/xE1W2AB3cdyNqRf9/FviZH
         7UDQa7HT+aHIjraidA7R8Nr8Su6Ef0SjoSDH3iKhG0cc+xjWzyRRjQGpIywI64lorxSx
         QKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779365802; x=1779970602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxP6h8dL5J030EST2E/d3Ecm7ut5abz34sAQXmwt+6s=;
        b=pofv+3eCVHQG2UFXKG2aAYz5V2x2O2m6igrgPGTa2QjoVHxrVga4SXH2McDta1bzlG
         cw24cMbmkDNG8aKQebOmrufVNZT6cugH7o1mObisoXsWBOgAUQVlixswLFrsaa3U/6H1
         x03H3wOH+1Arvz2rnwlqTvvkRoiwZKjkIKUWhxYaji85t5vl5HzYK5j89r8TUnlHKoMN
         SspuHbeQB2T703bdezayst+vl1dosqkj5J1IbIaXoP0ma6czVj6e66638f1TSG45W6Pb
         ZHXMNV1tFqnQvbyByU1Y8sP5gJmWumwT/sonS8k1VdcCCUubs12k14FIxnn3i6ind3Wi
         VuQg==
X-Forwarded-Encrypted: i=1; AFNElJ9pTlM99ndd8bhw7HlKPNvYcYiY6cz/voOkqu2v/RrGIufL2lOzk+kfF1FNUyeHayAOViZFnG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPv3H9QOCJkoHF/kU97aSObCodrFqsdLR04pNwVGXZXbZe7lVm
	reDuvF5tA6+ErGbfpjYTXv3aBA90VVRT1V79P1JyxO8WDsj5saGIq6Ib
X-Gm-Gg: Acq92OFNLSoQkxN140TXZuSIMhZlF+ugE8IVTJ6+ngnsSVI9EbFz2KVA5z5cHmcYRLv
	G2tS4oaSI6nqeu2t6TcYqUK5WLZa/OM2Q4Y+KHSg/xbYsBPFEEe2KoCDPzIxGfBA+dBdg2olkyp
	RKddmUWpLQwQweU6ZgkLBDusfOt2aI8stEDINo75JOR9BQaP7rSdq8rXd/6Qrc1Y4dLlEFVmFkm
	B8UFrFlEVdXFpOZ3lJVVNuQm8eEwvFvWVDeGJ/FwI+ZIR4ECszHG6qnNb2azPYoygHu1TzX0cnu
	yqKTk/UA0LRUk069ujx9cem1yJFxw8ifb0LhFuCAjUKE7mJ0PK6DAacTLXGhW2VhUnerBDLY2B2
	wJQubOX1PUSWc5GHBeOMsdEsSZhZf1Fhgc7Gfj54DeeAGO9LSvpUW3BKVzQN6YSj8M3goaBxWKv
	j4A0eyMvXD18iWfZf1Ulwd3H78g4Tk714OsNzR5V5YRrEg3+4=
X-Received: by 2002:a17:90b:28c5:b0:367:d850:6a5f with SMTP id 98e67ed59e1d1-36a45fd3682mr2664568a91.25.1779365802276;
        Thu, 21 May 2026 05:16:42 -0700 (PDT)
Received: from fedora ([171.243.49.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a46c53220sm753820a91.13.2026.05.21.05.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:16:41 -0700 (PDT)
From: lazyming <minhnguyen.080505@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	w@1wt.eu,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	lazyming <minhnguyen.080505@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: skbuff: fix missing zerocopy reference in pskb_carve helpers
Date: Thu, 21 May 2026 19:16:28 +0700
Message-ID: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253515-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,1wt.eu,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhnguyen080505@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E00A25A4AFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
the old skb_shared_info header into a new buffer via memcpy(), which
includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
Neither function calls net_zcopy_get() for the new shinfo, creating an
unaccounted holder: every skb_shared_info with destructor_arg set will
call skb_zcopy_clear() once when freed, but the corresponding
net_zcopy_get() was never called for the new copy. Repeated calls
drive uarg->refcnt to zero prematurely, freeing ubuf_info_msgzc while
TX skbs still hold live destructor_arg pointers.

KASAN reports use-after-free on a freed ubuf_info_msgzc:

  BUG: KASAN: slab-use-after-free in skb_release_data+0x77b/0x810
  Read of size 8 at addr ffff88801574d3e8 by task poc/220

  Call Trace:
   skb_release_data+0x77b/0x810
   kfree_skb_list_reason+0x13e/0x610
   skb_release_data+0x4cd/0x810
   sk_skb_reason_drop+0xf3/0x340
   skb_queue_purge_reason+0x282/0x440
   rds_tcp_inc_free+0x1e/0x30
   rds_recvmsg+0x354/0x1780
   __sys_recvmsg+0xdf/0x180

  Allocated by task 219:
   msg_zerocopy_realloc+0x157/0x7b0
   tcp_sendmsg_locked+0x2892/0x3ba0

  Freed by task 219:
   ip_recv_error+0x74a/0xb10
   tcp_recvmsg+0x475/0x530

The skb consuming the late access still referenced the same uarg via
shinfo->destructor_arg copied by pskb_carve_inside_nonlinear() without
a refcount bump. This has been verified to be reliably exploitable: a
working proof-of-concept achieves full root privilege escalation from
an unprivileged local user on a default kernel configuration.

The fix follows the pattern of pskb_expand_head() which has the same
memcpy/cloned structure. For pskb_carve_inside_header(), net_zcopy_get()
is placed after skb_orphan_frags() succeeds, so the orphan error path
needs no cleanup. For pskb_carve_inside_nonlinear(), net_zcopy_get() is
placed after all failure points and just before skb_release_data(), so
no error path needs cleanup at all -- matching pskb_expand_head() more
closely and avoiding the need for a balancing net_zcopy_put().

Fixes: 6fa01ccd8830 ("skbuff: Add pskb_extract() helper function")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: lazyming <minhnguyen.080505@gmail.com>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 44ac121cf..6a1a2c203 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6810,6 +6810,8 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			skb_kfree_head(data);
 			return -ENOMEM;
 		}
+		if (skb_zcopy(skb))
+			net_zcopy_get(skb_zcopy(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6953,6 +6955,8 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		skb_kfree_head(data);
 		return -ENOMEM;
 	}
+	if (skb_zcopy(skb))
+		net_zcopy_get(skb_zcopy(skb));
 	skb_release_data(skb, SKB_CONSUMED);
 
 	skb->head = data;

base-commit: 94e3dd6874bf04d5939bc8431b9f7852f3a4a121
-- 
2.54.0


