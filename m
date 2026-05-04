Return-Path: <stable+bounces-242974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IWXMkBw+GkYuwIAu9opvQ
	(envelope-from <stable+bounces-242974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:09:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFEE4BB730
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4717930156F5
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0635C349AFF;
	Mon,  4 May 2026 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLJYP4Zq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7DF392C34
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889311; cv=none; b=joKHmat88DvRdG9JXD+8bpqqVec/UElzEfJNzgqF9bPSOIhmDx3CYLgrxG2gEmpPSRV8d8psgWB7Lhbl0NUY1jr6hvztBbs/xDdBku/Wq7ED4g5eqXjtlIqj3qI/vpCLqOrJdZkZufs/st4JZRXrr2yVH/zb34t73u8BSkx/1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889311; c=relaxed/simple;
	bh=Cy4wsn1PZK5S/bvm2NwxmGupgmnGnk0WNR3lAlPVFs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGilNQ2PuzI85MrZqcMLKe8XbMUHugFPVS5MYQvOWRPcEvoAbQulPHqmQBae+1p8H0PQN0EOvjxdEY95z/GPq2JgVOE3cl5nBAN/yszMaLeJE8s2fH7jd6ON0ujq7cAPlQfbvLZa5Hzuf39UfC8sVjyI25Gt7w8u4kVdCnVG15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLJYP4Zq; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a2b636b944so4006820e87.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889306; x=1778494106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NFXtpfnoiIuj26mCFxMjJStgQUFP3eBujw2rICs2aY=;
        b=WLJYP4ZqvC5hk3o4Q7PjOKeFh3hp3fGHUCvF974zoff3w0psrcNyfCRQqt5gpvCRzt
         RpI6s1gxBCr6OJuus/QfvcEaTYUuu0gIvMmd6aJIKgPWPZ9WAb16V8jT2xxCD283RP/X
         zdK8FQcUAOY570+ZYqCYC8/ACpmIEl8M4EL4b16WC8z4Zgtagjx8ueHNtObOvxVHVcXX
         Lzo0cx1yM8CsASdhWGi4+9X7mhrPcmaft1O09eXeHFm6vhxw702ezdUlXOmhljJuG6LY
         3ZojJLonk/LewKtydGTequoHoBH+RG53BL4EU4ohPcrZHhu5fs+mfSwuaQWfVQshZKP7
         gw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889306; x=1778494106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/NFXtpfnoiIuj26mCFxMjJStgQUFP3eBujw2rICs2aY=;
        b=fc27zR51ZMJ7gKo21R8MQJd4tOyLh+AFfBJlfGfEO1086CSYTNLJaOcfdzHWPwezDj
         haDHx6lD8ntuPcBFCkL+i4G6H0MgeX+PQkZB/0tTGGDNaixWN/s9A2tLZx8Omz/eVmwo
         hpIt83ozZQfP7a32iwUeVfRIvDgBO1Yp8fYyGculBpRfy82tUen3Q/1cweSD/f9GgPGJ
         RDUo1wd2uabIwOig+XalWkfHOl/hfFl/nZqBCBfOYWpPXlce/hgKKuCnGL3u7PLYwXLS
         2/vdnznfs2Ah5SG9Me8HVDJCqAwb69OWmJ7qIZtAkOYbxg+hVUBqEIWxbMNIyCEpuhIG
         8zPw==
X-Gm-Message-State: AOJu0YzY8g3pNnbNtkrMJQYRAejHbkIjcLjJdc/pVPoOdVRNfdAUkARw
	iczBOobjcg0vZ1opyUSxgKOTdM+DcI4L8j3THaJpT2dM1mnBRLKyLhS0W0MpkM/QFWJYLS9FG4A
	=
X-Gm-Gg: AeBDieviVAV0R82+8mD9/ZTxV4TwD1VCjzRCC/fukpsYaCNTlW1sme9jAubr1PZfDL8
	eHUPv8nmwqRrt6o8b5TnDDztEDd1Zpr6Hn4fgGa5OJoDWkBvBFA6Z/NmZebw4u8eQnf6jWzZ5lb
	yKva3b6AqOWyTjPyTuCfBqwkk2zffNXFKO4enCOY0XLQuMUVyp2kFuFXSVvWAEQgvFHDOxNS+2o
	1qzILvcxcULXcSlChe0vaaNEgIlau+LXEE2wXBA7RyPXIJOIDJvHc0/7xTy5pBtViWwZ1P3lj0J
	VceecLwmGLvsaIvbawPnVh2INZQ9jL6K2eIHflvrj8tpo4/xN+r9KgkPq2N54QMvdS6b1USuj0H
	6oHevTfzwtXRxzcTQ5r63jCSvlRH8ELPwKvjUh72a78O6eSgAK5kl2YGJT+678mGK+dSMb1Mb6j
	2XV2gf9dAAWQ/PDGlVEVs6K9RPiyTFg36oWAGT+Jhq03L6CRdhCzl4ag/0ztsRsaTmYgMUHh8=
X-Received: by 2002:a05:6512:a93:b0:5a7:49e7:6e49 with SMTP id 2adb3069b0e04-5a862ec0f59mr2626251e87.6.1777889305426;
        Mon, 04 May 2026 03:08:25 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c33c2ecsm2856217e87.42.2026.05.04.03.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:08:25 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: vebohr@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 2/5] platform/chrome: cros_ec_lpc: fix reference leak on failed device registration
Date: Mon,  4 May 2026 13:08:17 +0300
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
X-Rspamd-Queue-Id: 5EFEE4BB730
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
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-242974-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
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


