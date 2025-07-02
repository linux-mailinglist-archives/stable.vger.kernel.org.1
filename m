Return-Path: <stable+bounces-159243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C0AF5AE0
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 16:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EF91C419C6
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A0F2EA746;
	Wed,  2 Jul 2025 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqnGC/ha"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E12E92A9;
	Wed,  2 Jul 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465746; cv=none; b=CvDRCf1EMG8YjVR/Yw2MIP1TmFs8XTGDc+a1gh9tnaSKf5Ey2PEhUCXORB72t5l7eMS8Dw0Cds3p3r7VjlMPO+IYcxK1r1osVTMcwIuRXd1F5udRFcJf02p6Z2rs6F2ykn2+ywFP9tHPo9Glh37K8ZX8oe9+g8P4NDRsJAyQvNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465746; c=relaxed/simple;
	bh=hgVRR0PR/ckdvyIGS+3hX9AlKTj2YA2xeoGPQSp3j2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IZ5A8/3qs9brtsmC6g6kt4o9tfvXmYt/bcIrvXEzVFKxzqQzC8q1wC5ZZTXspLj0ZX1ErQdSnuRe532enqpRawJ/MjZ+drMPbKXiPAOYP7+Hqc2ZSWxYDxKy4JrWU0DyyhOis92L9mSVqaoC1+VrdFpup+oCb/fwHO9RmyGLzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqnGC/ha; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso45878185e9.2;
        Wed, 02 Jul 2025 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751465743; x=1752070543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRZoP19mVo+xouu+rD216ylrbdoQ3y6C2mRJgbjte3E=;
        b=NqnGC/hafxF8eNkpoGDhrJ4+tPwPj1Ax+5kt4hyHS/rGmNZfEGnZiXEFU+nJYEpFoL
         P4vg6JVSxCSyV9N8ig/F9jr/iQmyWktCL7IOuEkP6xm69MBVCQTtxMMIZ1GCoFnYhnTQ
         tctfcmFueMaIlqTFo6a8ROghh/PFm5BYMFxIBUjySRhIycJHYxtcdgLO0leRnKz8kjYQ
         eTGrVkXFu/6gjptbooXGrwomIs3c7+NVBQn/ncpNvImTLDRcfhb9rqOtR3yOiUfUQmzE
         hzj6tL9IP+ihXXH5ThxQyHq8fi8aUacUbIE2gA7jMP8wGoEN2L2oTAOstOx7YpAbQ1CN
         Jerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465743; x=1752070543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRZoP19mVo+xouu+rD216ylrbdoQ3y6C2mRJgbjte3E=;
        b=S0Txyx9lOmWoQdmV3rK3PK24puvX+feGNsp8gyhwfNwYIM7VFMbSbZv7RezyKWusYc
         dmxF4YowsRERHHtP5TIQnke7IWzgjTfqpg/IY0U10ag4p+TO0YGstovEQEeh5nMyftZM
         PoL0FTNOxINZ2smEa3QKrjRotPZLhcQ24e/CPv88a4WMlxc9ceJoqR2VXFSsZ8P1Hlrd
         rSyRbRMjVpom9XkHTsq+RGhaE+kDa37BGUNuJFJ/2wXNmFMshVuf5Kv9Fsrc9AB4sptM
         lne4gUWoD+ysESc0BH27+q98x1XMXJIBJyOdoy932a9Q1+AyeJ4eaL/XpUGz19S09uP0
         5PqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlWgGEIzUEtyJqYJRwM+7fnTu3fyNApoef/hP2SZbiM0ddjc6KzUvOwOTPiCE9ciWy+G53/jVRCP2Eltk=@vger.kernel.org, AJvYcCVreNWHzA0TxrZt1ucIRUNu4MofXIGNMT6vEKginxHz36kQ5sTnrvVvyXI9DdGIv2Bnhu2Uomcc@vger.kernel.org
X-Gm-Message-State: AOJu0YwA/50wZGmT9hCwqziMS1MQUnSQzb3qPTGLyu7bbA8+/kZUvtJa
	paQWzdBnM7PylpepalbAo5Qz3cjPR0F0bdtesB6qmemlTGUCAVVo5iEluVgzW5GI
X-Gm-Gg: ASbGncvHrBdeTUDdQ7zTklvwu4F+dWeFKWLriNxmd0DEm+LcOPzyrpzynv/7hWeD6w8
	OTfjmyJ1bkpgFqS/5pw5y+NzVznHs4/ayr6uxzPEy9URQIwgETDC7HYpDKqRpeljFa4u3BTuJZ6
	VHfpciuv3uL4MgcJyvYIpLWroMrOgfw/eTmOoxq9Fa+aRos1s2td2UlZorgHM7MAy+z5nUHIPXf
	eV4SuzY7hf7BXsq+Ie3HUrOkk30EIu/hz3THaX8bYpdSiCBj23X+mZPahLtSvqXlinxFBTyIiCE
	znLwnoUB6L0dXSM0gxlmGxaXozGecNTh0AIwM3+IJmslM0nckfoFHfFuvboAXqdqK9nKv3tEBt4
	=
X-Google-Smtp-Source: AGHT+IGKvUHBAcdt7Y5rZZoCKXs2ZNpvgRwAwjxch2Y9eD+LU5/6F49qKav6+2grsiDSPNdbmoOjmQ==
X-Received: by 2002:a05:600c:638e:b0:453:59c2:e4f8 with SMTP id 5b1f17b1804b1-454a36d80d6mr29507715e9.1.1751465742339;
        Wed, 02 Jul 2025 07:15:42 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4215dbsm198343375e9.35.2025.07.02.07.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:15:41 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net] net: ipv4: fix incorrect MTU in broadcast routes
Date: Wed,  2 Jul 2025 16:15:15 +0200
Message-Id: <20250702141515.9414-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, __mkroute_output overrules the MTU value configured for
broadcast routes.

This buggy behaviour can be reproduced with:

ip link set dev eth1 mtu 9000
ip route del broadcast 192.168.0.255 dev eth1 proto kernel scope link src 192.168.0.2
ip route add broadcast 192.168.0.255 dev eth1 proto kernel scope link src 192.168.0.2 mtu 1500

The maximum packet size should be 1500, but it is actually 8000:

ping -b 192.168.0.255 -s 8000

Fix __mkroute_output to allow MTU values to be configured for
for broadcast routes (to support a mixed-MTU local-area-network).

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 net/ipv4/route.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fccb05fb3..a2a3b6482 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2585,7 +2585,6 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 	do_cache = true;
 	if (type == RTN_BROADCAST) {
 		flags |= RTCF_BROADCAST | RTCF_LOCAL;
-		fi = NULL;
 	} else if (type == RTN_MULTICAST) {
 		flags |= RTCF_MULTICAST | RTCF_LOCAL;
 		if (!ip_check_mc_rcu(in_dev, fl4->daddr, fl4->saddr,
-- 
2.39.5


