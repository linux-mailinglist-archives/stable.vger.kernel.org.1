Return-Path: <stable+bounces-44146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF36A8C5175
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F747B216C1
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813FE133402;
	Tue, 14 May 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F/Na5vCx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A854903;
	Tue, 14 May 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684533; cv=none; b=q9DcrMR5EDlu+mfeUJn0Ibq5p5xBngxLqIbhQ40PgTT6DwlU004zkkvepoBgs+9E/t3fAfFj6rjwcyqhwNWZSEGSfhqCUpL12TeyxVPmgkO7aaOBkR07/LyZwVYXHiFDc359SPfH+tXMJc0BkdEaPDoL72O2ewJswTEexQdXSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684533; c=relaxed/simple;
	bh=wGNYRzDPJD4qOdeP03wil/5aMLRuuXIANrB6f01pY08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd6DhcYAkAfzzjf2zvIZ/RYO5qGRp8F40wfsP+ibN5dOB07jlMJb4lVx7ZZgGmc+UdMhmqBwK8DsE+HWbt2wc0K+CDBqh3Hn2IL+cWfmAdY0mGC0hz2UXCfvgpjxyhFJ3Ah/029JGnRjHTkB2cXVQoAsK2uPnzR4Ndeddlrv378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F/Na5vCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C051C32782;
	Tue, 14 May 2024 11:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684533;
	bh=wGNYRzDPJD4qOdeP03wil/5aMLRuuXIANrB6f01pY08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/Na5vCxcmfIR6El4Cp/baDn55oJL6GxoM9RHVpftAq2skRkbJVZXqwWdBN7FNAnM
	 a3k+h8SBDEcpFRxrRK9+LezgOa/BIVYvHBqsAdUTOLJe6qOFjOvRyTjrallnYIVBjz
	 LkNeJ8WlfN/ewaNthpzIgCpwylRswfXSpefRPFo8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Chapman <jchapman@katalix.com>,
	David Bauer <mail@david-bauer.net>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 052/301] net l2tp: drop flow hash on forward
Date: Tue, 14 May 2024 12:15:23 +0200
Message-ID: <20240514101034.208598300@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Bauer <mail@david-bauer.net>

[ Upstream commit 42f853b42899d9b445763b55c3c8adc72be0f0e1 ]

Drop the flow-hash of the skb when forwarding to the L2TP netdev.

This avoids the L2TP qdisc from using the flow-hash from the outer
packet, which is identical for every flow within the tunnel.

This does not affect every platform but is specific for the ethernet
driver. It depends on the platform including L4 information in the
flow-hash.

One such example is the Mediatek Filogic MT798x family of networking
processors.

Fixes: d9e31d17ceba ("l2tp: Add L2TP ethernet pseudowire support")
Acked-by: James Chapman <jchapman@katalix.com>
Signed-off-by: David Bauer <mail@david-bauer.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240424171110.13701-1-mail@david-bauer.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_eth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index f2ae03c404736..1f41d2f3b8c4e 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -136,6 +136,9 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
 	/* checksums verified by L2TP */
 	skb->ip_summed = CHECKSUM_NONE;
 
+	/* drop outer flow-hash */
+	skb_clear_hash(skb);
+
 	skb_dst_drop(skb);
 	nf_reset_ct(skb);
 
-- 
2.43.0




