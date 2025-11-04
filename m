Return-Path: <stable+bounces-192432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79DC3260A
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 18:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04E13346D3A
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 17:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1598C33BBCF;
	Tue,  4 Nov 2025 17:37:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C53C3396F0
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277838; cv=none; b=eMoE7LxBrfKOPimMgB++XqvP+280s0gxIEnP8V+DMcRGJJJTp0JpYlwDaAGoIEZEx6iAOOW1ltlWXvxM7NT8JNs7Wg/kow7XRe2NUP861kaCqw9Ixp9evYYR1x6nSR6wX7JXmTScBh7WjjgqvYVEqo3HC/mkufp2SZ0jwQHIHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277838; c=relaxed/simple;
	bh=+RzgxlXhvAjihAWHcJSiVhsrURV2de8MPdHHcOWTs/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5U4TBbcMMnUQdyDmlK45rOngLJABbetp0zImR/zbtOZy4SwWZ8uucReowyRcL9EHYqF1WYIdp7aiE5QDsImZsx8KmN5JNjtoBlYC9JnaAGISryQF+8d+J/Uf8z8rS8GhnTHrPe6ItZDJT7+pkMlgF5lwQRWbov/UMaXUNejg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640b2a51750so5115030a12.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 09:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277835; x=1762882635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CR8vj1NdfmaZYiunLULz9OPZOynQvbneaWGWn09HLE=;
        b=BMGGGvn93Jqb1l96quOBgHEAd6jFaYLCqxv144IYFMQtOEyK4ztayPlmdRFKBvWCE1
         V10g+RpCvekoh8o1bY+zUfYdNzIY2oQPH8JbtqVmsAlX2xZ8WEiiUHbbZBOhBscJKG1f
         LGZejkuK89fUVIn5vN631hTJKZkzfJ6l7KyU8CfoWjTxC0CLxhcd/GRftMi3Dw9Lvrw/
         Ac5vHjKkVOihVkHO2qrnmtMI9KB8H7l/55wYFNgzOUHMc0x3o4OI6kW6gdoo/zD4UHNh
         1bjrLDCmkM2iJ5aZzDQNLrfIK63viPpMs+LPapjb2Q02KoBbX5wHOOHcw7J9GaA2hyvT
         GT1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOIwayLO2VZo2iI6Guv31+uJMrFF3yPyC7Q8wtOsFyHBAkrH07n5dDcTD/X3gq/P6YdD1rsIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCMPhCdc1M2TCwEuQnMsQ8S759oqRyFwaRgrRF0FxMgC1eRcYu
	zPvLJMWVLSIf2PU7GrjK67Y4vL5GFt3tMDA3/66uXbgy2OloJxPBPtHLwnbRUg==
X-Gm-Gg: ASbGncuRBB5UAYC92caO5wh0YW5wW5SsZ3t71Ry+iyV+eQgo5gEe1EjL7sHdyFyqoUp
	Yq6D0h2nOCQoIS7Mp/aeq7Oesdp2ROoZVWN9pcv/cwQeNgQormq5q348vyEghbReK2SaJBt93eb
	ab+azKfSy6Cwe6Tn8GDCAuNgFCScxVlu1R6VJ+sa4rs3CPDahkPBENn/Dya3vqSUcfD10Xelb0s
	eOqottGLjdIozizqHJVJU6WOdjb2O6nr3n7r6YOKtFISB2Yw6DGFKEzPq8RbHAHalt+yVnHMA4t
	uVmrqf6ZcMR7iIWbE+i3AaYfMxCl1ZC8FOoKIKk2D8LP7LzONmdF4nBtVXupopmGocPXeE1wpLZ
	0Q6phTTwOIq3L/wb0s/ChYO4EXirZCHwvjQCTfEKwi6FJ9gypsTiO2aGQKOmoPF0QvnE=
X-Google-Smtp-Source: AGHT+IE+KnBxhwGNobJbXOr3K4zGMGNsa+Cd5ngofjNn+43VHAR/eXIXKEd6sECqqeVT51t6KX+9bA==
X-Received: by 2002:a17:907:98b:b0:b3e:5f40:9894 with SMTP id a640c23a62f3a-b7070874d79mr1554101066b.62.1762277834442;
        Tue, 04 Nov 2025 09:37:14 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2560sm269697566b.46.2025.11.04.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:37:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Nov 2025 09:37:01 -0800
Subject: [PATCH net v8 1/4] net: netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-netconsole_torture-v8-1-5288440e2fa0@debian.org>
References: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
In-Reply-To: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpCjnHeeVoXRsgwHwQxnRxXWEeemW2sJ4EBYmsX
 y0FXGk6XqaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQo5xwAKCRA1o5Of/Hh3
 bW8xD/9odEMuK5OOwO+nH8x80k1edBZ74y34rQI2QWEZU1+pz6t9hqDFimbRJORBD2CJlKH1OIG
 EKtP6o94T8IHeHR4rY//SatjG4tq9Tmq7fj3mVpCei12OAInLJEmQR8YA2DbLKFSwHu9uxIuWK2
 UwWn7FSSH++VREpBmpGTn1JRzBaQLqwDl6Zeu6jw5+6w4M+oLmOVe3XNY8VUP5HBvnUjLn2z50I
 aVK/78Q7c6LFft8MfihDZJ8ZbzSA5FiAea7NnDP99Yc+sSFi6X+vbyIiwC/zNJvm0adr1WeNvFa
 4ky30T9rfX0C8DLUj1usY6Cm1MR62iW+7dxt7eTqZgOVLQdbEFHbXUypOqbvNLp779hIJWPtDsx
 fD6dfWrV76sINNh2F8pSOdCuMEr+pfcaMmnVYTj/JEP6SWUV36U5jd8xSGR8AQbHAzTV7vNj+Gx
 GSluVBNukhZcy2xBibNIHPnEDZKJvu45VrY84GRfez56BnsBYVBX+LPNZspslsHi2z/HZVSfvOz
 /eRWArCW5NTmy+ys7wE/KtuNRhmvmYw1/Wbwm3XHZGPINTr5ca34zYI7BHthLFuF2Ih9XOas7W2
 6+P5v5lBo0s1SSg7ejgni0V9EWE8cGrax6vTZYvVGlh1A4JeqIJYTYlnGDVYFoxz0xt3xw0lOCi
 xrknU0d2fveKVEw==
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


