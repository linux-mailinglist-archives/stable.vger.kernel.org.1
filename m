Return-Path: <stable+bounces-243196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGFhDmKn+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:04:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B92D4BE70B
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFB15302F419
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F06E3A3822;
	Mon,  4 May 2026 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gdywuf1A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128683A7F4C;
	Mon,  4 May 2026 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903263; cv=none; b=TzDS+aL6ySqdins/4IKmQ9pWAF/oZI7Yc+7UaQGoZwUoV76hvc3X9Rqr4tBGAp0MgZxS50KcHz7iSTCmAWC/tjWh0iCk/aM/ubjPn4u0sT76fmdiXKziudf28B2VTgAHR14GpiWrd1zSalQQxCtuC76aCDIIsXKAzxiEMReMEEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903263; c=relaxed/simple;
	bh=L56oYbOPXq2C3PD4RdH3aZDQ5q2DQ8IJG9Gdgt7f2SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEYaFNdFRXxFeDxHdl07QbDRgOrJnREx+i9NKwh4TOl2YT200Pr6lgSZrSlWKylX2cxxqI6ldPqFDd+YFBQQ+GQLM5ffhHs+mv9nqSvni/pLbHgNRod24RpUXNq0sqMRLAq4FlBzPgo/T6E1pbFTvJ4OXWa5BrsL+mJanAUlYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gdywuf1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D93C2BCB8;
	Mon,  4 May 2026 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903262;
	bh=L56oYbOPXq2C3PD4RdH3aZDQ5q2DQ8IJG9Gdgt7f2SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdywuf1AUabYZ7fyOAT7h91R52yiLYImOVACOblDA+0bAdxWOikVIw5REJ5LL9md/
	 DN4qyv61EQTBVXMesUpHHq/pGfecPZcGg6iPbIP3JaQMOQbiuBgkcfl/FIpwBslG4v
	 qhg/pFMEE61TdU3NEdIIcQ0FO+yLXQQ1KRVBw4cs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 7.0 165/307] hwmon: (powerz) Avoid cacheline sharing for DMA buffer
Date: Mon,  4 May 2026 15:50:50 +0200
Message-ID: <20260504135149.071218060@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B92D4BE70B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243196-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:email,weissschuh.net:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

commit 3023c050af3600bf451153335dea5e073c9a3088 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/powerz.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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



