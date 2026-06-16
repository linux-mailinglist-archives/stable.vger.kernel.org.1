Return-Path: <stable+bounces-264448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jDIoGDR4MWqMkAUAu9opvQ
	(envelope-from <stable+bounces-264448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:22:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A913691FCA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:22:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qSkaisx1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264448-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264448-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B954B30F64A0
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4F44508F2;
	Tue, 16 Jun 2026 16:05:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598F44534B3;
	Tue, 16 Jun 2026 16:05:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625936; cv=none; b=dsQ4X4LCss4KjSMx7AvsTO8d4p/ONq/mz+OCykJ9E5r7X1mgiQP3XKvoJq6Uca3fl17JDT3TJ5J/8w3rdzW4OSejZvybDBEeEsIEjDL5c54f5LHBSEp36xp7d7Wofd5LPrmV9bOnaWoLX6g6XS67kr03bx9C0E/dNmrJ1jopnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625936; c=relaxed/simple;
	bh=UHrXYLQtU5QQDNjsRpctGYYI9+qq7mlksw5nWut+7rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhTAcmh28jAsDBO0g6+LxFLwl8MjLUpDYEjqYFXn15Uwz8YnrmWrFQP8pALBUM3cVYy2kPMwLNp+bW/aRJCIZckiKGDTAxTZThSDXjEsbl1bw1i29b7unEhyITMzI9Qr8HgAZD29ix1iS/nqfm28KOTE9iMKEReomhSIlfVQcGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qSkaisx1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6997D1F000E9;
	Tue, 16 Jun 2026 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625935;
	bh=v8Erml6ATnLfAj5FoIjCS9jdOijWx/6ZRgEKxN9U0h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qSkaisx1vaCHBO0w0cG/WqfUqDCp1jbgaFxs6c2KyGMXihm1fRgbRFLHsu2obm+tj
	 NuwZEzZqaqg8EWBNtDuP+gtME/6p8YMBIE+LTewwolkYAvg1ZRkCEZdpOV0U9yE+Ug
	 vWoaW0u6YFZqQjYTgCivbqy999qJITVAHP4fZqP8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 6.18 235/325] firmware: samsung: acpm: Fix mailbox channel leak on probe error
Date: Tue, 16 Jun 2026 20:30:31 +0530
Message-ID: <20260616145110.134284301@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264448-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:tudor.ambarus@linaro.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linaro.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A913691FCA

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tudor Ambarus <tudor.ambarus@linaro.org>

commit b66829b17f6385cc9ffbcbe2476d532d2e3121ad upstream.

Sashiko identified the leak at [1].

The ACPM driver allocates hardware mailbox channels using
`mbox_request_channel()` during `acpm_channels_init()`. However, the
driver lacked a `.remove` callback and did not free these channels on
subsequent error paths inside `acpm_probe()`.

Additionally, if `acpm_achan_alloc_cmds()` failed during the channel
initialization loop, the function returned immediately, bypassing the
manual cleanup and permanently leaking any channels successfully
requested in previous loop iterations.

Fix this by modifying `acpm_free_mbox_chans()` to match the `devres`
action signature and registering it via `devm_add_action_or_reset()`.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://patch.msgid.link/20260505-acpm-fixes-sashiko-reports-v5-2-43b5ee7f1674@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/samsung/exynos-acpm.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -523,10 +523,11 @@ static int acpm_achan_alloc_cmds(struct
 
 /**
  * acpm_free_mbox_chans() - free mailbox channels.
- * @acpm:	pointer to driver data.
+ * @data:	pointer to driver data.
  */
-static void acpm_free_mbox_chans(struct acpm_info *acpm)
+static void acpm_free_mbox_chans(void *data)
 {
+	struct acpm_info *acpm = data;
 	int i;
 
 	for (i = 0; i < acpm->num_chans; i++)
@@ -554,6 +555,10 @@ static int acpm_channels_init(struct acp
 	if (!acpm->chans)
 		return -ENOMEM;
 
+	ret = devm_add_action_or_reset(dev, acpm_free_mbox_chans, acpm);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add mbox free action.\n");
+
 	chans_shmem = acpm->sram_base + readl(&shmem->chans);
 
 	for (i = 0; i < acpm->num_chans; i++) {
@@ -575,10 +580,8 @@ static int acpm_channels_init(struct acp
 		cl->dev = dev;
 
 		achan->chan = mbox_request_channel(cl, 0);
-		if (IS_ERR(achan->chan)) {
-			acpm_free_mbox_chans(acpm);
+		if (IS_ERR(achan->chan))
 			return PTR_ERR(achan->chan);
-		}
 	}
 
 	return 0;



