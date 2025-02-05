Return-Path: <stable+bounces-113998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E24A29C52
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 23:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EAD1884C00
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422B215067;
	Wed,  5 Feb 2025 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ZjI2/d29"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2FB205508
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738793454; cv=none; b=RqW/am9L1hnzlnV/WT/0ZKCZ7Jmlw5r5KcCRATPvOpoXx96Q9g+sYStcSfdX182RLuEg7psgyic1FfhDneTWUGoQnr+0BpXTVVFINrjbnu0+IolEtOfvQBiNEiyxg0EdWqoYwtRYQg2wCpJIudcnbPQ8yW2eONZ3yGhwWQqyo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738793454; c=relaxed/simple;
	bh=tevJpiW23QX5vNawBC3V5mVwwjc+cyWAooyXhBIKf1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDtAi+YP8KzOKD9/GQBdLBtuEtkOkJkjE6l/EYpmolxTA+67vqaS4XgL2McpKD0CEp92S4rAVTuQ6XErd32pfgPrXdM12ruWBVl4SyarXKcWMPVjKUMpxtruGi/4tffK2+/wGiEx80ytZsL/C3xiPDEb4GYweLJtuFuvpR7Ae20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ZjI2/d29; arc=none smtp.client-ip=209.85.167.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-5440e83daf8so36737e87.0
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 14:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1738793451; x=1739398251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1kUn0CXtkEyI0HmOYkgChrezfUURGEbEEqQNfXB1bI=;
        b=ZjI2/d29TlAdhIbF3Ua8iyk0W8HWxsmcOMOjv2fDniTNR63JtmUsnwlSVues1a2+Br
         W8OihfQeyRyTrjVIOfrMWJ2f5xuSS+ORaHDqVmzeG5K/+e+Xpnp1AFCz3plnFGscWLMX
         2UC3OcyXWbXClU5alLoXkIhbZnfcXGPUsubPO1UxSYoRZC1KNyRO2JcuuZa/x/FdIXAt
         HUyZ2FZmRUtm/s67oF07h5cM+xZQM2gB88u5KYVZlQ4ptU5XasTbfgWwJiB+5P9EfKy0
         kZ4IuYzan6tXwU0Ro29DBpObE/afQvjQCUE2tP/KMh5u80yKyQfjjWOQJq2hOy2V6Wag
         e9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738793451; x=1739398251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1kUn0CXtkEyI0HmOYkgChrezfUURGEbEEqQNfXB1bI=;
        b=dNDpktAyUk0kPV0JFQZ5veNH1H1hVHtANLvehKmiallbD4ElJzH/9hjW+/xwXb3QL7
         zEezwKwmvA5W2tnwTSyO3zRUPJx1OP2uqR2cgEBf7Rl3uYMc9nnfu0uIc91gLHjThjgD
         FxdaRXsuhUONE4bjz+ajL8Ye0B9rjiM83b8PqcCUBN6EPwEorCPilL2q41sk8IGiFxCd
         SeO5qwAxMsHNaZx0rOpUsBqyOCTT0EdMUhMbc8tIsKWv9egCsZL4nRJVGvyY21ifVgVz
         QsJLQI9amfgwXXwwQ8E5XCfBqyFEylf9vSs1PXYMSSxtXDWRwpnyIAy5Ye/6mjAgKy78
         abkw==
X-Forwarded-Encrypted: i=1; AJvYcCXUJYVgE4NqFWYTKiasjeyuQU7PwLRwctf8h3/fQBs97Me7zIzNDA2PutFQF2hSkBjY0hJ0/UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0qnKo49UPNW3f7z4yW0PElE3UZnULY2PApwRf2pBx6cJzbUyt
	tokuyN8py0r/bE9uD9E7M7HrIGJGtf7D0/UxywdZn3pUChTgv2gVz3pttmDuQA1ekwW265Nh7l9
	nPQA2elsed6qVv8ctzJ9zJ6df55+YvZp3
X-Gm-Gg: ASbGncutK7S0hNxA0nXxmkyGUJV+ISomGJjoxk5PIuXszowsqN7JGcC1yy4LOhQ5nN7
	KQq5r7fyO+rHydX60pBN7ngo1v5i+VOF3eL0hjJyaGHXhy6XTUKRoeEiDz4IveX14eLH9OxicRx
	LfPkub2ebBAn5FEVaon4ZfMTU6RL7zkQbep4ReptYYx+97sfhMxCmWLR9FAcK2g7725bR1AFP9g
	bLX+7fi83Aub7nf0Kpoxz9+EFKcFLg626Y7ZtJ5oKNcq9wdJk9oksXiC74dkUn+8pwozMxeXVOR
	+6YAkaVazmFAIqAUkZqIJWl2zmiPVfe6acDBNrW6tvHNgGh4UAK4atQm5NM0
X-Google-Smtp-Source: AGHT+IG0nuS0C/f8nx0E9P6dDMS0951lyYJUO3COjUsbinUq5Tt+K35UzFhNOFOrJL4Z7Fn3p5m3+3tWtWI9
X-Received: by 2002:a05:6512:1598:b0:540:1c9f:ff0c with SMTP id 2adb3069b0e04-54405a6baacmr536916e87.13.1738793450501;
        Wed, 05 Feb 2025 14:10:50 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-543ebdf095bsm598328e87.15.2025.02.05.14.10.50;
        Wed, 05 Feb 2025 14:10:50 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 1A8C11C431;
	Wed,  5 Feb 2025 23:10:50 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tfnbd-00ANiL-Re; Wed, 05 Feb 2025 23:10:49 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net] rtnetlink: fix netns leak with rtnl_setlink()
Date: Wed,  5 Feb 2025 23:10:37 +0100
Message-ID: <20250205221037.2474426-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A call to rtnl_nets_destroy() is needed to release references taken on
netns put in rtnl_nets.

CC: stable@vger.kernel.org
Fixes: 636af13f213b ("rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/core/rtnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1f4d4b5570ab..d1e559fce918 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3432,6 +3432,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = -ENODEV;
 
 	rtnl_nets_unlock(&rtnl_nets);
+	rtnl_nets_destroy(&rtnl_nets);
 errout:
 	return err;
 }
-- 
2.47.1


