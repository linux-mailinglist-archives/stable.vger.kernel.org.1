Return-Path: <stable+bounces-266785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w9i2De2uMmpV3gUAu9opvQ
	(envelope-from <stable+bounces-266785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:27:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E469A87B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:27:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ckv51UJK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266785-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266785-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50895303C3D6
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F9F449ED6;
	Wed, 17 Jun 2026 14:27:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6AF175A8F
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:27:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706463; cv=none; b=nSum31y3LJUCbf/gCbIaKusUBXI/+VwbmNXJaRz1rodYSSnxv25rLijFLavxaTG1b7HWEXfb/r0A0bu2SfUHpmz6/vOQwprUbZEGN+i9oEsp8qCSO9CFJMzNPvFY1iossJnC/c3vL7vQ1cZ9e6Q9tLfewV4VOnGLzVP/vYT5Jw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706463; c=relaxed/simple;
	bh=sYajp3OVdNZZsnGl3NaDrZaoPtc1aNf67ROsYzYrewo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyUFACog11P+WhYB7J8CLaltCP5u/Hkc1xWgoUZi7L93JDN+ZobCYJE38498jwSOgk+mAX1Y9TqFgPr1BxCh5xh1/PRqfLoLfhbLySp12TWkUeHIfYhjPIVP1aRudeNGFzRIk3SOZQdoFL9WQ0N+Jz0GQQy6uCGnoWDekb3hrn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckv51UJK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D5F1F00A3D;
	Wed, 17 Jun 2026 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706462;
	bh=aqAlZFn+J/5HIgHOLmXmUme7OFOIVIQ4qWCb1WRrtos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ckv51UJKJk2sgLcFrM3s6iooqLWMUgX3m4uYeVVhqs2e+NASD5WWKZ/LnSGKdYF50
	 Q+gKUHxx4N8iAKYPqgRIkWfOlOdgMn4W8gV/rqchWXzK9u7nStjNs/MNgLrOMxAq8Y
	 R3ZOy+lWTkjPFsDGbeNS+06YtOnYZq4iY6DDocS/kyTTdy6kfkHYRRK6VBRgB6KEif
	 ARm1OvZr+RtwQDNLcwUE4Dr3Q/frh2flhOMqNhDbeZFZZ4Nl4sp9Xp0kvYKqklOlZf
	 0ZNWct4FORAXeYS3IsKCBSy+Qa+TngGRLRxdHdyIcLoZRxV1xvpVWf6HKKS9Itoxh+
	 2kqum4OjamYwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/5] firmware: exynos-acpm: Count acpm_xfer buffers with __counted_by_ptr
Date: Wed, 17 Jun 2026 10:27:36 -0400
Message-ID: <20260617142739.3938338-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617142739.3938338-1-sashal@kernel.org>
References: <2026061551-lung-clutter-0849@gregkh>
 <20260617142739.3938338-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-266785-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A28E469A87B

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
Stable-dep-of: bf296f83a3dd ("firmware: samsung: acpm: Fix missing LKMM barriers in sequence allocator")
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


