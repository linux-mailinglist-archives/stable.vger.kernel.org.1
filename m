Return-Path: <stable+bounces-110068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1500CA18720
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 22:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4F016219C
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 21:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0A1F8917;
	Tue, 21 Jan 2025 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+pvBThc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804951F8668
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737494100; cv=none; b=QqSrsvjlpBTc+pMR8IUapsCCk4wBwk7oyWckeR0eQmdwlAQrSQuFtk89hUkz5XfEPiZwAF0dcrJht/pO+cjCPPmVv1MgJYsLG3mNK7htsNEOmd2yJjFDa74TkJnp2wLFlGoIixCgRxhB7g8dtimUMPQEx0O1n4vGOu5XVkzTS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737494100; c=relaxed/simple;
	bh=kK/OufzQmQI4XPHyamMFXi0pV8mkYyucQJnxY3oRAPo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nzkawGAKkakEVIpidNEPT78i1ZshUACMv/qYLzEEfUHwq3A/OhNC0ExEKLcrbZE6v9KDbTTbEEjPSGGMGt7QP6P2vIWzE3EkVl7ZKBxZOGHfkJvGcoWSdi+AzEtSsh0hFYmJy0mLWv3e1c/ZDb39+2zKzP5O1QOMLTRcipX+KiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A+pvBThc; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e1a41935c3so85264636d6.3
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 13:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737494096; x=1738098896; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQuSQ7bovNI6GEsgzAgDtL6O/sCAbswELfNsKv2rreI=;
        b=A+pvBThcevOQSX8rSJZLGxwp7AVqfRTK3Ct+TqadbDOpColpGiTy+YT39dPnbZrwWS
         k63xI/S54Ur7Ft4vRfYJJFqV2Q6UnoSAjaj+4Hns840lnyDVno0jjNtHsLwNneCThbwx
         bLJ8Pjsf7ixt/GYFHeIaePEXhzDzXgxMy2lBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737494096; x=1738098896;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQuSQ7bovNI6GEsgzAgDtL6O/sCAbswELfNsKv2rreI=;
        b=qxSykGxR2OIrrst8hkIR0n3k7dLxbBogC4YtR8p5DPzbdU0aM+g/nSiYoRf4Y2jIhf
         k/3AGYgUFIeRKRlQoGxD/6AK/baGquK5SZdPxRhoFIrEBLVFKziFD1MRxYFDHFwPxHmy
         CRWMIpBV3DHmI8EtOmhFPjfKOaVbUph+pFB8rwNCLAGD12SJYfJMbMOZEuk2z++O+mQv
         GLsf79FaU3tyZXgEkBGm/6Nx+27mAturMzbYcimfYKTmqiDsXWmPd/1JLblm7D6tbuA+
         52xSRjWPwSZP0UA/Fvunn3fPapumpRzL2ZVEbuHSe3MCHWZDWqMC1lnNg+T921XJIFa7
         vPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl/8+ZaPt+iyNo0Kf5J/1sA1/+bqE4OmIv+5lvoWAbgGu30dRc5dlZE/K3H34CWM/frQToxDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0purpuGzJZ3HGI5Y/wLgJ4PaQ1bgvRg5ckMT8zbmQb9mXoYDk
	pfqeZrKBMY+l84yvjrnrw1xMn+NTvMLZ6S6hxRZukrsdyqzcYiYALRwrOotZrA==
X-Gm-Gg: ASbGncv8Kjnc/4UjV7ePMw4OnfKvY7oO8WsEVxuDpXPOBYHl/rNPSYhMGs7XduKITSI
	M0Tu3C4ufBTB/TpLo5tn11bu4gKV1pr83ZmpnvgjCtxewqjm41iJhAZMWpT5GhHZGmXIxeDbvrI
	EAd77lqHi2f4vsoF1hxHMnKep+QNCGvMJBZrF9FAEQuTZ3t5ThwfrzC8A434DiCe80DG3Zb5+GI
	sn+YykC8FrJR8IDLTQH33UXqE2E1KirzYqoohxTvX920oxtYT2N+WEFHOKINd65jIsiFZQ+Q4N6
	NkQBvRwKGfkGJWpUsP+b0sv9/8LmIvaIngxum9ETmnRUw77isQ==
X-Google-Smtp-Source: AGHT+IFVRDtX4xLCSgnndPd/KmBxnL9FoLZx0NyA+ZEg2Wgowuj2xhPVpo4f+zf+P1TtX9DKiJhurQ==
X-Received: by 2002:ad4:5747:0:b0:6d8:9be9:7d57 with SMTP id 6a1803df08f44-6e1b222e66amr323757436d6.37.1737494096451;
        Tue, 21 Jan 2025 13:14:56 -0800 (PST)
Received: from denia.c.googlers.com (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc28f84sm54790186d6.63.2025.01.21.13.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:14:55 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/4] media: nuvoton: Fix some reference handling issues
Date: Tue, 21 Jan 2025 21:14:49 +0000
Message-Id: <20250121-nuvoton-v1-0-1ea4f0cdbda2@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEkOkGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyND3bzSsvyS/DzdtFQLc4PkpNS0tCQzJaDqgqLUtMwKsEnRsbW1ABh
 h0VdZAAAA
To: Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marvin Lin <milkfafa@gmail.com>, linux-media@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

When trying out 6.13 cocci, some bugs were found.

The fixes without using cleanup.h should be backported. The last two
patches make use of cleanup.h to avoid this kind of errors in the
future.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (4):
      media: nuvoton: Fix reference handling of ece_pdev
      media: nuvoton: Fix reference handling of ece_node
      media: nuvoton: Use cleanup.h macros for device_node
      media: nuvoton: Use cleanup.h macros for put_device

 drivers/media/platform/nuvoton/npcm-video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: c4b7779abc6633677e6edb79e2809f4f61fde157
change-id: 20250121-nuvoton-fe870cbeffb6

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


