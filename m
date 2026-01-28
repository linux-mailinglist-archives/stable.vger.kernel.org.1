Return-Path: <stable+bounces-212105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI7aKCovemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:45:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30027A45AE
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFFCF30E967E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F032512FF;
	Wed, 28 Jan 2026 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pExKAW+A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FE23E358;
	Wed, 28 Jan 2026 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614414; cv=none; b=VII67fc+MU4JUxBO+6UzGJ+Av0logDLD3fE5t5LSRTqJ/KOVkP48ST1ognRqxULnYdtt0sC9yI1EWgYVnj5Kekm7Ea/wrCEbX5nj57c80H9IyVKi3Q8U8oBRuWQLlQb8FajpJIlTQcfvT22vcNu1Md8b/QSm5iQJu8IMtMLF0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614414; c=relaxed/simple;
	bh=wvaDt7cbsVJ8ZIggSH12Ac/Vj8bCQ1rDjCMGBOxZD44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DH63D4bCws99FVXMgnyfWUsRoEJMRnPWn9DgPiw4brPrQx9VQWzw4OqNlglSekGsa5VwEMFyN+4QKuaossM3LN8LBX/l5Qf2c+kb4HKWLFAF88aFOOWL8KCZZ4sKnx/lYEOuKeOKGOMWf5NsN09qBbalwXGRMPtKz8CUtNqdvF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pExKAW+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3E8C4CEF1;
	Wed, 28 Jan 2026 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614414;
	bh=wvaDt7cbsVJ8ZIggSH12Ac/Vj8bCQ1rDjCMGBOxZD44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pExKAW+A7Fvju1c9OvnIUeM3xS+PGXq9T8c+RMZVTlvKtoV7U5mEL2rGeqHzcvMgy
	 jcbBwd/XJw+v9bvV2opUabApMwJc/sqMAkWoErGdPE0fdCzJpJgZKe2y5+hw3LA6vu
	 0MMN0Hqk4ow2a/tOEDDxPENn+QYuvTSut1y/Fku0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Yang <mmyangfl@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 128/254] veth: fix data race in veth_get_ethtool_stats
Date: Wed, 28 Jan 2026 16:21:44 +0100
Message-ID: <20260128145349.425985453@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212105-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 30027A45AE
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Yang <mmyangfl@gmail.com>

[ Upstream commit b47adaab8b3d443868096bac08fdbb3d403194ba ]

In veth_get_ethtool_stats(), some statistics protected by
u64_stats_sync, are read and accumulated in ignorance of possible
u64_stats_fetch_retry() events. These statistics, peer_tq_xdp_xmit and
peer_tq_xdp_xmit_err, are already accumulated by veth_xdp_xmit(). Fix
this by reading them into a temporary buffer first.

Fixes: 5fe6e56776ba ("veth: rely on peer veth_rq for ndo_xdp_xmit accounting")
Signed-off-by: David Yang <mmyangfl@gmail.com>
Link: https://patch.msgid.link/20260114122450.227982-1-mmyangfl@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/veth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 7767b6ff5a155..2b3b0beb55c88 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -226,16 +226,20 @@ static void veth_get_ethtool_stats(struct net_device *dev,
 		const struct veth_rq_stats *rq_stats = &rcv_priv->rq[i].stats;
 		const void *base = (void *)&rq_stats->vs;
 		unsigned int start, tx_idx = idx;
+		u64 buf[VETH_TQ_STATS_LEN];
 		size_t offset;
 
-		tx_idx += (i % dev->real_num_tx_queues) * VETH_TQ_STATS_LEN;
 		do {
 			start = u64_stats_fetch_begin(&rq_stats->syncp);
 			for (j = 0; j < VETH_TQ_STATS_LEN; j++) {
 				offset = veth_tq_stats_desc[j].offset;
-				data[tx_idx + j] += *(u64 *)(base + offset);
+				buf[j] = *(u64 *)(base + offset);
 			}
 		} while (u64_stats_fetch_retry(&rq_stats->syncp, start));
+
+		tx_idx += (i % dev->real_num_tx_queues) * VETH_TQ_STATS_LEN;
+		for (j = 0; j < VETH_TQ_STATS_LEN; j++)
+			data[tx_idx + j] += buf[j];
 	}
 	pp_idx = idx + dev->real_num_tx_queues * VETH_TQ_STATS_LEN;
 
-- 
2.51.0




