Return-Path: <stable+bounces-250897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLF+FybqDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:06:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A15592EBA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 452583054218
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057C33F4DE7;
	Wed, 20 May 2026 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KLy/Dewt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BEC3FADE9;
	Wed, 20 May 2026 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296594; cv=none; b=dZWxiUppSGsJcLnPouLQe15he2C+lwi5mwM/5zBKRlZLxqLgKAn+CoWwqo6eaHFW6FFwK63sAxNmQd17qDVR2iV4AhCf2DWdbFf7xC8KiDtPShVZiyHNwOTaI8QBe2Rtixo2bJRFTQ90F096+bsAu1dTU6gwKOD27+tR9O0zsyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296594; c=relaxed/simple;
	bh=0koqKgVaxpLav5Ec3AQWPYPFRUq8k6xRNjr4a55A+Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIX87eXJlxyt60x8isDwPtnPUPmGU8i/TYodSUM9sUcKjWsVqxkicXUcJdgGFgajRGzVvlQsPuDB4SNJkeBHz3hqTAIvWABpgeKyU7JDGAy/nF+Tr8sax6iL7n3iZl7IgPOjp5+/GRv1crxStB6q+8B4vcK93Yi7TfQOq35svPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KLy/Dewt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4631F000E9;
	Wed, 20 May 2026 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296590;
	bh=ns6yamsiad+C8bOQoassTm6Or9PeR4W+OIctapQuAwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KLy/Dewt8fgYuquoNuPtCDaOM8EYUcq9o7EAPF7sKK1574m1qTBnM5JH3JN/aUXg8
	 cAC3gYrLjk7MYmbRqW5/iFSRDpDn4SYervMDvWOZ+iXLy8WzLGTWon1zFE3MgqD9I+
	 wu0KDFoA/0Bog/vq8Cco6/efVkXozArkkK3uascA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brett Creeley <brett.creeley@amd.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0856/1146] virtio_net: sync rss_trailer.max_tx_vq on queue_pairs change via VQ_PAIRS_SET
Date: Wed, 20 May 2026 18:18:26 +0200
Message-ID: <20260520162207.611118969@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250897-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,amd.com:email]
X-Rspamd-Queue-Id: D6A15592EBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brett Creeley <brett.creeley@amd.com>

[ Upstream commit 3bc06da858ef17cfe94b49efc0d9713727012835 ]

When netif_is_rxfh_configured() is true (i.e., the user has explicitly
configured the RSS indirection table), virtnet_set_queues() skips the
RSS update path and falls through to the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
command to change the number of queue pairs. However, it does not update
vi->rss_trailer.max_tx_vq to reflect the new queue_pairs value.

This causes a mismatch between vi->curr_queue_pairs and
vi->rss_trailer.max_tx_vq. Any subsequent RSS reconfiguration (e.g.,
via ethtool -X) calls virtnet_commit_rss_command(), which sends the
stale max_tx_vq to the device, silently reverting the queue count.

Reproduction:
1. User configured RSS
  ethtool -X eth0 equal 8
2. VQ_PAIRS_SET path; max_tx_vq stays 16
  ethtool -L eth0 combined 12
3. RSS commit uses max_tx_vq=16 instead of 12
  ethtool -X eth0 equal 4

Fix this by updating vi->rss_trailer.max_tx_vq after a successful
VQ_PAIRS_SET command when RSS is enabled, keeping it in sync with
curr_queue_pairs.

Fixes: 50bfcaedd78e ("virtio_net: Update rss when set queue")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://patch.msgid.link/20260416212121.29073-1-brett.creeley@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c0b9bc5574e23..67b913218144b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3748,6 +3748,12 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 			 queue_pairs);
 		return -EINVAL;
 	}
+
+	/* Keep max_tx_vq in sync so that a later RSS command does not
+	 * revert queue_pairs to a stale value.
+	 */
+	if (vi->has_rss)
+		vi->rss_trailer.max_tx_vq = cpu_to_le16(queue_pairs);
 succ:
 	vi->curr_queue_pairs = queue_pairs;
 	if (dev->flags & IFF_UP) {
-- 
2.53.0




