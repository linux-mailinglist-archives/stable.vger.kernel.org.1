Return-Path: <stable+bounces-265097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ojZ8CJuEMWrClQUAu9opvQ
	(envelope-from <stable+bounces-265097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:15:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A225692E95
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:15:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Mj3arHWr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265097-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265097-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D141B324E9F4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F9472767;
	Tue, 16 Jun 2026 17:04:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D6328610;
	Tue, 16 Jun 2026 17:04:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629457; cv=none; b=huwsgLzPpM8Dq/xsltr4TFKXZSBTBcdtiNZACdWAbhzleQoghoB18uUdBXDW4sRjGEfq3+BWINpxuUyaQEKfAk9JcVl+XJ7mVti4ic1W+Tu8k/hJO6LAiyJuRgLzMaICCJtVdXdZxxaI3/1C8l3ZW/KqK6mr+GwVIBhv1hJnJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629457; c=relaxed/simple;
	bh=aBcrkcrI50LjRJ9hDBNzW7s2q/xeA8d3bOvXNJbkzvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/D0583q0V8MTRtiLZUnGF04ffmcipFCH54lF0Kg0n5wvaRjbiBmUN34TK3lLX0xxd0rbmzamUpx9KnmBqwlz179Rj2sFV3vgecyzAUHMlfNWObHOS7nYJ9GKlgeHxL73nwVaW7MzJBzsOCx2fbCuW77dPGJ6dbBvXLKBAKCUG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mj3arHWr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DF61F000E9;
	Tue, 16 Jun 2026 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629456;
	bh=8W5MS2Dx2DPQvUUa1Y24OY1k4krIs/RlIece/AYY8xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mj3arHWr75VFMf7MytjQiiMIRokv4lmCKvefI+amTyqC7GyOKs3szBXeT65H6MV0o
	 QdfdOlc7F56UDii08WkB6gXh/BqMIJIrJihRbhjt577MP13E4JgsZU5sgLmhiSrrvP
	 icYZ+QcvofqiNg5z9zT5KFZuSoJRAX+0Xk0gTc5Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 255/452] tap: free page on error paths in tap_get_user_xdp()
Date: Tue, 16 Jun 2026 20:28:02 +0530
Message-ID: <20260616145131.035960839@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,asu.edu,gmail.com,oracle.com,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-265097-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:xmei5@asu.edu,m:bestswngs@gmail.com,m:dongli.zhang@oracle.com,m:willemb@google.com,m:kuba@kernel.org,m:harshit.m.mogalapalli@oracle.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,asu.edu:email,oracle.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A225692E95

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit 3bcf7aec6a9d16438f2cec29f5d7c8d5b8edf9b2 ]

tap_get_user_xdp() rejects a frame shorter than ETH_HLEN with -EINVAL,
and returns -ENOMEM when build_skb() fails. Both paths jump to the err
label without freeing the page that vhost_net_build_xdp() allocated for
the frame. tap_sendmsg() discards the per-buffer return value and always
returns 0, so vhost_tx_batch() takes the success path and never frees
the page; each rejected frame in a batch leaks one page-frag chunk.

Free the page on both error paths, before the skb is built. This is the
tap counterpart of the same leak in tun_xdp_one().

Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()")
Fixes: ed7f2afdd0e0 ("tap: add missing verification for short frame")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260521163230.1478627-2-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 3bcf7aec6a9d16438f2cec29f5d7c8d5b8edf9b2)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 2c4f9d19827f38..5f01c875e49ee4 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1178,6 +1178,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	int err, depth;
 
 	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -EINVAL;
 		goto err;
 	}
@@ -1187,6 +1188,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -ENOMEM;
 		goto err;
 	}
-- 
2.53.0




