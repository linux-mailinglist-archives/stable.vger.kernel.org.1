Return-Path: <stable+bounces-183070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76305BB450D
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 17:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877F37AFF93
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F791B4248;
	Thu,  2 Oct 2025 15:26:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0C1A08A3
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418802; cv=none; b=A/inNb2ojSz1+GXlaCCaT4+XWD5aqQ9oc8F+UvghW9t889znXJkA7avjQvxYpUMt+vi3QiR+wGQdc6ZiBJWZw8g/jzDtamLyoA5P5q4nmrSJQBEDgMbGOlIu5bRTBmAc4PXhnZwhfSiD39OdCq6MwInJzuw99jHdI2Dj2YBEcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418802; c=relaxed/simple;
	bh=+RzgxlXhvAjihAWHcJSiVhsrURV2de8MPdHHcOWTs/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPd3Y+JUJyffkiry3sxZCywFZ90U2lH+FV5KPtjMYxnBNyYQ4R5pweuXtAS1PcfBgD79etZdWH3hyIPGU3COoTO8wK3k0339UkUFb9hscWMH0FrD4DxbWz6Jh09jNEdaZHmY4Cuv0Ow/uyihX6ihGtTcYHZqqH68bOfpeiJYPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-637e2b86240so1545400a12.0
        for <stable@vger.kernel.org>; Thu, 02 Oct 2025 08:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418799; x=1760023599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CR8vj1NdfmaZYiunLULz9OPZOynQvbneaWGWn09HLE=;
        b=gN7nuoIPdpBl9pfYbS+zcyPw6TVHYN5jY7a3UNKFLLS7A63aOttK/zM6u5ZX+X2eXW
         fFxDVK0IFoOjgGwqbZDI3j9rOMeJUNe1BH8VphLbS7P+e2/WKm04Tk/G+bcBifOJ8YGu
         ERgnrhYYXnt1TZ47d93cl1ysFLSv9tpZ8elM9ZNsemRfYDEj8Ne/hls7JFwsIIeFUDES
         93lB9hTO7JiA8VLR4MlzVUh9B3daMqszSPaVNgd2SAZA+x9RgXVWzLalkBtCFu9FwOEK
         zMHgadJRUnALP4X70tZIPTVl0HxMrlnQan7xFXDRaH0e8LT39+v8TR3+RQ/dgQaZVtso
         qzWw==
X-Forwarded-Encrypted: i=1; AJvYcCUZTqu584W36riszIBG9m4pSxhfWNmunI/VBxUCFfVxvxWH8RRqowoCRT9X3mHuW45OUSiFk6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhptU95CkYS5tHWiTpXAUOf5cxLWXg/NcA1Z7vcquuUKpB2uhv
	uyJfHlKuFuRKZP/wRD+WG6bbI1QJDxply1jsBT7/Pi76IszgOPXIcAi4
X-Gm-Gg: ASbGncsjtFLwffS7XJj2Uza/WrD0OPtGmFjJVauSkoXWVr9XEm5yGYMwTvL/nyEu1Ot
	qtCym+yOCcPK18CU6ejvkgOpSooHHf3uMc4pLloYRDEXTMpXJHQycvtc9hbrNvbuiUQHwuJl0aU
	uetQlzhBEXnmOfNnmVxTaUwn8HBRwgtewA2A//888CtO4zgeQZUA/cyRPvFNMGvX+Za4PEu0G5T
	mwRp4Rlnoh90Z2tRz7+chpCxNuuyl1ic0pOuLtDnoDxUaizJoL5+uwQsbVR0y1gvT4sG8KuMgv2
	ChTMZA0kDtDpMEe+NWwaBzN1JsLnkZ8GHhdCdtGkdK22g0JZtUjmVONOoTppENZGHgfiGcTrCnm
	qAZJ/gzzlTHjTteL5viqZba6wAe4+E5T2v94B
X-Google-Smtp-Source: AGHT+IGQezPxxiQ+1Z3VIlbAcwk+ye5bVV2z7QZN3w4RqsN7m5DXUIPTwn71y7T68heiqIIoL/CKuw==
X-Received: by 2002:a05:6402:2793:b0:638:66b1:e5b3 with SMTP id 4fb4d7f45d1cf-63866b1e788mr564378a12.9.1759418799104;
        Thu, 02 Oct 2025 08:26:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788110530sm2065860a12.38.2025.10.02.08.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:26:38 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Oct 2025 08:26:25 -0700
