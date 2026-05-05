Return-Path: <stable+bounces-243939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h08/KKM2+Wki6wIAu9opvQ
	(envelope-from <stable+bounces-243939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 02:15:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD214C52BF
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 02:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00551301B4D1
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 00:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AE121B192;
	Tue,  5 May 2026 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ4cNqps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4521A434
	for <stable@vger.kernel.org>; Tue,  5 May 2026 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940129; cv=none; b=Dy+GBs/CKhE9MAq3Wyq+M8h+gFHn88KRJq3waX30x/GV9tgbh6lytoxmQ3ZmTLVZTxrzsuGANaeq9LxdaKUb0p7u+Mwc/0EKPNt9I6YLQkoqP/qq8cBKwT7om48Mx9bQwYszl9QEQqFILi2amUv62aMvim2OQZQkPNFYSUD/QFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940129; c=relaxed/simple;
	bh=yWo8jXyvP7/yvKmbPCdk7i+AKwWFJ4tg6caNrW1SA88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3VDaEsB/9GtvEwjaQIuw1HB/WOMqL2QDJkLY4sTo0djdKiI47arGvunLZHkab1Ctu1BSic95uT7wS1eyD7LoiqUmlZv+V2Ff8rSAMqMKJPtsMdEpgf9xAQHAKyu2/K1GxjmRy+9FEwRyTmV4LlRB/gS1aYjHhns8nYedv0QEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ4cNqps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497C9C2BCB9;
	Tue,  5 May 2026 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777940128;
	bh=yWo8jXyvP7/yvKmbPCdk7i+AKwWFJ4tg6caNrW1SA88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJ4cNqpsi7Fe5MkXcv+qBhwC+FNe+C38qMmO7NNxmnB82z/hkYlvHW8oOWAC6qa+x
	 keGpAhjYbXI2Y4GrxkhfbkHTLGcEqyHLYgKQQNx3DLqYqeqaJNzPSXF7BzI+2YtWUx
	 hRCMvrF+217Yc/y2DpTyC9x8fkWtpHY6BnfpQM45yJX4WSfCOyMrkOeUbPiuO7SwFf
	 Nm4BG5V2N/yALHLQPUhFGHBl4r68ENRCXzRLM9xkVJXHOKlLV8vZAYTtwXr8OPIOCp
	 we+VYmaIR1RPATZDn5huimR8BBnYSgx/m6nXKmHd6OyNpojYHPFd29gaaHSOhMwGMI
	 0AbkV0MH8Po2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] hwmon: (powerz) Avoid cacheline sharing for DMA buffer
Date: Mon,  4 May 2026 20:15:22 -0400
Message-ID: <20260505001522.124823-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505001522.124823-1-sashal@kernel.org>
References: <2026050159-extinct-precision-0d22@gregkh>
 <20260505001522.124823-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0FD214C52BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243939-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,weissschuh.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:email]

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
index a75b941bd6e2f..dbe6b7ee16446 100644
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


