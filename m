Return-Path: <stable+bounces-124668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A614A65886
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E43F19A0782
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA13C1AA79C;
	Mon, 17 Mar 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNdvcli1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C81AA1EC;
	Mon, 17 Mar 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229490; cv=none; b=ur6VPkSfichzMuNxjtWOU4fgj1UdyXuvmjwZAKPcQwtYCRHVEg6J8DKW+YujSUKpjrHXmzMgNP8ZBoM8wvAkhI+hPXIqhN1UMKAIKJz47BW6oBDuVWZi9tJ5fq5UxdJ++onYIfoxVcSYn7hSXH6WIzAkimjnMo5O0DgGRItY+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229490; c=relaxed/simple;
	bh=nPcvCsCRgv6WrfYsWQMws0+Y9HYX7FAwpVGL1NHNTy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HNntMHOdesTBdaujWVNEiD2S6XAzFbc3SDyofDceX5Fa3aaVHHc1+4j4SdHm30J9EiuZWzp07LoWfKGLgKSd/+f5JQA3GRBrOCpiZh+fBY3aBchDI+yiL2MgphFRO7Ukwx9Fz1M++1nf8PF5Xmwxy/fNSUt9SHMGXWAq66uNpds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNdvcli1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EED9C4CEEC;
	Mon, 17 Mar 2025 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229490;
	bh=nPcvCsCRgv6WrfYsWQMws0+Y9HYX7FAwpVGL1NHNTy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNdvcli1y/cgee3JbQsT9M57bDSznd5J1sUbLtavX206ntnlKBotF10aXt/NjQe5Y
	 mmOItBA+q7QQMp1RrLUe2iSSyA5jc3mTNL5Mh+ga/hI8gUiY0BhdK1RarOGQbWPxXW
	 Y27OYECEw3afybcOkMVysrOYVIm8R5P49NpwyNvXHbalNmajrSHgnoxWBkykWlRBgp
	 5iARhW9oZKLDxg/RzzF4jTjs8qEFp79vZJLoIWlqEeDBry9hasVgi8qG+o3+vvgjj6
	 5tXs/vJcIJ6lCcbNMp3mIjpzBy1PCvmPesikyEfv9nFUwERU2JwbUGCfcvZ0FmkBFc
	 z0kzZnqxN3pWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	asml.silence@gmail.com,
	kaiyuanz@google.com,
	willemb@google.com,
	skhawaja@google.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 13/16] net: devmem: do not WARN conditionally after netdev_rx_queue_restart()
Date: Mon, 17 Mar 2025 12:37:22 -0400
Message-Id: <20250317163725.1892824-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163725.1892824-1-sashal@kernel.org>
References: <20250317163725.1892824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.7
Content-Transfer-Encoding: 8bit

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit a70f891e0fa0435379ad4950e156a15a4ef88b4d ]

When devmem socket is closed, netdev_rx_queue_restart() is called to
reset queue by the net_devmem_unbind_dmabuf(). But callback may return
-ENETDOWN if the interface is down because queues are already freed
when the interface is down so queue reset is not needed.
So, it should not warn if the return value is -ENETDOWN.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20250309134219.91670-8-ap420073@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/devmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee113..17f8a83a5ee74 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -108,6 +108,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	struct netdev_rx_queue *rxq;
 	unsigned long xa_idx;
 	unsigned int rxq_idx;
+	int err;
 
 	if (binding->list.next)
 		list_del(&binding->list);
@@ -119,7 +120,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
-		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
+		err = netdev_rx_queue_restart(binding->dev, rxq_idx);
+		WARN_ON(err && err != -ENETDOWN);
 	}
 
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
-- 
2.39.5


