Return-Path: <stable+bounces-120386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08431A4F1C8
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 00:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEC4188CE2D
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 23:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7D925F989;
	Tue,  4 Mar 2025 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHGS+YbH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BF200BA3
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132181; cv=none; b=Afv08oCp+Iy/eWA9zXfzSXumDIsx6O59kx455nytT4xwiyl52tlQotV6+Dc2xmAmEoQvTa4LpmnVIApkz8L7BuTevccba0Z19achEcAkanQO1/MTpAa/6CmfHjaaLG5ABLq+ZjnQLnpqvEG40I7oux/77Pr2i7Y3zx1s+wNhbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132181; c=relaxed/simple;
	bh=KGc5ZOpthDNGd1BsUds+xgHbJiLHtxGxIIOfKvP7wJk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mx5fDF6ecPcq/vtYlr+6SAV5dD0k8/1s/oZ4UIbGYqqFzOeICe7Y0DNeb8LLy/E8QVhq3XV1ZVXgAmuDKsIfOIh5l7EhAkFP3wOZJ3OMEf8wQ7qVRsAQuBskFnQzcdF9dLhc+e6VLEmplYGrWTV6p70uDRUWpeFfgCP1Ug4qQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHGS+YbH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2feb8d29740so9708673a91.1
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 15:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741132179; x=1741736979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+YMZiKSz5zNA/0UkYVvQA9DfWhT+3c5l8KwfO4x1oWs=;
        b=OHGS+YbHklFyjo2ZqSSi0Mksn52GfkpX6woVhcc/Svmpd+5J3NhSw1NpI4353N7zKL
         uG5p6BJHkGuA7SAOa4ZKns3mGkkPIkiZdGAqgKslUcxB1Fubs5jZXJAGwGSwG9OgI58Q
         kUqIql8Pk8tXwOlAV2g6UsA5H9Je311SiKcboR87S702+X7c2oVjY1J3vxUU6PvVLN72
         NnWwt5Cylk2wzGvRG8+Lu7NipnvttuhTqnLbjEekt/I507dX64NAbN4cwH2Z7XR/P+tx
         r2/1JIm0KjHWg0qs7vnNmZ9RYjkoAtRvheYGlux269bkcUOKZVprPk1AYzQHOXtDKBNF
         sQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741132179; x=1741736979;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+YMZiKSz5zNA/0UkYVvQA9DfWhT+3c5l8KwfO4x1oWs=;
        b=HfqhX1L/y1TkHdXhhJ6cElQJQdHrZrC5UuzDhiw/c9JdjAyWDRkiVsgNGryjWki+Js
         UCIseUFya6K/8YhSw8Gjrz1bdBnWb7zIYOcTSAd43orFazGIXhCIYW/lZLyQkcFdDuPE
         0T3y5WEtl5ji2drvmzWXUhRHKmMeWf3ySi2+iyjp2JNoIsMm61uu7WqzBill3CHpxGxI
         SMdhPfANSPGs6EUU/jROBOo+CbicdR4Rzdua/x0Fa8jxq5VzYtCfnjwiGUhoDYW/390E
         TgQp5esAkjEZOjoInb9SkYMHyzMrk4a0NQlVPHQ5RsJ1c/7YgRpF0sYSNsHm6K9c259X
         IEJA==
X-Forwarded-Encrypted: i=1; AJvYcCWRIq+Vs3kp3f9j3+aMEfxVLpJJdQZRCngYfy72er9Yb58XDGgL7lnIVB0VVOhcoNaHBaNrJOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUheBUYvxU6qdvw0AafInGPhFCTqTCBcew1GldgCmzUOU90tk
	8/McC76jYLnmDXJNmynUoa7iM/x6MgmEiw4eLujiEcmKwn6+j4tcaVzriZuvpBsG2alc7b+zo/E
	CKqzVcfE5eLBAFKM0d+wtgA==
X-Google-Smtp-Source: AGHT+IHyEqSO1UoerwLMdOalFYRe0Gf8bawb/DcdZP+I3DG6F3XwdwIcjvKhQhRV3aPh8doeU1NUpGVgU+jQgq2Yfw==
X-Received: from pjbmf13.prod.google.com ([2002:a17:90b:184d:b0:2fa:1803:2f9f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b51:b0:2ee:44ec:e524 with SMTP id 98e67ed59e1d1-2ff497c5dadmr1910088a91.35.1741132179057;
 Tue, 04 Mar 2025 15:49:39 -0800 (PST)
Date: Tue,  4 Mar 2025 23:49:24 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304234924.1583687-1-almasrymina@google.com>
Subject: [PATCH net v1] netmem: prevent TX of unreadable skbs
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently on stable trees we have support for netmem/devmem RX but not
TX. It is not safe to forward/redirect an RX unreadable netmem packet
into the device's TX path, as the device may call dma-mapping APIs on
dma addrs that should not be passed to it.

Fix this by preventing the xmit of unreadable skbs.

Tested by configuring tc redirect:

sudo tc qdisc add dev eth1 ingress
sudo tc filter add dev eth1 ingress protocol ip prio 1 flower ip_proto \
tcp src_ip 192.168.1.12 action mirred egress redirect dev eth1

Before, I see unreadable skbs in the driver's TX path passed to dma
mapping APIs.

After, I don't see unreadable skbs in the driver's TX path passed to dma
mapping APIs.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 30da277c5a6f..63b31afacf84 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3914,6 +3914,9 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 
 	skb = validate_xmit_xfrm(skb, features, again);
 
+	if (!skb_frags_readable(skb))
+		goto out_kfree_skb;
+
 	return skb;
 
 out_kfree_skb:

base-commit: 3c6a041b317a9bb0c707343c0b99d2a29d523390
-- 
2.48.1.711.g2feabab25a-goog


