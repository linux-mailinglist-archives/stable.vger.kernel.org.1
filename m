Return-Path: <stable+bounces-252874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAWVEfYIDmrY5gUAu9opvQ
	(envelope-from <stable+bounces-252874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:18:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB24598171
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5781B32D3388
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B59234EEF7;
	Wed, 20 May 2026 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JS6N06z0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE99333441;
	Wed, 20 May 2026 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301814; cv=none; b=Q5/N7yZFJa5WMSsoXxBPAZDo5q6QR/8w1AYd/ueMSfx8P1QliDDeZTJeWCZmWa2r6f66bMaz5r0vPb5T9gGDJblv6rJpoZp93KVshP2uGl51hodM7N/a4lJvItMLvwNI0iTz46rkZFMufMRgYhTTP2uJzA/M4mi7Ki7bSk5oTIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301814; c=relaxed/simple;
	bh=b9IJivf9QNQ7zmuTg/rJb/pmaWaahTgbV9y8TnSPkJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axRuUG9B5jUbBeKWxzaq7FQBXeuF664KjIXABNG2QxUoXP4J+g4YVBmwohe72Vo4oJu7nrnNqsfvjPXO4fvplAiW+4P1MKnTo0tQXxcsVhvPKt4bWgU2lhsBJCLY63obtkqSNTLerrz6XjtV0gkSBIOQjBYW4gva4ckpBgMUUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JS6N06z0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6E91F000E9;
	Wed, 20 May 2026 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301813;
	bh=sLwgRBkXpzWmSJaM6eWF1BDTed7+Mufe7E2kMlDsiuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JS6N06z0oK2+wDCwHECpEaog6IaCZpfkdRiyV32/eqBd7lkO0cpOQDibA38sexa5D
	 m+JtT0yqvi0XRhbUurVY5ctMsBcgd8ITucTJS6GYTyQ2F2UdAt1lN5sAgwHyD21Ag/
	 GcStJ/JkCbib5sDhHeh3BxEDbCIxb5Waf693rpZo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Christoph Hellwig <hch@lst.de>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 003/508] drbd: Balance RCU calls in drbd_adm_dump_devices()
Date: Wed, 20 May 2026 18:17:06 +0200
Message-ID: <20260520162058.652855024@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252874-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,kernel.dk:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lst.de:email,acm.org:email]
X-Rspamd-Queue-Id: 3BB24598171
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 2b31e86387e60b3689339f0f0fbb4d3623d9d494 ]

Make drbd_adm_dump_devices() call rcu_read_lock() before
rcu_read_unlock() is called. This has been detected by the Clang
thread-safety analyzer.

Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Fixes: a55bbd375d18 ("drbd: Backport the "status" command")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260326214054.284593-1-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_nl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d3538bd83fb3b..1ba81a5e77215 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3368,8 +3368,10 @@ int drbd_adm_dump_devices(struct sk_buff *skb, struct netlink_callback *cb)
 		if (resource_filter) {
 			retcode = ERR_RES_NOT_KNOWN;
 			resource = drbd_find_resource(nla_data(resource_filter));
-			if (!resource)
+			if (!resource) {
+				rcu_read_lock();
 				goto put_result;
+			}
 			cb->args[0] = (long)resource;
 		}
 	}
@@ -3618,8 +3620,10 @@ int drbd_adm_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb)
 		if (resource_filter) {
 			retcode = ERR_RES_NOT_KNOWN;
 			resource = drbd_find_resource(nla_data(resource_filter));
-			if (!resource)
+			if (!resource) {
+				rcu_read_lock();
 				goto put_result;
+			}
 		}
 		cb->args[0] = (long)resource;
 	}
-- 
2.53.0




