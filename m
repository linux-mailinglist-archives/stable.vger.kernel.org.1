Return-Path: <stable+bounces-78550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4975098C123
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25B41F21700
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1601C9DFD;
	Tue,  1 Oct 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYrHBVbQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500E1C8FB5
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795054; cv=none; b=pYEcu+JC/6SdMCs0hTYzx0ifsrBQ8Wl6RmWIe9x0XQjF628V9j9EFP2Bg17tUm7Xb7BcvwgDX3FXcW+Veeo2+CgCt1H1z6n2/RmlHNhCpV7nUUutGm4G9ZDPJo4AV6nXHyQk6HAs6sAyRqsRfaGQ05PQkzITvD748k6Ym5m0RLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795054; c=relaxed/simple;
	bh=piHXwSfkvEit8OKoiBImaCc8bn8Wvkjqpz11Dh8wUzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IzWaQkZl9WS6YiiD/O4BqRezGtN/VA1RPQHNaq5v2YVYOFdnnuabe9o6SCUuESLoktLdIWlfrni/TvPMc4uTYMC5GPF+UiOxpmdWRR2dabw55iLcQpKetQZyi57wy5jNn7H/OAQOdLGp3gQWvjN4fKoAMjp5qNoOabOZnEqV0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYrHBVbQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e22f8dc491so45738977b3.1
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727795051; x=1728399851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8W41dv0ea9C2mfWXmKFcR2OxX+YaaHqp1w4bvKkm2NM=;
        b=rYrHBVbQpYH8bwNu25O2KEmViKn9ztOybYNdPREz3KjDJ6ZNwgNiDqeJNmK0bvR50z
         Tb0XyQjKyAM+H2cGdca517ENQI5jlaPSOrkf3SC7maK2fkLXRUvmAW5N9wxMstMZO6Tg
         +YLsBBZwfCnBWt09QL+uCkrxArj7zlDPTNRlfdgZApE8ymz1EkkWdyMVJEwOWE1iE079
         FGIuw9G1bnpOs/8c7vERxUDGA6nbWQBSEW3J4NX0Atv6pKb2LaKWv1TOe9ltjTlVR3b6
         0Kyf2TkbgUJEutrQ/DYh87+IoeYFdT+Fy/b5uP2CQ8FABUClkhGH8HtDCfkgljmTvwKd
         dziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795051; x=1728399851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8W41dv0ea9C2mfWXmKFcR2OxX+YaaHqp1w4bvKkm2NM=;
        b=c1sLmt6pdMw0fypMJNjFwO2BtjKWaLGW5ToW/UQqlb6k+ctm0C2vE38/11qm5dcTrj
         TFI4tbz+C24YGGITLQiUdg1dy9YqIsnIeKpeiPhmdm9c79mpRqFdAqlDGSXbCJ4kKh2G
         9no1h3WkXRER0T9NAEKAPCdeCLuWHC8eIl28PV3MFFOBlJMNHMyZDrFgeDFWRvTkBHSQ
         JZrv1dOa0s22I+M6R99EV0xCpwohnFyuFTQfC4rDM93y5WqR23fiBIwHXL3nLPQSD+gz
         QyLX1HB7ca4OpFLOm/5zLJBhlQI9FgdZw+QCRntzWaQGZbwM3LjJhHyRfO5qaTX9IVAR
         15Qw==
X-Gm-Message-State: AOJu0YydFMfYR4423CvxJXP995+TBHfbvLW10d60yYlaiwUxCGpUU1+L
	TnB17SUpogP2+hhaseRbJSgew00DiaXC47JOuuOPasQLDBUuwxMDwOvHZYsBBLI9zAqRIC7ZUbW
	2w84AOD8rKoENpTvXlNwI/LZRH60IvtVI6LYNTc2eAq/2xxzSrspfxwIJIweB4qBZsnzX6z+zwi
	hnDyc8FkzOKPKC8wGuvFgLz8psf317hMrnfv1RrFi0KCg=
X-Google-Smtp-Source: AGHT+IFVws3K4Duat10/EOBldfA3+4aTSfqbeJmhLNzGS+lBC/JM4T2A66L08JdXJsa4nHeq8QnI4Ubsk4dbqg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:a2c3:0:b0:e25:cf4e:1aab with SMTP id
 3f1490d57ef6-e2604ca9f5dmr12629276.11.1727795051055; Tue, 01 Oct 2024
 08:04:11 -0700 (PDT)
Date: Tue,  1 Oct 2024 15:04:03 +0000
In-Reply-To: <2024100127-uninsured-onyx-f79a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024100127-uninsured-onyx-f79a@gregkh>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241001150404.2176005-1-edumazet@google.com>
Subject: [PATCH 6.1.y 1/2] icmp: Add counters for rate limits
From: Eric Dumazet <edumazet@google.com>
To: stable@vger.kernel.org
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jamie Bainbridge <jamie.bainbridge@gmail.com>

commit d0941130c93515411c8d66fc22bdae407b509a6d upstream.

There are multiple ICMP rate limiting mechanisms:

* Global limits: net.ipv4.icmp_msgs_burst/icmp_msgs_per_sec
* v4 per-host limits: net.ipv4.icmp_ratelimit/ratemask
* v6 per-host limits: net.ipv6.icmp_ratelimit/ratemask

However, when ICMP output is limited, there is no way to tell
which limit has been hit or even if the limits are responsible
for the lack of ICMP output.

Add counters for each of the cases above. As we are within
local_bh_disable(), use the __INC stats variant.