Subject: [PATCH net v6 1/4] net: netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-netconsole_torture-v6-1-543bf52f6b46@debian.org>
References: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
In-Reply-To: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2686; i=leitao@debian.org;
 h=from:subject:message-id; bh=+RzgxlXhvAjihAWHcJSiVhsrURV2de8MPdHHcOWTs/g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3pmsL95LlY0VMP3W1luaxEiZHoPub6VfwaOQ4
 YbUFtc3yImJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN6ZrAAKCRA1o5Of/Hh3
 baV0D/4r9TaEEvP77fTxZxdf0o0lCYQADBftm/XrTNtv1i0HqMi+xC9/hc+w1My4OpLHKGUashN
 5yl2EVbjC8lP7AnP8Y1TRX8JvAERoE8qlj+PxeqRUDFKQZUSdrVIyo3hZoHpJ8xsfZCFsdd2MsA
 vV8REz1OkI1fGPJp3/8t5DEn+wSeNAsej2T34BMarJvJf5Az1PmObDgqdlyxO/17LfU3ps3iNc/
 Fns/L4fNn5TJlTAUS6OAqUgrw12vgApt283suPX5nvM2QIq3xm1Kq95HLrBRp4GNZwRYoSJd4Mx
 VC5f5Cr528QhBH+t5y9z7GcSBN991R8ejK7tZ8CWBSDj/82pCTdGlx+M6zBwAztheaqlIYVrTKL
 nCKxFFSN+OpA9LSD+Vh+5JLazleDzRw1U5IIpSR9jqEiHFoUJAFymWfYoKLM7ZHsZi2iA6ptskk
 dYDUhe6pDjna7MqvlJMuYZy+JV+bSNiyqMxyi3uDkXjFHdNYxpj8UBtQ5mtNVO7nzCJu05+jTS5
 cckHZJTyCqZKtmORZz+InyXov1PRHlx/mzyZDfH9snHjuzB6NzVtOXp7nXLJkSnGbN+gYwbjyjC
 Q3evFzvFqHJ9F8vHhoWTeAdHXkM66w4C2l7Mt7Fa7MpGtEvnUCDQdJ9uQ7QuKYk19FMsKgTB2Z5
 e9+sDOF7uivC4hQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

commit efa95b01da18 ("netpoll: fix use after free") incorrectly
ignored the refcount and prematurely set dev->npinfo to NULL during
netpoll cleanup, leading to improper behavior and memory leaks.

Scenario causing lack of proper cleanup:

1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
   allocated, and refcnt = 1
   - Keep in mind that npinfo is shared among all netpoll instances. In
     this case, there is just one.

2) Another netpoll is also associated with the same NIC and
   npinfo->refcnt += 1.
   - Now dev->npinfo->refcnt = 2;
   - There is just one npinfo associated to the netdev.

3) When the first netpolls goes to clean up:
   - The first cleanup succeeds and clears np->dev->npinfo, ignoring
     refcnt.
     - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
   - Set dev->npinfo = NULL, without proper cleanup
   - No ->ndo_netpoll_cleanup() is either called

4) Now the second target tries to clean up
   - The second cleanup fails because np->dev->npinfo is already NULL.
     * In this case, ops->ndo_netpoll_cleanup() was never called, and
       the skb pool is not cleaned as well (for the second netpoll
       instance)
  - This leaks npinfo and skbpool skbs, which is clearly reported by
    kmemleak.

Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
clarifying comments emphasizing that npinfo cleanup should only happen
once the refcount reaches zero, ensuring stable and correct netpoll
behavior.

Cc: <stable@vger.kernel.org> # 3.17.x
Cc: Jay Vosburgh <jv@jvosburgh.net>
Fixes: efa95b01da18 ("netpoll: fix use after free")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/core/netpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 60a05d3b7c249..f4a0023428265 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -814,6 +814,10 @@ static void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -823,8 +827,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 
 	skb_pool_flush(np);
 }

-- 
2.47.3


