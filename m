Return-Path: <stable+bounces-89101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57D19B3751
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 18:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACE92828EA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DD51DF253;
	Mon, 28 Oct 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFtvX7yT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBE31DF252;
	Mon, 28 Oct 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135208; cv=none; b=pZiDOiQGxjjdroPxa5n+reDIeeACVXChy7BfkZBo5mPKiyfQ9G++SU95+Rfpir6tAUxFOcw2GaNTt87Iq3+QaK09eqYdg67ugkDJrB5rwZC2QUJXn4MAktAJZ+mNmEVkx09Vd4K6sCOePNEjwREnUg2boxaLrqcNRZDxwxYck0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135208; c=relaxed/simple;
	bh=uv8UhE2oHj/jAoSYFDFHGa6v1zWyBJnbSc/opV4Ew7s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DQzbjnPFD57QniQDeEVPGLbakgf/z00WAE10nQ5CZb913o6m79s8PtwuVHrqtTG+FHBJ8+Jwi9S/AqGoqdJd65AAtid06QTCEUyDQvE1CirsM0z/xrgCq4cBLHBs15Cs69ohKClr8sI47GzYrD3y+HajIGT3REdwdEylLFZsokU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFtvX7yT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43152b79d25so42341975e9.1;
        Mon, 28 Oct 2024 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135204; x=1730740004; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nirCWzG2Wn5O48MYiFe6S6iiaaXRgl7t6gTboEBb224=;
        b=OFtvX7yTKrR7l0V+JGoibB0ikjgDjCXmp8+j4LoQapoEF37A75NBjDjAkNFM0txtzB
         WOp6DOWY/ATvdv2sepJQVDhNLujI+C3ZEIpO9Eryw/81a63r7rZZntL6vitRLM+6QXvI
         whZ5sopxdH3h9V/ipVfLcjyXokybha9lvXvgiQo5hiQ9bDP2SZEHPrafc705HvDXuTGs
         smx/wUNffX9VtwvvMH09e83tcpC4/RMyPCAZLkOlQNnXVZRIVZZZP932oQrD7o1vRV+5
         3rfISzlAPKuVBRx/CWup/YyEloYTVQ4cd71S5XvjRN0t2cMyIJFT8lEP4w9rJaC0tC82
         KOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135204; x=1730740004;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nirCWzG2Wn5O48MYiFe6S6iiaaXRgl7t6gTboEBb224=;
        b=CorzkyYf1HBn1V2lb7ScG/WPtTpCoQGqND3NS2wbs5txnQ+QqakVOXE+0kyMORAdeH
         /a3V4pNnx9UWjanMWg0sU+M+E6ZeWOrOdvFn78vm59PZrDJqNL9mPPe6TglatnpZ9fMx
         r3Su8GDJ+xlQtqmdlsfsuMJY84npVF8qJbZDaYeEqOXQkwivUtRm9RyA7+pCFHh+u7h4
         CkOzuqZFkY3lXZ52AT7Mpcrl8BwQ3BVxHIaeLEeSU9+nDBtDD/tmCxJlUMQx+ukK9Npp
         OfBmZCIDdq5FbRO3w4MFBtZow0zT377P7f6sqwP/AdJumM5Y2pE7EhRVWc5AVAs+tUX7
         QLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQbyQmgehMXtugFNovglVJhM/qEHXAwpjQHRCGOSf+qRCxgMbcbbCDNeUUj7kF/Y/WPow8Ivc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeVfpdvk/DhFd+eEOkdluspShlELEk5QZZQjFf2nYznizyGD5I
	E6r1/cA7d1wFyepOOoZ2ydjVX1T1J8Fa/o6gTN3RcSrKbKFBHV5T
X-Google-Smtp-Source: AGHT+IEQC1BU8VU12ifQwvyH5dCRImXcjuHtW31p5zdb2omPfodR6YsUxwjQjlwh9jpeYW+c4MHuKw==
X-Received: by 2002:a05:600c:1c03:b0:431:5d89:646e with SMTP id 5b1f17b1804b1-4319ad30bfcmr80043155e9.32.1730135204497;
        Mon, 28 Oct 2024 10:06:44 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1323bsm10089732f8f.9.2024.10.28.10.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:06:44 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] clocksource/drivers/timer-ti-dm: fix child node
 refcount handling
Date: Mon, 28 Oct 2024 18:06:41 +0100
Message-Id: <20241028-timer-ti-dm-systimer-of_node_put-v2-0-e6b9a1b3fe67@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKHEH2cC/5WNTQqDMBBGryKz7pQkWv9WvUcRkWTUgcZIYqUi3
 r2pPUE3H7xv8d4OgTxTgDrZwdPKgd0UQV0S0GM3DYRsIoMSKpNCpriwJR8XjcWwhR+6vp2coXZ
 +LWgyVaS3vCzyqoSomT31/D4TjybyyGFxfjuLq/y+f8hXiRKF7oWuurTIy+w+2I6fV+0sNMdxf
 ABs5xWV0AAAAA==
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730135203; l=974;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=uv8UhE2oHj/jAoSYFDFHGa6v1zWyBJnbSc/opV4Ew7s=;
 b=42unLjeMw9UF99FvGsX6qXi7uZzLc/XRF9h4810jk+s6XqJBcJInQHlaRgHhW6ILfuw4MgXH0
 doTmV0BNonPD0WakPhDx1KYrgD1eb1WKtTTCVLyoSggNys+Ecs1c3XP
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds the missing calls to of_node_put(arm_timer) to release
the resource, and then switches to the more robust approach that makes
use of the automatic cleanup facility (not available for all stable
kernels).

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Add second patch for automatic cleanup.
- Link to v1: https://lore.kernel.org/r/20241013-timer-ti-dm-systimer-of_node_put-v1-1-0cf0c9a37684@gmail.com

---
Javier Carrasco (2):
      clocksource/drivers/timer-ti-dm: fix child node refcount handling
      clocksource/drivers/timer-ti-dm: automate device_node cleanup in dmtimer_percpu_quirk_init()

 drivers/clocksource/timer-ti-dm-systimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241013-timer-ti-dm-systimer-of_node_put-d42735687698

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