Example output:

 # nstat -sz "*RateLimit*"
 IcmpOutRateLimitGlobal          134                0.0
 IcmpOutRateLimitHost            770                0.0
 Icmp6OutRateLimitHost           84                 0.0

Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Suggested-by: Abhishek Rawal <rawal.abhishek92@gmail.com>
Link: https://lore.kernel.org/r/273b32241e6b7fdc5c609e6f5ebc68caf3994342.1674605770.git.jamie.bainbridge@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/uapi/linux/snmp.h | 3 +++
 net/ipv4/icmp.c           | 3 +++
 net/ipv4/proc.c           | 8 +++++---
 net/ipv6/icmp.c           | 4 ++++
 net/ipv6/proc.c           | 1 +
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 4d7470036a8b5be598bd21367f60854b023cceef..8ecb509a84d3b1eb8323180d25a655dd301b9a10 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -95,6 +95,8 @@ enum
 	ICMP_MIB_OUTADDRMASKS,			/* OutAddrMasks */
 	ICMP_MIB_OUTADDRMASKREPS,		/* OutAddrMaskReps */
 	ICMP_MIB_CSUMERRORS,			/* InCsumErrors */
+	ICMP_MIB_RATELIMITGLOBAL,		/* OutRateLimitGlobal */
+	ICMP_MIB_RATELIMITHOST,			/* OutRateLimitHost */
 	__ICMP_MIB_MAX
 };
 
@@ -112,6 +114,7 @@ enum
 	ICMP6_MIB_OUTMSGS,			/* OutMsgs */
 	ICMP6_MIB_OUTERRORS,			/* OutErrors */
 	ICMP6_MIB_CSUMERRORS,			/* InCsumErrors */
+	ICMP6_MIB_RATELIMITHOST,		/* OutRateLimitHost */
 	__ICMP6_MIB_MAX
 };
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 31051b327e53c870eb91755662653a9c7ffc0b32..190988bfa3e293adaf1d5c2849592b64dcaf38da 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -297,6 +297,7 @@ static bool icmpv4_global_allow(struct net *net, int type, int code)
 	if (icmp_global_allow())
 		return true;
 
+	__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITGLOBAL);
 	return false;
 }
 
@@ -326,6 +327,8 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 	if (peer)
 		inet_putpeer(peer);
 out:
+	if (!rc)
+		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
 	return rc;
 }
 
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 5386f460bd208c8f30902ea8b6aa613449d59ee0..1f52c5f2d3475f9ed1be1001c6e83b40d734b259 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -352,7 +352,7 @@ static void icmp_put(struct seq_file *seq)
 	seq_puts(seq, "\nIcmp: InMsgs InErrors InCsumErrors");
 	for (i = 0; icmpmibmap[i].name; i++)
 		seq_printf(seq, " In%s", icmpmibmap[i].name);
-	seq_puts(seq, " OutMsgs OutErrors");
+	seq_puts(seq, " OutMsgs OutErrors OutRateLimitGlobal OutRateLimitHost");
 	for (i = 0; icmpmibmap[i].name; i++)
 		seq_printf(seq, " Out%s", icmpmibmap[i].name);
 	seq_printf(seq, "\nIcmp: %lu %lu %lu",
@@ -362,9 +362,11 @@ static void icmp_put(struct seq_file *seq)
 	for (i = 0; icmpmibmap[i].name; i++)
 		seq_printf(seq, " %lu",
 			   atomic_long_read(ptr + icmpmibmap[i].index));
-	seq_printf(seq, " %lu %lu",
+	seq_printf(seq, " %lu %lu %lu %lu",
 		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_OUTMSGS),
-		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_OUTERRORS));
+		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_OUTERRORS),
+		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_RATELIMITGLOBAL),
+		snmp_fold_field(net->mib.icmp_statistics, ICMP_MIB_RATELIMITHOST));
 	for (i = 0; icmpmibmap[i].name; i++)
 		seq_printf(seq, " %lu",
 			   atomic_long_read(ptr + (icmpmibmap[i].index | 0x100)));
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index e2af7ab9928218185b7ae0ef50df3f39dc001b07..7bea1d82e1783c1956ea388ddc6ed842e2a6268e 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -183,6 +183,7 @@ static bool icmpv6_global_allow(struct net *net, int type)
 	if (icmp_global_allow())
 		return true;
 
+	__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITGLOBAL);
 	return false;
 }
 
@@ -224,6 +225,9 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 		if (peer)
 			inet_putpeer(peer);
 	}
+	if (!res)
+		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
+				  ICMP6_MIB_RATELIMITHOST);
 	dst_release(dst);
 	return res;
 }
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index d6306aa46bb1eb768ab77aae6a494640ed462157..e20b3705c2d2accedad4aac75064c33f733a80be 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -94,6 +94,7 @@ static const struct snmp_mib snmp6_icmp6_list[] = {
 	SNMP_MIB_ITEM("Icmp6OutMsgs", ICMP6_MIB_OUTMSGS),
 	SNMP_MIB_ITEM("Icmp6OutErrors", ICMP6_MIB_OUTERRORS),
 	SNMP_MIB_ITEM("Icmp6InCsumErrors", ICMP6_MIB_CSUMERRORS),
+	SNMP_MIB_ITEM("Icmp6OutRateLimitHost", ICMP6_MIB_RATELIMITHOST),
 	SNMP_MIB_SENTINEL
 };
 
-- 
2.46.1.824.gd892dcdcdd-goog


