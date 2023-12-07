Return-Path: <stable+bounces-4889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23027807DED
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 02:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307B81C2116C
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 01:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2E3110D;
	Thu,  7 Dec 2023 01:32:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8DCD4B
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 17:32:02 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d0481b68ebso830855ad.0
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 17:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701912722; x=1702517522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5gAtdhf3r5uOhJWk/x5Qdd2aBvmdfuVX+ev2hC4WxQ=;
        b=G6xbHh6ptYaG+tFFPFkaGIxOxpPkd/0kfYB32oGgpTkjAuF6x3E4DSFBLIqhS0MAAJ
         RkVotNdJ7TnhlNpqjjEJwQNiE/XrHcT0bCnfFe5F7Ss78Pg3vT0xkrEUlPFGnBNoh46I
         aLBb7J8IpoDkoOh8YBk4lMZmllSDlWpf32ae1Ri6yiq5HMOTVIqgYKfZX+Ukmk8ukRNU
         04a9eVNjw+8tJNU0hkVc609mgzIvzHekPwZ0JW8hYE0L9FZuWe0E41YaK5joU4+i+tqL
         RC4/MJ25zZdGHO5a41jGp+1JbyzEPqkLkvS0zdyifIgLNwSYfVJNC+gYzzq9mgmy3lNK
         j3tg==
X-Gm-Message-State: AOJu0YxKLXU5G3flXZ5N4TpyIwW75qGXJkb8WwboEQtQk64ViPHBqD4S
	Oha0kGmafci77YLqOqAPOO04MTl12wI=
X-Google-Smtp-Source: AGHT+IHoZdmiiQjDPmmlSskQm6epmVZoG2voBbwlD1VBv6fRuIB17p+RV8CLidcaB0Xu7TWx9OdDvA==
X-Received: by 2002:a17:902:ea03:b0:1d0:56b9:3730 with SMTP id s3-20020a170902ea0300b001d056b93730mr3495193plg.5.1701912721804;
        Wed, 06 Dec 2023 17:32:01 -0800 (PST)
Received: from tgsp-ThinkPad-X280.. ([223.148.152.37])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709026b4200b001d07f28461esm89859plt.279.2023.12.06.17.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:32:01 -0800 (PST)
From: xiongxin <xiongxin@kylinos.cn>
To: luriwen@kylinos.cn
Cc: xiongxin <xiongxin@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] irq: Resolve that mask_irq/unmask_irq may not be called in pairs
Date: Thu,  7 Dec 2023 09:31:47 +0800
Message-Id: <20231207013147.10227-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an interrupt controller uses a function such as handle_level_irq()
as an interrupt handler and the controller implements the irq_disable()
callback, the following scenario will appear in the i2c-hid driver in
the sleep scenario:

in the sleep flow, while the user is still triggering the i2c-hid
interrupt, we get the following function call:

  handle_level_irq()
    -> mask_ack_irq()
      -> mask_irq()
				i2c_hid_core_suspend()
				  -> disable_irq()
				    -> __irq_disable()
				      -> irq_state_set_disabled()
				      -> irq_state_set_masked()

  irq_thread_fn()
    -> irq_finalize_oneshot()
      -> if (!desc->threads_oneshot && !irqd_irq_disabled() &&
	     irqd_irq_masked())
      	 	unmask_threaded_irq()
		  -> unmask_irq()

That is, when __irq_disable() is called between mask_irq() and
irq_finalize_oneshot(), the code in irq_finalize_oneshot() will cause
the !irqd_irq_disabled() fails to enter the unmask_irq() branch, which
causes mask_irq/unmask_irq to be called unpaired and the i2c-hid
interrupt to be masked.

Since mask_irq/unmask_irq and irq_disabled() belong to two different
hardware registers or policies, the !irqd_irq_disabled() assertion may
not be used to determine whether unmask_irq() needs to be called.

Cc: stable@vger.kernel.org
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1782f90cd8c6..9160fc9170b3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1120,8 +1120,7 @@ static void irq_finalize_oneshot(struct irq_desc *desc,
 
 	desc->threads_oneshot &= ~action->thread_mask;
 
-	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&
-	    irqd_irq_masked(&desc->irq_data))
+	if (!desc->threads_oneshot && irqd_irq_masked(&desc->irq_data))
 		unmask_threaded_irq(desc);
 
 out_unlock:
-- 
2.34.1


