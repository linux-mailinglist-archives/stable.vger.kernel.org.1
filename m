Return-Path: <stable+bounces-232652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMDuNOiGzGnVTgYAu9opvQ
	(envelope-from <stable+bounces-232652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 04:46:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7B0373FE1
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 04:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0F9030065EC
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 02:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBD22D5C83;
	Wed,  1 Apr 2026 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbDlBhbU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6592308F26
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011557; cv=none; b=hD+oji32bP25Zh/DG0fexqDV9QMSSsB8l4t9mpuFUWPFrdrWSWWvU8V9WDZC2wC67kk0wWNnJWRkMLfUYPUftxv73TzzMWHjEricByfl5RcLb9/1O4YXqAW00lI/MZ1xwcULco4pLTbNqtrwUGy1KIWUGgnIM8b2KaWttbG2VK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011557; c=relaxed/simple;
	bh=5rqZFu4m0DhI2LCQIRiD6LzWwdcNiXgBJGJBIxfmWzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcSu5gPXH5FEOIn+77H+Ld5H98h5G99HnzwEc9dN0PYarOY3W9Moy1i07AUQG3qG3IHd1Cf3imQgef8MxIoVXKMYVU0UFnwxZsLPKf3EXi+Znc8gRMMgSB0riY8CrqHUNY2Wr6d79ngXQfQx7OxkSXIq51bL3FNs8NwfLCZgw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbDlBhbU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so2987779a91.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 19:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775011546; x=1775616346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k0AMRHVKUvntR7Icz/Ehum0LT86VVv3YWOGS3oQyg8k=;
        b=NbDlBhbUmm7ubGPH3omzSFJPvC1KYng04JkvHBvP3dHNAkq7Nuy1IumMShbzu+cJ5C
         E571R/G6mSuSyy1rPwBDiTP+dGaUJ3NhWV6MjSGqP7z9tUOgi+4Sqk6BvHFUahB8wfrH
         LH6iW3GdFEzzaDhZneuE+SuWoHBzr0wE6h8cbSd6iDr0XzUNbd/feqdu9B67xgFY/aQ7
         PE3x7umuOQHgx1ZfODfuDFGpNdh3Qir9Wx7rR8Kjajzlwh4jkv/k6dC9oYynWYcQBSC0
         xBHpSXjzd7LPf/2pN8xDi9K1qSD+IPtt+5pZpzpNgE93kTJD5kE9GXn7mP19W3J1Ewbh
         ygOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775011546; x=1775616346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0AMRHVKUvntR7Icz/Ehum0LT86VVv3YWOGS3oQyg8k=;
        b=pUyPK3IaH2ZGrn08QfDEw8E3+uAEzdFvZmm8HAjhWjM1ya2IxXKYnJFtmCUZKYFpTf
         3iIeQK3L3XZ+sjWz4kezsids0bJxCBpI3EAy39KsoBazPE9J5pTlHSWRMDJWzMlB6lDo
         GVqzSnL3ZWkxZLm5w1FuAvoTD2kxi7e+8wxfov3vTNzDOZqcJl8XnPcA816GZ7fquKoH
         a901WNqIz7qJApEcXpXfUMCFH2UXMSwcC4tBx8kNzoL55tBYtCcsEtgvD7yoc1SEkirg
         NeTbBwZ+Lb8NW3bLR3ttp5v54EnqLyhU64lPK3P9YD5+yyj1Jqqp5lHORxyJC5Gkjh4P
         nsxg==
X-Forwarded-Encrypted: i=1; AJvYcCWk0g4p16H2xmWe/YitIQmPFmEiuRFnhL5L0IcBzK/sFj9vvmyL3bpvg7oDjHv9Sf4erFu/TME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxip+S2b39JT45Q1JYQgll3U+PP93RHhM5mzOAQanTwuquACb1s
	yy23BmXc2rF1tEWudn7KgtFNBhFr8HHnoHGHv6XdbfGluxxugzE3ifus
X-Gm-Gg: ATEYQzyaCyikyHCIi+trKhs5b2DfH1nwGOicq3oqTgWTi/klC++LgcCOBBMInc4TDBD
	Gv5RGtIw9mX9+RB832Fgm1RROr+qOKkRC+NELWVTT/48tIvgawPCoStXfCuXqUod8Ds1T3or8OX
	iLZrKCO0g64cGczve3LCfsc5MAiDzi8qUYQIa//HoxT5jY4E+A5151mxOxDWMoGITcUZA+qbFdP
	s0RxDh0Ze/wv7rwJKZhF95tqhnKpLaRZnlbYTJHoH/yw/m30Yv9Hg73lV4Ih0y5fjdskl/qJdQn
	WsYXwMiC/NgCVeZyyQFSB92myV4ziv+3KtY2TWjccZB5bZQCUITCmXjNKuqU0pElQlxSmTm+Lea
	8u+nROMxBbDvz0w7VXaAv6gXEThD/L4kCeryAAViAD4OMaN+V37JayZ9QXsMhUi0dMoFgU2l6Gt
	SuJw6G/HSwAFtkooI=
X-Received: by 2002:a17:90b:3f8f:b0:359:fe72:3559 with SMTP id 98e67ed59e1d1-35dc6f7feacmr1597549a91.21.1775011546230;
        Tue, 31 Mar 2026 19:45:46 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba590d49sm1572450a91.2.2026.03.31.19.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 19:45:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Tobin C. Harding" <tobin@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: governor: fix double free in cpufreq_dbs_governor_init() error path
Date: Wed,  1 Apr 2026 10:45:35 +0800
Message-ID: <20260401024535.1395801-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232652-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7B7B0373FE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When kobject_init_and_add() fails, cpufreq_dbs_governor_init() calls
kobject_put(&dbs_data->attr_set.kobj).

The kobject release callback cpufreq_dbs_data_release() calls
gov->exit(dbs_data) and kfree(dbs_data), but the current error path
then calls gov->exit(dbs_data) and kfree(dbs_data) again, causing a
double free.

Keep the direct kfree(dbs_data) for the gov->init() failure path, but
after kobject_init_and_add() has been called, let kobject_put() handle
the cleanup through cpufreq_dbs_data_release().

Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/cpufreq/cpufreq_governor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 1a7fcaf39cc9..3ad51a986781 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -468,13 +468,13 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	/* Failure, so roll back. */
 	pr_err("initialization failed (dbs_data kobject init error %d)\n", ret);
 
-	kobject_put(&dbs_data->attr_set.kobj);
-
 	policy->governor_data = NULL;
 
 	if (!have_governor_per_policy())
 		gov->gdbs_data = NULL;
-	gov->exit(dbs_data);
+
+	kobject_put(&dbs_data->attr_set.kobj);
+	goto free_policy_dbs_info;
 
 free_dbs_data:
 	kfree(dbs_data);
-- 
2.43.0


