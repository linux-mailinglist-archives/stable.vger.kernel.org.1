Return-Path: <stable+bounces-9975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D00826AEC
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 10:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0BD1F221C5
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3E11CB2;
	Mon,  8 Jan 2024 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="UiwqmSFF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f98.google.com (mail-wr1-f98.google.com [209.85.221.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9F12B94
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f98.google.com with SMTP id ffacd0b85a97d-33694bf8835so1546124f8f.3
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 01:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704706864; x=1705311664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqm8T6ZJilGE+jPbAasz3dYt01ixeTiw6V7R5wFltv4=;
        b=UiwqmSFF3c+FLWWOU69nd4YF7hzGVkR61HubNl7UewJ+FcUCRg1pWlaRZ2+NVg+hKc
         0uK6SrDwXRPHV0l+P6T9KsmDKaZZcjjm5aFPqCbk3EswlgZPyCCeOcAlz4JQTLBWSpFq
         Ol1EaYrE8LhhnTLRgSTu5vsF91cWSeCEPo7/a8Oa94MhOrgmFytjjPj286FuFLHQhImL
         MIDWXlf7jtzmk/TZPe5ng9eOAF70jI6TY4i2tb7nWe/e1AnZjHiDh1gmNaGcjFB+QuSa
         oqDo8P8rMwUj6QoKmJH+3hyooU5uw6aG7p9vZAYBdWF2Fmu/3pUtuP3CIIEU7GTZRvBI
         RlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706864; x=1705311664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqm8T6ZJilGE+jPbAasz3dYt01ixeTiw6V7R5wFltv4=;
        b=gDbjVMFycmgsMGFFPu140Qx4XOJ/32SMIREdAJnI7vIQc3A34PtfOE+d/Y8fsL8HgO
         XuwAYshJV3ni9AzPemQ3njvjtYmMzvfbxS8CAdQCZnfGrF0vD1qbO5PyMLqryvA6hv+z
         zNp2mHbzY6TWQdnaD5I5WKrBmX5L1TZr4XKBy5dvgEak5dA4JziwIW/NYr72QEMFleIV
         +Fx8hKlcIieTj+6fBAZxRx1S52hGIcAylLSvAtNnSjStgtxUkW8q58bOhKwDoynY1xa3
         u90se4OOLvEoGymTjxG+gC1Of0pJhaHZI5+zJPnfgDt0i/YVky/k9m7fFc5xhJp8G0RU
         FR/w==
X-Gm-Message-State: AOJu0YwhoR8N6fsSQJFlVQtQOLNMtievePZOnjc4PVOvwOtRa0m2wdLo
	jyYcyoO2fckbmHMVvOngyqGwRurqOdQ8+RK0T2nB4Vi8xXCRChSHZgEc0w==
X-Google-Smtp-Source: AGHT+IEGYqCa3uqlQ/n8N3+SJuTlMWe4RkG6fop1gZ3cyiPRm0yClTlYfRj9ztkelTbGVOKxJT/K/vZQCn5E
X-Received: by 2002:a05:6000:188b:b0:337:6804:446d with SMTP id a11-20020a056000188b00b003376804446dmr1432569wri.72.1704706864495;
        Mon, 08 Jan 2024 01:41:04 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id bt28-20020a056000081c00b003372c0d3e4csm391867wrb.78.2024.01.08.01.41.04;
        Mon, 08 Jan 2024 01:41:04 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 3CFF760106;
	Mon,  8 Jan 2024 10:41:04 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rMm7z-008OeG-Uy; Mon, 08 Jan 2024 10:41:03 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] Revert "net: rtnetlink: Enslave device before bringing it up"
Date: Mon,  8 Jan 2024 10:41:02 +0100
Message-Id: <20240108094103.2001224-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
References: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a4abfa627c3865c37e036bccb681619a50d3d93c.

The patch broke:
> ip link set dummy0 up
> ip link set dummy0 master bond0 down

This last command is useful to be able to enslave an interface with only
one netlink message.

After discussion, there is no good reason to support:
> ip link set dummy0 down
> ip link set dummy0 master bond0 up
because the bond interface already set the slave up when it is up.

Cc: stable@vger.kernel.org
Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/core/rtnetlink.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e8431c6c8490..bf4c3f65ad99 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2905,13 +2905,6 @@ static int do_setlink(const struct sk_buff *skb,
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
 	}
 
-	if (tb[IFLA_MASTER]) {
-		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
-		if (err)
-			goto errout;
-		status |= DO_SETLINK_MODIFIED;
-	}
-
 	if (ifm->ifi_flags || ifm->ifi_change) {
 		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
 				       extack);
@@ -2919,6 +2912,13 @@ static int do_setlink(const struct sk_buff *skb,
 			goto errout;
 	}
 
+	if (tb[IFLA_MASTER]) {
+		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
+		if (err)
+			goto errout;
+		status |= DO_SETLINK_MODIFIED;
+	}
+
 	if (tb[IFLA_CARRIER]) {
 		err = dev_change_carrier(dev, nla_get_u8(tb[IFLA_CARRIER]));
 		if (err)
-- 
2.39.2


