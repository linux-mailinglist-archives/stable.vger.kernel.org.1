Return-Path: <stable+bounces-127826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC10EA7AC2B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DF5177B16
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA1F26A08E;
	Thu,  3 Apr 2025 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRjg6VEL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DD32571C7;
	Thu,  3 Apr 2025 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707177; cv=none; b=r5IL1wftESZSRA8Iyn7MO6Khgz9xsoPmMZJ4MESU9WHtEqD8cvQW1Fw5mhWMcFbdn1VXtUcY41F9SF4JsmS1A+aCQ3B/Pc3anUHELFDPJ/hZ7V6TBWG4zrLatxF9pD37Z64XwN86UPhq3LyyISG8LVno/Vy8CQBvh+9g62UHvV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707177; c=relaxed/simple;
	bh=1CcKXbqfhtHVfxqUZK34l1DDHU0gxjtEXW3/+5xuIMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iz+mpEpU3Nl5QKl/EXxOIzDl5Tk7GgwDJYB4yv+uEwCDSIAlkcn7UDTCllOEfHx4uM9uCa9YHzojIosYEzobQO7HhX+VKXzZNGRxPLnSMt2mbBYlQ3aCLa4JqemaJ5010tU3+jelVqrsEaWYs4/Zl8Esd4zF9Yq6/tnl7f1lgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRjg6VEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A44C4CEE8;
	Thu,  3 Apr 2025 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707177;
	bh=1CcKXbqfhtHVfxqUZK34l1DDHU0gxjtEXW3/+5xuIMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRjg6VELJuARNP64DEOqTR3ZB4+xaamqmXSNGPIIaFI8D8QIbyGUM5fBEL+9sShhj
	 Znk/epr4Gr25Ml/Tm5a54YbAA0HXrNYk2aT5neuDsGcphVR5xm9nu8US/FyVJ7FDzm
	 VwhqzDddsUHbjceErpwssZqKWQz8MCmfAgr4/rwLqtRpYjSBJcSVcp9jsUUQpa2ek0
	 CPDuiZ0nqr5mVJT83v+Vp3uFE3Lay68nEfw4hkfP1OHeDfYc1Iub9UQvM6DUx5UAGi
	 haloumLDWEvS3UqUn+4nWIprKZbWhs3XfsKMeVYfeH0iO/Aw1tw0k0clA0dWBba5fE
	 fsKKZJPllotOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	David Wei <dw@davidwei.uk>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	sjordhani@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 08/47] net: page_pool: don't cast mp param to devmem
Date: Thu,  3 Apr 2025 15:05:16 -0400
Message-Id: <20250403190555.2677001-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 8d522566ae9cb3f0609ddb2a6ce3f4f39988043c ]

page_pool_check_memory_provider() is a generic path and shouldn't assume
anything about the actual type of the memory provider argument. It's
fine while devmem is the only provider, but cast away the devmem
specific binding types to avoid confusion.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
Link: https://patch.msgid.link/20250204215622.695511-2-dw@davidwei.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/page_pool_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 48335766c1bfd..8d31c71bea1a3 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -353,7 +353,7 @@ void page_pool_unlist(struct page_pool *pool)
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq)
 {
-	struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
+	void *binding = rxq->mp_params.mp_priv;
 	struct page_pool *pool;
 	struct hlist_node *n;
 
-- 
2.39.5


