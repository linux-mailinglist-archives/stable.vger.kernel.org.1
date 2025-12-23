Return-Path: <stable+bounces-203330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168FCDA4BC
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 19:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C993301B12A
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2DF349AF5;
	Tue, 23 Dec 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="kglIjthc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F533491D6
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766516070; cv=none; b=RGgobr9B4MiRLC3b1dVgcAfYOx6SbJG9Sp4j3lPp+XQDlWGFz0WiPfj18KogYO0gEnS8RzP1TeHRnoSuibS6w09KmW6FdMRDqW1OyjN+FvSE98T46An2QHwX81eSH9y7qy0kQxRk3xuVHJcEysnlzvnoBRkmQYTy/DaFixZOSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766516070; c=relaxed/simple;
	bh=qsQGPBLL6uPmeSPt8K/LptIWn/XZlNhUtON2BL8/+fY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nr91+mR9VoF1V0h/l7R43h/X5/K0bWPYc1pxeP9flp7PGEFf4Au2Ynur3MfXT5PfuK4OS6dBdeG1gp+79OO+Kz0ihYhrPSBJuhAXyTU42GFaEkNFiEoFbb1cOEhw/LkVxGp12REmVug8XrvTzVGYGBnUMzKmwGfuT+Gw+4WCSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=kglIjthc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7ba92341f07so239545b3a.1
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 10:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1766516067; x=1767120867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2M6HobKFb6olbBZPpo5fsFtELm2PFrPDVXuMX1qBbM4=;
        b=kglIjthcG57Qh44EVeq0Tcp7isBtl7SpWjFhP44i92GXhxkr2ewsYNryOeKoddRvPi
         R7q5bjZkOQp1YVOS8dGbu5hubxCnIpyrRn8KZOjDSUYg4XWOi73jGwCPzzatFdL89HbQ
         ufKDehHoXLBCIm7SCWOnprD3bK3Gg/I/JdQVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766516067; x=1767120867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M6HobKFb6olbBZPpo5fsFtELm2PFrPDVXuMX1qBbM4=;
        b=a0Q6GmlOOHO1KrL9W5sSIoqlLomiuxvO/HvGCpXvAcvvPH9R7p+v0yxOTQ3StL9YU9
         +QG4849s7WgShtn7fqEmX1c8w79Z6tDsQvcFEeN+R8DnPGwPun+hgESbkgToVnunDiGX
         lM7RmF0tNV7W6JjpCVKFLIjt7ZBET/nAxC1kdHA5hPP7aWS69ew/rj6CfiucZQhm5XCB
         cVJLs5Gt3DaFU7gU8Jy7KewggB6SKDMNRnBbsazxMI68tmMUHADZuawh63CPn7ClY3re
         ogfH7XQU/6ROFtRtET2W+S/4shPig3j4NxnsgP/wMp9iNnRT4R5t5o5Zfk7dk2vXw02i
         ea2A==
X-Gm-Message-State: AOJu0Yy3XaK5VEv2nz/KVcritjeyxf4Rj8s5uK3tdK25R5eoyhaK8mb+
	bMKhhJRuxUaMcmtNFd6FxTweUqv5bSvLhQq8wDBm0hEQehXrlbOB26vJjZ5T+8SP484LHqFCFfF
	/B/Gq
X-Gm-Gg: AY/fxX4C96mA4eheIUVCMrW+tHhICuZRZJZqobimtfiOpDqPAnePPF3M8dgjrtakbLx
	lVdaZtyV5jgwxJyTS7PS3RDOymvFO1E5sMUN/Vrs7adUyrQJR+IpT2u6EQr9ZL1U6m64AlazucT
	207p3d8ul8+Fbpr46Hcz/oo24Z7NAbekBIOuZYmfE9SvTSjjxhbdwhibG9giVh9Zzh1LXYHVKDr
	Ri6IkTOOcZktZHb5pL8mxH4pMLEU6ErYdoyJ6jEWkXiWlugZncfdPxN0JEbpwDU303Qq9ual93s
	B8mcieMcCQJfEab6sTUJmqFszMkAHLxXEee6REA7ffuOwuq7JA8+sbYge08KnmqOcY8EHka4llN
	+YWy4Mu/t+v9KdM3J5Xw/Gz/30YSo0knaK+KKW8Tz6LSO52MXAI4xooHIJGnjybISPGZVSiVQ0+
	qKkoX6IOZNQ4Sd0Q4JpF9wRw==
X-Google-Smtp-Source: AGHT+IGOmFPriDziCPiUzuy2l594cZ0RuRTeKugmfoqx5M7+OXIBOGf2uBYBDTOEYmtohNEsD7xcRA==
X-Received: by 2002:a05:6a00:228f:b0:7b6:ebcb:63fa with SMTP id d2e1a72fcca58-7ff6198e350mr9787283b3a.0.1766516067244;
        Tue, 23 Dec 2025 10:54:27 -0800 (PST)
Received: from MVIN00229.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93b516sm14484956b3a.6.2025.12.23.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 10:54:26 -0800 (PST)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.10.y 5.15.y RESEND] ipv6: Fix potential uninit-value access in __ip6_make_skb()
Date: Wed, 24 Dec 2025 00:23:41 +0530
Message-Id: <20251223185341.1850880-1-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shigeru Yoshida <syoshida@redhat.com>

commit 4e13d3a9c25b7080f8a619f961e943fe08c2672c upstream.

As it was done in commit fc1092f51567 ("ipv4: Fix uninit-value access in
__ip_make_skb()") for IPv4, check FLOWI_FLAG_KNOWN_NH on fl6->flowi6_flags
instead of testing HDRINCL on the socket to avoid a race condition which
causes uninit-value access.

Fixes: ea30388baebc ("ipv6: Fix an uninit variable access bug in __ip6_make_skb()")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
Referred stable v6.1.y version of the patch to generate this one
 [ v6.1 link: https://github.com/gregkh/linux/commit/a05c1ede50e9656f0752e523c7b54f3a3489e9a8 ]
---
 net/ipv6/ip6_output.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 426330b8dfa4..99ee18b3a953 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1917,7 +1917,8 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 		struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
 		u8 icmp6_type;
 
-		if (sk->sk_socket->type == SOCK_RAW && !inet_sk(sk)->hdrincl)
+		if (sk->sk_socket->type == SOCK_RAW &&
+		    !(fl6->flowi6_flags & FLOWI_FLAG_KNOWN_NH))
 			icmp6_type = fl6->fl6_icmp_type;
 		else
 			icmp6_type = icmp6_hdr(skb)->icmp6_type;
-- 
2.25.1


