Return-Path: <stable+bounces-678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279A27F7C16
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594201C2112A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815443A8C4;
	Fri, 24 Nov 2023 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZzK8i1f0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099839FF7;
	Fri, 24 Nov 2023 18:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B185C433C7;
	Fri, 24 Nov 2023 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849501;
	bh=6RIhxoOZSxrpegN/b0rlC58wO+QTrUQZ4BWsfwI+epg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZzK8i1f05pOMkNNxKquu/2P3JDutoxOOSVLBBry4pOyi9p86hN87hNUkvH4pjbsCi
	 1XTg7zLL7ijKiAKH6aM95yp37e1n8toFNg6JmebM9y7ZS7km1VgMJVL3ESiFVto+48
	 0yko//AcQ3oQxZPPZXHhpQcJ3hUojjBWB45t4AK8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	k2ci <kernel-bot@kylinos.cn>,
	Linkui Xiao <xiaolinkui@kylinos.cn>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 206/530] netfilter: nf_conntrack_bridge: initialize err to 0
Date: Fri, 24 Nov 2023 17:46:12 +0000
Message-ID: <20231124172034.334442902@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Linkui Xiao <xiaolinkui@kylinos.cn>

[ Upstream commit a44af08e3d4d7566eeea98d7a29fe06e7b9de944 ]

K2CI reported a problem:

	consume_skb(skb);
	return err;
[nf_br_ip_fragment() error]  uninitialized symbol 'err'.

err is not initialized, because returning 0 is expected, initialize err
to 0.

Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 71056ee847736..0fcf357ea7ad3 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -37,7 +37,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 	ktime_t tstamp = skb->tstamp;
 	struct ip_frag_state state;
 	struct iphdr *iph;
-	int err;
+	int err = 0;
 
 	/* for offloaded checksums cleanup checksum before fragmentation */
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-- 
2.42.0




