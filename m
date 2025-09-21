Return-Path: <stable+bounces-180812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30F9B8DCCE
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 16:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C055179849
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186FD2D6E4F;
	Sun, 21 Sep 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/AAbJ6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAB34BA28
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758463882; cv=none; b=f7cZHN+PTidCLQ/doyJ72Hj2zULuaMzKqxm2K9aekXNBBJxLtXafCSYnG3x+ZgI/glDBBYsZud+TDNT8Y6r4M0SwV6DryF3ma+PyrrrmugETJHx4infMUE0ZjgBGx84sYPrSfyyVWHIiFRGvDkdlQ8UeRG57tng/V8KzPnqDxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758463882; c=relaxed/simple;
	bh=JDkoCz2YM59IKCvCBqmS8iojQ4+7n4hW6kdn0fp9NxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qv7iFukMAl1MIvOHsHWrfkWhbSxGkpa0Scx/4uvkDLCo3MY36aUvKtWudAUVsDlGYPJReCd7xzgGlluawBen28ctV+WFqEDc5XS8FHBLIK1Gqqzyv45/32BYhkzXws1tdM9rPUvGUICmU/WaqAs1bilD5B2UqKqph9SFRM1h02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/AAbJ6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01EBC4CEF0;
	Sun, 21 Sep 2025 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758463882;
	bh=JDkoCz2YM59IKCvCBqmS8iojQ4+7n4hW6kdn0fp9NxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/AAbJ6YWiJQdbzl8ffgna9O6K/L8ueslsHpVbGSK7wswR8Ja/I9mXTnoMRHsUa7K
	 YLwd60Jn+PGNKovzQhWb8MjuE/MhQi/erd8/enW4kHJKDL+v5FUeUSP1IySQ+4OAH1
	 eQFWbXLkSO185NluB/kJXf1fHPaiJbtG+YxWsYEgl1WAUj9fUl+0BOy/eom5iv7ubg
	 KKC5zkj7GeVDR24t6DtDGckubXytqatuvlOnGaVOqCg0yKxohxt1iEjYe/8Z7ItMn3
	 SxNJOMiysI5535Qzc3ge3mgFtS88WzKYE/pXDlUeF+9Umddgnmv4Pg6MFhggb3lPln
	 8HMZbOkf35HAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Honggyu Kim <honggyu.kim@sk.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/3] samples/damon: change enable parameters to enabled
Date: Sun, 21 Sep 2025 10:11:18 -0400
Message-ID: <20250921141119.2917725-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921141119.2917725-1-sashal@kernel.org>
References: <2025092116-ceramics-stratus-5d18@gregkh>
 <20250921141119.2917725-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Honggyu Kim <honggyu.kim@sk.com>

[ Upstream commit 793020545cea0c9e2a79de6ad5c9746ec4f5bd7e ]

The damon_{lru_sort,reclaim,stat} kernel modules use "enabled" parameter
knobs as follows.

  /sys/module/damon_lru_sort/parameters/enabled
  /sys/module/damon_reclaim/parameters/enabled
  /sys/module/damon_stat/parameters/enabled

However, other sample modules of damon use "enable" parameter knobs so
it'd be better to rename them from "enable" to "enabled" to keep the
consistency with other damon modules.

Before:
  /sys/module/damon_sample_wsse/parameters/enable
  /sys/module/damon_sample_prcl/parameters/enable
  /sys/module/damon_sample_mtier/parameters/enable

After:
  /sys/module/damon_sample_wsse/parameters/enabled
  /sys/module/damon_sample_prcl/parameters/enabled
  /sys/module/damon_sample_mtier/parameters/enabled

There is no functional changes in this patch.

Link: https://lkml.kernel.org/r/20250707024548.1964-1-honggyu.kim@sk.com
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: c62cff40481c ("samples/damon/mtier: avoid starting DAMON before initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/damon/mtier.c | 22 +++++++++++-----------
 samples/damon/prcl.c  | 22 +++++++++++-----------
 samples/damon/wsse.c  | 22 +++++++++++-----------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index ed6bed8b3d4d9..11cbfea1af675 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -27,14 +27,14 @@ module_param(node1_end_addr, ulong, 0600);
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp);
 
