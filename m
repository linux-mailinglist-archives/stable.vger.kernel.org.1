Return-Path: <stable+bounces-118705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E28A415EA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 08:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052F3174380
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D113B24168E;
	Mon, 24 Feb 2025 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DQvVUuRc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BAF241675
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380644; cv=none; b=O6z2hjrSROKPc1oizITkOegbIcVrQSolgMkB5Nvp2BuQyiKznaYEYK5+qZTu9N95IyIWma+/Mw2lKGtEKUWZM6xt5AVr5jLnTJAgE5kg4Lurc0YpN9kakb63KqTYg+nWfOGNt+dWGh0D9d2w2oRiR7WhXfDvwdiEo4x5oZ5TxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380644; c=relaxed/simple;
	bh=8AyV0e0qRbEmKU/uCI50pjnIFt3/6pXpYJ2kgM0yvh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYf5HHuPkvd5sD2/s59SAhf2jZk94GR5N7bdXPyQUTnp/Fo280uxP2MEzqTr/er9MO/dzplUCXU7AiNteXkwGgPJTjJcDXlUQGfHRH6vzFzxySwvV4cRUgKxSXXWrA4YhNqr4ZV542DFsKI21jp0bbkcP1DS9qjRNI/3umx1ZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DQvVUuRc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0a1c4780bso423519185a.3
        for <stable@vger.kernel.org>; Sun, 23 Feb 2025 23:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740380642; x=1740985442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5q6OzdDXgwAQxAxBQA745WK29nT03MLnpLkJ+gh1wVI=;
        b=DQvVUuRc07ODeb9F6NLOEkVhpDBAPELeUDxv+/BT3zMQuczi/VtdxMCERZa4NWORux
         I2WC3lDXCpx78wv7fLDoffJLGT+xxOta8dX9OR6Fxf6qi5FjYlU+JUIyJKlspy9hoblF
         dWeVt9pkXzmPifK0T1ZLsqAFBXBNAWGHm5m54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380642; x=1740985442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q6OzdDXgwAQxAxBQA745WK29nT03MLnpLkJ+gh1wVI=;
        b=jJJTOf4DTZS1OJwFkgOXgOj5Trrq/wsfRpji5Ax/FBZnoZLE+O1984052j1XHvJe34
         6duqF9RIYAQc5avXhLVTry9BDNrugeqw4kT/3jZbFLIJOQCy76aYelhRczfJymm2Pjfu
         HzL+u1aqrPapSsN8ItUl9dMcZDqJJ39EkeDQk3jiEoGHhLx3FXA2GCZ3Zf2W6sKmYkHh
         UoAgU+c472gqX24wcVhWQWJBH6bQIPjA2KsxKkSPzXnSK751ftjxY3OUE5mxwR2yEV8T
         adtgRIpufoG8tRwVTk94j6WOBYcfNULM5sPxZX7vzXwovup0GP9F7r/qmKamqFPrjKJ0
         DJug==
X-Forwarded-Encrypted: i=1; AJvYcCUALNyRejOLJEd6t6asNNTEojBz6VVe39Ccd3UgPjuDH3ykJ9lf9BAr9oGbc2yIaaE9iPNbdZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrd5dgwepXNlBAtk5VVRxUVO6ZrY4pwHp/L8qJmQGBMJHtliyK
	k5rPh/uhc61soy/880pYRbCnSAWb8MKUuCOK3tZDPenpH3J2iH7BKlOi9cGTvg==
X-Gm-Gg: ASbGncuz98ue8IlxQjHxW00KGL9Qq+Xs+HzwYX82aZP+A3CamQw7Djq//WXggWu9xey
	JL4F3r+5L0IUd+jnQHTmrVSgoWGkWN5HFrJoIo/rHsS3D+PVnmqvJq3CNiCKlBcY1pc2F0DACmS
	eUEpYQ7q6AKR0D+RE0T1K88QeC5rtTGYjud9sVpu5gIxECMh2hcd7yDjdfeov7kcSJvW13sBTDk
	5oU8WPvEnhfgg6E8Me1dLdyBb9jPm9YyB1V8GE8mBBiyEqEFq+UugoO9+af5Lujfk4IdUfg6Rp5
	Rycp3S2YsztldW504icJU023WLKAjAN+wGkdK6oSnJN7cKXXCxI2AAXTtL7PG58ZuMZPxphVEOX
	vEok=
X-Google-Smtp-Source: AGHT+IHgxFsGJ5AGKD2il9LAdTDxMgGFCz1Kjs7fo9qIU1XdeZFdKJmn66/YwmftLgDLOc15f+yjhQ==
X-Received: by 2002:a05:620a:8006:b0:7c0:8175:3651 with SMTP id af79cd13be357-7c0cef5333fmr1704029285a.43.1740380641946;
        Sun, 23 Feb 2025 23:04:01 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm977920485a.47.2025.02.23.23.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:04:00 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 07:03:55 +0000
Subject: [PATCH v2 2/2] media: nuvoton: Fix reference handling of ece_pdev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-nuvoton-v2-2-8faaa606be01@chromium.org>
References: <20250224-nuvoton-v2-0-8faaa606be01@chromium.org>
In-Reply-To: <20250224-nuvoton-v2-0-8faaa606be01@chromium.org>
To: Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

When we obtain a reference to of a platform_device, we need to release
it via put_device.

Found by cocci:
./platform/nuvoton/npcm-video.c:1677:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
./platform/nuvoton/npcm-video.c:1684:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
./platform/nuvoton/npcm-video.c:1690:3-9: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.
./platform/nuvoton/npcm-video.c:1694:1-7: ERROR: missing put_device; call of_find_device_by_node on line 1667, but without a corresponding object release within this function.

Instead of manually calling put_device, use the __free macros.

Cc: stable@vger.kernel.org
Fixes: 46c15a4ff1f4 ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/nuvoton/npcm-video.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index 0547f119c38f..7a9d8928ae40 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -1669,6 +1669,7 @@ static int npcm_video_ece_init(struct npcm_video *video)
 			dev_err(dev, "Failed to find ECE device\n");
 			return -ENODEV;
 		}
+		struct device *ece_dev __free(put_device) = &ece_pdev->dev;
 
 		regs = devm_platform_ioremap_resource(ece_pdev, 0);
 		if (IS_ERR(regs)) {
@@ -1683,7 +1684,7 @@ static int npcm_video_ece_init(struct npcm_video *video)
 			return PTR_ERR(video->ece.regmap);
 		}
 
-		video->ece.reset = devm_reset_control_get(&ece_pdev->dev, NULL);
+		video->ece.reset = devm_reset_control_get(ece_dev, NULL);
 		if (IS_ERR(video->ece.reset)) {
 			dev_err(dev, "Failed to get ECE reset control in DTS\n");
 			return PTR_ERR(video->ece.reset);

-- 
2.48.1.601.g30ceb7b040-goog


