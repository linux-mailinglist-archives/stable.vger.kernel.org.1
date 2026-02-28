Return-Path: <stable+bounces-220230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GHMDGk0o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5588F1C5E4B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3305A30D1423
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9E175A8A;
	Sat, 28 Feb 2026 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmuzygYE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED505175A80;
	Sat, 28 Feb 2026 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300135; cv=none; b=DvyPjUO1eY8Hg0CZ9FGuVB78WxCabkUjjyby9haCoj/VS0uEeiF4s0IFhy3dqSDYmYTT0koogMhlrzsfaMgLrCkSejyxNoKnGC/MSI50dafGJdqmFk+J3YFaLSDh7YjFUFdXGAEGjQufGcb/6ayK9viSkNBae9NzGL4omy0BdJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300135; c=relaxed/simple;
	bh=K/186z1y6c+vK5de+7Iw8hyg8iSR5DBLjUV9OQvskRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f88xt9C97gjIamkPLXnty2oy59MJGjJNv7m3Qx222AXxMKvTI6S05a+t+jqvwuZ5TEtO5ojsawipHlzBCtIFfrhlM+CzbIax04fjF4nDl7pwKga6Y3+kA6wk/jDULSjmvhzUjZcQ114Wpj5AaQfr8YDKagtiVt4wHW5Do1LzEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmuzygYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD5BC19425;
	Sat, 28 Feb 2026 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300134;
	bh=K/186z1y6c+vK5de+7Iw8hyg8iSR5DBLjUV9OQvskRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmuzygYEy63shX9nEhF3wNBl0Vw0o3P/pxcNmIAGDDo4uXb80mkXEAxL0rrqMb+z4
	 mcFakPhASnLi6KX2axo4gUT8nOViggG6NJUPtqTqmuHSB08hIfHx3kY9OyeVMcPZqN
	 sr/oJPh9QMNUnS3BOrMYPy1eKJb6pwwA5f26co9i6zN8T66RctPJeBpj/a0tPPesSw
	 A4qV6/Nwgq/xtdhLEzIwamlvv1FynqmGrKbIgqM+K9lzpYeeTtmQYKsL7U415RTx/X
	 FUaf8fS+Z3ycihykwEiEuJlZaVLu9Mvl190zsMvOyHcfMVQ0ionqEQaJoD68CSCJWL
	 qhDI/Bmz0XiNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 152/844] media: omap3isp: isp_video_mbus_to_pix/pix_to_mbus fixes
Date: Sat, 28 Feb 2026 12:21:05 -0500
Message-ID: <20260228173244.1509663-153-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220230-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5588F1C5E4B
X-Rspamd-Action: no action

From: Hans Verkuil <hverkuil+cisco@kernel.org>

[ Upstream commit 44c03802a5191626996ee9db4bac090b164ca340 ]

The isp_video_mbus_to_pix/pix_to_mbus functions did not take
the last empty entry { 0, } of the formats array into account.

As a result, isp_video_mbus_to_pix would accept code 0 and
isp_video_pix_to_mbus would select code 0 if no match was found.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/ti/omap3isp/ispvideo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti/omap3isp/ispvideo.c b/drivers/media/platform/ti/omap3isp/ispvideo.c
index 0e7f0bf2b3463..68e6a24be5614 100644
--- a/drivers/media/platform/ti/omap3isp/ispvideo.c
+++ b/drivers/media/platform/ti/omap3isp/ispvideo.c
@@ -148,12 +148,12 @@ static unsigned int isp_video_mbus_to_pix(const struct isp_video *video,
 	pix->width = mbus->width;
 	pix->height = mbus->height;
 
-	for (i = 0; i < ARRAY_SIZE(formats); ++i) {
+	for (i = 0; i < ARRAY_SIZE(formats) - 1; ++i) {
 		if (formats[i].code == mbus->code)
 			break;
 	}
 
-	if (WARN_ON(i == ARRAY_SIZE(formats)))
+	if (WARN_ON(i == ARRAY_SIZE(formats) - 1))
 		return 0;
 
 	min_bpl = pix->width * formats[i].bpp;
@@ -191,7 +191,7 @@ static void isp_video_pix_to_mbus(const struct v4l2_pix_format *pix,
 	/* Skip the last format in the loop so that it will be selected if no
 	 * match is found.
 	 */
-	for (i = 0; i < ARRAY_SIZE(formats) - 1; ++i) {
+	for (i = 0; i < ARRAY_SIZE(formats) - 2; ++i) {
 		if (formats[i].pixelformat == pix->pixelformat)
 			break;
 	}
-- 
2.51.0


