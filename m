Return-Path: <stable+bounces-109505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF5BA16AF9
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 11:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E2E18821BD
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677A1B85F6;
	Mon, 20 Jan 2025 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="cn9D4d0s"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D97314387B;
	Mon, 20 Jan 2025 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737369850; cv=none; b=uzBBCChUYQKfxSnkSo0f8oQzoha2uKzIWCXspf4+BG/NudL2sTup+VCF1kzUTR+TAyCtrzHHmY4fIPXehKThL8UYpkCYOeazCI5sdLzjfrpVNu7NeVnz7omFs1SF2loVoMf1VeT2C9COyKPLvO4s6aGHjHAMGAFWzY3xf7XG51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737369850; c=relaxed/simple;
	bh=GxV3g3AVZ7Hjv5VGE/3z76p6K6JyCTtgXGpii5Ce31E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrNUFZwIUXJmY8UlJ2PwL7bXKfH/r01nZmXsbmQIPPFkK87OU4vrgFzEvtUFY8dp3g/anGzFD/VDtTr1Y/m+vraWkdT/AxXQhUxHCZzIoYDpAAyOwLlZ2nGoyrZ1GSpKLbmwT46KjR0YcEJP68cVLM+AllADYdahvHUwfRmLEsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=cn9D4d0s; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737369838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DLQ6qsNzGZFppIPo7gttmGGIzVGvIyXbtulBIFZZLno=;
	b=cn9D4d0s0CRBeGp00S5Mm/qLFQDsax3ac1mXJEGQYpHuL0r1FrspxekTqeHzSwlDwJ59se
	XEfsJBUuHtlDbDOwx+0+81uAikVQgbIa506TxsOh4q4za3rorR3p3uIZIrv1y9O3u47Cjf
	Fb+NFGg/oOfQEA1sRfBY+IylUlNiMQE=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH 5.10] fou: remove warn in gue_gro_receive on unsupported protocol
Date: Mon, 20 Jan 2025 13:43:57 +0300
Message-ID: <20250120104358.21574-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

commit dd89a81d850fa9a65f67b4527c0e420d15bf836c upstream.

Drop the WARN_ON_ONCE inn gue_gro_receive if the encapsulated type is
not known or does not have a GRO handler.

Such a packet is easily constructed. Syzbot generates them and sets
off this warning.

Remove the warning as it is expected and not actionable.

The warning was previously reduced from WARN_ON to WARN_ON_ONCE in
commit 270136613bf7 ("fou: Do WARN_ON_ONCE in gue_gro_receive for bad
proto callbacks").

Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240614122552.1649044-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
Backport fix for CVE-2024-44940
Link: https://www.cve.org/CVERecord/?id=CVE-2024-44940
---
 net/ipv4/fou.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 1d67df4d8ed6..b1a8e4eec3f6 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -453,7 +453,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
-	if (WARN_ON_ONCE(!ops || !ops->callbacks.gro_receive))
+	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
-- 
2.43.0


