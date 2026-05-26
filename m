Return-Path: <stable+bounces-254241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNCTMiAeFWoVSwcAu9opvQ
	(envelope-from <stable+bounces-254241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 06:14:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC195D09DA
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 06:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 119CF303A536
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E8F3A8739;
	Tue, 26 May 2026 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCulRNW8"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727B3B531A
	for <stable@vger.kernel.org>; Tue, 26 May 2026 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779768828; cv=none; b=LEcqI2kHR40kTBE4ogf9VrKq4SbVl6luctcJv7P9AV/EAoS9QT5M6JdED72yJsCn2afl7aVVczDjdYP8qVd7+/TNsvJzQwcubM3uMX3CCBHjARRR0H0Y0lNoeuWFafBKPLchiv8FusXHXWItI0RS8C5lo8OzaaQ6qxaN+kvLizc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779768828; c=relaxed/simple;
	bh=xTsHZDYQwum2QlLXYNCH2s59XPiw2BSHIOY5zFmiYa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pazj2pj5Saek86KZ4sBfHw07Z96QwHdfxtp0kezkYApDeHZbyyT9lgPEIMfbuq4AKU0HyHAB85ES45dGlT/qqSVGe0YLmRJqeii5G8JFLD8LXksStJ9wk+TeM8eKKdk8TkT9/3Ez5RAFqjzwXyyue5kbTcm4Bk4n1Et4MkIrZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCulRNW8; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-6312970d9e3so7719438137.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 21:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779768813; x=1780373613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0Q5miFwy3tG8zNhMFBCq3/h29OE3WocoHy+YY3lzMM=;
        b=rCulRNW8vvonAWF5ru6JMyrdDS9Ox9nxQ+LM6x8hosLNhAlOs4AUOF5lZe9zRd4QH1
         fFvkC0uJw1UlqyGBreLOEYlTvnGpjnf5zpuD6rZel6L15rn7XyxVWE3IGz6YcM4+h5BS
         mR0tjlHCF6sCs3UDS3Ydy3pl6wNEfx08gRqYtukZ3BuN4qhAH+MHqHYaO+gY7KrcMjWX
         HtjR2jK87lnEvaDt+94lpgnTqDLbDpB9PBI6ALJzNR4EdJ8mNiErjMZ1UD19I0Xx/qvL
         3ben8x81oHDeaCnV9J5aE7SMgDMx0J+dGtWeWwmh5XWzqpWhtQPv+C14nYdyJxCD87Ps
         TJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779768813; x=1780373613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0Q5miFwy3tG8zNhMFBCq3/h29OE3WocoHy+YY3lzMM=;
        b=na55r5MFJTLKzoiqEXYu2Turg/uLq1LpXZp6kdTAN1udhsYqMIDWxLuTLqXmlBN+oy
         hjhdPIAeFIAKKd0BHBuDk+No20EOkQ5z/56o5MWKf5jKS8RxVcqTMzIvqK5lmNoZZGjU
         LDZvHP1DTsL7RD6dShvU71Cqyx1ph/m2xqsPSnNoqcvb42RaQCR4mrA2H8oUMjyKlFzO
         nvpsLbsFBDWSMDnZQghhJYiZzZLMl/i/X7N9kxWvGSWFBs07kUliDYLNN3Oaw1oe9mzr
         7rNPmYLuNcmGZu3P4ZbbNDjR/K+Q/ppzKFaUKpJP/kiHUqRriSeB2s/AWWrel+pGYxC4
         94qQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IZuSyxMnCXyjFhm1U/vc2VCNXRqBv46kPiGtAkC35bP6zERLXhrT6UV46skdVgXnqLK6DPdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjdCH5w/SDbZ994CSR5+3fkuy8aFasUszrICUfDgNKk5NZkUnf
	R45MuA6rV1oRnnktccxK773jajPEDvtkVj6cRXAW0JxHxofA5IKRl71/Ek/413ur2ns=
X-Gm-Gg: Acq92OHJmUhKD2vgdfBWYKOccq2W/saQpn0BOodjmyqRuFO5DZDYsUNEWCq1LFoUfW8
	CUAe96iu/+v+6dPoc0KN2DeGQ+RmPcRES2djMnF0UJcSgSNNmnBcvmyR7NvuNjporR0zuhiCuAf
	owzgXHwvDFtB4ZUU7EZUoZDtz3UUP7bXsOVPUOv2VVt5lbgPscBA5jg8CaKcT30uhEN9pY1SCdp
	/9xVD9mGEiknyFZ+0kPqS7160nwWMOs9KQRP2mDIrcOMo0J1Eq1DgtDga/NA5Xk2aSXrqdmh3e2
	SC+WJR/QWFDyisyqvKM1dx+7Lxb27SGV4BLU2f7VLyWbRMTQF519qZKNv9JcYU6r76luMSspJWe
	mWbAWsk2RvMjXCSA1ve5zCqAeG25LH/XtsIRBTyOq4Muyxs+Z6Y9JGgAh+BaNm31Zwjk0sYmMSo
	UZpbSCUYUP1mOSE7uskWPEisJibEvY2A4kK4vKRQ==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,oracle.com,gmail.com,1wt.eu,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254241-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3FC195D09DA
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


