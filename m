Return-Path: <stable+bounces-176457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714DAB37A47
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 08:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C537219F9
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 06:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1793F2D6E77;
	Wed, 27 Aug 2025 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnhp/UV4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BC205E2F;
	Wed, 27 Aug 2025 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275856; cv=none; b=PJe9MC8j2iLviIkJRcfRTwOSrTAlA3C63XlntSZSAiHKp4eon/IzEv3xJD/9T0lCYkB8dzASLYGwVp8fBKc3349GrL6NQ8tKf3yAiu6z3uIMBAHbwJwpuN5ZPhNxicm7m6VI2mIMXygHdHpiVHQcx6VCqXhOArZjrFgicrZMZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275856; c=relaxed/simple;
	bh=kVlyh+9zjWrWkE9IzWbt9j+Kdlbna7+U0ZjUEEug9Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q+88EJ3ie3g7N2yw/9ObOzRYu22qTSVN5KktXcZD0DqNkRONXIhIx6zawTTCxVep/fus8f5zMnyigyITmmm3vAkw4hS1kdjkHgtYU0DbAjdFeXQdVzCMVL+AlXLJk+zohqDW0ZRHUswDG0DXnqxLWuTTP0vGLnnBxSGdPUMscHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnhp/UV4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c7aa4ce85dso2002886f8f.3;
        Tue, 26 Aug 2025 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756275853; x=1756880653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTffp2Une9psOpkE9avAK28pF5DJdZIHIrhlvCx9OY4=;
        b=Vnhp/UV4YV0x4CesOAQb/1cx2gEDz61xBWBs99nRCb9BXFIU9mEFCY+dIFLIIR5upl
         XgxOo6ZsegZog+LYp2g1uriX0ZE8LFg7CAkRlhUGUVm2L3QGhYCoYfuN2hlldj3CKQnJ
         yotEw4r81w/uVrlUWkBVSdp8lvxu9AZaZ5yiYM3Vd4VG0/9e0OzsB5hh+JQqknz7CxWj
         Sc06dyoF5TGxcqGTIxKC7OOb2Dt0h1UzMDA0Nya+axJ7tMoQMuoWp0gRVW2J/O1CdcXW
         cTDz/w4nZJHR3TPu1/k12mSmqfEAFvH9cHslmXwxCTAJ1qlsKAeoRFLRmTJPMyOQ6P96
         6o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756275853; x=1756880653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTffp2Une9psOpkE9avAK28pF5DJdZIHIrhlvCx9OY4=;
        b=jiRPVVJPhc4VhDlAGphkd9xlW0JXhDblvvO1hCLSbu0Og2MEPIMFAScHKR++gBqmIN
         Hyy86TsWRocfkeHvEbbos269rT2M48M9VU3SVvKQIEHqZoNbHlEuMPHNtFh3vxz3VdRy
         mxTRoy1+zCahGJ4RLrGMS6NANHG1xMTm9uGlTsRNEn2sA3yz9+Kjvn9aVOUXIQgIkUwk
         3XwcQGT7HuLbBs13S/emvwRwz5r+Ge6bwwntiwtYKG02TPW2aJbW4gMOHOd7Cq1gzac7
         5Z8Ki3M2ixhVzUG6Ymz3Gs8q+0y0f6XEDR8IwSrPaX5Tts4L3CSDKPh0S4hKopOgInIK
         WGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6qa6j+il7YIjCv5JXp3Yp6LrzBkHBzvuLXZPQydLmbkp9ipwh96FHLE4TIDhgmD4iNzWDaOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/DhqdOs3SqCTAnn0G8HC4Qj07OL6r4mLz/hgfru7j3wKWsN0j
	/4q2Adodn3Gp3vCZIG5uu7NdpZYeu7ayZv23syt467dcTidTCEdVfkuqKNF2QQ==
X-Gm-Gg: ASbGncunupLG/rycFw0/I1slejqYNd+N4zOLr68EVczohzNrNWg8Q6mh0Duyz0szGym
	9NVytzFdaH/SIhtlYMeKvKUdtjiGphyY46a3V5d7jYM4DhPKPouLCPwell894zunDI+v5fT3Hpg
	3T1CR0AqaKtcwjQXHsMaqmEPsJxIAj5xMfX8e+nELmXMLQ9tibDkdgSjJCLYLl4TAAdTAI3Yago
	ioefMGIfg89nJsQnb9FEW3MVvRQtFdbtuOv5rTnCZJ8b4HZ4w6c+rAZuvPy327cTjGCxuXzKEzf
	k7FsWAQYXmUrCPpyt+Dm6LxTSHvkKqG/4jNdZyvnEwD8EaHkA/9WVPdwJR/+nuoSTwXTnuwOq0a
	0xCExX/aqqfFIUfEqKZZ4suNJFg==
X-Google-Smtp-Source: AGHT+IHEgklavUSzLPlc+ZOoflTsrIRZ3Z3NKnpJ7OaHAYLP706fmxXS169Z9AHTmsJOGYiGuWM+EQ==
X-Received: by 2002:a05:6000:22c5:b0:3b8:d15e:ed35 with SMTP id ffacd0b85a97d-3c5daff6b01mr13806088f8f.23.1756275853378;
        Tue, 26 Aug 2025 23:24:13 -0700 (PDT)
Received: from oscar-xps.. ([45.128.133.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66c383b1sm29749875e9.3.2025.08.26.23.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 23:24:12 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org,
	bacs@librecast.net,
	brett@librecast.net,
	kuba@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net v3 1/2] net: ipv4: fix regression in local-broadcast routes
Date: Wed, 27 Aug 2025 08:23:21 +0200
Message-Id: <20250827062322.4807-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
introduced a regression where local-broadcast packets would have their
gateway set in __mkroute_output, which was caused by fi = NULL being
removed.

Fix this by resetting the fib_info for local-broadcast packets. This
preserves the intended changes for directed-broadcast packets.

Cc: stable@vger.kernel.org
Fixes: 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
Reported-by: Brett A C Sheffield <bacs@librecast.net>
Closes: https://lore.kernel.org/regressions/20250822165231.4353-4-bacs@librecast.net
Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
Link to discussion:
https://lore.kernel.org/netdev/20250822165231.4353-4-bacs@librecast.net/

Thanks to Brett Sheffield for finding the regression and writing
the initial fix!

 net/ipv4/route.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f639a2ae881a..baa43e5966b1 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2575,12 +2575,16 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 		    !netif_is_l3_master(dev_out))
 			return ERR_PTR(-EINVAL);
 
-	if (ipv4_is_lbcast(fl4->daddr))
+	if (ipv4_is_lbcast(fl4->daddr)) {
 		type = RTN_BROADCAST;
-	else if (ipv4_is_multicast(fl4->daddr))
+
+		/* reset fi to prevent gateway resolution */
+		fi = NULL;
+	} else if (ipv4_is_multicast(fl4->daddr)) {
 		type = RTN_MULTICAST;
-	else if (ipv4_is_zeronet(fl4->daddr))
+	} else if (ipv4_is_zeronet(fl4->daddr)) {
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (dev_out->flags & IFF_LOOPBACK)
 		flags |= RTCF_LOCAL;
-- 
2.39.5


