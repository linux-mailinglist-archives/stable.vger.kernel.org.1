Return-Path: <stable+bounces-254240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMZ+EfYdFWoVSwcAu9opvQ
	(envelope-from <stable+bounces-254240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 06:13:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD185D09BB
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 06:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D7BC3014500
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB53BE168;
	Tue, 26 May 2026 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAQCPTVO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BB3B811F
	for <stable@vger.kernel.org>; Tue, 26 May 2026 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779768814; cv=none; b=ZKVK0OBhatmjFk1hFBvAlmqUGdUuf56y4bQxYxzLaEFeLzhnyX5SwJ2KrJoohyYfs7ZgRcTEukejoTxLLLPJrBxWyScXp/Zw4GsjIBtghIhgvzj8MUm6V8O/8cR7b0ZCcPvj9kAceJmubzHCR7U87oGz363mCrG432Va8l5a+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779768814; c=relaxed/simple;
	bh=xTsHZDYQwum2QlLXYNCH2s59XPiw2BSHIOY5zFmiYa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9g/6FW3uagExlP78HRRqcXDDUDewi+sYuS88v4Z5mfWD2r+oA4mEgHHDALJBsYOneOYeAOg0T1WfvJJko3lqMYDtXNArqSKo7xMr7PQn01E4DnoB/IMWlK1Ad4KY4PrzFXlo7oqyf2f7b+CaDL3cm3VSkNO5XFIVT4I13ZZbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAQCPTVO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c80167f56cdso4381360a12.3
        for <stable@vger.kernel.org>; Mon, 25 May 2026 21:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779768802; x=1780373602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0Q5miFwy3tG8zNhMFBCq3/h29OE3WocoHy+YY3lzMM=;
        b=sAQCPTVOmuY3blXNbz091iDLaCVketnrQpPS5nlboK5orOOaUNAaDQD/6ea5gZkK99
         cgZ91wF+souanutGl6YESsvIU4y/uJaWME7oqR2stspYaKPiEwqqxuUuCaDxBds0hcJy
         d/KGtpXrPiDEYM0dQIs+5xCAw4jUgvucunuDbHKMk3dpXjtcOJGpDnOg8yT375giALkW
         fda2OGcjY/gpX0EChJukADI1dJeovsZzgVncH9rl16s3hyUOAmmVYDHlrMs8/1Z5aAVl
         3oaTfc2B0+n8hquC6+Ip7jE/V4KrEO2IRunumHo7ZpHK68r9LIrRzbDzlMFMF/VpHTiz
         OnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779768802; x=1780373602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0Q5miFwy3tG8zNhMFBCq3/h29OE3WocoHy+YY3lzMM=;
        b=KHw5cw9mTtMIhjCzjmom7FXojOpqu/Imcn5qBHLERLprZz2CWO8HzaJljBcjPm5noK
         xAS6UnWyFt8L7bP0th/svq+UCm9H0hS6ccCJbJ9RYMpdygwX4kFBcKPjmTkNJKzLM6tj
         dmmTVJDNhfG4eQvnYz0c3ShRV2erP3yBFChHd7mzc6/neVQ4XSwsEmzBlAs/xct26Tz8
         ht0tZa4uq1yElVOd/Uxwo/IVZBN9WL8vJ5niIwerPSutGXbgk3TiEe+n48rlJeqWq/Nh
         IEVhiDxp8vB1Mn0Jm+TSyIy++JtNu00IH+wBiUzZIK4Yr0ww5dK58JF2+vlF3JGkpiNg
         l+Bw==
X-Forwarded-Encrypted: i=1; AFNElJ9XT2e6j1rywCUxO92vVvwJsbBocuWrjug8rG2IQr/vJx/XfdZHMEVXH96NAPXi/2lC2ofTLWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9LbspvgUeSJfOH49pd0GRE3xwDVBYMX9VblODIfPDMrRCq3Bz
	AIwd6CHnj8AHiHxKlNK9P0waQNlHvdNVIv6tMUiOR4JTeZMs3gG+VTNS
X-Gm-Gg: Acq92OHXMnMUFHyePW9PHq/6Fg25KGE9y7b0A5+IOp9mwXZF5KqP5GNWlxn/2xw0C6k
	+iKf1x1NlzlCDtQZue2REtcMsI1GBdQuJnYDPqwSxnujYXmItaUX5P2HTNyi+OFEg9JFgsVvOJ6
	IhV6OANnPOReG6kEvlEeEHMGZUu0U2uBPZk7OA3269Ul/dDbH6gKGQI7Yw8eceyFW7sqMfSh8lu
	MJZIze3KFSc+NVkQdjcLINWGYuH3Ojgel9a5vAY54ga0EC4WseIaVncWymIsIdQ2wbXIQQDIZjK
	Zjywsns4LRB2Xmm1+1Rc/y+PROEIbTm79eDeZJU3Co5Bi8HO4p/mQ6encU2shveBPHwx3XTOYpQ
	WgRNDBmJkdiWYwsr/84752QMkafwXj4JGk3bBP6pMb9bzBdMktjWqLHDoBPRbgxRoeskyxcZk0s
	+Bj2ArfCGsjQOTOREk+/NOQWA17af4ZlFldAhXeQ==
X-Received: by 2002:a17:902:f60f:b0:2b0:5795:9ead with SMTP id d9443c01a7336-2beb02cb6bamr182900635ad.0.1779768801981;
        Mon, 25 May 2026 21:13:21 -0700 (PDT)
Received: from fedora ([2001:ee0:4fc8:5b0:526c:3adf:8a0d:13a8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56f4343sm144349485ad.36.2026.05.25.21.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 21:13:21 -0700 (PDT)
From: lazyming <minhnguyen.080505@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sowmini.varadhan@oracle.com,
	willemdebruijn.kernel@gmail.com,
	w@1wt.eu,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	asml.silence@gmail.com,
	achender@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2] net: skbuff: fix missing zerocopy reference in pskb_carve helpers
Date: Tue, 26 May 2026 11:12:39 +0700
Message-ID: <20260526041240.329462-1-minhnguyen.080505@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,oracle.com,gmail.com,1wt.eu,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254240-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhnguyen080505@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ADD185D09BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Minh Nguyen <minhnguyen.080505@gmail.com>

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
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v2:
- Use real name in From/Signed-off-by (Jakub Kicinski)
- Add Reviewed-by tag (Willem de Bruijn)

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


