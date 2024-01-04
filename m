Return-Path: <stable+bounces-9713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD8824685
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 17:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2533D1C2405A
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712042511F;
	Thu,  4 Jan 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="HM/HuIjZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D9250F2
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-50e766937ddso799951e87.3
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 08:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704386584; x=1704991384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJSHKaFi6Wuik3SbRA8uZxLDJSaz0g6Q6tKnT5H2s7E=;
        b=HM/HuIjZASxqHyW6Yg3Ur6xd+PgwpfFsaL7kg44eh8UP6XaE8mU7FIaZ7b+w7Q5tXq
         WqAXGrfbfiRIFNdEbdo08Oaj50yi9f77jHupAKZ8hcWhvH1fCMA3nrhE4HmLszuzQ0QI
         KM5l3jDU6Ov92QOv8dpHAPQ+SPC43+yrDBZuYsy8Vwf44XDsYziaFeavXU+PNYAozdQJ
         pl1IllAwS+8Ugg0KYF6WbEZSOvvp+AW84Nc7kxfO/Cd2ex80CO7qrU7Cb1AIWKNbst+M
         t1QB8Bf3x88ssfUOKwZYB6sPEONfIZIZnT0AF6aysMDr9KQhx5ylcSKFUy4JQ0GhlUwF
         VHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386584; x=1704991384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJSHKaFi6Wuik3SbRA8uZxLDJSaz0g6Q6tKnT5H2s7E=;
        b=CkootdWO+5PBiJqWT/yPGnM5roo8pbmbP1c0MXTGAFafStWv37wMVTWrOllkdTbR6X
         ffD+vNCVe8HyqHJVJOqPKi1A/3SrSjktbp3CgA3bTJi0Z4N9x2Rlt6O1BqRhnX8W9OtD
         1iHTrLQGK1w4p6E88/V+pECuBcNe+Sz6D4bf6i+Z8VNjNLebmJrcZKUY2hUJocFvjKYp
         X/IrQ01U5Wl1ob1dqFkRJ4YMdioOm+kyQiHqhgPvMHDUbBfE2B/pH/S1iDoSRUOAjQk6
         0aQagfrctmzbIHlk4kN/uB50J89C8S6oWv/dZACazYTqbP1/cwAZ0L4Z9FUq+xPoGE2H
         1SMg==
X-Gm-Message-State: AOJu0Yzr3GsrotQhQ95vaFIcrVjbLmvI7MRZ38XYi5U5QP47FsFNRp/v
	ZRs7lw2FQbK2hN2dt6EMh2JTG2NTOM5AbqFqH7Z+gL5f1qlVdigQXxqOmA==
X-Google-Smtp-Source: AGHT+IE3vzXX3LTLF4r66FdYhGqZZMGnrFFvC96R6K2fIR/U8LfG5ZawI83QJe8t4qb3k0WDFxoQofE3xrsJ
X-Received: by 2002:a05:6512:e9f:b0:50e:85be:e03b with SMTP id bi31-20020a0565120e9f00b0050e85bee03bmr490417lfb.115.1704386583677;
        Thu, 04 Jan 2024 08:43:03 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id y26-20020ac2421a000000b0050e7bf6fd89sm729485lfh.66.2024.01.04.08.43.03;
        Thu, 04 Jan 2024 08:43:03 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 21212601EF;
	Thu,  4 Jan 2024 17:43:03 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rLQoA-00GEpg-QM; Thu, 04 Jan 2024 17:43:02 +0100
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
Subject: [PATCH net v3 1/2] rtnetlink: allow to set iface down before enslaving it
Date: Thu,  4 Jan 2024 17:42:59 +0100
Message-Id: <20240104164300.3870209-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
References: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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


