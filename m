Return-Path: <stable+bounces-237662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAKLF7td3WmadAkAu9opvQ
	(envelope-from <stable+bounces-237662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:18:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE71C3F37D5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E0A3304741E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C96C35B62F;
	Mon, 13 Apr 2026 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCYSQfTj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B83921DF
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114972; cv=none; b=dOAwKPzpZJpRbxljuRWysfS7qjY/I+IiW0ZrKuxfsQYKNncBA9IMkCV5ZrbQ1VMcCyL00Q3OwxpGITRV/MMpswi6VJIkR2ncbZIIqiox0uucyW31O5//d7RhbtpQcXzzC3xL/n1auWxtP9wXrE8nWxeankUk72gx7JboLiX9Gow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114972; c=relaxed/simple;
	bh=AFiehBHJJDtpZCChKbiQwpG4u9g76gs9xkq5Ctyl29Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSNNNofTznPOb34Nrww/sRb3rZqpYUpc078ouWDDzeAUqy17wgoCBkr8YA4D55GsIlEZe49Q9QFSXpzoaNnDLDwWRPcJ+1xU03Vp1zyBCFWDdvCCoXjwNcxDi38AZaxDsOdgDXvRyxWxMNSglDT9bsgy8dsI6QeFFojA+n6h+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCYSQfTj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso2753107b3a.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776114970; x=1776719770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6XYsoy0hgti9UjRylPOMBsVgDXd9AkuOGfbur3GU+c=;
        b=rCYSQfTjHK/iS2sINpKTL4VV2bJ7qLAPsgOiUKy00wWRQrigLU+1Uxrx08vz2R0J+h
         GPGjhkvvXX211/Ok4r4IeGUWcATJuIaZcAcdKnh7ynbosXWS1q1NaKA4thh70JzsfJHD
         ARFnN9U+0P5WUlYVS/169rffHzZlvvP+3qtOFHWuz6jPI/8p+QxKN9539MOrwYOQvO3S
         IZoWtZbwWW/euNSkC3NAuS4Wc8M0ZJqNcmCydKg8KGCfW5MmEuvDFSlEeFq+xcKqykGG
         eWsYgkMm5pVhtdPb3y/LzA8f+wHcDz+tsoKYQ+NHernjwU3274l5+EfOVtJKtiXV39VH
         nS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114970; x=1776719770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6XYsoy0hgti9UjRylPOMBsVgDXd9AkuOGfbur3GU+c=;
        b=X4q9AD6eawF8i28FP8patrZnQDMfRSz/zFFwa/2C1Dg62yeQLp27vKScT9mkFbe4wA
         uuszZVEq+9QBswORzYLlvDHOkue41nslL3ruBXb21y5Bhm+jwStdddoBHri9qP7oaA76
         IE2JgUWSSVRaPnEv9F2CtnB5uD1HjLD1/MHpwnnUeluEgieASAPYJ9gpHONq4P8QWgd/
         nJmQBjBL2mM1Cd4obRxjCDOp5ykAMyUGRQknCA4ByfMsyHoT4t52tmwrqj59DDvLQ3hM
         +gonuFNfiw3CjaPj7cXZHoDniQEFDhR8d+mPrFJJj89hGM17mmyc/i7/myhIalmARVDm
         vxuA==
X-Forwarded-Encrypted: i=1; AFNElJ9gX6o7BlLpmYfDTVWKK/g3UBZjy/H/nSo8HowvevFaDQWdzgkNHCGG+KQ5I1n25U+kAIGrc4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycf+abMLavsYrxuXjJR4axQlPFs1mxPs6ZI7DJu/vb3oHwhDqH
	9fdjTCl1EHXM+yG3I5lqhfceB4DVWUyvx2YyVZDLwJJwqi2a9tiZKYGv
X-Gm-Gg: AeBDievLozJvEXcA/RR7lxdU6HRlG+iglMYoIkei4m2WUMKuNwz5Lf9lWdmUczltgo2
	lJdRr89oCL0Ls5aQJE1t1x//Q+oxkIsuc5ZFMPgDuq6wmzVXJbFEM9aUBGzxbX5cZLtkhOB8gSV
	s2WgYpmfnW/d048rG3UYE9Y7BHLwv2yf7WPR7YpbfEEhhIOsVpmbJ3vUKBJ8cXJI7gDim/dQs9S
	oJi0eYA8GkvXIdLNTNhz4S68C2f+6jVTCI2ratDVazEXBx2WAzzQSI0gW0ZPCAljSjd0d365Q6i
	aPWp2J8Bw9oWdozARKTmuDhi4rXvVe5GEs6Sy7cCYjpwhwqU2pSsAKsvZNz7Rssy3ZGyA0aPwC/
	UBvPIkAtpTfMQgspt+1C7O7B2mCGm2DXuYGFAWotVFzzsvw9ETR0FvAGnz9kf3EDynVNiRzYMBD
	x0wqu9um9O70IWaL1gRzrfdk+LnfH6EKOtYbxjy25S+zyU
X-Received: by 2002:a05:6a00:278d:b0:82f:250b:9f1b with SMTP id d2e1a72fcca58-82f250ba2bcmr8529329b3a.23.1776114970028;
        Mon, 13 Apr 2026 14:16:10 -0700 (PDT)
Received: from tech-Alienware-m15-R6.. ([122.171.18.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee32sm12822124b3a.7.2026.04.13.14.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:16:09 -0700 (PDT)
From: Sunny Patel <nueralspacetech@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sunny Patel <nueralspacetech@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/migrate_device: fix double unlock
Date: Tue, 14 Apr 2026 02:45:49 +0530
Message-ID: <20260413211559.20969-1-nueralspacetech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,kvack.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-237662-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nueralspacetech@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE71C3F37D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

migrate_vma_collect_huge_pmd() calls spin_unlock(ptl) after
softleaf_entry_wait_on_locked(), which already releases the ptl.

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")

Cc: stable@vger.kernel.org

Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
---
 mm/migrate_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 8079676c8f1f..7eb2f87ea39d 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -177,7 +177,6 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
 
 		if (softleaf_is_migration(entry)) {
 			softleaf_entry_wait_on_locked(entry, ptl);
-			spin_unlock(ptl);
 			return -EAGAIN;
 		}
 
-- 
2.43.0


