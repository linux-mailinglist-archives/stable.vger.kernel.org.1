Return-Path: <stable+bounces-124682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEA5A658AF
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5677188D014
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5A41B6D01;
	Mon, 17 Mar 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwJ+sX5A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0141A2567;
	Mon, 17 Mar 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229535; cv=none; b=FPPW8m7WHldnwlDkw7feyjcnv3PmukXMxi1EqKvzrlePdeQjwdQc2BNjRi2ebStfK0oOTZpn47gCFZL0c6SPcWWqasTFtvyaelRYsndC6lwU4gTN33Y/veZp8vF/PgVsjOxKL0iNxEGNEeYX0kQ8FF0cer/sExweIV8LgB1bStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229535; c=relaxed/simple;
	bh=nPcvCsCRgv6WrfYsWQMws0+Y9HYX7FAwpVGL1NHNTy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AB9Dd4qMLHyLJSFXVfxe+tA2BVOyN1/yI3jxSkN6329q5v2jFygZNvDzax2uw5T+J05ayjGSmarjtBANjyVaMLo42+PEyX1xQseYMFpQrIDidF46pIC3sXpcldaneplMItKA+jnSiW0KLFnARqI0ChQ7T/9JgxUZmpoT8hvzPS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwJ+sX5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3A7C4CEE3;
	Mon, 17 Mar 2025 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229535;
	bh=nPcvCsCRgv6WrfYsWQMws0+Y9HYX7FAwpVGL1NHNTy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwJ+sX5AHfe47qx2mrMvVgx1vNuxD2zOz58bRRZOkZMJjVaJpakE0LtSrxejKHodS
	 06MvCYVeXbI8FkMTzlScm4Yz0w8Ry5uiqKe8G0+soYdth/N1GCcLnQq3UC8WRSmhkX
	 Fl6X5HhsWtrtZP9B2ZJc1WNTymfaR7d6eOgg107VcLoD6Pp4trlwC4CL9XDAeVmdUW
	 pYF1Km96Syn4XOtI5NMDgDCw7StTJkFflY3pdXtnYfkBxKvXpoDmZ+SDVfsveMWuVC
	 sYNCHXO7pmcebLw9oGVeviz+lPTuz5RGcm9f36HN6cFX7eXOtu1Zr0s3ysVu2WkAEc
	 YdqfYjuNgjifA==
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
	willemb@google.com,
	kaiyuanz@google.com,
	skhawaja@google.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 11/13] net: devmem: do not WARN conditionally after netdev_rx_queue_restart()
Date: Mon, 17 Mar 2025 12:38:16 -0400
Message-Id: <20250317163818.1893102-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163818.1893102-1-sashal@kernel.org>
References: <20250317163818.1893102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.19
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


