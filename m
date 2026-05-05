Return-Path: <stable+bounces-243986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFKeJkOH+Wmx9QIAu9opvQ
	(envelope-from <stable+bounces-243986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:59:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8F4C70DE
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EE49300DED9
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D563C342A;
	Tue,  5 May 2026 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ju70unOv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9D3A2549
	for <stable@vger.kernel.org>; Tue,  5 May 2026 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960768; cv=none; b=dI6cJMXfD58WZoYmsL64rIyj3cpt5QWSSdDA4MbpHP8PjZWNSmyOpb9wao//4FfdOv34yVLDadHlaie4v86D3Fc+02rexpubv/pyxvz8bRVUb4xEoZvvJ4E0RBGmZLLBgum+JvZpmrmqwZegU63uP4/5oUcf7FgcMoRUN1TPQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960768; c=relaxed/simple;
	bh=Y66UIJF/MVQoFfvaewywhSqz7Wgkk6Cq5XhZI6S6kMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThRBlQTTky8N3U9yE81je9GWUbokT2gDaE8T/27qXzka7Dde5N/UoiTXoYpC/5hJGM5J29ggvgnz2sd0TX6Ez+FHo8C496KpAL810o/zMVytym28vCxO7mVkKEJLOBKSWUTvxs0Szn5Ll3DTV79+Zn90Tc14X6YRJJ/K/HRUGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ju70unOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89234C2BCC7;
	Tue,  5 May 2026 05:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777960768;
	bh=Y66UIJF/MVQoFfvaewywhSqz7Wgkk6Cq5XhZI6S6kMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ju70unOv7EM3Y42d9of/xzGsDUWLyeve5mHD6rk5IUK0pCt/c7z8ufDXIArb12S4+
	 84ffdPXVtyehbjmrRSzH0FZdSD+dVKONxA8JAk/BLB4dF1CSBQMuqlwgu6d8oaFM6M
	 fmufk/EVCrVjBVhCYlTtGz9j4oaB8Z+yc43Qgc19zurjzi0JKwA8BJEbRUXu3kW96G
	 J9WtEyNxrMgWoBgGfnk5NwOy8ow0qKRui5dlipA14Dy+yJVW2OaEgdn0lww8m6XWBV
	 MqKOgTeQixbnZqRd7H3xwH6UN8dH6s9lbuImHmb21Z/pxw8nRscsDnErbVbDRE0s6c
	 S68oV6u9Zkx0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] hwmon: (powerz) Avoid cacheline sharing for DMA buffer
Date: Tue,  5 May 2026 01:59:21 -0400
Message-ID: <20260505055921.224904-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505055921.224904-1-sashal@kernel.org>
References: <2026050156-defendant-fretful-734b@gregkh>
 <20260505055921.224904-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3AC8F4C70DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243986-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,roeck-us.net:email]

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 3023c050af3600bf451153335dea5e073c9a3088 ]

Depending on the architecture the transfer buffer may share a cacheline
with the following mutex. As the buffer may be used for DMA, that is
problematic.

Use the high-level DMA helpers to make sure that cacheline sharing can
not happen.

Also drop the comment, as the helpers are documentation enough.

https://sashiko.dev/#/message/20260408175814.934BFC19421%40smtp.kernel.org

Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")
Cc: stable@vger.kernel.org # ca085faabb42: dma-mapping: add __dma_from_device_group_begin()/end()
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/20260408-powerz-cacheline-alias-v1-1-1254891be0dd@weissschuh.net
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/powerz.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c
index 9e1dfe59aa561..191f952a1bbd5 100644
--- a/drivers/hwmon/powerz.c
+++ b/drivers/hwmon/powerz.c
@@ -6,6 +6,7 @@
 
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -33,7 +34,9 @@ struct powerz_sensor_data {
 } __packed;
 
 struct powerz_priv {
-	char transfer_buffer[64];	/* first member to satisfy DMA alignment */
+	__dma_from_device_group_begin();
+	char transfer_buffer[64];
+	__dma_from_device_group_end();
 	struct mutex mutex;
 	struct completion completion;
 	struct urb *urb;
-- 
2.53.0


