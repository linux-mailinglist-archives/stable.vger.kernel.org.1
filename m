Return-Path: <stable+bounces-238156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OSgKKq832mOYQAAu9opvQ
	(envelope-from <stable+bounces-238156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:28:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7FE4065EE
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF12D302F0F1
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24D63CF032;
	Wed, 15 Apr 2026 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0Rddejs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48D33F383
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270402; cv=none; b=eQYnq1aTewL546eIkeoag4ndlPZSqeqziLc6lNYmXo/rITbt3YSvO7bVDx+NcP28p0HKmri2414yh9EHxKGFV/VeuJRgXn/S6pZ7qWUigPdPKHpKDGrW/zXCZFht/Lnbq2kEkdy85xpj8ZnKHjRflmdxBzMyPYbjx3MTa083XmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270402; c=relaxed/simple;
	bh=UnJpWbigtRXI8ZYTspGvdjU6LR1rMd0ZayI/7mYqFpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NiGjF88QFz5xNw2N+FurtTUewEYCmL8KoZftOw7B+41zd+XiDbhg+M+bofrWBWJ4xrPVV63HVgJbEarsuTGay2y8ZYaRyOlQGkc/Ci+X69fGdWfXw+C4ESXdgMqTRkVPaQ137DrmTuBP4Hsu7yg5RcOfwBFln83Q2Qp+dVjYVEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0Rddejs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad21f437eeso41733895ad.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776270401; x=1776875201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1zpHRVjDzLZNvpaCId8wIvMsrE+6aFCOM0f/Eu3QAc=;
        b=L0RddejsYEe2qLL72eR1pLi+FsQiP05NaDU9uICWVaqD4yO/17pVjb4G5P7sKbpw/F
         Bk72icjOrV8ETseEtK7vOMb8i1ioRSssiiwb/7Qn6x9FsBb7JDt3DkppwwrIyKbV6bp0
         POzJvR4WZ/m6dLWGoZvAe0Qu1V5uieqTJnS615CCYP0uEe1sV8rLO8TCKCx5IgUtX43C
         IprQgVHOadK4UVFj1Y1CTSLVw5NZbyCP9D7cjJ0l9EcunAcEGQ2SODUkk+8gD/yPA2Vx
         xk0EhBp91s2cucyVBc4O5fqDQt5+DKPemygbAF/M9zp9of/Rrj3IQ++zebzuj/87yca0
         jvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776270401; x=1776875201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1zpHRVjDzLZNvpaCId8wIvMsrE+6aFCOM0f/Eu3QAc=;
        b=jq9MHqJjLdfxMo2NgaakcSMZ6iegNPvCAoNZnyl+dNm1FhAKpi1lXoZo2TT8GLKpB8
         L1Uq6EYUkbvRwjuPIPOqLgWw/amKqAtsbHBIfyf7y2IRa8fVT+L/KJrqZCU5xytwo7wL
         k/jq3c50xqiZ/KWOPtAbMxw1sDURPbFleDncOPVVjWJZoETvwdXF2PRLMR3nuN9BLKne
         TwQH/8oUcbJ6HQORr0X127Fl2qaeYd1rudenh3PaFVXDwH0OW+d97P1ZcY9VMcse281+
         0aNn+LQW1vkb3dhaxy04DAIfY1OitC54gQFg50PEORgd4lRoGfxwR+asVbFVgOSXgU5u
         DxYw==
X-Forwarded-Encrypted: i=1; AFNElJ8nfjxHoaVe2KNWS6RFm8T0St159c2H8ATqFFoNLSKLSix0pfEFdcV0urgBiNabL/HgiWGhaak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgrh4I0hXs4IRhnuzcvBd9BCXSLlbp/Qg4zPyRVR3HYGtvxmUi
	6CRzv0zPldXrMvoCDjXp2ThR38XmUI27xM/mDoaWZMMok0XwN/soaKyA
X-Gm-Gg: AeBDievNNHI/Yd8VHth4I1H0Tu+XPSn4w4v8Us/GZWeIjDXaO5jiBE9EUCGXuDmijom
	sJmjx7WS76XEQLx5aqIQMVJE/7Ex326DeDZrbmNLzMBooPiTwmsRAi6jPeLVSmuMlaNMu+zvF3E
	A/2OJ2OcciPw3ZHaiT5qCC+KmzFluK41Pfd7KIfc268B3xzgxrjdQBSMbqr3lT69yNMkFWBzoZx
	YqFvOxZuEJbIr3X8tflRMWk67oIQ20+4nMfb3VkuK+rupcsfjpeKcGM2MZkJ5CuB26XU7lUMA5f
	QhcIE3ntBKd7XAQ0sqO3ynM2rYBXimnxvN1/qAT3Hp4O2Wqp3dInl18iBEOJ1qAmafK7TrEjHn7
	m0rG3EWdv5h37fOtPmVa6i32MLDw61/a2g7bXGuHJB7X23S2mj0atd0DFkCxaBt9cNJz4xmqmpG
	2f7O8Lp+kZM58N793UtSr342VAM53jHCVAabBI
X-Received: by 2002:a17:903:3204:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b5eaae1d27mr1422085ad.16.1776270400484;
        Wed, 15 Apr 2026 09:26:40 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:3836:7c38:e5c1:4b6b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782b1174sm32878115ad.70.2026.04.15.09.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:26:40 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Vincent Sanders <vince@arm.linux.org.uk>,
	Ben Dooks <ben@fluff.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: sm501: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 00:26:27 +0800
Message-ID: <20260415162627.3558789-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238156-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A7FE4065EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in sm501_register_device(), the
embedded struct device in pdev has already been initialized by
device_initialize(), but the failure path only reports the error and
returns without dropping the device reference for the current platform
device:

  sm501_register_device()
    -> platform_device_register(pdev)
       -> device_initialize(&pdev->dev)
       -> setup_pdev_dma_masks(pdev)
       -> platform_device_add(pdev)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: b6d6454fdb66f ("[PATCH] mfd: SM501 core driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mfd/sm501.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 0ee6d8940e69..8276456b142f 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -704,9 +704,11 @@ static int sm501_register_device(struct sm501_devdata *sm,
 	if (ret >= 0) {
 		dev_dbg(sm->dev, "registered %s\n", pdev->name);
 		list_add_tail(&smdev->list, &sm->devices);
-	} else
+	} else {
 		dev_err(sm->dev, "error registering %s (%d)\n",
 			pdev->name, ret);
+		platform_device_put(pdev);
+	}
 
 	return ret;
 }
-- 
2.43.0