-static const struct kernel_param_ops enable_param_ops = {
+static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_sample_mtier_enable_store,
 	.get = param_get_bool,
 };
 
-static bool enable __read_mostly;
-module_param_cb(enable, &enable_param_ops, &enable, 0600);
-MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");
+static bool enabled __read_mostly;
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_MTIER");
 
 static struct damon_ctx *ctxs[2];
 
@@ -156,20 +156,20 @@ static bool init_called;
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool enabled = enable;
+	bool is_enabled = enabled;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (enable == enabled)
+	if (enabled == is_enabled)
 		return 0;
 
-	if (enable) {
+	if (enabled) {
 		err = damon_sample_mtier_start();
 		if (err)
-			enable = false;
+			enabled = false;
 		return err;
 	}
 	damon_sample_mtier_stop();
@@ -181,10 +181,10 @@ static int __init damon_sample_mtier_init(void)
 	int err = 0;
 
 	init_called = true;
-	if (enable) {
+	if (enabled) {
 		err = damon_sample_mtier_start();
 		if (err)
-			enable = false;
+			enabled = false;
 	}
 	return 0;
 }
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index a9d7629d70f0a..223f13a5a4ad4 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -17,14 +17,14 @@ module_param(target_pid, int, 0600);
 static int damon_sample_prcl_enable_store(
 		const char *val, const struct kernel_param *kp);
 
-static const struct kernel_param_ops enable_param_ops = {
+static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_sample_prcl_enable_store,
 	.get = param_get_bool,
 };
 
-static bool enable __read_mostly;
-module_param_cb(enable, &enable_param_ops, &enable, 0600);
-MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_WSSE");
+static bool enabled __read_mostly;
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_PRCL");
 
 static struct damon_ctx *ctx;
 static struct pid *target_pidp;
@@ -114,20 +114,20 @@ static bool init_called;
 static int damon_sample_prcl_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool enabled = enable;
+	bool is_enabled = enabled;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (enable == enabled)
+	if (enabled == is_enabled)
 		return 0;
 
-	if (enable) {
+	if (enabled) {
 		err = damon_sample_prcl_start();
 		if (err)
-			enable = false;
+			enabled = false;
 		return err;
 	}
 	damon_sample_prcl_stop();
@@ -139,10 +139,10 @@ static int __init damon_sample_prcl_init(void)
 	int err = 0;
 
 	init_called = true;
-	if (enable) {
+	if (enabled) {
 		err = damon_sample_prcl_start();
 		if (err)
-			enable = false;
+			enabled = false;
 	}
 	return 0;
 }
diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index e941958b10324..d50730ee65a7e 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -18,14 +18,14 @@ module_param(target_pid, int, 0600);
 static int damon_sample_wsse_enable_store(
 		const char *val, const struct kernel_param *kp);
 
-static const struct kernel_param_ops enable_param_ops = {
+static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_sample_wsse_enable_store,
 	.get = param_get_bool,
 };
 
-static bool enable __read_mostly;
-module_param_cb(enable, &enable_param_ops, &enable, 0600);
-MODULE_PARM_DESC(enable, "Enable or disable DAMON_SAMPLE_WSSE");
+static bool enabled __read_mostly;
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_WSSE");
 
 static struct damon_ctx *ctx;
 static struct pid *target_pidp;
@@ -94,20 +94,20 @@ static bool init_called;
 static int damon_sample_wsse_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool enabled = enable;
+	bool is_enabled = enabled;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (enable == enabled)
+	if (enabled == is_enabled)
 		return 0;
 
-	if (enable) {
+	if (enabled) {
 		err = damon_sample_wsse_start();
 		if (err)
-			enable = false;
+			enabled = false;
 		return err;
 	}
 	damon_sample_wsse_stop();
@@ -119,10 +119,10 @@ static int __init damon_sample_wsse_init(void)
 	int err = 0;
 
 	init_called = true;
-	if (enable) {
+	if (enabled) {
 		err = damon_sample_wsse_start();
 		if (err)
-			enable = false;
+			enabled = false;
 	}
 	return err;
 }
-- 
2.51.0


