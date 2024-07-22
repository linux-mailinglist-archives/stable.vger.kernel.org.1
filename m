Return-Path: <stable+bounces-60657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FCC938A92
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 09:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751702811A2
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 07:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA991607BF;
	Mon, 22 Jul 2024 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WT4JN75y"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0E1B810
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635187; cv=none; b=BBYGW8Nk3a+3oLJUxQVGuTCjz6o3SNC988M+wt3mQ8ZrA0gZJeUQTFLGj3bHjgPGrBK8M/6QIKVYNNN19Jkk0BvKdhalaGwit/eYqXA8ncwCYvIySQ3KggYiC1d6z3E/a4zTZXY0Gt7lcqsGCueIq8Vp905UpZhQCmcJ/iiW5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635187; c=relaxed/simple;
	bh=ih0oOyBdDWMghtImdERLunCZVfcxNuenLxXbTArNr9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dRxEJR9HySvLa8jV14dqeyg6yyoS4D+yKJdxhIen7SbXD5Pj9nb0caXUuXePwI8cBOGp6UoAo++Rmd+YZROJ2dNrLPF5b8wOkO3fgvzGF5XM9SACG77SBPuENRc7EMD58r4AyCbOBOJXpUJqj0vBs+6s+oKiK/duYokoWQIWKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WT4JN75y; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79f18509e76so230033485a.1
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721635185; x=1722239985; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+zgXocDeC2RuEHsaW4tq9GG4rpo6JvrpIHNShAs6hA=;
        b=WT4JN75yJNieUWCjqmdo5T6SRH8BEj+Lt27RcaeiCNqs/8jcfNh7Ry8wW7kZMXbe6Q
         UhKyQNsaXo8amZbCN1RX5lYBsk8syotw9oszlzuh6HEW5r4eKrmBAZWgvX6Y9hCqQMLi
         o/uMgiPE+4jmqWE+5H6BX4GCDudW5lLtM7dUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721635185; x=1722239985;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+zgXocDeC2RuEHsaW4tq9GG4rpo6JvrpIHNShAs6hA=;
        b=Wp8dWAabdMFHGgEpdOgoqqeoFpMvJVm4R0LFNfRFW79BplRd2Z0eUNmmSedq30ZxHh
         k6cvCrv1f4Ad7I8h5hnKjV7r+UFuQppTS0HPJLMdjZ/3ba3l5yRIkceUIf6Rp9w250fS
         iI5eYUH73ijtEwsKoxmO34T0Y2pWvU7c6WjaQPNe9INlxmyN5Hl5A52mStbpjnX62L3q
         XIpnp9o1ydZ39RdTWiB6ai8Wigb/tPDxTUX4/9mVIF4UiAQG6RNJ+lrBIOzLL46re5Px
         J0SgZ7Iq5DeUIm1BeS03uTK+XuSJi7yJS17k3bLTHEgI1xn7K0jZLB/kNvvek0CITNm+
         5K1g==
X-Forwarded-Encrypted: i=1; AJvYcCVFRIC944DNa6BCeXD4G6tuoG75KWOVP6c5lWzwjXVssBc/Ei3bjQqa4HdtorxyOi5PwUuS0Atvmg11XN3G38VPLbssdhHj
X-Gm-Message-State: AOJu0YyTc55NDomUMsiDXeDpH13yAmbl43BRG7i77DTiw/G6m8m9fgPI
	JB7i8FrcGoIeCtkfVW9tUg3OwuNQA95fnxAuK1eGWts9Mbwn2CEd4yFlvIfomw==
X-Google-Smtp-Source: AGHT+IFmamk8Ht9tQ8qCsjD81rce8+5TXekAtDPmDVtE5rgDLYsSbBl0QWQDRWjfadNnJU4XxeB8+g==
X-Received: by 2002:a05:620a:d81:b0:79f:84f:80a8 with SMTP id af79cd13be357-7a1a6538261mr1020910685a.13.1721635185298;
        Mon, 22 Jul 2024 00:59:45 -0700 (PDT)
Received: from denia.c.googlers.com (197.5.86.34.bc.googleusercontent.com. [34.86.5.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19900d93fsm334134985a.65.2024.07.22.00.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 00:59:44 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 22 Jul 2024 07:59:43 +0000
Subject: [PATCH] media: uvcvideo: Fix custom control mapping probing
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-fix-filter-mapping-v1-1-07cc9c6bf4e3@chromium.org>
X-B4-Tracking: v=1; b=H4sIAG8RnmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyMj3bTMCiDOKUkt0s1NLCjIzEvXNbQwMTdPSTazNDCxUAJqLChKBao
 CGxodW1sLAOQQVelkAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 pmenzel@molgen.mpg.de, stable@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Custom control mapping introduced a bug, where the filter function was
applied to every single control.

Fix it so it is only applied to the matching controls.

Reported-by: Paul Menzen <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/linux-media/518cd6b4-68a8-4895-b8fc-97d4dae1ddc4@molgen.mpg.de/T/#t
Cc: stable@vger.kernel.org
Fixes: 8f4362a8d42b ("media: uvcvideo: Allow custom control mapping")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Paul, could you check if this fixes your issue, thanks!
---
 drivers/media/usb/uvc/uvc_ctrl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 0136df5732ba..06fede57bf36 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2680,6 +2680,10 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 	for (i = 0; i < ARRAY_SIZE(uvc_ctrl_mappings); ++i) {
 		const struct uvc_control_mapping *mapping = &uvc_ctrl_mappings[i];
 
+		if (!(uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
+		    ctrl->info.selector == mapping->selector))
+			continue;
+
 		/* Let the device provide a custom mapping. */
 		if (mapping->filter_mapping) {
 			mapping = mapping->filter_mapping(chain, ctrl);
@@ -2687,9 +2691,7 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 				continue;
 		}
 
-		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
-		    ctrl->info.selector == mapping->selector)
-			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
+		__uvc_ctrl_add_mapping(chain, ctrl, mapping);
 	}
 }
 

---
base-commit: 68a72104cbcf38ad16500216e213fa4eb21c4be2
change-id: 20240722-fix-filter-mapping-18477dc69048

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


