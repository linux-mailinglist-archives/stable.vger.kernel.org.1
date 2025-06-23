Return-Path: <stable+bounces-157665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34504AE5503
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F261BC3054
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9961222576;
	Mon, 23 Jun 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jiUKttEb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779343597E;
	Mon, 23 Jun 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716424; cv=none; b=MRmychyBYP4yhW18FO1VMZ98yVaIVCFwH3QpSR37I5pliQZmJ1/7GvG/ujbHHMiG5SWNgpvKEXEHDcJZ9jEKz3kvzbIIzGP0fyQt1jX2EnYHMd6qJ8N7r901nWi3IqM8jzSVwsD+Jt3Tn9vdJxuDAAWHWfcNp+EzvtdaIJ9SO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716424; c=relaxed/simple;
	bh=ykX1wcOSssNcYiOcppAlaYOX1FPdOLNmJvIc/OJkioc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cePmYC+zBxXWu2uEgN9Lfk5yUAShzMVbM5v8KZZK4IKiyFAmrvoAoIm7xsC+Fi9GxF5S9mHv1s2f4Lg4qsXH6jid/MjwZJoQiMto/Oyv+lSZhr5f5iZ/YX+SSsuDRy/Wkhn1QccFS6kmdO/SlNJMxeDthQ79MSbrSLUr4WoiGsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jiUKttEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E193C4CEEA;
	Mon, 23 Jun 2025 22:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716424;
	bh=ykX1wcOSssNcYiOcppAlaYOX1FPdOLNmJvIc/OJkioc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiUKttEbJKnOoCYKYO1Cj49smoHXGTT0KVOoCUOXqe3xk1VuZy4I8eLLI+SK9lBW/
	 T2UXrCabTqmigXfQHPmJb+7PlzIVe5FGhvKl7562qs8hOMwyrsJimUe65u09Q7QTDU
	 QZaf66VyJLXGh2r4M867MFKhGzv324Ft3mLxaurI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 250/414] netdevsim: Mark NAPI ID on skb in nsim_rcv
Date: Mon, 23 Jun 2025 15:06:27 +0200
Message-ID: <20250623130648.297488095@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Damato <jdamato@fastly.com>

[ Upstream commit f71c549b26a33fd62f1e9c7deeba738bfc73fbfc ]

Previously, nsim_rcv was not marking the NAPI ID on the skb, leading to
applications seeing a napi ID of 0 when using SO_INCOMING_NAPI_ID.

To add to the userland confusion, netlink appears to correctly report
the NAPI IDs for netdevsim queues but the resulting file descriptor from
a call to accept() was reporting a NAPI ID of 0.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Link: https://patch.msgid.link/20250424002746.16891-2-jdamato@fastly.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netdevsim/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 79b898311819d..ee2a7b2f6268d 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -25,6 +25,7 @@
 #include <net/pkt_cls.h>
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
+#include <net/busy_poll.h>
 
 #include "netdevsim.h"
 
@@ -341,6 +342,7 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
 			break;
 
 		skb = skb_dequeue(&rq->skb_queue);
+		skb_mark_napi_id(skb, &rq->napi);
 		netif_receive_skb(skb);
 	}
 
-- 
2.39.5




