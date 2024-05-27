Return-Path: <stable+bounces-46418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E68D0426
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79A41C2154F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CF7201241;
	Mon, 27 May 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJ83R5bq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B919200138;
	Mon, 27 May 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819469; cv=none; b=a5SMcUrJc3sP46zftZqcLZnN7XuELoknX2XK1wfWyBarsl1VE8KQUaTe5oOSZI1z4I0JCrd8DIvtPJWqK5GyjfXwcwSMRMo7CafFHVFDBW/YXeCRCrnXfjS4CgqKbCyiLFdp6tWNXMOVVQbnd6h59SIaDNC4sGAGHhZjgYErif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819469; c=relaxed/simple;
	bh=ouMgPq98R/4+nN98hHVg3mBpd1ZuLZQLD9HpkmlSQZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTQCWzSguNhZOhsQ078bETCW52V3RUBoowEVq6lhSCL8g6yaROodbvQHiCclhsNCj1ECsp/Xups5TePcG9c1jJ/goLb7uIesdjYcMd2gB57voWGM6NoUcwGEpa1kvIeVSDL3ylcOXmygaIczb7pXBoWKY4AOadjoLVAN7z4tK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJ83R5bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58787C32781;
	Mon, 27 May 2024 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819469;
	bh=ouMgPq98R/4+nN98hHVg3mBpd1ZuLZQLD9HpkmlSQZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJ83R5bqREPILf+R7Ln4B6Dte7qtMLQqM/3xeDPU+rujM9SHbQXHbTETBzPlfImpZ
	 fenvzA58yFCe+ZAfG7LCAMUG5J8cMsCb2WYz4aV/oxqqEU1y9FuyFBKx1TfBGbTCQV
	 arg2YSKZU0AugLwOpz0QmlGLu0x8GqIj1xoGUIOOZrwyiRebTqWNC5ZDll1bBXZhRI
	 QjaWnpvAQ2ud+53e9Df3/7LTAYjZMTGTnBBxKnLU0VkmJA0t1c2l+Xv52aj9TwoD9R
	 ReCSR66mrqhWBs8XTey9FPCBGEjkwiRE26wfLZk4lCnOm2D/JASLcDfyaprMaFX36m
	 B7kMhHNLIcbgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/17] netpoll: Fix race condition in netpoll_owner_active
Date: Mon, 27 May 2024 10:16:49 -0400
Message-ID: <20240527141712.3853988-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141712.3853988-1-sashal@kernel.org>
References: <20240527141712.3853988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit c2e6a872bde9912f1a7579639c5ca3adf1003916 ]

KCSAN detected a race condition in netpoll:

	BUG: KCSAN: data-race in net_rx_action / netpoll_send_skb
	write (marked) to 0xffff8881164168b0 of 4 bytes by interrupt on cpu 10:
	net_rx_action (./include/linux/netpoll.h:90 net/core/dev.c:6712 net/core/dev.c:6822)
<snip>
	read to 0xffff8881164168b0 of 4 bytes by task 1 on cpu 2:
	netpoll_send_skb (net/core/netpoll.c:319 net/core/netpoll.c:345 net/core/netpoll.c:393)
	netpoll_send_udp (net/core/netpoll.c:?)
<snip>
	value changed: 0x0000000a -> 0xffffffff

This happens because netpoll_owner_active() needs to check if the
current CPU is the owner of the lock, touching napi->poll_owner
non atomically. The ->poll_owner field contains the current CPU holding
the lock.

Use an atomic read to check if the poll owner is the current CPU.

Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/20240429100437.3487432-1-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 4ac8d0ad9f6fc..fd2195cfcb4aa 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -316,7 +316,7 @@ static int netpoll_owner_active(struct net_device *dev)
 	struct napi_struct *napi;
 
 	list_for_each_entry_rcu(napi, &dev->napi_list, dev_list) {
-		if (napi->poll_owner == smp_processor_id())
+		if (READ_ONCE(napi->poll_owner) == smp_processor_id())
 			return 1;
 	}
 	return 0;
-- 
2.43.0


