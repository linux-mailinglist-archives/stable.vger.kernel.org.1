Return-Path: <stable+bounces-270107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JPNqF9W4RGo2zgoAu9opvQ
	(envelope-from <stable+bounces-270107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 08:51:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7406EA567
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 08:51:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b=EnPWGn5e;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270107-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270107-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15BEB300FCA1
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 06:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ED03B19CD;
	Wed,  1 Jul 2026 06:50:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348772D9484
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 06:50:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888645; cv=none; b=QpRmCtvTuPiX9T9crHm6FKnUu+ZdZQyhXiPLuQB2rXY8h72nT7as/LoalMn6Q6kCWHKBlXi5dhdZpqnL66NpPMgcRFt1M/j9bNtgKasJ4fZcdeKHUui2cw9lrjVel5oScir+Lh7EYV07kFVz3sisWbdB8RH4IHRGFEV3+Tz6Fv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888645; c=relaxed/simple;
	bh=BW2E2MltUrh8Ffu3za+NXtLmFNG73i8yFckczgf4Yq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZ/0VKVFjDnAo9zOatBkk7lW0J0wOdYpzvYg75EdFSMyV0jG6GW5FSQAdfXCl8G9LkiLNniPk5vrjkseyrAw5zi+X6iddRiLz98j89HiDH1/rEBoUNqfKgaZwiVHh98z1Juq6ysn5+xowa/LbiTQ/OikJDFHtSjZ+blm6mhpsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=EnPWGn5e; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8471013fac2so163725b3a.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1782888643; x=1783493443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5gFr0Ah0wwlFvOzu82oC3eo89DUP3i2jLIZB/ISzek=;
        b=EnPWGn5eWM5Vszy3q5fnn3a4VP990p4di9T8yOyuvSy4OGFGlugqR49A99C2alHckW
         fQVDh3Ii/JotmEF2Ds+iGDxV5A6UPSwxBZMdx9XEzA97WRnK9QOO4MHyFyeqHel8Z0Gy
         haJjSZsq3S463I2tfcwpibZtMo3tY+gO4y/72UDb308hm6hMhOZl+8j4GEoNUoEjo3OT
         ysHTtMVpEzHMv4YbouBj1Z0YSENrLu8LJuv+Xxt9uXraeUuNh9SKOs7oFb8qcWYKlOzf
         oPTl37mdHmQS4DLo3v1f/X/NiOBwO6ECu/xS1PKHOnETl+JoDKWNNqS/2Ew9d1HdhzhI
         RPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782888643; x=1783493443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5gFr0Ah0wwlFvOzu82oC3eo89DUP3i2jLIZB/ISzek=;
        b=ogz3CLxf1qEqEDsZOHk+xJmM2BbsS8kA7q1mFCGBhWngZoDpQPrCrutkAF3JBYOIuj
         v8og+o3+sEFRUmY2V/mhAfMY7TlFhZuUJw6tZPJJGQKp6xrMzMhMVQ+gHqcS14aWsC/t
         Q0iyLSSXV1YPtZG210l8iNe0JcUXHNYcB8l6kJUzE0g0Y2+14RyNlJRCG1k6rcxxivq2
         dUlTuoAE0MTKMWlptvF6GF2su+qGrKzqxEP3WSctSwsr47Jpnt3R40MFvdWotT0hDsJs
         +66kAl4nyJcBpGyJ/Dai1aOnuBB6GhsMTcPDb6IFBZFt3oDsNq7OwqlmPg2lM+uW/MeP
         x+zA==
X-Forwarded-Encrypted: i=1; AHgh+RqM5TkIqMYN6dHxOtQ+z2G0VVcrCkuIt92618bbMyWik23oEIbF8MVpAJXdS6jlKROj8+dQeWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2OLY91qDvVEV6DMxNaicihoT9HT7HKjmBrCHPT73HhXe1LRp
	e4kH/0Zmhg8DFQge/SwELLI9gjAmiApJgO/zpsWfQfFmwvHmdnEWxY6XA/BjyVopwBI=
X-Gm-Gg: AfdE7cnHMSzEbpV11zvssTsqmz0tZsq6ENUmrBeLpxYmj6H8YpqE9r2mAFKRgWRlEyt
	hK6NZEOGQ3uP205WuvwW2PkrZycWSy9pbzJdB4s1K8WYETgY8GpnlAjc52jbLfgzII/WDj4vXsM
	MCf0neZWKr3fryK5VIXyA06YcpEzsjh3Q16K186Xr48uVWsjIBMGg33RpP9z1tDMPQOGT/9KjMU
	Jbd632eITDKInDfdFEjPE5dJZwQHdzlNxbwm0YebjC93wjvL0Zqu4tnkNGr2ZrbdkjsxZw+1YhM
	5cVuWJBH4OvDnmCXvOwcIijd6G3fYfp/9MmXrXBDBxQVQ2W87fWiIpLIm/frokGzhTqYHGpRz80
	4iejs20zPtiw8MnyLg8GVk68uu2+A7oG0oldlK2PYSR0lHvWp/apE7W9kpHyj11BbMA5MoZs4Lg
	eQK3+zg6BdrjdPKHErw3WRcQ3HNTUdyfxqc5w0ZAz828RbCs1TQHWSkh+64dl6rpwe3IqDr+3/Q
	eSnNUW7BrE8y93mPbduNu1eTjrVE42yy6R+Cthw5qs=
X-Received: by 2002:a05:6a00:4652:b0:82c:6f07:299f with SMTP id d2e1a72fcca58-847c06f7ccemr322704b3a.14.1782888643573;
        Tue, 30 Jun 2026 23:50:43 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8479ff8c6f8sm3289531b3a.1.2026.06.30.23.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:50:43 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: skalluru@marvell.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] bnx2x: fix null pointer dereference in bnx2x_free_mem_bp()
Date: Wed,  1 Jul 2026 12:20:26 +0530
Message-ID: <20260701065030.381836-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270107-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:skalluru@marvell.com,m:nihaal@cse.iitm.ac.in,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,iitm.ac.in:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C7406EA567

In one of the error path in bnx2x_alloc_mem_bp(), bnx2x_free_mem_bp()
may be called with bp->fp uninitialized. And so, there could be a null
pointer dereference in bnx2x_free_mem_bp(). Fix that by adding a null
check before the only dereference of bp->fp in the function.

The issue was reported by Sashiko AI review.

Fixes: c3146eb676e7 ("bnx2x: Correct memory preparation and release")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only.
Thanks to Simon Horman for pointing out the Sashiko review.

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 5b2640bd31c3..25ee45cb7f3f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4712,8 +4712,9 @@ void bnx2x_free_mem_bp(struct bnx2x *bp)
 {
 	int i;
 
-	for (i = 0; i < bp->fp_array_size; i++)
-		kfree(bp->fp[i].tpa_info);
+	if (bp->fp)
+		for (i = 0; i < bp->fp_array_size; i++)
+			kfree(bp->fp[i].tpa_info);
 	kfree(bp->fp);
 	kfree(bp->sp_objs);
 	kfree(bp->fp_stats);
-- 
2.43.0


