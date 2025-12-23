Return-Path: <stable+bounces-203325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A927CDA3F5
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 19:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04140301692A
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D5E1990A7;
	Tue, 23 Dec 2025 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="Bsm83H/x"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CDE1373
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766513757; cv=none; b=bOjNEk/zhSIhnAj2crPhXDL8mMLAPhxzuZ3C0Jtbn0KfvODG4G4rWmrt05BF0euvNwflzoF5M9sGgC0aw+ZsrGtyCg7GJ7Wu3sF1N0dc8ShbQ4RHiTFWkj/ymbXM7eQwyQ2RFx3RvHf85eWfw0p/gu9OxvFuS0rSXfdQZUYbIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766513757; c=relaxed/simple;
	bh=qsQGPBLL6uPmeSPt8K/LptIWn/XZlNhUtON2BL8/+fY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=agnPf1t9e0daqaNkSgoPowIijkKttI7o3K+icKKXFJ3j7W5/t0PbXgz4jdxFRTje35PSf8lJP6xPETUvxqf5cIBYc+wHWPq/DfE0IeMCbXgvLLy3pG9Sieh8S1RtPAtzbKzC+F3mEIP4CA1ZLqVTnH3+oMMDua8aSKc8nQIrNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=Bsm83H/x; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c32700f38so756238a91.2
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 10:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1766513754; x=1767118554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2M6HobKFb6olbBZPpo5fsFtELm2PFrPDVXuMX1qBbM4=;
        b=Bsm83H/xj10xdatAG6toQtNvfkngnLMLv2LfLAmyQncCWv1ag78OERF70kNDpV4THS
         JMDi4t14Kyt8UN5vOj1+4VdZm/6ZNO4HYoqOSgE7o4RpexmqfUH990oEI8k2l1BksMnS
         umPu6Sts7hOCco6jZu83ZV8FC5fZtn4WTjiEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766513754; x=1767118554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M6HobKFb6olbBZPpo5fsFtELm2PFrPDVXuMX1qBbM4=;
        b=ctqVYvRxoOadSRSaSAo6XCVq2YU6oiNGgqQxOpijNDe2Vm8YdvCih32ICTRVYanBPD
         WPi5GH4uGK5wkrMvuXCSoqeQXC3GnIKdu7nynb+UjlXm8lSi9pKk96ULPj6qmPn+5uA2
         dWxb3n5CS7Nd8N5k8yx4Uzeim4Fovlb7EeiP33nrsIL18oIsVoAsYqiopkQ7WYknRmV+
         seRqLvrX1bBus5qYAvMDIkQWEOJ1KZjUJZqOOXQgm5PioTeP+9jzYKP3JYqlKLd005Zb
         m+jdAE69pf+iiLAa/nJ7Fs/aYZnUV5pHqUk/ef/QYoiBI24uZmDI8CF5MTuJkQAgRbAw
         xuhQ==
X-Gm-Message-State: AOJu0YygKIWxL17PDpUpBAMF2IsjufSQLSIh0FO3Qhs+RLdEtH1H1r91
	rC3XEmm7sgmqReDm5DZ/b4SWjrTTQoG2D7GFEeUzLiDCwNdSJQry2Za5xtwKU2wDaymKg3LAdCB
	ToFKZ
X-Gm-Gg: AY/fxX5Kyo4FjOhIjGL5xdoErGmYA8/YLp6QhJ4mWpv1r1+jSYFB6SakJWYzqyO+qkr
	04E/yUaeX9QoadLAmIyBv9T3ANA65HTqF4X4oHluyv7hmgyFbH5Oi4LomFmObhpEBFLH8sGjWQr
	/H737aD/1FU7WwTvXNmtGd57XujnU9iM1uCPpT9/nomyq+Al8FiQwJQ225Hzr9aNbvRxqhkkA5q
	2283NKBjw4FzXp4cSJI9ohZRkV0hlPWaGKBRKdIVYBMnc7QIx1TGhBhwyvN26ZrXhERCGzw+Yb/
	9uuoJ+77QdDZRGYrPADE5grVOPe+ESHwM0+x4rdUh1R0//0E2uvjbo+0yTueOr2VHncuNMzP4xP
	KqXNESBTO13ad1B44yJChrn6twTvCCSDlur0SUaYUeTUL+hkYc2n16XS057tCnwY6JJrnCqBkIM
	VSftU8ofLJ6hyPXoX8uyMGdg==
X-Google-Smtp-Source: AGHT+IHsni1ld3Rgepy6hByJUGTiPT9gJnFJUai9hYISzCARm7xFOX3wS1pp1kK5aIrYNGgPUwnY7g==
X-Received: by 2002:a17:90b:6cd:b0:349:9eaf:34cc with SMTP id 98e67ed59e1d1-34e9221b109mr9366472a91.8.1766513754398;
        Tue, 23 Dec 2025 10:15:54 -0800 (PST)
Received: from MVIN00229.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e7727356dsm7905014a91.4.2025.12.23.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 10:15:53 -0800 (PST)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH] ipv6: Fix potential uninit-value access in __ip6_make_skb()
Date: Tue, 23 Dec 2025 23:44:53 +0530
Message-Id: <20251223181453.1850174-1-skulkarni@mvista.com>
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


