Return-Path: <stable+bounces-266585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B6pQGA/RMWraqgUAu9opvQ
	(envelope-from <stable+bounces-266585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 00:41:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F06695A15
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 00:41:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cuWTa8hG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266585-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266585-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4B8831C26D4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 22:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB233E5ED8;
	Tue, 16 Jun 2026 22:39:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA33E5A0B
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 22:39:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649580; cv=none; b=VoATLntjJvPfiGCiE8nR9zVfrJoe3cuV2ZGmVew1zqTY5D+Oud4LZSx491CFwuONZZxYKPausLGbv9CJ+tJRtidYXi98MXzSp0ZbjriMpfK1x7dO8QSnY6bhMKjY78vZX2U5ISrGjfy/jX3wK1dinHnAaLDL6XHCRR/a701p6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649580; c=relaxed/simple;
	bh=/MxLn7SV7yoC6BEhkcclWFZg5jgk2yBkZnR6vzVVgnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiNNszl/djFJH5QAgwSAchtLCtkOJldPNFcgZI+TSZPym22tdHXUYnmLO5TmDlR48IxvPmLgBMDvHSB4tBRAaoFbvRaW4wyASf9lq5EJTeOoVvNptewL+kvIdgpCk9pGsceaqXD1QBwiVL9Sac+JGBDwnsFZVcnp9kpoPICqwVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuWTa8hG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34A01F00A3A;
	Tue, 16 Jun 2026 22:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781649579;
	bh=/L/4z8eYRbBlPSr4SQYNVYGryVs0ypyqL7fGkoNFdKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cuWTa8hGjk07VKqR3Xru618hg8dfb1fQahZCD1lZCi/tFtMw8TcDou4SCkYh1V5eD
	 mz/dGyFKgGbv0kwM4kTpqiDfgO7ohKq+y53lCpvqeWfxZii5uula0LRw/HiCNmPxwq
	 mur8YgHToxH+LgzdIS6yNXZLyp11bzRBFFavL6KQ6TLTMktHpk2USFaL9DLOkJPkNZ
	 knwnKtE69QHvtXkz/nr1/1C+moOj05mZ8dvtsOU9vzhj+tGBT925hNlmX3FZ2Rl+DR
	 ulMnzdqd1mBK2UX2PrWafVLdhmecep2uaE0ymqye8J5FJOVi284bxs/JNSNyrVkMEP
	 Pnpi7g9MIX4bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/3] firmware: exynos-acpm: Count acpm_xfer buffers with __counted_by_ptr
Date: Tue, 16 Jun 2026 18:39:35 -0400
Message-ID: <20260616223936.3557131-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616223936.3557131-1-sashal@kernel.org>
References: <2026061524-schematic-trapeze-18dc@gregkh>
 <20260616223936.3557131-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266585-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:tudor.ambarus@linaro.org,m:krzk@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1F06695A15

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit 951b8eee0581bbf39e7b0464d679eee8cb9da3e0 ]

Use __counted_by_ptr() attribute on the acpm_xfer buffers so UBSAN will
validate runtime that we do not pass over the buffer size, thus making
code safer.

Usage of __counted_by_ptr() (or actually __counted_by()) requires that
counter is initialized before counted array.

Tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260219-firmare-acpm-counted-v2-3-e1f7389237d3@oss.qualcomm.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Stable-dep-of: f133bd4b5daf ("firmware: samsung: acpm: Fix cross-thread RX length corruption")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/samsung/exynos-acpm-dvfs.c | 4 ++--
 drivers/firmware/samsung/exynos-acpm.h      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.c b/drivers/firmware/samsung/exynos-acpm-dvfs.c
index 352a6e64d79ddc..06bdf62dea1f30 100644
--- a/drivers/firmware/samsung/exynos-acpm-dvfs.c
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.c
@@ -25,12 +25,12 @@ static void acpm_dvfs_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
 			       unsigned int acpm_chan_id, bool response)
 {
 	xfer->acpm_chan_id = acpm_chan_id;
-	xfer->txd = cmd;
 	xfer->txcnt = cmdlen;
+	xfer->txd = cmd;
 
 	if (response) {
-		xfer->rxd = cmd;
 		xfer->rxcnt = cmdlen;
+		xfer->rxd = cmd;
 	}
 }
 
diff --git a/drivers/firmware/samsung/exynos-acpm.h b/drivers/firmware/samsung/exynos-acpm.h
index ac634ef9c6780e..5df8354dc96ce6 100644
--- a/drivers/firmware/samsung/exynos-acpm.h
+++ b/drivers/firmware/samsung/exynos-acpm.h
@@ -8,8 +8,8 @@
 #define __EXYNOS_ACPM_H__
 
 struct acpm_xfer {
-	const u32 *txd;
-	u32 *rxd;
+	const u32 *txd __counted_by_ptr(txcnt);
+	u32 *rxd __counted_by_ptr(rxcnt);
 	size_t txcnt;
 	size_t rxcnt;
 	unsigned int acpm_chan_id;
-- 
2.53.0


