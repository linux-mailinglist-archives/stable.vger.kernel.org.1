Return-Path: <stable+bounces-55011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12924914DF6
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4534284047
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68013D8A4;
	Mon, 24 Jun 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Fu1ccmna"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51613D62A
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234546; cv=none; b=PXWzs5ZVKSAbFEL7hhUyPSK2i4qLZGHRRgwNXjgrVBFV4HQlmJ3ffHYAXLqMvNrpJ65+4uVZ0+p/8zq5CN52yGVphoMb0qdiAEQEh+MSNeTXJiZ6bVoUYTGTjKJduNpHXKlDADtSW+PFON/BhkUyt2l5b/8ZnVdDce7IWFoBQD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234546; c=relaxed/simple;
	bh=YnwMFx7v27V6FYvekKLIctK4MfTa3mGutFv4M3UNWRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsv5OsJfobhzI5Zz91OUnBcY3Y9GlVJHHo5WX9Eeu1LseIl/jFpEW64DS8SuNeyGO/Pmmrhpnz5E/QaCTfShMFfMaT3vS566qWD+W2K/6KIqx8dp/zP1S4kvf4b49hAhjnNf9Z84R7TN32moQNl7qS+/3R8xYOBrZc2R+vQUF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Fu1ccmna; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-a72585032f1so98661266b.3
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1719234543; x=1719839343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdqEoEJ0Pf4lgGIH6ji9Pz/3++dxBfiK/h/sDIFPHrE=;
        b=Fu1ccmnantlWGJLI4dH6m5m9HQa+KJbOmeQZcRKp6A3hC+VyTuYWqmTpL9tdrhwTGW
         tTmbQiIRdBTPOCaNw8DK2W/mijX9vRmQuX1qfitOgAYc5Yfjs3QdpDZlA+Wr+V6f8cOX
         AOcgWy7U3kUnnIFa9gpgn0Ah5YL2FFLrwgXq0J9vjXPpK5tiUdzCzMtVCxN+OPaK2z39
         OaqX1AqBVdsQC4jCP330o1xw6YcY0KMSQCnPzTdqvNtijjPm/yGI35iM31mx6lNndlPQ
         6Q64JVzW5Ooaz8RGSnNMQUv0mz73tUvB6t8wiE0anMlsrpSNWJYcVjVOJXzyKZ7+8RCZ
         2Qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234543; x=1719839343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdqEoEJ0Pf4lgGIH6ji9Pz/3++dxBfiK/h/sDIFPHrE=;
        b=rNZVeTPXn2LDKY3gOypcSM8/dgfcLwyZ/99BBne1a2bzjilIOgTSR2qEHXRx2W+Jfd
         mCxPJsdUeBA2t0si/geC8k5hZ8rhfWtpFYN7g+1yHlRDS5bq8QK2mx7ySwQEd2cWp9pr
         YqgK9t+Em+XY88nQ6D+9oNfGoj4N32HPXCINJoyRKfSj09xXVa3VvLURsGvJW3gprjMZ
         wiK5W+3WUrh5ws3DoQpYr4Y3j2bMpbaodpEBhJ/aNiiwTjg4httwyZBTRV6UUpzHvnFQ
         zM/GBfeJF9QfDE1d3xH330frE2BH4DG53RahCYwGFCO+kWRSZjU8W7V4eTHePC10l6wk
         xhOg==
X-Forwarded-Encrypted: i=1; AJvYcCVk3wlhKGuwf4K3IBkAYLoLc4MDMiTjLcCOG8q4tzU03Pr5dkB5IculuBcYcdiae1mCY4vjlXi/5s9k91f7c5CF9QLVbSDw
X-Gm-Message-State: AOJu0Yxt2OTpr7YlKrZY8bcCjrDIgtBvzz3EhyRurv/+aXDhYjgEw1xW
	lalEbZEPdWF9I98hLg9Cqx2b0PhL5zV4GQEs+Lj6YX4XrvTzY9G2zV4JfZ4Kbt97Wyf2pDhFY+Y
	7MFBxlM+EykJ+iPlVq5S/IniG+u9q+/WM
X-Google-Smtp-Source: AGHT+IHCk7wynrIl8qJrDVl6mUMvyc5T0uLPZ9fOJVKL4yEifbZ4Dcx4XDbVA+6QE1V+fboohRVwC3ANdYMU
X-Received: by 2002:a17:906:4713:b0:a70:6f2c:b308 with SMTP id a640c23a62f3a-a715f94a9d8mr372023966b.29.1719234542660;
        Mon, 24 Jun 2024 06:09:02 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-a6fcf560fc5sm12243966b.229.2024.06.24.06.09.02;
        Mon, 24 Jun 2024 06:09:02 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 570A760490;
	Mon, 24 Jun 2024 15:09:02 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sLjRO-00406D-1I; Mon, 24 Jun 2024 15:09:02 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/4] ipv6: take care of scope when choosing the src addr
Date: Mon, 24 Jun 2024 15:07:55 +0200
Message-ID: <20240624130859.953608-4-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
References: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the source address is selected, the scope must be checked. For
example, if a loopback address is assigned to the vrf device, it must not
be chosen for packets sent outside.

CC: stable@vger.kernel.org
Fixes: afbac6010aec ("net: ipv6: Address selection needs to consider L3 domains")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/ipv6/addrconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5c424a0e7232..4f2c5cc31015 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1873,7 +1873,8 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 							    master, &dst,
 							    scores, hiscore_idx);
 
-			if (scores[hiscore_idx].ifa)
+			if (scores[hiscore_idx].ifa &&
+			    scores[hiscore_idx].scopedist >= 0)
 				goto out;
 		}
 
-- 
2.43.1


