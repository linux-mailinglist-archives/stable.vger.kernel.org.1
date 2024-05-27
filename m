Return-Path: <stable+bounces-46400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EAB8D042D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE74B2AA19
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1571A0AFE;
	Mon, 27 May 2024 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5e60RgU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B71A0AF8;
	Mon, 27 May 2024 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819395; cv=none; b=Gw49awq22rKxr9lQtgDcRdr+bnaQxxcMlBUR8GwYwULHUhBbNJRZBtE6zEL5LZDJS5Gmj7r84gxQ+uRlrrNiaPQYQoBBI2/Q5+d+7dkw6q54NH/RwfNt6NGzYOUQgRQnJosMAp8TItAkvu9Q05skRb2iTcCJ9xVRGN3Yhn31zY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819395; c=relaxed/simple;
	bh=gT3PUxRsUL+n6n4zrXENoJgzxNiIqZwJ8cCv7JfCF08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViroHwtQJACsgYEwfku9azM1MeeUnuBoR4GZvI08xljI9Pj5w9+yoQZM/3hPkzq6VM3taJgkcb9Omj9bfzp6arbG4jpW/9hamrB6VwKJAJ8FyjVCOVUclXX7EOVsZHd1VdGzl0yQkW1s/KLaXoxuNewnT/2O6RpwbKWYvdk4Nr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5e60RgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADE9C2BBFC;
	Mon, 27 May 2024 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819395;
	bh=gT3PUxRsUL+n6n4zrXENoJgzxNiIqZwJ8cCv7JfCF08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5e60RgUD9Svp+actuMkyw7DT+WC4S1aQBgl5xzD9bKPX8gDCl7AhJCYqcBG8q+0d
	 9CO5w1mbEUUPUyK/YIhKq+dhgSVFty9QXRqGG2I7dIGH6JpXoeQNdrML0XJDxFzu1M
	 lUNKwCKLwrFQHwP5EO9wmS/L6sVHwdGWNFWfChCTL1evrBvx1SRUQ9HTxI9WLDA4cx
	 MM4lMbTMnhkCt3+NwAwnhxGhpwuikbHtzMVOSyO79ricRusgMBjBeqv0pTY6zcraUJ
	 t7Ji282DMvTrtaxdUxtffrlg/bop1ulDZlocv9V8DkqsQdsHbSI0hkAVvPmbP0pYm1
	 W2RRwECRUNzvA==
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
Subject: [PATCH AUTOSEL 6.6 15/21] netpoll: Fix race condition in netpoll_owner_active
Date: Mon, 27 May 2024 10:15:26 -0400
Message-ID: <20240527141551.3853516-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141551.3853516-1-sashal@kernel.org>
References: <20240527141551.3853516-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 543007f159f99..55bcacf67df3b 100644
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


