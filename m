Return-Path: <stable+bounces-121327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405DEA5592B
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 22:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CFC167643
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5E276D2A;
	Thu,  6 Mar 2025 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2e6Y22X2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B335DDA8
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298126; cv=none; b=FzaMd8cdW4G9PfDovUWUtsR/vdQGBhRDNUA3gCX4FxZvkfZzYD9pwUTgaJGwh7tm/0HK/6uI401/bbjkH+vIjuy6ki+ZQ3ccbk4WBMRBBwhqgb9zmyKUA+U49qx9SGQeszwHis85wMwgFVP65qjeqDzQqnNxKUvwqnDAoMUifVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298126; c=relaxed/simple;
	bh=azxxHglNwZOmOo21MSzDsXJjKofzRYYuFM+xpJtchuw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SEvCBkx26aYhHho1kzGURhCpwaIPog7hMfM6Nkq6owlu0m7FQYLEGFdpG55vWgyUS8EAdW+40+jDl3u0OMnuUoZe+dAzTVNv9w4lsa5/y48lkykdmiN0x7fZPsnQrgwLz/J5XjjJm/6LvYEL4fAFFyUOWWo8PwQ6M7pJLkszkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2e6Y22X2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so1676030a91.1
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 13:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741298124; x=1741902924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NLkSmt1DZnRhFx9XULHVdYEwtFXJcPydAoKqmySuLlQ=;
        b=2e6Y22X2yuv+HlRfCtMdXPKmiILHbBvD5jKCLW5IIzXiSw+gzORJCF2/ZTua/OPmAS
         uun1x+WWai9AqJxTfmJ1RELdjJ4sfoSuZvrbv/3Zwv6HQNXRrMcqWyFrcbrKsHAFz1Ce
         744en2q9mUwqynJ0e0UmPNrngk+B7hs0Mz/IGx0XFGfzZfL2k4WoG3It8z0FsuFwpA98
         4qw/6zYDHRvFBvC8cFcozuqeRktwkikBAuUAvNzsreEXXKvvffY9BDHuU4B04JMEwP7v
         B9lBpjS+y2XI+e0xJHo5DlDvLeMr5G+gq3t57Z7/ArGi84U0cQyhhX79TNB9vJUCB7g0
         Gy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741298124; x=1741902924;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLkSmt1DZnRhFx9XULHVdYEwtFXJcPydAoKqmySuLlQ=;
        b=NINyIsqxoTGRf8aun5VrQ7/ub/9YssXg18t3VeIVVKoNnGEhcb9bEeSF5iN+Cb2NUF
         oA69VWIgG1pAXhQIn9xf5rg774bUs8YKzboxYmSV7oNdFs6XrzbhEI9prBqrTPBKWUX+
         jllxku70IQ05OPtxp1Fzc3IKeMtMVd83vgPuUfKdPMk/KRxy+4iGr6zno00wBLEdnJgh
         ho6cE1fFx07wUAgZpOl/t2ReWSMBh5Wn1LI3zKJdDeN60gMEoHa/tmzeZpmC0O0dNRCn
         PxtqFSPQw8D8dlStCJfro0QPvJC4183XEbhEfWHtXWl9KGRpanw4IFR4luXLyOO58K12
         Gx1g==
X-Forwarded-Encrypted: i=1; AJvYcCV5+MSHppPSHoVDmnLo7c6xBYjbKIk0XkDd6YKngpiP2w8fMD32QGc1VHwSFZqT6dCpk+Fhf4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWyO8YhGWTgWJvFFJmRVKu3z4xlAqWSwolWl0lEln4nz80VK3N
	Z8hjCtjip92z4beon75ROxQKAfDFNui6VrXtJPp0OtZhav7f4ci81rQt+lxhKn7JXnwwzWdVJR6
	olZqi+I0lHOGqu0UWIkhIPw==
X-Google-Smtp-Source: AGHT+IGHDB9A44dGCVln69a2GwdZhq805JNhLs2P9Wez5QFWx8ZhmbyqG15VhWEUgx6YhN7ouHokY7Am1brqjoBqXw==
X-Received: from pjbdb16.prod.google.com ([2002:a17:90a:d650:b0:2e5:5ffc:1c36])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b11:b0:2fe:955d:cdb1 with SMTP id 98e67ed59e1d1-2ff7cef99b6mr1144261a91.23.1741298123934;
 Thu, 06 Mar 2025 13:55:23 -0800 (PST)
Date: Thu,  6 Mar 2025 21:55:20 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250306215520.1415465-1-almasrymina@google.com>
Subject: [PATCH net v2] netmem: prevent TX of unreadable skbs
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

v2: https://lore.kernel.org/netdev/20250305191153.6d899a00@kernel.org/

- Put unreadable check at the top (Jakub)
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 30da277c5a6f..2f7f5fd9ffec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3872,6 +3872,9 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 {
 	netdev_features_t features;
 
+	if (!skb_frags_readable(skb))
+		goto out_kfree_skb;
+
 	features = netif_skb_features(skb);
 	skb = validate_xmit_vlan(skb, features);
 	if (unlikely(!skb))

base-commit: f315296c92fd4b7716bdea17f727ab431891dc3b
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


