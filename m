Return-Path: <stable+bounces-158551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47107AE8374
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950371C25BA9
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 12:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47621261594;
	Wed, 25 Jun 2025 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+Mw7rtr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F667261586
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856149; cv=none; b=FT7eLurSyOtc+132OaNIZRvRo7uBHhVMCTOI23bzTeJBueouN+d9T617+LiRFeFMUgmwPo2I1nVrJcOb9M15I7fl6D6pCEKHnzl2T8M97A86eWP2O/pTtHv6nYaQ9DD0sNh9u1iNMNmaPNKDF2Cq7p7KXfA4g6D9AZcnahdC5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856149; c=relaxed/simple;
	bh=zo2UL484d0AGMYJtxt4hadyRW6GcT7eleqX36vRw48g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfQG9efZagcN6C8Q7ogez3QoFSInmhys097xk8XRD+FwC4phnqZgEpfivrhSoj3whUqLrCHYvTXA8PNB7Gb+InUPeKDSLvZCDXcfvSe3cP6NcSXDzQquPr09heK3+J1KrF2sPZeafzVbf1h7JMFnVuNxNHvB4MEHtARIF2E79vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z+Mw7rtr; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32aabfd3813so56862001fa.3
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750856145; x=1751460945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsei3Eyn3BUK/kZy554Yszykq+16RnUOlPIVPSWrvBM=;
        b=Z+Mw7rtrJJbuSCUgqIa8esbHUdQ8bHheXWIIVWkv2QxkHW78QjF9RsgAsDvPIgOTxn
         1n4K8z65OVbpA363fXLEKVsd9aTPB9kS69XZcTkgR38HvUSRzPBJyIIhqEFxpR++We8w
         rxLZzI2KE4sscmyU44YRjHp0unMbaBxvm5atY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750856145; x=1751460945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsei3Eyn3BUK/kZy554Yszykq+16RnUOlPIVPSWrvBM=;
        b=WUP5VchPLYQcjfTkpuLcmq/SKyDqv9HinYDYn6UaIvkwfKcyD3Z6QdC7zkb6S7ZUVn
         lYyyXE4yPQ6yWsExNNHZ8+o2odv6T0UTLvW6PMQeo3+S6mKR/Pv2SnQAdOGJhM4INafR
         MkDWDK6BPlAERAvUMPbqNQRl1hiuFCjmkpd2nyHHzlmHo7PzKDbJdFqHwOWIwMPSFQ1P
         CSGHXtQfSc2UgloCi6P3Y1pgeF91HZQ9gCyPhjq92yfYxzMOsQQ8+ZqOUsTTd4FPRgho
         c3g0JdoOHcJh16eKrDj5SX0StWJLBypt5FDAHLsLQb35/8DhbrxU/9lkcuoeyTYp8/UF
         NLUw==
X-Gm-Message-State: AOJu0Yw+gHhbjyqwdhWvvgtjOddeCVmOHuHQ2lltUVQ47T7nEfMhSiZu
	7sTPkFXL9uTeKjVTQlGB0x7YtYHuUyzli19lOc+P5PHLIrjtEs1c8tpOoXAkjyjQao4CBx+q7e3
	UCrk=
X-Gm-Gg: ASbGncu1wdEkmyn+GVoRJwA3/rbQWnYp6WF4jz06pgdE5YYgyKeMfqKU77w2Yc9rYKt
	Ns1OI22K8/xDUDZOa5M1YUxuwgU7OK0Ft3cScTCKRrCIqtXHAHo6H/RTEm4kHfrxJPAHRhvecXD
	dgWZ+05/ElTekACenf+AqvuKigo3wQOwXACpig5hlOFLcv3aRT6DNL10pGf37T1kuR3D1ijlByT
	nN0UIzQZi8FhrRiGlPYTM4TxmHUpwZJASLzAnMetaCrsepi5yy7EozymsiveEMCBp+XYa7M/R/1
	8CgzgqUpb0TNQtt+oPWrvdfQH6xbMo8FT5qeuDnVKvAWhZbTvUnn5ysLJfc9qJvsYaksplioDh3
	S7DKTVPcbZy5ncx6+bVus1c4yQJT8AH4eK6AtWq4uONU3P2o=
X-Google-Smtp-Source: AGHT+IG9Dl7EsGZ7zKPZg0BbccZybuPwP33D/AEMX6OgZcJT+UiNxuuUN8LHvNdak+SHDkM8dz7YcQ==
X-Received: by 2002:a2e:9944:0:b0:32a:5e74:5726 with SMTP id 38308e7fff4ca-32cc65823f0mr7085601fa.38.1750856144952;
        Wed, 25 Jun 2025 05:55:44 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ca873a713sm12299411fa.5.2025.06.25.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:55:44 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.15.y 2/3] media: uvcvideo: Send control events for partial succeeds
Date: Wed, 25 Jun 2025 12:55:41 +0000
Message-ID: <20250625125542.587528-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625125542.587528-1-ribalda@chromium.org>
References: <2025062016-duress-pronto-30e6@gregkh>
 <20250625125542.587528-1-ribalda@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today, when we are applying a change to entities A, B. If A succeeds and B
fails the events for A are not sent.

This change changes the code so the events for A are send right after
they happen.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-ID: <20250224-uvc-data-backup-v2-2-de993ed9823b@chromium.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
(cherry picked from commit 5c791467aea6277430da5f089b9b6c2a9d8a4af7)
---
 drivers/media/usb/uvc/uvc_ctrl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index c845df51c3e5..afd9c2d9596c 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1540,7 +1540,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1551,6 +1553,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1786,11 +1791,12 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
 			goto done;
+		} else if (ret > 0 && !rollback) {
+			uvc_ctrl_send_events(handle, entity,
+					     ctrls->controls, ctrls->count);
 		}
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
 	ret = 0;
 done:
 	mutex_unlock(&chain->ctrl_mutex);
-- 
2.50.0.727.gbf7dc18ff4-goog


