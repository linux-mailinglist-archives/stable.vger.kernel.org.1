Return-Path: <stable+bounces-164605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA232B10AA2
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 14:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446AA1650EB
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA141E4A4;
	Thu, 24 Jul 2025 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWNNmJXb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5317B2C3757;
	Thu, 24 Jul 2025 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361428; cv=none; b=JGtFh9wnNTxDgpuZQt2FcCdI71AYPnpysQR/cCZ1pX5SuZT/4Wl/LBAyPDBnAvhiO10FsUZ/iMW4L8Ggv+hK0mtCjdXTSFEDWcfPTWwwzIE8cgWMnvtswbkhNeImsNlgaFy+KVYMzQZ/QfxDrNpiyMcnFnbORt2YkR/wtQKId9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361428; c=relaxed/simple;
	bh=Xq+2aOr76viJriRnJ+pzgbCo0qffhEbG7lm/rdlTwjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bQNmhBOL47elWEUHzA0sP1RblhQkdPd/qrotLizn4LU76nCRGUwjj7ezXhkxWNgdgfZg22FJl/80A4R7f9lESrahCGhfA59ED+2XXBZer0jBnqgQ3dJxLrI/Kle2WX7bWuirM1SixhQzXJcreRgOOlc9N1XJeGRlLVixhNbEzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWNNmJXb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a53359dea5so491747f8f.0;
        Thu, 24 Jul 2025 05:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753361425; x=1753966225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PfVMcAjLS47xQwt22LwNV9vb4H3Sjsc0X/7OduC46U4=;
        b=PWNNmJXbqrP/uDyeVAAVXhdRXTu5XX5/D48wJml6jD+qli3yWiciW1YT2EMAbf7xWV
         8AYR/UsKZw8k/XCegv4rHnhQymf+skwK++qELI9C2imH3SoF8B2Qr54FFO/xgBiHTbN8
         cN4mDSDpXMiLRS47VlsUvJjXtSILfsgSbMXBE8XzrZ7O7+fUB2Ojt/0lh1ZLsz4Y4oQa
         9YZIMUZKmtiNP3F40Q9k9ERz4762YhYBGy53H7zZzWMcgORsUuUOkZa/2wJkxD/HeynO
         y3lYW8SLofcZAg2AyA1vE676kxX9R4behXlLbkqteRUT94FXBwwtUP4ACoxzLwthpa39
         AEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753361425; x=1753966225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfVMcAjLS47xQwt22LwNV9vb4H3Sjsc0X/7OduC46U4=;
        b=ooZEwbRXuBhS38v9eXs9Bgqh6jO6OGialOB3lsgnzcs/0SkmWjKZG4b2wxeNKoNkk5
         LZz/4NAfYgY9LcatWiHGU+DKUeyQYx5y9OLecxe1yG4dDDl58qBQjQd6+cH0IGuIp5LF
         fasFQcMa0pYsM6LF6d6SeGVWUI9+y2jKAz5grFH++IBV561GHJ0/Qa4Z/XQdw6HEc6nz
         c1RW0bSGdwhwKou9ebIlKU2mLNc7kUEvn9+RGoDVtB3W2xUDk9KctlRuZkdj60VYD0+T
         4ru6cZCAJ2zuze9Y99AIu8m5Cj8Ek9y8mPRHTWT7Bxf6RT8UTXkMw8RWp92y/aIyz5yv
         u7pA==
X-Forwarded-Encrypted: i=1; AJvYcCV96UM3Hjof/wc3GS2wBhmw3VD1hrRaLpLZVbr0puI1hxpzHY2McQRGwLnhAVWTIp61vw2JoyQ5gpNXm7I=@vger.kernel.org, AJvYcCW1wXXGPXw22baQiaRT3W6tUWDmFAlAgiI6dYlSutXG8TUPIKmzg111T7RxOe6cTTMOh0macSj1@vger.kernel.org
X-Gm-Message-State: AOJu0YzqWG74x20T6Nf+vuE4HbHRQJc7idxCOH7xYecPszGJd4aKPrlg
	bhkmNdyAckqztwubFb2uyXTkPEhtNCqT0UqKoVRBxfy7B+Mi1/gtJN8gjjf3w50o
X-Gm-Gg: ASbGnctxmsvJs6v78uFcw89CF65qQic7k+zhvXI8xBL4hwpoQLuGPN7m3i/JwQcUSav
	hv8eft409i7TGSRKYPyL+qPhqNGerEnih9oEKsaTwkyfEESJqKqqYYFPI8N02O9Lf1N3tlmVkM2
	+cAcasJelJO7pLnPukrpzcYbHV1IeTQR1Uqp9mCkOau8JrSSpAUr0VCCBgwTz7eA2xT/TXUy/Eu
	qUKtMDrvGajbP4DLpqzAUv4j3rvXEB2kWScQsk9asbtfwouX6Gi9ISkA3Ue/iJCKtStia+0ydZs
	TVgTe+mYUOhCQLgmJmdTBJeJnMM+X2xfFXxtL75JX7PFbE7K/5je+9q1CcbddxuF7N6wq4Ue/1C
	EtzOM/iMAHujHLTyJtdZr+9hsgFm8SEy7C9U=
X-Google-Smtp-Source: AGHT+IFgSLerD2l5sm9nFan11JNgWqeTR2V8VwvZLnCysxO+YNGEGzgx1M1XpIFFSgYboxFu9aKH0w==
X-Received: by 2002:a05:6000:22c2:b0:3a4:f35b:d016 with SMTP id ffacd0b85a97d-3b768caa12dmr6105752f8f.11.1753361424142;
        Thu, 24 Jul 2025 05:50:24 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc6d1b0sm2111089f8f.18.2025.07.24.05.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:50:23 -0700 (PDT)
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
Subject: [PATCH net-next] net: ipv4: allow directed broadcast routes to use dst hint
Date: Thu, 24 Jul 2025 14:49:42 +0200
Message-Id: <20250724124942.6895-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, ip_extract_route_hint uses RTN_BROADCAST to decide
whether to use the route dst hint mechanism.

This check is too strict, as it prevents directed broadcast
routes from using the hint, resulting in poor performance
during bursts of directed broadcast traffic.

Fix this in ip_extract_route_hint and modify ip_route_use_hint
to preserve the intended behaviour.

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 net/ipv4/ip_input.c | 6 ++++--
 net/ipv4/route.c    | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index fc323994b..1581b98bc 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -589,8 +589,10 @@ static void ip_sublist_rcv_finish(struct list_head *head)
 static struct sk_buff *ip_extract_route_hint(const struct net *net,
 					     struct sk_buff *skb, int rt_type)
 {
-	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
-	    IPCB(skb)->flags & IPSKB_MULTIPATH)
+	const struct iphdr *iph = ip_hdr(skb);
+
+	if (fib4_has_custom_rules(net) || ipv4_is_lbcast(iph->daddr) ||
+	    (iph->daddr == 0 && iph->saddr == 0) || IPCB(skb)->flags & IPSKB_MULTIPATH)
 		return NULL;
 
 	return skb;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f639a2ae8..1f212b2ce 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2210,7 +2210,7 @@ ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		goto martian_source;
 	}
 
-	if (rt->rt_type != RTN_LOCAL)
+	if (!(rt->rt_flags & RTCF_LOCAL))
 		goto skip_validate_source;
 
 	reason = fib_validate_source_reason(skb, saddr, daddr, dscp, 0, dev,
-- 
2.39.5


