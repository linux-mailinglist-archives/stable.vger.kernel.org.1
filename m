Return-Path: <stable+bounces-235739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDTjLg5w2mk02ggAu9opvQ
	(envelope-from <stable+bounces-235739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:00:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 204723E0BDE
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4867E3032F62
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2C33A9DB6;
	Sat, 11 Apr 2026 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdx8Dk7f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B223A8735
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775923192; cv=none; b=h9sj5KeAq6MVKmIBb7iBKdp4sksj7k2tbreLjP6+8lgSgM2PKhjYtniXg5ukOxsmYFZks4UtSTaz71/xO9evVRebIbi+BSAeDEAQasX7tN8L4YVBZr6XRSPZlXya/Zyik8SRCoqlBUi4QXoTw/+4QDDgu3wJebJ2UaTmuDRBzx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775923192; c=relaxed/simple;
	bh=2KuqzLq2TTMM7/M26PrKOuxml9mVo/X+sBMTMo+n/ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OarzVgkzb7BLhZvX19Jpotuji2vLCItibzcSnCbdUzLwFQCUa1cyATpbovVqg0Ref5KPnLSxzQ2SGvVJeXzdAEGi7XQWuSPy/WQHAce/Y32BN3ZAahUqaNxVN+DXMI6PHaujgJy04l4dBiqXiOnldbiTKZz0IRW2Ft5PEtqHRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdx8Dk7f; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f1f6103afso289830b3a.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775923189; x=1776527989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/oUmcpWT9pX8ZG0MeVbZtVLCnJJW8fXpeclOgK9M9OY=;
        b=kdx8Dk7fwqM70jy7Z2Io+uCnYeCL1MlyxqePS7ftruugosq5YDD3O1ItCX4XtfiV3S
         XRyyLTe+scGaOrNhKNCqDlDGpuXetwulzDGFjC6ul6epesDz2VlMb553MPQPdQ/CFVGz
         pR4x+oDo6s7FnIRgQa/CJFSmgJUtTAG3bD9F86SR62Xi+NAOCCXj5r0PMIhguNOkwcjG
         bmKuncLs4cZlfHbRIvmtU1wNkp7TIBkdj0MFYRMdxAT9Ulb7ZZfcsdC5vZIl1MRRuonb
         ACXnHCznnqK9+x4eVx1nhhp8Zoih4acUQdZY4Zb9TSWHWxVz8zCQm4j8TX1R13TGAf8s
         1TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775923189; x=1776527989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oUmcpWT9pX8ZG0MeVbZtVLCnJJW8fXpeclOgK9M9OY=;
        b=EbeRaUKxqtmqBNniwjA+gYloaY3BGlWeTRX5o56l3swWvo3DsCjeCy7lxUX9fLsGkw
         l+2QfWfXGZS1GsUkoFa8KehpJUZm/xd7fNQDKMDqPFNux0DEvbttOqZ1tRCkLw4nqvWA
         if2+TO+UyY6xKgd2oiqDyZ3cjvLAw8FJ6ZMeatTIfVGwHkp1krYEAfwM9dQKySjypsur
         lyZu9Xq9xI1JmsztCgJblmibZaSMtOAb8g4tyALsGDy6fpZlBHx/+ag6HI5EMl44Pky1
         q+2O8HY5mjnObeIRSyU80nJ9NxmTjDfx5kXr1MTYz/9mECPdQ8EtFEI2kIfHprH9xJ4d
         tRWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV94JIh1pjS4SHgD1+OYDiPyb1P3OxsPJtRYWer9zk86nSarJm6Le51aBb1H9Eqx/KmQLJXbc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//GmLlMpq734yX9tTSMfMRd8AZkn1kch9fdsfG5G9FcUDufHN
	r28vg411B58iY0HnhIWOEr9+o1FD3PYY3BpoV7d2HKzCEzJfYcH0Tn9d
X-Gm-Gg: AeBDiesWDhUSJLQ4fFA1iCScYRb1IpRfFmsykexmfeC+Ni1ZhomGldf/wLuxzrYTXma
	1+s2EkoGHK7OZUcIUAT62J34oNti40NXH1IYQYYJv4uoEdnXnkc18gCsDigh+vko2hY0YMBbpEd
	MNirzCYJ6fiMTc78p/LQnIn2kVaw9sZIt7ILrLnTX/fikDLF6tRgW9l0bwOT3CCK2c4cVL4dk3G
	uE4dVMDazuNo+HOT6wN4dUxpO08Md7roHjScFhdYitjNeCe0YHIkCjyGB4b2KKVCZ/7sTGG0wSE
	Vdnu2T0Stg2cJ6n+H3OoQIVY0+ufTUlgsSJ+N5JpohVbQyUfMR4PGvzmR+PL/zf4qs19ltUdEmy
	RrCQmsW92L416i4wED9KIVJp073Alc25rjxt2cm2iGV2ZXRK/oGwks6B/ne/nUuZDP90Gf+ZNph
	Vl4NzdG/eDZXt4xQ==
X-Received: by 2002:a05:6a00:3987:b0:82c:249d:d84f with SMTP id d2e1a72fcca58-82f0c38a1demr8020722b3a.37.1775923189476;
        Sat, 11 Apr 2026 08:59:49 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4df7f5sm8009079b3a.43.2026.04.11.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:59:49 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: Fix refcount leak in channel register error path
Date: Sat, 11 Apr 2026 23:59:38 +0800
Message-ID: <20260411155938.2350613-1-lgs201920130244@gmail.com>
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235739-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
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
X-Rspamd-Queue-Id: 204723E0BDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_register(), the lifetime of the embedded struct device is
expected to be managed through the device core reference counting.

In __dma_async_device_channel_register(), if device_register() fails,
the error path frees chan->dev directly instead of releasing the device
reference with put_device(). This bypasses the normal device lifetime
rules and may leave the reference count of the embedded struct device
unbalanced, resulting in a refcount leak and potentially leading to a
use-after-free.

Fix this by using put_device() in the device_register() failure path and
let chan_dev_release() handle the final cleanup.

Fixes: d2fb0a043838 ("dmaengine: break out channel registration")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/dmaengine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330b..6bb1212ae0e1 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1111,8 +1111,12 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 
  err_out_ida:
 	ida_free(&device->chan_ida, chan->chan_id);
+	put_device(&chan->dev->device);
+	chan->dev = NULL;
+	goto err_free_local;
  err_free_dev:
 	kfree(chan->dev);
+	chan->dev = NULL;
  err_free_local:
 	free_percpu(chan->local);
 	chan->local = NULL;
-- 
2.43.0


