Return-Path: <stable+bounces-238177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGzPBtfR32kNZQAAu9opvQ
	(envelope-from <stable+bounces-238177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:58:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76030406F0F
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A359A30982B3
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8475A239E9A;
	Wed, 15 Apr 2026 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLFiMUdq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376533264C0
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275843; cv=none; b=Qqr2lAOiY2whwK0o0NTCffAO0Y2k31RQQUcijvaJXG3wfvwPS6qVaLZ3xurfNRL/dCLf06crumw3KsO7z4o8oFmJ2nZUq0vxK2hoJ4nqBRH9QjQcMpbxO+qwkT2MYuVNLLEUX3sER3KT8RbDa5L2ruB1VYqGHSC9ix7jUf3+qQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275843; c=relaxed/simple;
	bh=zYEZtG3CNWlhxk5TCgfhLdH0TQVOB7keHngYJTHByUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLV17hMh/3X5j6mVgivPQjD8zXo/LGdNeTESuvRENES1WnmUn33iY0KNtN4QVyYe42N9IU0up1UK3vsUGCLzEggbn+zAs26edGY9eGTpXozsbvuhQUsx0mygfnN0dWvZHOjUMtgd8EspmyYAAkTv4krev2GxP4LrLS6P6crD53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLFiMUdq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d965648a2so6123149a91.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776275841; x=1776880641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVK8DHikQoX7A6e7OIrQHyMcwBuwukNQmr1sdoA8uRw=;
        b=pLFiMUdqV8fBQUB5pzAs2UxHYVrKEL/zCInz2p3JCZ38E8CrMKoSRqXqSqomSHMQm2
         wkko3qf3kSHcI69KqW8iC6Yafwhc+Cu3sKrcptiF565+uyl/UUrDqwdgOgp0QmUseFpQ
         +HHYmQAUlken7ROoqwxZmZznd3gGatHzVKoj3HOLSkzQC2whEkVPsI3ie7XpPPs2a3kC
         cGf8IuQcXMVRxsePJtMhPOwJOVoC+d+GCk2zvIp9Xw8e0VRnkuyZ5vJ4zf1Iv2xhpYid
         ZVjAExDTu17ZmLU8oN5S6wDiS0gc0gHMVN28xfpVo0eZctd4Tfwmx8HQt5JfbUC3elXO
         JTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776275841; x=1776880641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVK8DHikQoX7A6e7OIrQHyMcwBuwukNQmr1sdoA8uRw=;
        b=R6h/GaecDQQxfmAOoqoSASvwAudIdgoM0kC3LFWnMepoTiwv4hSDE59ZP8GZWKvCdj
         NSJRXJm1cuQrcwxjQcxL/zl+b3Th9k07fhR6G0Jys6OKP+Gf6YdJYg+LNA5VAebA260H
         fmDJTSZUYgvnXlXOI2AWpDFnw1yCmcWvPY8PHaEf3VthGJ21iIEgrPpj222UV4dEEmUL
         qrMuBeRNovnLOWnTZ4N+lS3IsnWS+8wu0fEiXTymGmx77aF3zPkImcvNAu/FwLT6Ar2Q
         nnzmU0Gi2c2RhhG+6GLLvw6A30dUmehpIRHvLI+VgQLs/LLpUVjaLN+hJEaYnvHrpsvB
         mEwg==
X-Forwarded-Encrypted: i=1; AFNElJ+4CaBmS0r/ZWW1ooYlaoOwnTnZhz8jBEaubwpe6ugttkgO3NVVraSgO8Oy72t5vZ/WgxXOJ5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYr7RgCQSZp2XBXypMMtThesf7E5Y/ctHN/189eCH2omn2G7DF
	1cqn0RhYh4tHZwZqiwSUm4QNg1PvJj1g+e1MfH2+MuzW94r8tiRffMl6
X-Gm-Gg: AeBDieuD6f2IzSxfUhXD207fRI0vdx6UiQqYf1JeeLTRL2DHSU3BhAyvMF8+a01LYQr
	H4OB+CY30peVk6xhpMLvlXfQejEnrZpyfGlwtngJcQR9g5nqQrrRqlIwqUns3o4P4iREJWCypSs
	JGjPkbwOBMBumht+FI9zqx4DuDx3WTOJm94WuxskoWV68A5h4G0A878w52730DvmQqrOZhjehk+
	1+FUmMkoIcrU3V89epazScgjI8o3kueGMsuEiEf/UhScK6rYPxfGGNBFr5fBqUIs6zaKsZYo9E3
	3dDbNNxUKOj9gHds+YFhcP4y1HdjKkMq/i0589zFgP76OyZlp2AiBBrl9JBLteq8xQ5+1QlbsKa
	Lu9Sppgq0knBd1GMy1NregF97TnFB31nMQZZ/oug+uaczZuYI6d8hnl2FGdejAPrSghsTE6JyKk
	v3oHZSzrA/ZHbQjutH4fWgiwuTmiOKZbWjAQcq3u7g103pLTw=
X-Received: by 2002:a17:90b:4b46:b0:35f:b3fe:18e9 with SMTP id 98e67ed59e1d1-35fb3fe1caamr14818307a91.16.1776275841534;
        Wed, 15 Apr 2026 10:57:21 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:48dd:8f21:beaa:cec8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782cf2aesm29261815ad.83.2026.04.15.10.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:57:21 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Thierry Escande <thierry.escande@collabora.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec_lpc: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 01:57:07 +0800
Message-ID: <20260415175707.3640225-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238177-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76030406F0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in cros_ec_lpc_init(), the
embedded struct device in cros_ec_lpc_device has already been
initialized by device_initialize(), but the failure path only reports
the error and unregisters the platform driver without dropping the
device reference for the current platform device:

  cros_ec_lpc_init()
    -> platform_device_register(&cros_ec_lpc_device)
       -> device_initialize(&cros_ec_lpc_device.dev)
       -> setup_pdev_dma_masks(&cros_ec_lpc_device)
       -> platform_device_add(&cros_ec_lpc_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before unregistering the
platform driver.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 5f454bdf63536 ("platform/chrome: cros_ec_lpc: Register the driver if ACPI entry is missing.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
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
2.43.0


