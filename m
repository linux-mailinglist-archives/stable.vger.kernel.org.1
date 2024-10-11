Return-Path: <stable+bounces-83489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A8399AC8F
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 21:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2E228DA67
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5AC1CBE8F;
	Fri, 11 Oct 2024 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8O7agWo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716771E529;
	Fri, 11 Oct 2024 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674546; cv=none; b=Z1cTysJFx6UMNCQpswQgqrwwa8EUxC4N7oAkPW251vzGJdq95sCq6vTXVbO1GlwFyP2r5ohc3KTuwrz1VquE+FgZqMNzkPwazNgEqTx44ng05x3TTa8KNVi5EqAzH8J8QP7VwuaBY6Pxw+vQa0HkBQwJ2/DK1UtZxBDsE4id1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674546; c=relaxed/simple;
	bh=CUgnykuigeyvSk+12QRyPfcuP3wIVJxY7aInDCemjsU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kk0LFsnLWIyY+z1D7FIZwArJapq2CeOJaUFN8h1C1pqIi3Ovc4sKhbLS5aQwRRCKFRhyCjkC8oDmESId2N25BEcRg/NzPOnNEzAfSUDgseD9GkUIcYfrjvv8Nk5gVzlsAB2fInkKPIzX0OeHzEKhUfvSx7Nan/5sZRyZU7hhpX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8O7agWo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431195c3538so14690295e9.3;
        Fri, 11 Oct 2024 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728674543; x=1729279343; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EYgQWgt/qKmfdHG9VXiGCkrR3Ne5T90ztqEtcBQu9CI=;
        b=Y8O7agWonQS3ilRb2hy0CHkpToZ6Wrs1Xkaws0gEk1lCIsfSCsQeH6hxZSd6Lt+n56
         g9AZtxPwrAdeSuXsXBRyzEJqkIV2apI2Nq5zlChZTBwKxfXTUbiZGYTeqYxHAZmZsL4O
         VAEIKG9IL/p3ELHFiK/6kSK2SZ3jMZdZ7qWNJJgl+kRofUWb7Y/r5CxwUvGsR3YE+67h
         wXGdnJmQr4MA9Z88ozZ+r+N0UU5uuRrrmvjimQfGUQNTbe1bOMv/rAbydZc0cJeL6xjY
         gwCrcAamQzH0K9lha4bV9LKLJPn4dervXRmK5j7wpuT7VuGSRLIgiQr0SmyBk543Zd1Y
         lStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674543; x=1729279343;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYgQWgt/qKmfdHG9VXiGCkrR3Ne5T90ztqEtcBQu9CI=;
        b=ovTch+lOaNXsTJLsKARZRZWyzJ7JzuJLfztqIM5UptqnDNS1hZfB9nM9/WcZI3HAUU
         fi0Rp5ducFhc/uKNzqYhvFS1MwWmurF3p3a+Cpaxiw6g3DXvIaO/gCrqVTsuj5uI+snf
         ZHDdNN2GieOsj3Vy/I7xqCItTdGZ6fReoAxuPfdntPAWKUr5e+JwHd82lXwrVcG78I9I
         0StNI37mW90LXErCUIfmwhrb3XOwgp7cOrLAtpN9eALgbzFiXMvTLnji8QAzvTScpvSB
         m1Q//Ybxrxr2H4lwlvpR2Um7/f2Yq7aDDm6ZC7DOiwO2vBVJMadh55fm0gFZlNeC1FjZ
         OEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZHrPEdOouoFoze/eTRJw6GalyITfte5Jbo3U8MhaxPKYsQVNp8/xf5Bg1XHTujAxfHtrB/6k@vger.kernel.org, AJvYcCX7AhLKadQAZ4RMzRxnSicLdD0R3StvpX292yw6qfeYBNMuJHcZGJi1MfNwnk0XAZi0o2mGy3TGqW/r4Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+SII3RteRaN2nX2yvGVJKisItz77My0/LuEsBvFo5gshByYrt
	7UIVLX6x8EfrxIextSO2ohYYNauYhoRobDExJbuRLiCuEpSf3Fs9
X-Google-Smtp-Source: AGHT+IHDrJkqntC5hbJBHUdbeUAjDp6V1K7XShBIFjrWbQhxHt6e86dahsDJxOy2EMtrhVQ1CrDX1w==
X-Received: by 2002:a05:600c:1d26:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-4311deba2a8mr23732905e9.4.1728674542675;
        Fri, 11 Oct 2024 12:22:22 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-55c0-165d-e76c-a019.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:55c0:165d:e76c:a019])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee49bsm4581663f8f.100.2024.10.11.12.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:22:22 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] drm/mediatek: Fix child node refcount handling and use
 scoped macro
Date: Fri, 11 Oct 2024 21:21:50 +0200
Message-Id: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM56CWcC/x2M0QpAMBhGX0X/tZVfVvIqktg+/DG0SWp5d8vFu
 TgX50QK8IJATRbJ45Ygx56E84zMMuwzlNjkVBZlxQWzctfaW+8Sd+/gNgyr0qjHGpWGZUOpPD0
 mef5r273vB8+vyTdlAAAA
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, CK Hu <ck.hu@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728674541; l=800;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=CUgnykuigeyvSk+12QRyPfcuP3wIVJxY7aInDCemjsU=;
 b=VS2IFCGJyJpyQN++hbNfW+QHI8VE09TUL+q0ILjUhG8LFSsaeXapxeE08GCY6WIEkfxFiYrvq
 3o6Dsm8HPgzAHTM2Gzm1+GZnOiqBBIM/R5LsZ4CcxFrH8NtRwbJSivg
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series fixes a wrong handling of the child node within the
for_each_child_of_node() by adding the missing call to of_node_put() to
make it compatible with stable kernels that don't provide the scoped
variant of the macro, which is more secure and was introduced early this
year.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      drm/mediatek: Fix child node refcount handling in early exit
      drm/mediatek: Switch to for_each_child_of_node_scoped()

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241011-mtk_drm_drv_memleak-5e8b8e45ed1c

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


