Return-Path: <stable+bounces-192630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 619AFC3C337
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 16:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC6B1887FB8
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20C5345731;
	Thu,  6 Nov 2025 15:57:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7D33E345
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444620; cv=none; b=qKxv82NUzR7Mk6ytqtrTAgOmv4bnmichbYAIr9MQhk4ep9V+vp6J0CRbcsOxJ9sHPn2ZTNGkTD9JeXAe0KwiytGoBtssVJvm+9vpuB/obfXknSG64327nlzisNHn+gsgLd189z2elkHSdN3jyoBYJT+9GCPRD/MVnlGtQ5BB52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444620; c=relaxed/simple;
	bh=PBufnVhc0vYw6K1yqEtQER08QOskv29ELpqGFdftBe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOH9RDuLbiFd5YA314IldsCxDZHoj2LGp77tnY24tA6n9vrSUjk2Icpy9VR3XCWMfKPK2ABkPAwwvZHsgUMVCZxWen9EFAWa9tjRTWxaZTuEvHXknka64bN9dhq23sEpei8ggsv21v7wuVLHGaSYGu2ptqOxaihxkEy8m+yLKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so188541466b.3
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 07:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444617; x=1763049417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjGKFyPmmnOORJmfJYb79vkMgO3eaKsfbWlFTGwHffE=;
        b=nzFWERNl4xFWEuOieGrVDa/u0vebK9IVybLhayvjFfd/bZcQc5cLoYb1qXAEY/RICi
         Qw1wykcNj+FFXfi5LIuKI6zAL5BhYb8x39bNvKTxiyaj9JcBIFKsnKbVc9V4OOtCfner
         M0VJy73HXqSqGc45wJSUPuLQOb7eeE+/D+RT3qMVEves3QNlll4LPxlP1dMRWYV5nNXV
         W74mWyPfKRJL6ilRpH0REYGkrGx67p/DheQFpFCtH4E/H810kxhYs6sSzlPeO9l02EM5
         TJmS3BiVuTLmEOXZ744Yg5hODPQLDboLohnAd+RFa1yxKWf06KSbLnkWq96JUBM9FiI1
         jMVA==
X-Forwarded-Encrypted: i=1; AJvYcCVWkJnT13xCKnKH82xmhbLgUFF/c6xumaKfouGjVRHd1PT/H27dnS67NmxxDHFVnWzMI9yXEMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8GJznwzBbVfz8m93UrTs2Dri6kQTfztTwmcatrUttLd4JkNK
	pXSdA+le1wpcFE0xpOs34J/ysrv9dARuhA4+FCsRU+U7CYozSS8s3mEa
X-Gm-Gg: ASbGnctU8rkLEKut32VN4vuYWcyrBRsJF3HkjcFFlz8YwEjuPBg1x60dUEn8SuNf03I
	ypI6ck+FpUnK13hHoJBsA3uQyUWOKm6mKwA6lUPHfWT8vCEOPxmR2UcIBpJ1k8CDcSWO+99vU9G
	RD5TQxzeWEQ+12B+gVrk9kdyd7nwOAPqmJqSjjtU6BbW4s2qPCn27w5iNwExcv/sasa0aKAtB+w
	/1Ynp3rUBPWOA/EOecPD3xZ79Ihrk+ZCgGoxvL6ZGO4yFeI7nCaEkVGAz93ejfRCLYOuRtuz+5x
	sSkQaihDFsSDhd+02dTVmeJTR637zXX9vFXNWMXesLZRu1gbbuvFPy87Nd7/X+ia6gVxlt4/kxW
	s9ULjFz/sMSsk3ucqm1Voh1aSyS3S/K4xuF5vi5GpK356W3hhE03ghu9LwNqpU6+7DWyxzCE3F3
	OAoA==
X-Google-Smtp-Source: AGHT+IE1I3KsdrFfPzR8ZbLblQmlN8xA2lL4chWTQNh9/e/sKcWfQSx/nPRWrqzoh4RnHnBtbfozTg==
X-Received: by 2002:a17:906:f855:b0:b72:95ff:3996 with SMTP id a640c23a62f3a-b7295ff4f7amr227875066b.10.1762444616910;
        Thu, 06 Nov 2025 07:56:56 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289334090sm250482366b.13.2025.11.06.07.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:56:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Nov 2025 07:56:47 -0800
Subject: [PATCH net v9 1/4] net: netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-netconsole_torture-v9-1-f73cd147c13c@debian.org>
References: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
In-Reply-To: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
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
 h=from:subject:message-id; bh=PBufnVhc0vYw6K1yqEtQER08QOskv29ELpqGFdftBe8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDMVFPcvHaEIvqY/K0FMrxc5XuLCG7DPYcVfKr
 zAJADuB4YiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQzFRQAKCRA1o5Of/Hh3
 baWiD/4+Jm/bGM23oRiaStiDbJzcHe9o+DQub4eeoFUmIU9ViAwTIOYJKC2Nqx44QF5Nx8VSWWf
 U55ww+CydeULqtsdCNc2D1LQf2uqpuVKSY2yEhgy416XNIB960v0vxXwc6PNUWqu9qNtn2GfXoO
 g1zIdEe3lPWnVzETl1lt8lsapfeQ21XNwWIY+QQbD3FICLeTGLhzEOsgFyRjw3M/tdbI5OetPef
 O7qwcMiXmdoZvQP1GpQfwZX+F0rLI4+vAVvI3gWMKlKqYRf33nCY8ErINNcKCcrPI3DVuIojB7G
 eLwPPnpn4RAcs6PAkaoU9Nof5DA50QAndSBbjLMr4E7ez3GtlUE6q5SjnS/HGs/OdgPyf4sL5sz
 lXQI6/GJgcCIhciHAFVD5vlOSderxZGNeEXfvkJGgqtVLnw7EAbH+u0UmQchNTlCixBV4VEpYi1
 4BwLALvT6ST/xqAacz7ffxsGDAMiAAQ5wRy4y72V6kmBu4AvCFyZC9r7Ea4cFuorwtl+Vf3mVPF
 qN1Kwga41B9UVEe/YD9UeNdg+q8E06PtLpdLF96ocI0+VRK0Tt5lGoTpYZgq8ljGhglTbtF7fyN
 Hiaal6823bpg7LCdP7+xCRFdx98EpWj4VoWZWzBhYskGMkmosh1qJAQVUyoybopbHFQM+lXOe+t
 8nTugHL0cqI6kRw==
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
index c85f740065fc6..331764845e8fa 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -811,6 +811,10 @@ static void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -820,8 +824,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 
 	skb_pool_flush(np);
 }

-- 
2.47.3


