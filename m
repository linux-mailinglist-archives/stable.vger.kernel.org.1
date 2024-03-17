Return-Path: <stable+bounces-28309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0CA87DC28
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 02:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CE41C212F6
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 01:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D51139E;
	Sun, 17 Mar 2024 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2gyGDqA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F987F6
	for <stable@vger.kernel.org>; Sun, 17 Mar 2024 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637617; cv=none; b=Nb4G+BHkKIYpdsgLj8e/AZnrAd4hl6E4vMAQDODh3/9BY9Zi4LiXQNX0JEwUMEtTVPQOBefpxCHGvS4sx/AXn+2C5q9+sNQx5fwG5Mb809JKnX/N1kZwe5EGbuUg+I6GkQU0e6Bjs67muqjKl6yWsRt3WSNWcgQACSTkQ2C7hSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637617; c=relaxed/simple;
	bh=lJtzrHcwH6Dh82o60di9wsJZ16JP4mYWIzPSePGcdRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gn24tdMMI/L/KoVUPo5xOqx3SUR/hOvg7hD2zwXpu570/zXgd3Qq+LqzA5eKX9VY6HLpbwdnhUqnfH1L37KmW7sDtlaypI8QsgbdKFc5e7vOMwClRBroueBWBZdCxQPMKGibgALdUsVao7knRMCzMhuHUI7Ozb1hJAfQ8MFAWUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2gyGDqA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41409c8d7a4so4168875e9.0
        for <stable@vger.kernel.org>; Sat, 16 Mar 2024 18:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710637613; x=1711242413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=raK7ZFeVwbe5dwwRV1dmnSxWSifXPen+UpQAeaKCVVE=;
        b=j2gyGDqAFFTr9kvY6MmF69BD/qYHykvglqmeqtAWUk332M2s3gDfaBoQOzuK+EyxC9
         768BPcXD9N7p5PWTRUdrz0YgJ/T+/mQqTAwXMo6fpGpAHSCLZ1dpJlqR2VzIhVGwjXuY
         e7r8jWE5g0OKhW3enk8XSNZrByjpCHPYkjursJ4qwczqib0X/hYYv8FZxXV0SGiV3eac
         LVe2dsO27TWrOvA17WOU3WiwQ81d8Fsq/sz7qoKhj0kJ22nrhn9vRSXNJdb4SpiWMxlZ
         rCHr54AdeXMnJm/BgLu4roSwd6eHFXtKpk7DtRtFm6v5ulP3qiEjMSF7O5qx4tLbLR15
         N//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710637613; x=1711242413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raK7ZFeVwbe5dwwRV1dmnSxWSifXPen+UpQAeaKCVVE=;
        b=UlhG9qZDW2CVABZDhpsgNUAxxl+b4vVZIONbgFVIXfL2i3Ru1jozRYPIwq4CuKsneV
         Ta97KQ1s31megntqSS1mnDT0nYC5oGjhOaWPpOuomXpaI79ECm1+bZ4tEh68spzQBe8K
         MeiaIcesMdg5gx7Kna6nZo8SZJx9k/nQmvYGiFz7hodoKU4I7JX6y452IhIKJrkYz7ms
         yo3/VOvg70tRoTMdr1XMN6tnP+mU6Qyoto48RnEDVWOMBPkdTzfMIf+YAxvGyfpGjcMS
         wJQZ2L1qS5mr0/jSy/INaQlVVsBkCu3uxy+SjMFAcww1H0bW1G8oIkDwv50yk4yKz9+b
         0KSQ==
X-Gm-Message-State: AOJu0YwZRxaZfmmVzekAyOexcIEEzVpOq4wLKDC94JW8z2PpCQMLX/bE
	7hEmEiPnKKdtQlw6uDKRtP7Dar4LZnHa7DQNTfDTmPsf2D4jCby8oQKugPA/G9UA
X-Google-Smtp-Source: AGHT+IFdh+T6d1vy/Q0RBLYxOI9KhQT5KO4Xo3MQ/dfpLqcUC8o70An4E2/QW7dK/llVHDSbK4J6mw==
X-Received: by 2002:a05:600c:3ca4:b0:414:24b:3022 with SMTP id bg36-20020a05600c3ca400b00414024b3022mr3927423wmb.28.1710637612907;
        Sat, 16 Mar 2024 18:06:52 -0700 (PDT)
Received: from localhost.localdomain (77-59-144-113.dclient.hispeed.ch. [77.59.144.113])
        by smtp.gmail.com with ESMTPSA id fa21-20020a05600c519500b004140a341f5asm1650042wmb.46.2024.03.16.18.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 18:06:52 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v0 0/2] Fix LPSS clock divider for XPS 9530, 6.7.y backport
Date: Sun, 17 Mar 2024 02:06:49 +0100
Message-Id: <20240317010651.978346-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a backport of recently upstreamed fix for XPS 9530 sound issue.
Changes wouldn't apply cleanly, and were backported manually to 6.7.y.

Ideally should be applied to all branches where upstream commit
d110858a6925827609d11db8513d76750483ec06 exists (6.8.y) or was backported
(6.7.y) as it adds initial yet incomplete support for this laptop.

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>

Aleksandrs Vinarskis (2):
  mfd: intel-lpss: Switch to generalized quirk table
  mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530

 drivers/mfd/intel-lpss-pci.c | 28 ++++++++++++++++++++--------
 drivers/mfd/intel-lpss.c     |  9 ++++++++-
 drivers/mfd/intel-lpss.h     | 14 +++++++++++++-
 3 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.40.1


