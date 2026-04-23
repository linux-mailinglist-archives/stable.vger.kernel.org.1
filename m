Return-Path: <stable+bounces-240503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ng7BKQq6mnfvgIAu9opvQ
	(envelope-from <stable+bounces-240503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:20:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9676745399C
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A02CD3042D33
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8668431F9B8;
	Thu, 23 Apr 2026 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+wahVun"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4CE319848
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953953; cv=none; b=p6daGh1SQxwlXsiHFhjHus9noJ7SUjpRGt523AM4h0tBOMyNtLwsSwT1nRAcUP0tslUNar4iyl2zTGAeW5LwRgp3zC0jVN8odDmz8nvDaWwGWU19O+bD+mP18lRo39ohaq8JnKHDb1eCVtaI0Sn8LoaWGCq7tngKNAN2wlRSSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953953; c=relaxed/simple;
	bh=kOgs95O6JRaZlEPi/372ZddtgKAq7o8MYF3mwzBuWXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AofU3gyIYFK+2avH+ObdA3UqX72hsRzuT+0rWJnJPMs7BdQCE+3eq4FXtR/O+KvoDwWkwL2fpDhKq3Yvxshq0oJxxho/ar5Y/jiY4gwuQKH3TTeJTxDhkA86BOW4iy83mymr6HtXeCViejYd+95dcHTlD2/gyWGbuE/F698ZhbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b+wahVun; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d03db7f87so4600759f8f.3
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776953950; x=1777558750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1raj2hLcvt/ctJ88E4Z4hbSzBiYLTxybyHDMre6WH2o=;
        b=b+wahVun3/NbLUQRMC8TDjwlN92mMe3AHCS/m89Lo6YbtSOgcd3CL/531WGd8IniF/
         lO9Y+xk+brKJRlbmxYWpKwHuZdzryhzg1Q2/omBiCqLm4oqwg6MQ89dqAJeymn56yb92
         YInsflWhqTvE27YqLPqjra/23LCJ1ksOE4hc/fuFAObVqQfEAoktTMvP+WNhQJWP7Uc9
         8zV18Dql7UqumZT4FevwL747zeYoymQZq/jQl5URBXpULeilfQvP6mCqWMhJlBmyYZgF
         VGHRtXP85/bjjgHsGTWto+Z9Rhs31EdzcJ5d7DrqEFfCKpEp8a6fMf9NL2rEoroGcqVg
         KHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953950; x=1777558750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1raj2hLcvt/ctJ88E4Z4hbSzBiYLTxybyHDMre6WH2o=;
        b=W/MHKUnpjF1/dy+iUqinQfRf/aT5fZxEDE4XJYtBZiolRQvAHubR8eS0COQ7c00Jxr
         PXhpRUKNJKIowxChKWJBkDESVagYqlCalry8lUtjkGvqM4tGuRyYjBp4YlG1fxCODPeA
         jtlhi3d9NL9e3DadYC0GDR19mPed2zI+kSSjF6F0HNT6J4ZiK29CVzAXDYDpPGIsuDjg
         AUgNt6moyjPjoC8rLsemMu+9g4N4LKclnnqSRVxLnf8P9zhoro0Hy8G6uMxvIrTkhc6J
         giShlghk+Src9482Kw8aH5OiVMVIHmcntwkXVyEtULlmmJgdJ+PepV1nejZSW31/wg3p
         6Xzw==
X-Forwarded-Encrypted: i=1; AFNElJ+eEuugWQlcm76PLBDqmMGy/IWtPMyfbuEH6E+pWS56A1pDeYDgtZtsivU6boZL06NZPDB9RC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw1xKwkpg70zReIiuz93+LmC/erqWtc0dea8pbOxMtTSM1pv2j
	OjKPJU18w+kElgKsyZ9BkqiP5wp51FQVn26Ml2m/1GAytk4ie82c0JwUCLJXIOcAj2s=
X-Gm-Gg: AeBDiesiKM8KiCWWlwc81bNIe7rrzs6Yk+vuo5CO9vRVvywaVnVOm9KkC/dH637Y9mU
	5XVPzI8GYdhIm/OvweTlKKfAXaMkQwEhrYetn4Re2RX+yKP5WmyYST5RteF0WkxdgLSo6nHJxmB
	8sKxq6MEcBIw+yYPmDRPaSBhjTeb53Yp1fyKSCfLl3c+M/XPX53mH6Pwc+AOq04adCLDnxY0mAa
	C60AK9oyaK2XU31AR6YPDNxDY0/Qm91z6idlMH6rW20DqwuYeuPPSFelOw8Yr2onugneBwfSGzt
	iawVmCBpzzULE4pwQuRirSVWpg4nzJUcfdGKp9egcLGu91whe8DDJ3dEC79hKclMFmlebT+4Z84
	pvtKYVAX5e9t0eZX+DZ0qw0Sy5qj3KYAZOGDxbHI2VbtAQX+CTR6Fw0AItDuiWV0lImbs9Q8kt4
	vxLUCkcpXFX6Y6eRtwgbQ6/Eo6qtru8Zp+cCdyIw5YBIdfJDCJS+HvwfvzZlZIyVELzz3le9qn3
	Y+JnTJEo2omPEuUxex/taktb2pA
X-Received: by 2002:a5d:5f96:0:b0:43e:a73e:cc8a with SMTP id ffacd0b85a97d-43fe3e0aa94mr41477511f8f.36.1776953949571;
        Thu, 23 Apr 2026 07:19:09 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm51107483f8f.31.2026.04.23.07.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:19:09 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 14:19:07 +0000
Subject: [PATCH 3/4] firmware: samsung: acpm: Fix mailbox channel leak on
 probe error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-fixes-sashiko-reports-v1-3-2217b790925e@linaro.org>
References: <20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org>
In-Reply-To: <20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776953946; l=2175;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=kOgs95O6JRaZlEPi/372ZddtgKAq7o8MYF3mwzBuWXQ=;
 b=18HbsNzGpOO8k/tK09MU8TicbRqu3E9ILnKYrDV1cDHGI48yY+5TskCUogS0Dt6MibK/x9cgh
 gCD6yJNK1UnAM7ibtJDYED7qeoBJ+rZZTFISCeBmJY3R1GFry0GLLhk
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240503-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 9676745399C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko identified the leak at [1].

The ACPM driver allocates hardware mailbox channels using
`mbox_request_channel()` during `acpm_channels_init()`. However, the
driver lacked a `.remove` callback and did not free these channels on
subsequent error paths inside `acpm_probe()`.

Consequently, if a later step in the probe function failed (e.g.,
`platform_device_register_data()` returning an error), the mailbox
channels were permanently leaked. This prevented the driver from ever
successfully re-probing on a transient `-EPROBE_DEFER`.

Fix this by modifying `acpm_free_mbox_chans()` to match the `devres`
action signature and wrapping it with `devm_add_action_or_reset()`.
This hooks the channel cleanup directly into the device's managed
resource lifecycle, ensuring the channels are properly freed on probe
failures or driver unbind.

Cc: stable@vger.kernel.org
Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Closes: https://sashiko.dev/#/patchset/20260420-acpm-tmu-v3-0-3dc8e93f0b26%40linaro.org [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index a9baed5762d5..896fbdc2700e 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -535,8 +535,9 @@ static int acpm_achan_alloc_cmds(struct acpm_chan *achan)
  * acpm_free_mbox_chans() - free mailbox channels.
  * @acpm:	pointer to driver data.
  */
-static void acpm_free_mbox_chans(struct acpm_info *acpm)
+static void acpm_free_mbox_chans(void *data)
 {
+	struct acpm_info *acpm = data;
 	int i;
 
 	for (i = 0; i < acpm->num_chans; i++)
@@ -658,6 +659,10 @@ static int acpm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, acpm_free_mbox_chans, acpm);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add mbox free action.\n");
+
 	acpm_setup_ops(acpm);
 
 	platform_set_drvdata(pdev, acpm);

-- 
2.54.0.545.g6539524ca2-goog


