Return-Path: <stable+bounces-238141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBNIEMKl32miXAAAu9opvQ
	(envelope-from <stable+bounces-238141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:50:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8CB40585A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D0FC30A6199
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143343D349E;
	Wed, 15 Apr 2026 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdRBwrLQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21A346AFB
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264410; cv=none; b=Cq+aZZocSNbuzdRiUNn7Olizg2LNbDsotdaHm+8fTsk2vy+FYkycOsRusL1HH773YBOi7a5wLHik04zjxacsgAfNNSWJL/xPxiM6VFujtxiaW32VRRTioWV7XOUJkQMmDpehrJRk2PD8nh3qbSWZFb6gvQThiMjno+Tt0HMBZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264410; c=relaxed/simple;
	bh=m5uBtB5w2V3z3lf06S5GGwOx4WottXt9NNdAXqDjePg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InfwHQweXBI91yUR57Md5VOcpA1DmMQR4NTB8d/5sw/GruXtcGHCnUGuEY72NHfmLtRDgZcXQlRSKkr5jJnAuX3RkhJfwyaW6QzidCvAPPTvZBTDRvx9lJ52TgHzJcfMcwg4j5kzBU4d5OCFrrvo0FFduE33jMf00LBI/7Vsayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdRBwrLQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35691a231a7so4412833a91.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264409; x=1776869209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znxX/LCQa33kO599nbk2Q/Mw7o66DJJuY9IEDvMYWxM=;
        b=jdRBwrLQSWBQ44CYFYi88TTo2u7PyIQMI71O7MdeBIUpmROJput4LPlL4X4ctp2TFk
         /1c+wIlivUILjd9XOGpZf7brnlxJhdCKx37RAIysZ+5dO1Bneb71kJcOx4rMjRSKDJ8m
         anuz1EhL/2wSa53OCrJEBz/E8uudmNoFdyELlPLVWDRbaqnk6lsrtSOVoFgkdqeP9H/L
         vAhGUohhEe4qUkMBNwuw1ZXdoO8LwCq5kW/CpGAvttUMwsUaJHSEoVb9wwCuH/kcpukH
         mlQMTEgjEVpGUKdv7VhVrygPM2usgiHBSkHHbtMlQGgV2QCHC23uH08VI8U7J+vDOLCm
         29jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264409; x=1776869209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znxX/LCQa33kO599nbk2Q/Mw7o66DJJuY9IEDvMYWxM=;
        b=U7yqZRbsTkMS5163NPh/W9GAmH8nEMfFNhFVIhpak76XIGGXS8fjFVF1+Xz3omxnb2
         KWYyfpJdRguHD2mClY1hNrd3P+HEu2WSmm88zDYSHOG/c+FOM+kMOyMi8Cg0A9SqcnMK
         VFWq0eV1uAFtLES5EoUVtYFO8Tc/ruG6YhcnrpvMjuzjfSoX0bzXT85cCyVAFywDHqXx
         Ji5ABRGhRq8FVn5a9hWc00a9pbuLo5/ziDbRoBKOlm1fXUKXbm1Pi0YsfcBuuG5YYJ8i
         slSqXW/jpAt76LcPiAVStnS6K5QT2+hJfquIA/sieTw1upx/TK9d/l0P/Jj/Z5jQyExu
         ideg==
X-Gm-Message-State: AOJu0YwiRFK+WObuGtPic0OZqPZscAK16Qc7kWgyBSz8PkyOpGr4P6ci
	Bt2ljJ3ABO8IaVeqXhsnJwEanYYpJA8/2ii7/BTQkcz3gTUrn1icNJ+W
X-Gm-Gg: AeBDietmOMkFn8Bm/fLYfXjxxonCkUTEuwa1DI6OPS5aMWpRC+m8D/xbG0RMvSoAiSY
	DOpC5NpHrzH7tfWI2wNPKwH84iZ9w134BUY/rUzvyhd8toNVz2qdFYuEJfsE/MLFEnCainLr5xX
	8qTNoi68b6LARy5ppiPXdoHL/6JH93GP8rPooALpRs1FVG54Sv/QoJBvoMrsWL5SwQplR0dmoP2
	yyNz45s4/63KUBI/fvfK5KRY2EPaBCpx7/cL9T4xIn4JOvQlkrh0/F/ad3DC84+k6oXmUxzmhGx
	MCIA2AEtyH1L1auhH3HSDkNtFlXDBDQ+GF5sz/pJLA16zO+T2AGKsExcZzWcQN5rpsJoZuPbLxs
	Awjr42LXD6wByi1keeZ0yD7eNv1Omxz26Rr66LF0T9kSeIxA+m7yLoXTtsm1LJKzHoRUeelBCI2
	jSgU4P7y3wwvuincupNbcfizWcbOxfkI5l
X-Received: by 2002:a17:90b:4a04:b0:35b:e550:e68a with SMTP id 98e67ed59e1d1-35e4254fb13mr21922246a91.3.1776264409084;
        Wed, 15 Apr 2026 07:46:49 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd308cf98sm2310617a91.7.2026.04.15.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:46:47 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] macintosh: windfarm_core: fix reference leak on failed device registration
Date: Wed, 15 Apr 2026 22:46:35 +0800
Message-ID: <20260415144635.3318697-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238141-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ozlabs.org,kernel.crashing.org,lists.ozlabs.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A8CB40585A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in windfarm_core_init(), the
embedded struct device in wf_platform_device has already been
initialized by device_initialize(), but the failure path does not drop
the device reference for the current platform device:

  windfarm_core_init()
    platform_device_register(&wf_platform_device)
      device_initialize(&wf_platform_device.dev)
      setup_pdev_dma_masks(&wf_platform_device)
      return platform_device_add(&wf_platform_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by checking the return value and calling platform_device_put().

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 75722d3992f57 ("[PATCH] ppc64: Thermal control for SMU based machines")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/macintosh/windfarm_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index 5307b1e34261..4003e72f3a57 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -436,9 +436,14 @@ EXPORT_SYMBOL_GPL(wf_clear_overtemp);
 
 static int __init windfarm_core_init(void)
 {
+	int err;
+
 	DBG("wf: core loaded\n");
 
-	platform_device_register(&wf_platform_device);
+	err = platform_device_register(&wf_platform_device);
+	if (err)
+		platform_device_put(&wf_platform_device);
+
 	return 0;
 }
 
-- 
2.43.0


