Return-Path: <stable+bounces-58140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE0928AF0
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 16:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3041F240F7
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C972F16C44C;
	Fri,  5 Jul 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="encaNi7G"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF5168490
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191187; cv=none; b=oprUSdXl2hh9Dxz7XioPbWbbFjM/viyMMMfw1UJmD3qcqjW8FjH9+8X8Hhihdr4ukiOncMllT0syAb3QgiCGoQaIUW82P6v6U7EnsvrJcdb2SJvkx5MkPTE2JMaIu6rgWUVnTPaVb03ouKmO9UAuXEttrDlb4utQoh4U1Fq0lQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191187; c=relaxed/simple;
	bh=F18MNQqMgi2s1pXAA8VazUOW/a2/fCiXeYMprACDpHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7tnr8VN0a9GhFbfl8zaQt7vr7YXh35TPb37lFht4d5roaD08eWw4BVx6+ZngwCCrtsv6gwBE1oJWvfZl+JrCrN514eyRbgsSguZ6hoiemnM6/QZJS2DMpjYuNFaZLXDHkmk8NVKMEC4kxbCOxhAr+gu8bq4sxuexrf9bVysZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=encaNi7G; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-424acfff613so15336085e9.0
        for <stable@vger.kernel.org>; Fri, 05 Jul 2024 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720191184; x=1720795984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cua0A6GEdu0iOk0GUptHeWMm27awSaljV0LV/Qv+59A=;
        b=encaNi7GOlrKYBKwmzrvXcrkPfMLu2jnNRiVKRM2Eh71Q8u08shElZhWMePgZjyzCH
         6I/+GoyWJqTOU+rm1RRhdCSiOKhPUqXKPvnN2hm8/mgmI5LwLMnvFw7G34ZxM6GjRti4
         rr5POLDD5uZfr3STibRKCwC98e1E0ZxsHQH0LqnoNnpZHrl9DSn1U8F79gfsmcpPMicp
         HKn/JuH591G7kCdouYw5PGsBVmFPa3mFhxaAtG05c7mSZBAHNe2BIWgETwtREy2iwY2i
         ZUTKPhm4RZLaRDl+N5cDbCmbO46SQ9bwswvlxgcf7aaFua5YBBK7m/S0vNgtHaJcb/jf
         2q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720191184; x=1720795984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cua0A6GEdu0iOk0GUptHeWMm27awSaljV0LV/Qv+59A=;
        b=ZCBlc9ccFO2GLnCFvRWpQJfnaqfbki9v1drbTNhtFnB56md7gV5rOt5oJ/MtTY91o2
         v2fMtWWB6n3QmZ75fgfjfz9FzgYWiys1+h4aqWVqtBczRyASjOXdMTi4iOptIgXokpjV
         2CFc+Cmwoyv+KSc/6ASO9GLJ3ze1eNc9kixfhyA3358XbOT5AaOygJFNVUdW3V9amZZc
         E1iCZVVppKdxTlX6I0SjPBI7R66dr/enBv1NPZMxGE5cPhp8VUMLph46BDlnwtiRwwkQ
         qc367upPfIfbWYoy+IGtGeveY6+HAxqnJLp9cCHgSiXj2hX/WHipQ9WaZaJVzghdFWtW
         ESig==
X-Forwarded-Encrypted: i=1; AJvYcCUul64Dmrx6kywJdbDl4NnTzPHbplE6PXD9YOzR9JbcjzslRoZvWfIP5uh7QQm9PMj7gfUXnK5iFj88u8zeeWaP7VQ8YuSK
X-Gm-Message-State: AOJu0Yyw3yoQjrFWxzz8I+mSNvkQIQ1lR0gURU+d86uLWHZ+1pKzxunT
	/dgeTuiZOwzV9Hr65+nUcI3g1x1JKy91xYzn5feBcObNRLDphgmP4ZO+yzXlewBRzrQMPfsTi93
	WuE4R19czDU2ZhxMoytrwFQs33gqR3SM6
X-Google-Smtp-Source: AGHT+IH9MttpwefKxSrmvypAnuQVniG8F6vZL0IbtrTqPdUBDTZbEsd+LavOwor5RyVYzU89haCcdqOITvr1
X-Received: by 2002:a1c:4c15:0:b0:425:5f73:e2e1 with SMTP id 5b1f17b1804b1-4264a3d9500mr42617415e9.22.1720191184117;
        Fri, 05 Jul 2024 07:53:04 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-4264a2fc94esm1385335e9.47.2024.07.05.07.53.03;
        Fri, 05 Jul 2024 07:53:04 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id CD86C602FC;
	Fri,  5 Jul 2024 16:53:03 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sPkJ5-007Cqg-H2; Fri, 05 Jul 2024 16:53:03 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/4] ipv4: fix source address selection with route leak
Date: Fri,  5 Jul 2024 16:52:12 +0200
Message-ID: <20240705145302.1717632-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, an address assigned to the output interface is selected when
the source address is not specified. This is problematic when a route,
configured in a vrf, uses an interface from another vrf (aka route leak).
The original vrf does not own the selected source address.

Let's add a check against the output interface and call the appropriate
function to select the source address.

CC: stable@vger.kernel.org
Fixes: 8cbb512c923d ("net: Add source address lookup op for VRF")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/ipv4/fib_semantics.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f669da98d11d..459082f4936d 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2270,6 +2270,13 @@ void fib_select_path(struct net *net, struct fib_result *res,
 		fib_select_default(fl4, res);
 
 check_saddr:
-	if (!fl4->saddr)
-		fl4->saddr = fib_result_prefsrc(net, res);
+	if (!fl4->saddr) {
+		struct net_device *l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);
+
+		if (!l3mdev ||
+		    l3mdev_master_dev_rcu(FIB_RES_DEV(*res)) == l3mdev)
+			fl4->saddr = fib_result_prefsrc(net, res);
+		else
+			fl4->saddr = inet_select_addr(l3mdev, 0, RT_SCOPE_LINK);
+	}
 }
-- 
2.43.1


