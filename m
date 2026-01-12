Return-Path: <stable+bounces-208047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FA8D10C1A
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 07:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BA2830C21AB
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADB731A07C;
	Mon, 12 Jan 2026 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HULDzgV0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C117319851
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200547; cv=none; b=aJAZtTjCLVqWKc+Fro98E59JmUeGlrlgjNQcrApPbrMkN4yGgEZoDFZ4ws3SF+6TN3sXyE+vRza+q7MEYUPj4+EpLA6BLDB/Kl2rMDF7SpM9hevEeNE6nDbKTswsq8EHPZ6Bxl5rpcSSCr4F0EULQbb16IE9nmuGePCIZyCGHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200547; c=relaxed/simple;
	bh=/NupvgywEukBz4QryS1IcnmPfJQHRj4TZPz9BZQSMgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZebZlfZto57hS0UP0bDxvGaDZMtU+v9Wr8gP9cEueM6lNgkwsVgol7H16XlPIwi6KyDyfcDfMVb2qJgsFk4pH5o29GQmXhIJdzn2VDA/KkOoy0oTMMNopn0QCTrIaveP8rfp7Kr9bvGpSe0URkYgghu7wm5BV3DiobzZ4R9p2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HULDzgV0; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29f08b909aeso13655915ad.2
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200545; x=1768805345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPMqt7OubTukSzfJGmFa7NplH3SyhzWtPIziyN+vzQc=;
        b=kMqBCedw4n1ir7pGePWGhwVON1AyR3fxIHxOeKPXPpBwboqTYjgg3Ctds4ok0ZrX9B
         So9t4wetx8skefmGIIYhCigUBvWjVAlGv4Df2l9MC+rSxTTTgOwdOTD2Nv4Qv4fa3SlB
         wm7f7gmbJ2FFY60rqVSMkKyprApfYP9bd4vLPq3+1NGnhqyP3E47MJO6NFyjmeqcH7dz
         m8KQxEcVx1w7Q01a9zxlNY2iz8wFP/5Sl/TYs0e3Os+m9c7axQBj8FTjQtTN7dUQ/THz
         iGsKBNCb4C7xwDZnvjybjhImswPtdQUZnl3lLiyJeL0D9YqFH/vUysaecxlsCrbghM4N
         yqTg==
X-Gm-Message-State: AOJu0YzojiIUdM4Nj33Rnmbo5XJ4TUwNv+lBZLjxjxv1rkr5+iS+kfhu
	Aivne8zw5Ys/PE8SYU4IiLNCdC/u/VktMo5Wlx1qxJTST6q3yzMOLrSSJ9OQACY8MqyolJiWZI7
	D+yGCtl9gqG9smQ90/+Gd6w72Em6qv16S1E9fRd/adJZL9UDRNval7bx1x8IPCLsGu7i81OLiDe
	mPvzbW3Jf5C6m337bwUlRUEwtZCa6pI/JYRuRbK6dL4n9YWAo8zuKKTYOeLEUlx1rliZOTzd54C
	T5WLB1KjXsFkp54i14SNOfc9JKnxbU=
X-Gm-Gg: AY/fxX74Pab6+AJ80id1MJ6zWVKbyQmhMPtVqFotKU92MQQjdJhqLETBViuHd2SFCx1
	dvSZ8XyH2OLgIUVzhHrRz5QCb1L8ru/lMCO5IlMQ3rzBnWEvsEwcrtbf9GE0hSkPWBZ3L5TLVtc
	tz4ZvD7xwPK/czHDB8+iM28y85k5JjL2UID+rXIwdWXOA8jkAROrTYIf/VEfvbSCY3Hbn0ZYwwW
	woiDifl5k/WOGJGE0eHl/KCO2vIg3ZWcG5k2k6d90aRJrRievCy8LRvOv/A4H2yQyAMUsjTuC/i
	/VdgTTOJIligLn0295xK8sxErY2m4QU3oV1r+t16Jgu0jbC3/FB9zf6w4TmdmRueJFii1/HzRDv
	IEAYDXv3CAzpVcZSOz6G2DY3o5I9LlWIMR/FbvwtgBfkj62GwkE25o03kkZe2aatnRLwR3tckDg
	ULMReZTFzZAhjp/4focJOqyOj3wIPrlWEHDtr94inXF+7yaoX6JvjSN0kGQR8=
X-Google-Smtp-Source: AGHT+IEpjqilgZT2W3+konj/2R/m7JkmWUO4n3twB6godVdG9s1Du3Mh6D7b/4qti7YfMyNJs5nIg2H8M9eJ
X-Received: by 2002:a17:903:3508:b0:29f:2df2:cf49 with SMTP id d9443c01a7336-2a3ee4b48b5mr125860505ad.5.1768200544658;
        Sun, 11 Jan 2026 22:49:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc4af1sm20624735ad.47.2026.01.11.22.49.04
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:49:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88fd7ddba3fso24055716d6.1
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768200543; x=1768805343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPMqt7OubTukSzfJGmFa7NplH3SyhzWtPIziyN+vzQc=;
        b=HULDzgV0xNjjSDM0vQDvUI6wFElpZDOEMzhjLyc0Zk2D0LMSxBEPRLi4ELVQC2Zckj
         +t0+mYjt0a+14Ys/HHcXrEkZecSP7mRKLNoLAbvQ34qFg1tmnQlWVTfUaw17GkjwMuvP
         tY4Ic7ug4kHP2ApvIjskPOrgGh9/eHxqAw+/M=
X-Received: by 2002:a05:6214:2481:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-890842cb736mr185047406d6.3.1768200542755;
        Sun, 11 Jan 2026 22:49:02 -0800 (PST)
X-Received: by 2002:a05:6214:2481:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-890842cb736mr185047146d6.3.1768200542333;
        Sun, 11 Jan 2026 22:49:02 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm131125426d6.23.2026.01.11.22.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:49:01 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v6.6.y 2/2] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 12 Jan 2026 06:45:54 +0000
Message-ID: <20260112064554.2969656-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260112064554.2969656-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260112064554.2969656-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit c65f27b9c3be2269918e1cbad6d8884741f835c5 ]

get_netdev_for_sock() is called during setsockopt(),
so not under RCU.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use __sk_dst_get() and dst_dev_rcu().

Note that the only ->ndo_sk_get_lower_dev() user is
bond_sk_get_lower_dev(), which uses RCU.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20250916214758.650211-6-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Keerthana: Backport to v6.6.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 4f72fd26a..55b46df65 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -125,17 +125,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 /* We assume that the socket is already connected */
 static struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
+	struct net_device *dev, *lowest_dev = NULL;
+	struct dst_entry *dst;
 
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
+	rcu_read_lock();
+	dst = __sk_dst_get(sk);
+	dev = dst ? dst_dev_rcu(dst) : NULL;
+	if (likely(dev)) {
+		lowest_dev = netdev_sk_get_lowest_dev(dev, sk);
+		dev_hold(lowest_dev);
 	}
+	rcu_read_unlock();
 
-	dst_release(dst);
-
-	return netdev;
+	return lowest_dev;
 }
 
 static void destroy_record(struct tls_record_info *record)
-- 
2.43.7


