Return-Path: <stable+bounces-60684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23732938E7A
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 13:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BA02817F0
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 11:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A1816D336;
	Mon, 22 Jul 2024 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WfTmXDlh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73E316D315
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649153; cv=none; b=KHrcVSy1Z1qpxl9twMf7VOHQP6DlqWG5dFAhYontiT7WMkv6Z7K3TPDeBsmK0UNIBJ/LeflV6a62Pse9dRHhtEQED3UQ8aIVHq2E0b2e338eBzfAnv4Twkvb+eJVL6+hY/b3lESUCCxq+uQySv8WUTwV7FppMPZEwgiMSAqHyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649153; c=relaxed/simple;
	bh=QsXTXPHta5hqnSr3LHCTAZhJ1stEGXqeSCLWBUmyozw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WSxHvmfvHtiWysakMUYbFXljyUtKG7hfWr/zFtF1zXd8SXP2usq50//Wuzw3/yuD8Ipu9KQ6qp5MQcsOwOgV5pzJQYg24WAtGtZ3/TwYC5g9TXafDAuwjV1DR+ixyaZ41doB0GCfGq4TbnDVuc+FfKdqfDJvjJw6+MBcbmky8G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WfTmXDlh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b79b93a4c9so31802776d6.1
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721649150; x=1722253950; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XQYfbL9PFIw2vg4G+G5d59yXENQMiik/7/3n9CbSyT4=;
        b=WfTmXDlhy59TsUQiHTpVUqswyT2yJCoGaRmlr8mBb2dBR/wIKsqavNs8RjBfREUE16
         fJLhIcVrBFOaGg/yLehy4qHXXlFhAT0M87M+4vImdbElj0EyELYNPKjF+WdIZShEoPml
         ZzzbOpJM8MCZxarVyh/HxNl9ykXGs5z8BnwzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721649150; x=1722253950;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQYfbL9PFIw2vg4G+G5d59yXENQMiik/7/3n9CbSyT4=;
        b=E/wGnkWN68KRxjuc+jwTXlh8rtqFN4xnxdJVJHVgwed2Imq9zAmiwd68mc+brFq0eG
         ej0ptejHGHOSMTzNahkKZtji+7hTHeZNAzArXJEw00T5NMR+bgrjOiexalLQe1nIBGZB
         p0S+6pUiLQNKz+wgV4eTci5B9ehm8p3hJzxG920HRAi59v+/OZBFCx0G8/r4hMuLZydS
         9wu4hhJ/ZtP9UmL09AHPTdIKXUfVlgpC6nLRoC9nXT4DIyNXH7bjXABBNaVbGJR+lBIa
         rmmu/6RMyBA1IIww3pYJQgdiI3zQdJbjggOJ8apIKkwMzN01x8n7LwIb8rSfTcG6Rzjo
         oC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEDGutGhx3o6vx/Y5VGjCmg7Vca+hnD4iLVwKC4WJAWXUpvN4t+15eFx4+mm2+y8WpAGHM0fWp+s1NGimqJr3ufRLflzLI
X-Gm-Message-State: AOJu0Yz4qqHYHilJqDu+3q7AyrINuTaiLSbkNs6qBADDS7JfULqIWN1c
	sm0w6JtyY4hWuf5MeV8evl2kN2TJY/sB5aeg/laRWEMgroilUQJaickgXDMj4g==
X-Google-Smtp-Source: AGHT+IHtBu5wz+9EWExK47KziP0oA/oIeohoyQXcWuVyU89lepQlMMboXK68AersAqjxj3D97IA/Gg==
X-Received: by 2002:ad4:5042:0:b0:6b4:f979:1e03 with SMTP id 6a1803df08f44-6b79cd51d63mr238282386d6.25.1721649150341;
        Mon, 22 Jul 2024 04:52:30 -0700 (PDT)
Received: from denia.c.googlers.com (197.5.86.34.bc.googleusercontent.com. [34.86.5.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b96c8fe8d4sm13914726d6.17.2024.07.22.04.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 04:52:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 22 Jul 2024 11:52:26 +0000
Subject: [PATCH v2] media: uvcvideo: Fix custom control mapping probing
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-fix-filter-mapping-v2-1-7ed5bb6c1185@chromium.org>
X-B4-Tracking: v=1; b=H4sIAPlHnmYC/32NTQ6CMBCFr0JmbU1bGwquvIdhgWVoJxHaTJFoC
 He3cgAXb/G9vJ8NMjJhhmu1AeNKmeJcQJ8qcKGfPQoaCoOW2kirtRjpXfRckMXUp0SzF6ox1g6
 ubqVpoBQTY0kdo/eucKC8RP4cH6v6uX/nViWUkNa51tWP0eDl5gLHiV7TObKHbt/3L+Nivqq3A
 AAA
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

The following dmesg errors during probe are now fixed:

usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
usb 1-5: Failed to query (GET_CUR) UVC control 2 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 3 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 6 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 7 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 8 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 9 on unit 2: -75 (exp. 1).
usb 1-5: Failed to query (GET_CUR) UVC control 10 on unit 2: -75 (exp. 1).

Reported-by: Paul Menzen <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/linux-media/518cd6b4-68a8-4895-b8fc-97d4dae1ddc4@molgen.mpg.de/T/#t
Cc: stable@vger.kernel.org
Fixes: 8f4362a8d42b ("media: uvcvideo: Allow custom control mapping")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Paul, could you check if this fixes your issue, thanks!
---
Changes in v2:
- Replace !(A && B) with (!A || !B)
- Add error message to commit message
- Link to v1: https://lore.kernel.org/r/20240722-fix-filter-mapping-v1-1-07cc9c6bf4e3@chromium.org
---
 drivers/media/usb/uvc/uvc_ctrl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 0136df5732ba..4fe26e82e3d1 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2680,6 +2680,10 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 	for (i = 0; i < ARRAY_SIZE(uvc_ctrl_mappings); ++i) {
 		const struct uvc_control_mapping *mapping = &uvc_ctrl_mappings[i];
 
+		if (!uvc_entity_match_guid(ctrl->entity, mapping->entity) ||
+		    ctrl->info.selector != mapping->selector)
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


