Return-Path: <stable+bounces-266861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tBzMCIbXMmpX6AUAu9opvQ
	(envelope-from <stable+bounces-266861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 19:21:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECB069BA4B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 19:21:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XV7bfpDv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266861-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266861-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D450D30098A0
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 17:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1963235AC28;
	Wed, 17 Jun 2026 17:21:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07B33A6E9
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:21:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716865; cv=none; b=P4CVKbKyTYoB7Mf3uSkI2GxPHSJC+Mfa/f5u3CLukDH1Gr2OPNUJJqJ42KQR/ua6xfax47Fl6blvcd+IK7Wj4d8GLyg8zCMTa/6uWe8X5C6T+RwyjB5Qt2TwJmF4D1meijXThc4iccRl7QsVsRLGVb6wVJakipS8MjqDuUMoQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716865; c=relaxed/simple;
	bh=HVa1h59h8s+V1dm2pFYTw5JrRxaeLzeM2XLyWWrJz9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJbInNppKsB4gJkieODuBkDwvFduB/L2BFuSTfpMzBJZR0GMP7svhSnora5LoLsQTlHIt5dd8pbfrP8DN7c7Vu67VvYJZubEE7lLZdfDvWAX3W0KM29aaG/8IeGdQGV4Jnxn/jgL1SzRBVYpf6zJ818+P5h4UipN4IPWJ6Xtda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV7bfpDv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CC61F00A3D;
	Wed, 17 Jun 2026 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781716862;
	bh=4xZaG/vcr5i+EaU4NsUKacPJYo1qIC/fFGVlL0wiAdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XV7bfpDvYgdhf2ETmXM+EnbROc4BpxOX/9ajBtWK9puUSGr4GabfwBCcoj4zcrBrL
	 1fIzfkmEG2CpdOlLWMQ2HqDx3hY8z+BnJJ82ZAzXyRBnDfBv5wUcyfQgOFeaF+43x5
	 Q+49ou7Y8f4eavOg5RqXlKbWX+ne1Pfd3GdIBWL/xjJqE413oxfjIChNSa2BaM15jz
	 /AuzfWNP023cSLcD+VW/i07+wFzEkiLYnmgqn42zo0B0WVblJ6Vu3fK9feUxiOTiUA
	 +qQ4GRO7f++7JPi2SnLbCfGEnTiMfV3QefNSvtRdydTJl2A74GwkUSFsrK2i8acNZy
	 gZXwkgKGvLylA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/6] firmware: exynos-acpm: Count acpm_xfer buffers with __counted_by_ptr
Date: Wed, 17 Jun 2026 13:20:55 -0400
Message-ID: <20260617172058.253463-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617172058.253463-1-sashal@kernel.org>
References: <2026061553-curly-gigahertz-3ad1@gregkh>
 <20260617172058.253463-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266861-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linaro.org:email,msgid.link:url,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8ECB069BA4B

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
 drivers/firmware/samsung/exynos-acpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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


