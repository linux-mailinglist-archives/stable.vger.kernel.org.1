Return-Path: <stable+bounces-58968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F212E92CCA3
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 10:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB61B285B17
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 08:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3142B129A7E;
	Wed, 10 Jul 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="T/metDuA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com [209.85.218.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31432B9DD
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599328; cv=none; b=NV48/SnS/+BXzRdbcTXCA2SBYezRwJU1RUeljBJpHt1Tb0x6xnBGrK1Zv6Eoav2oD2BQAm8vOLtvf9EFy2wSWhPe2+gkqBN0dhGni5z/EFEBt8yKvh4M5z8VKoecdI0JSEVnnR/jDktGQekGxUjSM8e027gMjl+6qcX7538LVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599328; c=relaxed/simple;
	bh=ibX4c5HkiZ3iw5b7jPJhH6vG8JD5H5pnTuVXtda0FQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkMyMWaTOIImLQvHi+a18a79tuRfzColK9mQUpnYx/G+SDur+6eCufHgrNBi/LPJlorlQ6R5VTfx/RUMAyaxAEu1hHwFY3S1BkjzXfwqTExotVw5cUiATsqNKf/TmkDAOLQGtt61qeka7KKdj7fIZtLW2FymwRxDbG1tNqFmWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=T/metDuA; arc=none smtp.client-ip=209.85.218.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f100.google.com with SMTP id a640c23a62f3a-a77cc73d35fso104909066b.0
        for <stable@vger.kernel.org>; Wed, 10 Jul 2024 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720599324; x=1721204124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+/8q0n9zIZuPd8v8xe46w2FL6quvs2/a1bhvxAdF2Y=;
        b=T/metDuAkdYsaCBjHaBokk/YlHcnYu5CvlQzpOP7OCfeyKkqhNDkvJWf2AWHa0vkxv
         3hKis11NwAwgJ0AgPGlQ89okk0faJluhfQXzhZVHxQZKH6L0VeKJrzj2DepUB4HcPOZz
         UAtNL7QYBxW6cApA+aSCEP2cIxu5EhYtNa6QZK8ifaJQbob1WojsA6w6OVDw+ieHVfd5
         gZ+O8K4h+Bgenz0axGti4Mgf0TPGamAZC4KDMgFBgX2zBMs5Qv+lf4SXBR5vfQ5BE2U0
         1moePgBzxAdvE0GFKsYdBaWTmo1oPnznenpTo04NmY2w6otMNugH9c7dtu2gtNOTfdRA
         +jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599324; x=1721204124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+/8q0n9zIZuPd8v8xe46w2FL6quvs2/a1bhvxAdF2Y=;
        b=YX35IaivhufvRn+7yuBSxfW/LlTq6hy0cbihD/rLRwo0UTKMWVtsCpKBeFyiIV2F3U
         SbLkpS7kLUidPGGJFwq5QCBJOf5AnAinELh+QTuLAOITQbM8N3AcvnrIFFDeE/3pkaPK
         T3BkT8kLammnr6aWSkN9ZdGxsIEKW8x3BiTi3h1RZo5JeGSn5PNDZG0lrYJGlRZH/aGG
         qlttUPKrtB3kuTRvxt+4HuELPiPhgWM2ZQv2dfL+KEJEbjS4s5O90eCDQhhityhkNlSP
         Hifeo7M0i0PESoF30G2BkywMPtmltwB5eW7EWVDxSMI9vvFrjHdshtWmZa/BRZh1wOm7
         YKIg==
X-Forwarded-Encrypted: i=1; AJvYcCWSwtS8EjjAvle5UB0WEN3NAKyzCrISTs9UILFX8fEqd3u+GRA162DOKp2z1ghYTRvyErrcKpQzsIcB+XQkGvqTTteBOwQA
X-Gm-Message-State: AOJu0YzxdmaTdOEzZ0hehDHY4tNascDmXRRcQzfPgqg9oLohGgbYDLY+
	6konet7A/rv+46ATdfFRtm90er5S43Ie7oH9go0KcwZT5muoJ4m0VlZxCi/QjLG4Kz/G04z48gK
	NogZakU/JcvDtkvbgdbJftSMUUKiVBoX+
X-Google-Smtp-Source: AGHT+IFsldb2fu9x0xbmMVclMdscPmCxu5if7Io4zRFog8YBq09ulvZ48ZpidT+5sDJQbv+HPV2iFLgMWMoi
X-Received: by 2002:a17:906:4e89:b0:a77:d40e:7b2a with SMTP id a640c23a62f3a-a780d3f441fmr250384766b.37.1720599323967;
        Wed, 10 Jul 2024 01:15:23 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-a780a6dc788sm632466b.101.2024.07.10.01.15.23;
        Wed, 10 Jul 2024 01:15:23 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 8E6FA60466;
	Wed, 10 Jul 2024 10:15:23 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sRSTz-00Fz72-8k; Wed, 10 Jul 2024 10:15:23 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 3/4] ipv6: take care of scope when choosing the src addr
Date: Wed, 10 Jul 2024 10:14:29 +0200
Message-ID: <20240710081521.3809742-4-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240710081521.3809742-1-nicolas.dichtel@6wind.com>
References: <20240710081521.3809742-1-nicolas.dichtel@6wind.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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


