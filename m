Return-Path: <stable+bounces-58242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A642492A8DA
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 20:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57ABE2828EF
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE4414B97B;
	Mon,  8 Jul 2024 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="hXRjdcdH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A32143C47
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462560; cv=none; b=gI7zcAjhlRvPbLC4W5JvXN/RdVXq48RVXnful+290udxK7n/jZDRih6Jx5bRbGwcX0GAUK5LneI0ir8nTbhigQrI6MzNgK0cpWnnC7dddTbE81IQMpT0OZZDBQf9EkQWIUuZ2m0qdqnjQt4urzm/1qiLh1ZX0D86gaOuI4/mZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462560; c=relaxed/simple;
	bh=ibX4c5HkiZ3iw5b7jPJhH6vG8JD5H5pnTuVXtda0FQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2us0uiG7Dxgi3HDxMgkTB+EGk3Tpibk/KIpCdMiYuUqwVVmPMc+I8BFGbaPXkD4IppqA8glg1vRO2YSM+f4VoLp3vFlnOInSsap3dKPJXyUtplQOfB+YjkISrH/ZPQWxOW7+UNn02Pisa9Dkq0moD73QVrPHJBTzYb0uXjHob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=hXRjdcdH; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so3543315e9.3
        for <stable@vger.kernel.org>; Mon, 08 Jul 2024 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720462556; x=1721067356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+/8q0n9zIZuPd8v8xe46w2FL6quvs2/a1bhvxAdF2Y=;
        b=hXRjdcdHmxm/tcHT0sBlC684I1RGpJA+OZtDlBl/w1Pf91zHUzaPAGpLZEA3GBX5NH
         mLbIbUV9QKtHy7YxrCtktnVPYPIu68DnvTFSkkfhEQCAQkpWAnr/Kvry7DL56u00ATbO
         zNJ0BviD6pBDuLqLjTK7sRgL+agqMfgaNSBjgTuqdrPJkWDzQj2EOxuIjrnCO66xlD/+
         Rr7BExVjO56rs9/pC+zXsEp203IkmJdWwlJgzYvRRYsqOHAfB/fufoUuqJUSJzRK3oBD
         DV52Hvk1gbmrtchmovYS6URsE8/aTG2KmzgL6WkcKlldVQjPfdZuKFY4h+XTI9SnNala
         NdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462556; x=1721067356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+/8q0n9zIZuPd8v8xe46w2FL6quvs2/a1bhvxAdF2Y=;
        b=Q9WaEpOC13FfUbBcILpf8kDflda8kJ9aVtwmY7ve1PN9oBGXj9sErdoNU3xltGL+72
         N103Kuf6+IjSs38qU2PCYAiJoJPMeyDYiWIDPGesEQsHEwRWJXYfLrks8FXbf77Zy3Ds
         bjU6CSJutMVb1aQZ377QxNlBOAoSDj+Zowqv5FlkXjQcp81SPjPSKRgLGwuVE2jqm+t+
         UWWDmiubCMAAcS11BkXzxDZb28BqF4Wl7//UQRHTaEXUH9zssBaXpkb4SA0iUs3Y3Svm
         TzALf+E6crGnXLFuOIW1Bq4DF50tnA001mEzIRvyIB5Ia0QXS+sJPuli3G8cW3wtI1jL
         V97g==
X-Forwarded-Encrypted: i=1; AJvYcCV5nHs34kgZJRGWsmohcyhqg34e54czp15/zi/KF2nHm+FvAonnAKLBukCxFT2Lp+Jc56v5bB5h6FF3CsNP4bx/xfWdMEH2
X-Gm-Message-State: AOJu0YyCW/dqIKzd15NJ02g/rfL5GAYzYu4adwtcjq2lC9WeF9zH0FQe
	P3y+z6zcpgrof2ZISuatupHd3AZbtm46t1T7gPNccauidBgaVEZH6qvKwwdTHi0sRWTpw0ONt1r
	qgEfYO6+C23a1cnTXfDPoM0nhulg72G+y
X-Google-Smtp-Source: AGHT+IHkqVFPGrB1oIKqijM7RNmdDYfluVmCTA+6xb+aMZ21j/vyzS0Shew3Y1jn1PyKmCvuBp0eUMLeBznj
X-Received: by 2002:a05:600c:428a:b0:426:6153:5318 with SMTP id 5b1f17b1804b1-426707e209emr2482865e9.19.1720462556441;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-4265f7f3a25sm2527395e9.44.2024.07.08.11.15.56;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 2869A603DB;
	Mon,  8 Jul 2024 20:15:56 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sQsu3-00HP93-QD; Mon, 08 Jul 2024 20:15:55 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/4] ipv6: take care of scope when choosing the src addr
Date: Mon,  8 Jul 2024 20:15:09 +0200
Message-ID: <20240708181554.4134673-4-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
References: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
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


