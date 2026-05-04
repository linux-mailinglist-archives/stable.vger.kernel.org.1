Return-Path: <stable+bounces-243607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBqGAjuu+GlIxwIAu9opvQ
	(envelope-from <stable+bounces-243607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:33:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF14BFAD4
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B8F8315C4A3
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC303D6484;
	Mon,  4 May 2026 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pVJzkQNb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5E1A6827;
	Mon,  4 May 2026 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904319; cv=none; b=qe0JpohUEWdbljrz979AQtcb9pzczKMRYqrADvcsyoLIVTUOty5Vu8EMNTVTELqIIIsnV3AyxQX/ardXACDq67tw9VpkePM06kQeSEocdW/hYwgjP94FVzArSa095kuutwQPQDlVvnMm5iiK1B6jiGfF5kb0xIf3GUC9IlqYbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904319; c=relaxed/simple;
	bh=cIrZMEzut9CRIzqKmoxDmVedgfnWT+Q6KqHn0VoGRSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/RofNZNkVg1xBJm47kd2xgcSdPWs7zUYi9Y82b1KqOFXJxLlfIw4VRvFYNMb695jBkfrY+nYy1FD4egElMyxoHdAypjPkUw2Z3fAeZmhur1P3R9sPGResPxW6NoqTMMSPU+J6nE6Ba2JtHte0SDHUso7tqvD25A2bg3aMa9KaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pVJzkQNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D066C2BCB8;
	Mon,  4 May 2026 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904318;
	bh=cIrZMEzut9CRIzqKmoxDmVedgfnWT+Q6KqHn0VoGRSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVJzkQNbuGE9Hb/I5SldJ/iYjBrbp+hdqLKsLyMUg05LUStAakKiJW0loGCsURkA+
	 3CE7kPcoc+lLfB6QiSULbv+G2XtNSJ0iAsKDaoBKKyxELXm+z5hm9HkVXK4Lx3YG0T
	 NMuotWIc47aY1qFzxd28UmdPrFVmTNmXGE+5yhws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Zhao <chezhao@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.18 236/275] IB/core: Fix zero dmac race in neighbor resolution
Date: Mon,  4 May 2026 15:52:56 +0200
Message-ID: <20260504135151.817000720@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 96BF14BFAD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243607-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Zhao <chezhao@nvidia.com>

commit 5e6de34d82b49cab9d8a42063e9cd0f22a4f31e5 upstream.

dst_fetch_ha() checks nud_state without holding the neighbor lock, then
copies ha under the seqlock. A race in __neigh_update() where nud_state
is set to NUD_REACHABLE before ha is written allows dst_fetch_ha() to
read a zero MAC address while the seqlock reports no concurrent writer.

netevent_callback amplifies this by waking ALL pending addr_req workers
when ANY neighbor becomes NUD_VALID. At scale (N peers resolving ARP
concurrently), the hit probability scales as N^2, making it near-certain
for large RDMA workloads.

N(A): neigh_update(A)                   W(A): addr_resolve(A)
 |                                       [sleep]
 | write_lock_bh(&A->lock)               |
 | A->nud_state = NUD_REACHABLE          |
 | // A->ha is still 0                   |
 |                                       [woken by netevent_cb() of
 |                                         another neighbour]
 |                                       | dst_fetch_ha(A)
 |                                       |   A->nud_state & NUD_VALID
 |                                       |   read_seqbegin(&A->ha_lock)
 |                                       |   snapshot = A->ha  /* 0 */
 |                                       |   read_seqretry(&A->ha_lock)
 |                                       |   return snapshot
 | seqlock(&A->ha_lock)
 | A->ha = mac_A     /* too late */
 | sequnlock(&A->ha_lock)
 | write_unlock_bh(&A->lock)

The incorrect/zero mac is read and programmed in the device QP while it
was not yet updated. This causes silent packet loss and eventual
RETRY_EXC_ERR.

Fix by holding the neighbor read lock across the nud_state check and
ha copy in dst_fetch_ha(), ensuring it synchronizes with
__neigh_update() which is updating while holding the write lock.

Cc: stable@vger.kernel.org
Fixes: 92ebb6a0a13a ("IB/cm: Remove now useless rcu_lock in dst_fetch_ha")
Link: https://patch.msgid.link/r/20260405-fix-dmac-race-v1-1-cfa1ec2ce54a@nvidia.com
Signed-off-by: Chen Zhao <chezhao@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/addr.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -321,11 +321,14 @@ static int dst_fetch_ha(const struct dst
 	if (!n)
 		return -ENODATA;
 
+	read_lock_bh(&n->lock);
 	if (!(n->nud_state & NUD_VALID)) {
+		read_unlock_bh(&n->lock);
 		neigh_event_send(n, NULL);
 		ret = -ENODATA;
 	} else {
 		neigh_ha_snapshot(dev_addr->dst_dev_addr, n, dst->dev);
+		read_unlock_bh(&n->lock);
 	}
 
 	neigh_release(n);



