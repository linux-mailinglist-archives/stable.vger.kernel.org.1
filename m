Return-Path: <stable+bounces-38873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AFA8A10CA
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EDD1F2CF15
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B82514884C;
	Thu, 11 Apr 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pmkeUDYy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32C148314;
	Thu, 11 Apr 2024 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831844; cv=none; b=qesoJ8MddBOi/5hOKgpkhbbNNgPE3htTinkvWVU4t4P0fIYLYNFbaXeU/l4Pkzf9x5DtWwy9GMBlSgOfNQTi+EhOKQ0K7XMeV4hxz0vqpsWH0Q6bygDv8sBQ444XscuBdkFZi7hKqpmXvSCUXStpFSOA2HTUi1IJT51f8fnrXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831844; c=relaxed/simple;
	bh=sTipYulEZm9jF2omEAPPOKZBafYR5dP5g8AcNQ5Jo1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxqsVHIP/EYW7iXB2Rg9ZMkoR2Ik7evO+qx+EW8NtFva2ByMux/eH8tNtU+gC3eF+mTavaPHB6a5CikuF5IdDwSwG3uVnVlwj7WYoKoDJ2oV2P6R/VgDAqra+1gcKEYg+k6EvrP0/euqjwFjR4taMJWG3aIQcOkep75O94Tr6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pmkeUDYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B07C433F1;
	Thu, 11 Apr 2024 10:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831844;
	bh=sTipYulEZm9jF2omEAPPOKZBafYR5dP5g8AcNQ5Jo1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmkeUDYylLbwKzGtZuUc1BxM2pkGCzn+BjsraIGIJwu21E99QJMBFHDMrkiLYKceF
	 +Whtplb9HHtyEmkSdep3/P//+p7pDfWQfAPa5ybd8jbB7HHsRrE04tpY66HADsFeCo
	 FTIEWiNKbpazEicuRe57EnIpcKacGWYDTymYK4Bw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 107/294] wireguard: netlink: access device through ctx instead of peer
Date: Thu, 11 Apr 2024 11:54:30 +0200
Message-ID: <20240411095438.892176925@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

[ Upstream commit 71cbd32e3db82ea4a74e3ef9aeeaa6971969c86f ]

The previous commit fixed a bug that led to a NULL peer->device being
dereferenced. It's actually easier and faster performance-wise to
instead get the device from ctx->wg. This semantically makes more sense
too, since ctx->wg->peer_allowedips.seq is compared with
ctx->allowedips_seq, basing them both in ctx. This also acts as a
defence in depth provision against freed peers.

Cc: stable@vger.kernel.org
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireguard/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 6523f9d5a1527..9dc02fa51ed09 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -164,8 +164,8 @@ get_peer(struct wg_peer *peer, struct sk_buff *skb, struct dump_ctx *ctx)
 	if (!allowedips_node)
 		goto no_allowedips;
 	if (!ctx->allowedips_seq)
-		ctx->allowedips_seq = peer->device->peer_allowedips.seq;
-	else if (ctx->allowedips_seq != peer->device->peer_allowedips.seq)
+		ctx->allowedips_seq = ctx->wg->peer_allowedips.seq;
+	else if (ctx->allowedips_seq != ctx->wg->peer_allowedips.seq)
 		goto no_allowedips;
 
 	allowedips_nest = nla_nest_start(skb, WGPEER_A_ALLOWEDIPS);
-- 
2.43.0




