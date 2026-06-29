Return-Path: <stable+bounces-269737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dBnjIMtWQmoh5AkAu9opvQ
	(envelope-from <stable+bounces-269737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 13:28:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C616D963F
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 13:28:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TRIh3zGt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269737-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269737-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15429306FDD9
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FD73FF89B;
	Mon, 29 Jun 2026 11:20:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD73FD15F
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 11:20:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732057; cv=none; b=Y99g0jcaqgMRU7QQ4NwheoPkcl81CwSgO5H2LuONhFpaZSuNdMCpO+b6rd9rbwDf46v22HY2MUJV52Uxao7zwZqM9ykboO+5yJ/rD7yHyzMXIO8LYwDJLp06LaERA4D7JJ1oFUasPngzWL+873XIPteu6lYpi25aUOvG0nJarz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732057; c=relaxed/simple;
	bh=oBlqxgiOGageFSYmE0C05QIao61wUq0bgS3LnT7IDh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qK4mcTjEfw6i7CRVE0aFKmHiM1IFJ1KGUQVMLzVFqcACSXTGJyuVsNDQKNKZLHw9KsQrq7X7AVjiU7Cshtnx2SYYSp2dHNNde+g0EGMSsADtu4dnr+pWoPX9D7Juwu5Unrk3dKN5g8lIuFc+zMYXYfCDi+yrSv2qCdON4/WiQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRIh3zGt; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so16928995ad.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782732055; x=1783336855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViL3fRcEiOH5DjjJbtd4DZVU5q2T+7FWxEKjKuEIV8w=;
        b=TRIh3zGt417/hY8IHIlpEzZ/YXKoVu7/O7FAtWrMgJlqFeYkyL+cz40M74u5vUEKRI
         WrBdRl+qUc4Tha9B9jKEBDygW/vxLm8ISjcXuZMOzXrWmuyFdjR8AIzBBrw29wqCnLP8
         BKU5sDdtf8VNbWpDGhr5jx9DfCyI8nMwxWRnMjtSWncGFSGF5adJYF5YPuMRjXVX7/AH
         3aujJviJ6avSKhkOE7m1s9l4h88GcCxk8thUUTAH9B3AlASboGUAQ3fYqgsC3eIV0is8
         /pMsHpWN6cb9uXYuVV9ZZ8gsAHlHA1I7rclXjyUOmZGxVaUVUOWImMC38cWhjeXuTVCp
         MLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782732055; x=1783336855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViL3fRcEiOH5DjjJbtd4DZVU5q2T+7FWxEKjKuEIV8w=;
        b=eZJ9fM8TUoRk0ny+r50vDF/XfmE4zxP+XNaG2lKTD3UPXg8K0H+ssaweoZGewIw9yZ
         ZLNHgjCfDUxZGEcY/WOCNTpqP7iPXA5IX6Z95+dv60UiGNWRJH4gWBKpH7kvzc0/pC+D
         qLGtoshuEKNSaSUtl20IuANwUPwVX7yww125mkFFi/g09LyqRguneY/jyR8Flf3S7TRF
         dQgvpyXPRoBC4WJRM3tcL6TIwXqEgdPwRHlX4SO6kCAtzwiRzbLbWu/AuVGE/PRbH114
         tIEpfDS4gAV9aYGwpot6LSuMTI3C3vtTHW5MlD58SxqTWfq0eWLCvaRjneFBYpdqT3iY
         L4qg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1ANNL9ryvCUwvHaPy4uKK1jjgxA3KgSCHy5APs2o0uzLiuCQMJ5pKvtknONmHG1vVYjPI4Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQC4pHUeFo0O3Yl2VR4sXMTMWgUwKLv0yjFz9tJchOzHpSGpq
	Z39niuVC2D+ADs4V/3f6mkKzOcTTusJThWRJgDCA9FFBXyidmJuApZWV
X-Gm-Gg: AfdE7ckH5mometac1x4SO+7m+QJyxAXhX2d12b/E9rfjSlZwgo4vhH//jPwEkXpBd0m
	eMl3xqGDl12OOxLMTxIxInyi3Ggm4/pmhVvtKRTzsShGez7PtGKWM6+t2PnWKMlqcrIVCrNG/Qy
	CkhrqPb+McHqvqkKSbIE586TFJLP5y6vFQreqIXroyqY80uOvKEF/scAHhNWdmfm9M+RZ/IfoB2
	xp411IOglhkWBdyqnXgqStclch4JGU/N0wN3448HGEKi5eCprLyOyHWZbQNIn0REvdMLeWKryDh
	wVihm/4OKsohZyMdRefm3KwNcJBo/PG+pIDXpeY92VEibbklL15cU6YFQkoN2UpbCgQXnpru2zp
	UasxZpolGiAzT/VzdIEBbuX0uR+vXcHCM8VldXbMObuebLaxdRFC9kKL/BzuqKTDw7f1Yj9ch/X
	qTElOnswyLKB7Zs2wHToBq6MHIUgjqHWbx7giKU2vHklaTQhBdUH8=
X-Received: by 2002:a17:903:690:b0:2c9:97a7:71b1 with SMTP id d9443c01a7336-2ca26545886mr67075ad.44.1782732055099;
        Mon, 29 Jun 2026 04:20:55 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63d09f0sm92759085ad.56.2026.06.29.04.20.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jun 2026 04:20:54 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	yosry@kernel.org,
	mkoutny@suse.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/6] mm/zswap: Fix global shrinker when memory cgroup is disabled
Date: Mon, 29 Jun 2026 19:20:27 +0800
Message-Id: <20260629112032.20423-2-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260629112032.20423-1-jiahao.kernel@gmail.com>
References: <20260629112032.20423-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-269737-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:yosry@kernel.org,m:mkoutny@suse.com,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jiahaokernel@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7C616D963F

From: Hao Jia <jiahao1@lixiang.com>

When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
Therefore, the global shrinker shrink_worker() always takes the !memcg
branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply gives up,
so it fails to write back anything.

Therefore, when memory cgroup is disabled, fall through with the !memcg
branch and shrink the root memcg directly. Stop the loop once
shrink_memcg() reports -ENOENT, since the root LRU is the only target and
-ENOENT means it has been exhausted.

Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
Cc: stable@vger.kernel.org
Reported-by: Yosry Ahmed <yosry@kernel.org>
Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 mm/zswap.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 761cd699e0a3..0f8f04f22888 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1356,7 +1356,12 @@ static void shrink_worker(struct work_struct *w)
 		} while (memcg && !mem_cgroup_tryget_online(memcg));
 		spin_unlock(&zswap_shrink_lock);
 
-		if (!memcg) {
+		/*
+		 * Reaching a NULL memcg means a full hierarchy pass completed.
+		 * Exclude the memcg-disabled case, where it is always NULL, and
+		 * fall through to shrink the root LRU directly.
+		 */
+		if (!memcg && !mem_cgroup_disabled()) {
 			/*
 			 * Continue shrinking without incrementing failures if
 			 * we found candidate memcgs in the last tree walk.
@@ -1378,8 +1383,15 @@ static void shrink_worker(struct work_struct *w)
 		 * with pages in zswap. Skip this without incrementing attempts
 		 * and failures.
 		 */
-		if (ret == -ENOENT)
+		if (ret == -ENOENT) {
+			/*
+			 * With memcg disabled the root LRU is the only target, so
+			 * we should abort if it has no writeback-candidate pages.
+			 */
+			if (mem_cgroup_disabled())
+				break;
 			continue;
+		}
 		++attempts;
 
 		if (ret && ++failures == MAX_RECLAIM_RETRIES)
-- 
2.34.1


