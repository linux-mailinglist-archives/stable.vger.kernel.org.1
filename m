Return-Path: <stable+bounces-235563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNJXI+p/2GlSeAgAu9opvQ
	(envelope-from <stable+bounces-235563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:43:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4923D2228
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78200301C10D
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 04:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9B733260F;
	Fri, 10 Apr 2026 04:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haz6t1fr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA35332601
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796199; cv=none; b=RnHPAkPYXFE+SdLXedimjoipEZ5ArR5ulKvAuH4fDq62Fy/RmdPndJZQsd9sAELmHt62o3QVLWmjV5vczmLgpja3UozbTpVjCqkWttJUT3dlKBoFRSuFn7KXcV5fiVdEvBjE3M+cyCiuuTzzorAGCruDzXoY+rLoc4fFmDRB6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796199; c=relaxed/simple;
	bh=iN3sIFcZLTLFMSNhoVbJjjcQ9cXhEOUIXwgOoP8u4v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPR4EY7IyBCkYmf4hidWykZF/2WPo/agTjJmykQ7S/vzM/NNCziRovaHfZ3Gtryg/dKK8CpYEv92abtkM8Q6YjuQQp7NGK6ce1ncUIrbVc0B68boYBZcJzHnNoMF/j4gHpjgrl/FGpipunggoZshu7B64+j7iloKtrUT/8Db904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haz6t1fr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82c70e4654eso765000b3a.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 21:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775796197; x=1776400997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBXWLvahdu/HVwF/Faib/MOJG0gD/Btl4TI2BjLmBLY=;
        b=haz6t1frmpIqYW0OEJZSjetGTEipnYfZ+6Nuz2T90s25he1rc6ttvliAM7d2RbAmhS
         lPipSVMRet6ciCh170bkHLnNRc6p1gwnXkVlxOHThbxx5wxnXDx876I5pJpR2WiqXrkS
         Rz6AaMf0vk+EvgZyU9sX4AuRm2aZD+ebzYtrACvwkRHsq9/pE5nRzC51gUvaxo1lw8Un
         SSDoF/3Z/Q1HiPCSrbirOiwbtfCAZzytdElspX+iwwseQ4BGJfZy97k+JHaQBVzFebmI
         8AEKmPEslYb4QKI+9/yLQr8ERRx4hHxTeap2Xp6uncICm8ySDXe0MANpF+Alu0ZLTFLX
         Ut2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775796197; x=1776400997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jBXWLvahdu/HVwF/Faib/MOJG0gD/Btl4TI2BjLmBLY=;
        b=U8xArdAkL5X9BXdwBm7m3Ttk+4Wp2EDzfa+RxQB0L2XSPUpf7xGdKCwnITJt7kxb+w
         7NQa/ysjKQvwnKQO1gW4EMmzyRNUOVp3X5C2ly92JLbI8dBU16cDfs0tvSYKxZRtdcdR
         WRXGqHvVuzbZXT4gk6e5NnGQhb+00kTXNYnLvYl/Fl/pvN1WWHUjC/EOEdEB/AZr6F5h
         Xkupi0l5nVJFxblr57jRBbqdsOn8t8mTIJ7zvRq3HzOg1s1XpT0O0PWkQVBZaSVX0cmL
         QV4dvCV97T8xUf2k06fSzFIYXE01vwpQ4XSwMkuSCLrznTqtvyhTyWtARTrUZm+6oO/E
         J0zw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Aq5tR9O0L/KI2ZTOIVPU3IBk05AXCMp5cEKLZp/3sgLxaRa7EMVWkCTnepacEVZzhxmVNXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVC+ihQ+J4IpD4HonGKCgugjPIiF9fQsOkHns3DYxRljNx2VN
	zujH3Ekl2wUqePk2OOOsQspmegCZmvwcMyqPGbwT5+slTWRmAalYJzGG
X-Gm-Gg: AeBDietrYlIa2KqAknFOmEjwvS09hqUbzYlfMwdgHxxiCzlKXr8sf/Ql6+Fw67yf5Yj
	fUndAAY0D74CxkcRlp7iaqN2ZQ4tdLy5si22LhsAwsLygaCNYt0mIkCzoopwKnH2hSGqd+A/isM
	EUuGBa/OY2JIrGh1tsd27ZwtR+wZIQuw4h/8BYVNon9x3ENVyMTUc3E1Wg3Pwem54PetNZ3836m
	rTZoYjqi3yhrLfX3pguNrKgRxargXj6aWbteShM7E71nUlZlj/i749aG2eBKri3CgmsJbZIIOQE
	oE+V5WfGHhv6NUidbkK4+mEG939POANcOSu9EZ18AlHqrmIa9tUqQHTOHT1UB7stAmaJ4iAH8tJ
	QRRNTf6cteLOYy4W2Owa/jDHsexyssuPMvlRv1tPgVqZjlRXfYDEvCuFhkn/ZMJMLZtKZPJKXB2
	5rbFNs6T6O91lk+oeP6HZeheJeJ2o=
X-Received: by 2002:a05:6a00:b908:b0:82c:6da7:2d3d with SMTP id d2e1a72fcca58-82f0c250a31mr2001305b3a.11.1775796196784;
        Thu, 09 Apr 2026 21:43:16 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30e7besm1200109b3a.5.2026.04.09.21.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 21:43:16 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 12:42:58 +0800
Message-ID: <20260410044259.95877-2-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410044259.95877-1-aethernet65535@gmail.com>
References: <20260410044259.95877-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[huawei.com,lists.linux.dev,kvack.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235563-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aethernet65535@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE4923D2228
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Problem
=======
When a user sets an invalid 'addr_unit' (e.g., 3) via
DAMON_LRU_SORT, 'min_region_sz' becomes a non-power-of-2
value. This value eventually reaches damon_commit_ctx(), which does:

    dst->maybe_corrupted = true;
    if (!is_power_of_2(src->min_region_sz))
        return -EINVAL;

Although -EINVAL is returned, 'maybe_corrupted' is already set. The
running kdamond observers this flag and terminates unexpectedly.

"Unexpected termination" here means the kdamond exits without any user
request (e.g., not by writing 'N' to 'enabled').

User Impact
===========
Once kdamond terminates this way, it cannot be restarted via sysfs
because:

1. DAMON_LRU_SORT is built into the kernel, so it cannot be unloaded and
   reloaded at runtime.
2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
   Writing 'Y' does nothing, as 'enabled' is already Y.

Reproduction
============
1. Enable DAMON_LRU_SORT
2. Set addr_unit=3
3. Commit inputs via 'commit_inputs'
4. Observe kdamond termination

Solution
========
Add an early validation in damon_lru_sort_apply_parameters() to check
'min_region_sz' before any state change occurs. If it is non-power-of-2,
return -EINVAL immediately, preventing 'maybe_corrupted' from being set.

Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/lru_sort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..3fd176ef9d9c 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.53.0


