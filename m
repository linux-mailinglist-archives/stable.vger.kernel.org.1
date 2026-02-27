Return-Path: <stable+bounces-219908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPEBEdMkoWlOqgQAu9opvQ
	(envelope-from <stable+bounces-219908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:00:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913701B2C57
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EB2B30DF85F
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3837362124;
	Fri, 27 Feb 2026 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRowTCz5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3D362125
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772168399; cv=none; b=fWvUTzQFM5ePJhVqmSxdMkqtiSBI7ArOlvopgB1gpGjjGyxth1ACUO59MGA+bJQceE2WkxNNrCGRGrc+f8WD8hrUjOwiAK1MUqJOcrjGt0g9Qw5f732UVffj3UhNozMAF7KCBKo0VzioPSlGCR0z21KFXU4QzJ1z1svLX2hPsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772168399; c=relaxed/simple;
	bh=kNhN4uiLU9hWF7ojHUliD6F9I+s0BzOeel06kok/oic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rAt6pVXTepYDYf1U05Mciol7fr4ZmmRcAMpSBMXh3zsblxJ7gmHZbqCgmuk1jcTBTHKd+HxxevRRVDw9l56nggV5Ng4rTKzVGABo5Tn8i+8OfVsQpRi9sWgoHqY4ML/BzOhRWtmbHtwwin5QvKNcgDelV0xenBRJC4WTWHYRTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRowTCz5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8274936d2c0so1068606b3a.3
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 20:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772168397; x=1772773197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9M9yKCPLn+iVOORDFLmMfOISzVgCjsTOG3aAkzJLHbw=;
        b=QRowTCz5UvNH7lKSH4foUx6PiucBn1NG/6dXaU2yf4zuS2ww/WAss3fgmwBFTj86Ac
         v8FxkNGo2RNKYjbY6t/Jm0pY/n2n/ViUDX72hrzxHsHue8Kj0RwN13CLayyYO2E5UZuN
         s8u7Br/LHhbnBgG535JhwUd9/gBCfbpJYYGA+6kLM81aXsm+zU1qzJWOY+ZIR6uyMW8E
         AJ7YCylUgcItnJHNvJOKeieq6R7mLoDZuW7joJg8O3nGm4ZFA/RcMeEZwLcbLUZH+MGa
         pdOFZK/7DYfyvrOcSk9eFeoJvtKYPOnqTqiL3GiRd6CW4njBvBf7AoHrKiINwlIA0NAV
         Fldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772168397; x=1772773197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9M9yKCPLn+iVOORDFLmMfOISzVgCjsTOG3aAkzJLHbw=;
        b=e35aVIpt+1iG1GxeykY9Ucrl2NMoxarsRzv0q0K62WkoG4tfSo+eRfXXihJOlat/xw
         6Av2dolc3rRBL1faZI4Zl9rphNys7agFlsNgECnR+pgImw5GpSSnMeiKyZVBeBTdc8rY
         c2exgs2EQN6FlqSlf/HSd2AykVPm2VEzBMGFdV1L6OAm8G0oKqEOclTvEaVEFfsa9Fx8
         8nKoA/QcveGThaebzQYga9e2raA6bQ0QWMhIaGWiT0A0zNznzRydE6P/eO+C/6IXp/yO
         zpxp1teJlYSfpc6bOtq+MHLsdZ+YnkMtM6At7u4eXMO9f/rv2cDViVUr5U3j/r5veLjd
         of5A==
X-Gm-Message-State: AOJu0YyI9Pv+TAZOi8+4PBXQWT1I2nmdiluTO93v5BUHhW2MZHePy31Q
	iSP1SkDU/AKplPmZEA6sb/X5JHK5e29FBhoEmRpi4Xxu0plLiv9uHHC3U31h0w==
X-Gm-Gg: ATEYQzzmp7t7wWmSypO5cZePYn8RABabK0SKiig155qvSgBE2Dd84MFRX5Pdjf96DFc
	vlQ/cD5LLoQAAosTG2QTPd+7xkIGy3s9OBSkl5U2RzM62xeVw4X0QgRACLuvAyKQdWSAyO81VD8
	QNhmZ1y4dClGt8nb5wSGIbKi5YE7QOndIOw8sRS6wCjrCpVACpPWlVroi2XIkRwBu8az2FVjABt
	/aBQG4QH1ftX2vKAPbGko+UMWYKUQaZKEVqFLnqFeiFWnoY4AtVS5GyLVo0xEdcI2hD+ve4y7JA
	zdusJO0HzNGdczhwYbyHA4MaYEdPnh1eUSJanP/30X2V0W814pHxkzxXxiw5Biv5klkMBNzTPnl
	z1G/4jjuCQ15GYwDYmTf6uXlkHwtzVJubck78S0UuENOlMX3BKFOV1bfmbCF6NfwoZRLPO8dkid
	wwxKZ24NHNLf4km+l5sMwN8LZJdNPlLurtbqfo8yUc//Benc36Ww==
X-Received: by 2002:a05:6a00:4390:b0:81f:4566:cce6 with SMTP id d2e1a72fcca58-8274d969893mr1442557b3a.28.1772168397546;
        Thu, 26 Feb 2026 20:59:57 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([175.201.112.127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d94de6sm3966543b3a.24.2026.02.26.20.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:59:57 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.6.y 0/3] drm/exynos: vidi: fix various memory corruption bugs
Date: Fri, 27 Feb 2026 13:59:50 +0900
Message-Id: <20260227045953.165751-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,samsung.com,gmail.com,ffwll.ch,kernel.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-219908-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 913701B2C57
X-Rspamd-Action: no action

This backport patch is for 6.6.y only and fixes a bug in the
Exynos VIDI driver.

https://lore.kernel.org/all/20260119082553.195181-1-aha310510@gmail.com/

Jeongjun Park (3):
  drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
  drm/exynos: vidi: fix to avoid directly dereferencing user pointer
  drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free

 drivers/gpu/drm/exynos/exynos_drm_drv.h  |  1 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 60 insertions(+), 13 deletions(-)

