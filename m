Return-Path: <stable+bounces-216778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCv8FuZGlGn0BwIAu9opvQ
	(envelope-from <stable+bounces-216778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:45:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD00E14AF8D
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DB5D30214EC
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 10:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBF5328B64;
	Tue, 17 Feb 2026 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTGHQMvZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B525286A8;
	Tue, 17 Feb 2026 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325152; cv=none; b=i/iwzTrT+MiOQVpZ9MnJxp7/Tpyd9rI6W5iFxaeo9aZ3mFLdKAD89npQnuPMm4G3pGSK6h9n4frWehePpS/7yk+0HLsCCvGNQDs0kHgKZV1c4NVhKn7N0Og/r2RuWMpsISMB7frNyn3U5n/a+yCtsAJIPPHWLJXlljndfgFoHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325152; c=relaxed/simple;
	bh=D/18vX0U8oV3WxSdcGUB2Uskwm50raJDQSM08umXfcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KEF7WvixslTPFd5kNOzCY6yFGrX0I7OVyNWdEJCV/aOMyjiXZxC5nNzDzH5CBr3+apvEdAuraC9/FG9WXf16WypLGBGYSFzuGFHdIMqeXrpCrdNHDphkgEcJRQu0j3ubJomfSOiLc8HbN8nE36y/0CUXxD1luaZ3Ptn0B7EFf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTGHQMvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B876EC4CEF7;
	Tue, 17 Feb 2026 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771325151;
	bh=D/18vX0U8oV3WxSdcGUB2Uskwm50raJDQSM08umXfcc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kTGHQMvZ7nYjmjJ9xtni2hWG9bHYvDJcZqhsn2H9et9gxCEEn3mABvL/d1sot1ysu
	 04ReAiud45YPRaFXlkkxTVktKhBOy80H0syjFckPHX5tVLuvC5ZbHjSfJDxXTgxU2u
	 mfasbrPlTqmwOxuVd/2glE1Cz8JrAko7v+HwxNDKj3WGgdy43lWHHC3bCHI9v33OBK
	 WK9mOecq+bg/bOzEKnEQhnLGOClNWWQg8aoV+cONd81XOqS4dRUQoILaNwoP7NHDr3
	 1XAqk14j2td51tKOhT0YeQMsdUxk/navNrRF9hvQnPYkzkk1KAhHtPkkkX/FVugl+R
	 qoo1fgH2KSokw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5DCE68165;
	Tue, 17 Feb 2026 10:45:51 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Tue, 17 Feb 2026 11:44:50 +0100
Subject: [PATCH v2] iio: imu: inv_icm45600: fix regulator put warning when
 probe fails
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-inv-icm45600-fix-regulator-put-warning-v2-1-08ad62b1dcdb@tdk.com>
X-B4-Tracking: v=1; b=H4sIAKFGlGkC/5WNQQ6CMBBFr0Jm7Zi2tBhdcQ/Dog4VJkohLVQN4
 e5WbuDy/fz/3wrRBXYRLsUKwSWOPPoM6lAA9dZ3DrnNDEqoSihhkH1CpkGbSgi88xuD65annce
 A0zLjywbPvsMTaWP1mTSZEvLZFFwu76Jrk7nnmCef3ZvkL/1bkSRKLKV2JJWRim713D6ONA7Qb
 Nv2BZ3MCovaAAAA
X-Change-ID: 20260205-inv-icm45600-fix-regulator-put-warning-7c45a49c4c53
To: Remi Buisson <remi.buisson@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771325150; l=2123;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=CVZas5UhEJ94/d80MVK7gJ+dz5aI1EgQ40KA9i4M2V8=;
 b=jeJId2zELziyOy/YQSRZ+4mocOQ+U8XsHa9/QQwCipkKVAo67/efHuJPv0/cEdqfJzU/9c9bD
 s4heHxlhsPhDLqK7qzeGG+sibDhVKPk9JSIM1UgLxTnJR3Bc7ZcOgAw
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216778-lists,stable=lfdr.de,jean-baptiste.maneyrol.tdk.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[jean-baptiste.maneyrol@tdk.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD00E14AF8D
X-Rspamd-Action: no action

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When the driver probe fails we encounter a regulator put warning
because vddio regulator is not stopped before release. The issue
comes from pm_runtime not already setup when core probe fails and
the vddio regulator disable callback is called.

Fix the issue by setting pm_runtime active early before vddio
regulator resource cleanup. This requires to cut pm_runtime
set_active and enable in 2 function calls.

Fixes: 7ff021a3faca ("iio: imu: inv_icm45600: add new inv_icm45600 driver")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Rework patch to move pm_runtime set active early.
- Requires to cut pm_runtime set active and enable in 2 functions.
- Link to v1: https://lore.kernel.org/r/20260205-inv-icm45600-fix-regulator-put-warning-v1-1-314ec12512cb@tdk.com
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
index ab1cb7b9dba435a3280e50ab77cd16e903c7816c..811ff80a2e626b4c2bb7b718899abe77488c7745 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
@@ -744,6 +744,11 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
 	 */
 	fsleep(5 * USEC_PER_MSEC);
 
+	/* set pm_runtime active early for disable vddio resource cleanup */
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+
 	ret = inv_icm45600_enable_regulator_vddio(st);
 	if (ret)
 		return ret;
@@ -776,7 +781,7 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
 	if (ret)
 		return ret;
 
-	ret = devm_pm_runtime_set_active_enabled(dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 

---
base-commit: d820183f371d9aa8517a1cd21fe6edacf0f94b7f
change-id: 20260205-inv-icm45600-fix-regulator-put-warning-7c45a49c4c53

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



