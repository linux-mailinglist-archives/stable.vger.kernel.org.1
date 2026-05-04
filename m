Return-Path: <stable+bounces-242979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFFTDE9w+GkYuwIAu9opvQ
	(envelope-from <stable+bounces-242979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:09:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A904BB755
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EC6B30166F1
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCFD392C28;
	Mon,  4 May 2026 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/S4OwK/"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FEF38D69D
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889339; cv=none; b=b6pFCvdqD+EeuOuchYuXZXa/bscsk+rXaxsQIEB1PsjhtKIFCalyChT5lVrXPGfX1i4HNJzvPx4Jz7M7dBnV2khB+rVP2hMAeXNYuQP2qEQ1UrUmthsli7g9x1mmJXUYZuDc1uhvDantMNKofYfzy7U/tTVklgC1O/z1OJK7LY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889339; c=relaxed/simple;
	bh=Cy4wsn1PZK5S/bvm2NwxmGupgmnGnk0WNR3lAlPVFs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrYXt82Tape3EmYGNm6MOlcwC7JKSJh1ETE04KJdm05XLSs9Xk9D1iSjh/Wiyvj97mz97aMxLsiXakjBtrg2bkgTXmVqjv4Ek/H/iXKRqislkXDZjr1J4Q8tpjlU77+k3xHo/qdArNix/QUxFN7Wscb+I17b7XuV9dIqLI2LDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/S4OwK/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so4566203e87.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889333; x=1778494133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NFXtpfnoiIuj26mCFxMjJStgQUFP3eBujw2rICs2aY=;
        b=W/S4OwK/mDH9qgFdaX9V/LIcw77jeLCazGPcXBh/NeubLWIl8cTu/IMSRTOj4OvgZo
         UlvzsdbJm4aiRFbTGD/pW3W0VEXYN3393v5Y7gLDAmH/VKNU0uRh4JpdapTX7kTiJ8eX
         qg22rnknZavXlVaZKu06G4BT6b9uRwLG7MjkqCWtPpbhyRaE01A/WLBAGceq33qWFs2K
         UN/huOPySHgLg3bZ7n51fWSWwdYkCfLTb808fl5v8Xfh9F5t+/uGArZ0S0QZsj6h6idH
         psGdctEpG7IeF87SuO7yKdqrh/94GXNBBBVYa7M/IuUWIoXHWkVC3zWtpgL0nDeMAue7
         PNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889333; x=1778494133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/NFXtpfnoiIuj26mCFxMjJStgQUFP3eBujw2rICs2aY=;
        b=cyVR8fYacQHlCFlMkRBpqCJxW+yoLw3ba05WTLJbeCrx5RJ7fdCmKBRtkoreBvOVD0
         l5OWOAn1iKJRDX1SL1WIwy+c/Moz7ldTxkNJPSnbKFz+Ib8eybSyLuv3ZXY/XLbUFYDs
         PBhpup1GfGaKL2fegIr4qf8niZLA8ws560Lqs5UNJxOzUv2Xt2yu432EWGbcYt2qW/8a
         p+vvSvO0BOPp78yCPXPgcRwQuDGN5iqexkWfH3B9q7DOedSWDRkHnIrAZ0AXPUIk/dCk
         7EDSDhnuWT1wwsbvwCVphm3EMr8mxLOawUrJ0S6Qb18jnWLtSTR9g3n2vlm27G8Wy1f4
         vVIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+N/sTXjB7cFLEQwOwwQ+7ssXPRsz7PP0T4B4ypGtZ+el3oXfTYrHkfLM9tmbAB7+x/Pynjr6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6sr0MPGmboZkkoi6bANeaz+3lVzE1zV3B1YKRWWDCC6cRh7j6
	HX86mutctfl71PfwpBhgRvgjPzYTJUr/FYaR+yexEIYJOyiFdomQtnvGAywAvCfvwK1WTVVNEeU
	=
X-Gm-Gg: AeBDiev9bvrXw5VKlJLzstimzpyDi99S6eYzqOTennJdFut/0vEMfmtgcHtJepOUFza
	2HNPgTrYV3/+X95Hc8CJdTHLvVRMbgWmT+uZwXJGNgoWu97D0j4Op+vZ+XaUT8SA4Rhh27YulzB
	fbTIbd4rHTvvSqBmCfu5e6hVqtM4nXP60jkQ4hbHhCkBz2r3daqc7r69xcHNQXfgA4i33s1iz2Z
	C1uY+yvToNICPslKgcto+EW+HfWeq4eD2lC5xSQJGpbqKMfi8oAEAmJKQwJpn6gkE6ebeGR3NzO
	HYob1gFje58iRLbyuOq/+55Tx6Hvg28n+1lm9zQPSIIyIQnnzfn7/VyetURAzKN03ZlQcOA+Bqd
	Lt/MBI2TjgF83LzBVY7AUvX5+GczQkff+iLQufBDXKBaEBTuoZsNa1oQvTy7a4PSHYy09Qjh2ur
	tj+9IY0jCYuHli6Yak6tKiMMcZsTimgN9kiZqRfMtpKcO02YXBcxZR8fjolM4xzjBwwXsS1JT8e
	Y2kqNg50w==
X-Received: by 2002:a05:6512:31cf:b0:5a2:bf50:763d with SMTP id 2adb3069b0e04-5a8631c8222mr3274301e87.38.1777889332874;
        Mon, 04 May 2026 03:08:52 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a86645ae7csm1979099e87.79.2026.05.04.03.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:08:52 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Vastargazing <vebohr@gmail.com>,
	stable@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Thierry Escande <thierry.escande@collabora.com>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH 2/5] platform/chrome: cros_ec_lpc: fix reference leak on failed device registration
Date: Mon,  4 May 2026 13:08:44 +0300
Message-ID: <990a6407ff9b143bde6ea2bd8b32e9346ab756c1.1777889235.git.vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777889235.git.vebohr@gmail.com>
References: <cover.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B2A904BB755
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,chromium.org,kernel.org,collabora.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-242979-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When platform_device_register() fails in cros_ec_lpc_init(), the embedded
struct device has already been initialized by device_initialize() inside
platform_device_register(). The error path unregisters the driver but
returns without dropping the device reference:

  cros_ec_lpc_init()
    -> platform_device_register(&cros_ec_lpc_device)
       -> device_initialize(&cros_ec_lpc_device.dev)   /* kref = 1 */
       -> platform_device_add(&cros_ec_lpc_device)     /* fails */
    <- platform_driver_unregister() called, but kref still 1

Per platform_device_register() kernel-doc:

  NOTE: _Never_ directly free @pdev after calling this function, even if
  it returned an error! Always use platform_device_put() to give up the
  reference initialised in this function instead.

Fix this by calling platform_device_put() before unregistering the driver.

Fixes: 5f454bdf6353 ("platform/chrome: cros_ec_lpc: Register the driver if ACPI entry is missing.")
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
Signed-off-by: Vastargazing <vebohr@gmail.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 78cfff80cdea..cb3ff76d29e9 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -892,6 +892,7 @@ static int __init cros_ec_lpc_init(void)
 		ret = platform_device_register(&cros_ec_lpc_device);
 		if (ret) {
 			pr_err(DRV_NAME ": can't register device: %d\n", ret);
+			platform_device_put(&cros_ec_lpc_device);
 			platform_driver_unregister(&cros_ec_lpc_driver);
 		}
 	}
-- 
2.51.0


