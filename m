Return-Path: <stable+bounces-161948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F663B054E5
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 10:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB9F3A4705
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 08:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39FD276026;
	Tue, 15 Jul 2025 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="L5HQIeta"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9025D55D;
	Tue, 15 Jul 2025 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568209; cv=none; b=G6DbZVQXoHrvEmZjP8CJGYFgA+mKb6/iTc/5+8P3Fc1LtHRJTjSk9ak1aIzhM5aSH/Fh8l0A9+uA9pUckkYimFH2zc+rAEgmDFnq4Y2eUrsdYKDyExv6BL/broAFwMXrNHGDeU6lEME8cdYRhNE255CGIWire3LGkK2VVmpw6lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568209; c=relaxed/simple;
	bh=7RChoxNZvIGW01objUPMp18lND3qP5swJI6Jly25b3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VsszU1/7n2Rg3MXuRXXpVyRjaYz5GTHtxNhIXM7d1LgKP+bePa+Lrel9sA73xGxrN4uO77/sZQnJEt01dnYqnhq02pWg2ef1rzTzYNLCl8DPIbnKVHRFA5J8Be1VMEnLs9NCo+/g154NTqKKKowT9C7MbRTzUZDaRKfa9hdSa/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=L5HQIeta; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752568198;
	bh=PtRaWMoDptc1e8ypjYcAlmQHmognEHmmTZFTUdTg2kI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=L5HQIeta6qvSZpeDl6M/t7djawgykFC3xY6G9ivVl+fUVJ9V6DMVddkLBFGyAzkI8
	 GJRvajG+WJmLLarnIuMgREHaf5NJpjNhwAKe36ytNsWfiBJELphXa/ncSOGQShVZN0
	 b3TOrYHol5UCJsuzXraBDf5Qz0KznEt/vooZywFI=
X-QQ-mid: zesmtpip2t1752568181tad22719b
X-QQ-Originating-IP: 0GVQog9toGo4M4xXdTRBAEj46JRuzpoacgxAEvWriAM=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 16:29:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6392857298671382999
EX-QQ-RecipientCnt: 13
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georg Kohmann <geokohma@cisco.com>,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH 5.4] net: ipv6: Discard next-hop MTU less than minimum link MTU
Date: Tue, 15 Jul 2025 16:29:32 +0800
Message-ID: <46839B9D4350724B+20250715082932.430119-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Ndw/mc8X39ObLYczeDAmBLa5Jfu/2I4d/3TRcrTDpKuFWUKQ3vMrOrVI
	zUNGAQDkdaZLznAU2OFImTdP3Ps72RUcPrsnUw7nW6+E7oZeINAwv95+Vy8tf29/l8bSMrV
	WUgGR7XiPoN3q29XHtLTsp4SR6302ZExOnwapPurnl9ESvEoEeXhqHoYmXLgcqJIges6iDo
	lxo0ywkTRNTwz2i9qNKzeMteAMIiEcNCVmXExxmYKz9rSaMAM0kNn9eNpTuJW6l9/tDHHRj
	GuaAG6X1Ge2Oh7b5bChj5XaE4tEsyw6Nu6rwF3fuoReZw0c/dmWgK8mhaHKdobhLozukXCP
	s9wsSZ46OrjmTNTzm34HXswrEI2HNVC5tellRHYnYVqYrbaDDxjSR6+WjXSId0OjsaZVehT
	rikQm4JePCfAdI4Npm3jCdc/Od0fD2oMn80K89TUmnSBYQoZKVS2zakJHCEYwV9jgqRFUFT
	SB9WdNIiwTqxokpgdL/Xw1RBr//9bPW5LK20rd3VhEbJtft/QFEtfuI7AqTpYFIJadNCtQU
	jIisGWDEee3oBPEiuUML6GD13Cce4QF19qMuEg0Td90KgKLPRyE3eefVVhsMoVJAqCWewQT
	ebzGUpfwLyLMesc8BIWFLFfSWKv8qSiq3S/wxnSRcsol/pxhl1bkJocX2dfWLLeOP7tyvbV
	//F9xY+EXr7mrs+BLXYF/A6ylB4fbFQrRQz+p51du+USRn/paBr68wwlTXdlQazFj7Q9Ae9
	fQDS2KLZapjzyCsAVF80JOXpMuCiGfqOXMbAWJOJtGBLPqZ86dqJGfdz1Lq5DMcZoFfx1DR
	wHwBC6QY/Sf7xe19EKKBpHnSs/hV4ZgxffnwswkuKaNEYy8V1TEy5RJEI7ZAni+p6wMNySE
	USb6C28ofOH5QMeNJtyG+MmhpKu6wr9qYZLJByutz3rOPah2LdmhWEL7ABZTkLwjUxm6+rW
	80M5NIS3tR9h2FX1jJrrAf6JKo5VCxXal8tH6uxovSj5cDd4trMTnu9UHpACMvUgtYw9r+s
	4/K9UD+w==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

From: Georg Kohmann <geokohma@cisco.com>

[ Upstream commit 4a65dff81a04f874fa6915c7f069b4dc2c4010e4 ]

When a ICMPV6_PKT_TOOBIG report a next-hop MTU that is less than the IPv6
minimum link MTU, the estimated path MTU is reduced to the minimum link
MTU. This behaviour breaks TAHI IPv6 Core Conformance Test v6LC4.1.6:
Packet Too Big Less than IPv6 MTU.

Referring to RFC 8201 section 4: "If a node receives a Packet Too Big
message reporting a next-hop MTU that is less than the IPv6 minimum link
MTU, it must discard it. A node must not reduce its estimate of the Path
MTU below the IPv6 minimum link MTU on receipt of a Packet Too Big
message."

Drop the path MTU update if reported MTU is less than the minimum link MTU.

Signed-off-by: Georg Kohmann <geokohma@cisco.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 net/ipv6/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b321cec71127..93bae134e730 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2765,7 +2765,8 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 	if (confirm_neigh)
 		dst_confirm_neigh(dst, daddr);
 
-	mtu = max_t(u32, mtu, IPV6_MIN_MTU);
+	if (mtu < IPV6_MIN_MTU)
+		return;
 	if (mtu >= dst_mtu(dst))
 		return;
 
-- 
2.50.0


