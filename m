Return-Path: <stable+bounces-8682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEAC81FED2
	for <lists+stable@lfdr.de>; Fri, 29 Dec 2023 11:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482BF1F23610
	for <lists+stable@lfdr.de>; Fri, 29 Dec 2023 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D3510A1B;
	Fri, 29 Dec 2023 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="QS0s+loO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f98.google.com (mail-wr1-f98.google.com [209.85.221.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211A10A18
	for <stable@vger.kernel.org>; Fri, 29 Dec 2023 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f98.google.com with SMTP id ffacd0b85a97d-3369339f646so5656816f8f.0
        for <stable@vger.kernel.org>; Fri, 29 Dec 2023 02:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1703844524; x=1704449324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qN2AySqHIVWazQbwOSCTBYt1qaBst2lx7B05hPGcnJw=;
        b=QS0s+loO5hmdVclRL5EKBAwciePETSkeDYk8oebwNuUj+f+3vjqdpt2wCeQZ1tQDJp
         +RnaC42U2ut390H8aOHOhq3alTsfMIkBW0nwTvKTAkbq/VOKG9YQ1Bd6xa/TeCctO6+m
         9llU3SjnHEglf/QFUbXvoZ2ZRfnWl7GrAdDj8HwqyNOt2sPTV4dqoehDK9AxG4rFX61X
         thN4+Q/rIzuTTlXl33n3LIpOpVJJbK4HcCwxkd4vBtp+nZfzwLx8zo6SagsbM2DWVvw0
         YPAYKpcEm4LSTslEtNT+3sJ/nufDRkX85MHDLmFd0asa1bmoOxhffrbCJCkDoNCz5rwA
         1z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703844524; x=1704449324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qN2AySqHIVWazQbwOSCTBYt1qaBst2lx7B05hPGcnJw=;
        b=ahFJBOD0YG6zSuR/6ZBmZE/xNkqOgY8DY63gkZFMVLOC1/DrlSeqcSZkrvPcI/QS0s
         GIsN25HfsTBwjCfawl+iC4u/JnwEjaSbPxJR2R0v1KMALlpeOAp4VWKWVDmsIk3hyr0e
         YyjFji9/8z9jh7Y2oH6gYcBIxQ4cHqG9dAC0q7UHRWXGXCaQrpAzd98L6Gl/vM6dmaEH
         VUG+Gl9oBeCidfWO8jBsxX6nL8sL02gICh5n8hjYpxtT+SWr3Gb1VeKmCuZ8Bamq3hjC
         BBT9ewKTJ3HtlXsz1WO18FM4PoGDuHAJvroFa9fqOiSCsSUR1Beps5UrfwbcipSpHJ5Y
         j+3g==
X-Gm-Message-State: AOJu0Ywo8avIDYkKQxEuFa+WTRmoswW5pl169d8v3kXlhZ3YrvFsd2fp
	mZIqVlR0cWExxKEB9WxBfhewflZ1gh7MktfrKMLKBL6vym2ddk0KK+5Svg==
X-Google-Smtp-Source: AGHT+IE3Msn/QkpYTu3dm8ZvoeghZneX0m4ay0PqWn2cDbh+KgTRbOhot869pbvPEsCG/qDIeYZyDQoU82c5
X-Received: by 2002:a5d:644b:0:b0:336:6919:9180 with SMTP id d11-20020a5d644b000000b0033669199180mr5578845wrw.38.1703844523914;
        Fri, 29 Dec 2023 02:08:43 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id b10-20020a05600003ca00b003372b662986sm28217wrg.41.2023.12.29.02.08.43;
        Fri, 29 Dec 2023 02:08:43 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id A2170600F0;
	Fri, 29 Dec 2023 11:08:43 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rJ9nH-00GlmZ-Bi; Fri, 29 Dec 2023 11:08:43 +0100
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
Subject: [PATCH net] rtnetlink: allow to set iface down before enslaving it
Date: Fri, 29 Dec 2023 11:08:35 +0100
Message-Id: <20231229100835.3996906-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
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


