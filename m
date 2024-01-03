Return-Path: <stable+bounces-9245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E097B822A81
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 10:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA3D1F23FD0
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C66D18C2A;
	Wed,  3 Jan 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="T5YfhKX3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0118B16
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-40d5336986cso100608315e9.1
        for <stable@vger.kernel.org>; Wed, 03 Jan 2024 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704275331; x=1704880131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks0oa0YKogNtQyDRYtTec5mz65pLjC2m8lMsaisLSP0=;
        b=T5YfhKX3pmytkryLeMeC7YkwOYTgwxt4K4QGyPEhhloJoSRqtAmwivRGYWHJ8+EiMW
         GLtJyJExvW7so9fs61oIe5I7lzS16kYdLuv3/+/BAxVpVl+ke6B+wzlwqPpeDOPTn0/r
         7PeTRDkiSO584a1a3M6lo8pvNZfN1KmUE6ori+AX7VXVA6W1GQMLdKxxC13625DggJej
         E/c4etG9bWF9tZ6/W7ANNhLwhAv9o8RE4sbHkVPk1AFdmhU0MgiFMiZXnOvztqKqdPsQ
         jAMRXklctbxQXrdR4mjaRMjSZxMRsn8q6icpZprjovlJHc04zwLfMBnsG33byNcIrmsl
         D5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275331; x=1704880131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks0oa0YKogNtQyDRYtTec5mz65pLjC2m8lMsaisLSP0=;
        b=qLQH7ZR0cJ/4tXBT/NuOfH7cSAhu8p/NehFNkPNA2GCdY0pJUFA1SpebZ4i0vrRIM1
         dAMGy+rtHqoIvpNpxAo+fYajK85+FJ3NX1AtjkRE1aphKDGoWuv/qDw4xRvleW0Y4Gr3
         1tgP6DOdANW4EGUpkMYoS/6yG1R8oQ3JJGdOyh2a+ZN2MOhweJ4n1j5yH/yMBDQLmZ4d
         5a/xU+qnM+bSrfo2FeAtyhciWK3lCC/Rp6fKyXCmKVb/WJVKnbNPC76d+UbdnYrRmgne
         lbSxo0BIcpxaVVRJtxmN8zisy4dJLi+JUV1aI6bJ1yxX0CILpjLwE1Y4yC1e9ZNQf+i6
         re2A==
X-Gm-Message-State: AOJu0YwG8d9+1kPhUFC/Vi7xXUscuEhpX+FKZaYzqP1IotEniPGbe3Is
	76HPNUKyjv9OKM8+S4d238MwnIx7TLx5Jnm5L837EsA1UFp+bOQnnDQSNQ==
X-Google-Smtp-Source: AGHT+IGMP8tYoKtal31XwkHdMkNwswtiE9lm9Bx5A7p3hzqHaJBYNdOUaZISIkGA0l7Up8IfRIC+gCRgsj2r
X-Received: by 2002:a05:600c:34cf:b0:40d:924d:9417 with SMTP id d15-20020a05600c34cf00b0040d924d9417mr84525wmq.67.1704275331209;
        Wed, 03 Jan 2024 01:48:51 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ba20-20020a0560001c1400b00337092f3e28sm974780wrb.89.2024.01.03.01.48.51;
        Wed, 03 Jan 2024 01:48:51 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id EE1E360301;
	Wed,  3 Jan 2024 10:48:50 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rKxrm-00A3cp-Lt; Wed, 03 Jan 2024 10:48:50 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] rtnetlink: allow to set iface down before enslaving it
Date: Wed,  3 Jan 2024 10:48:45 +0100
Message-Id: <20240103094846.2397083-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The below commit adds support for:
> ip link set dummy0 down
> ip link set dummy0 master bond0 up

but breaks the opposite:
> ip link set dummy0 up
> ip link set dummy0 master bond0 down

Let's add a workaround to have both commands working.

Cc: stable@vger.kernel.org
Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Acked-by: Phil Sutter <phil@nwl.cc>
---
 net/core/rtnetlink.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e8431c6c8490..dd79693c2d91 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2905,6 +2905,14 @@ static int do_setlink(const struct sk_buff *skb,
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
 	}
 
+	/* Backward compat: enable to set interface down before enslaving it */
+	if (!(ifm->ifi_flags & IFF_UP) && ifm->ifi_change & IFF_UP) {
+		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
+				       extack);
+		if (err < 0)
+			goto errout;
+	}
+
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
-- 
2.39.2


