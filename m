Return-Path: <stable+bounces-176991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E3B3FDA9
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1158F7B14D9
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D02F7449;
	Tue,  2 Sep 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQliHrdH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98B2F3C0E;
	Tue,  2 Sep 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812052; cv=none; b=FDNZVE0EiyvTBP913aAkT7RlWB7KoE2BmxZRuMRjHhM70R4sCffiA2ri2vyVNS4po3/YUj4rwCvi/YZfB7GaPu8jZTI/0EQFFLhyXHgF0J5SDyxtOfeA1JtYKvQkn5N5qiVgJtXmWyZ4UFtyf7LpVHD9pHd46UFckNFuorRytus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812052; c=relaxed/simple;
	bh=BoGw017JV6MDafm2pfGD3s91i69iqGZ66miMlmTbOQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sirqWacCgHGVQDGlTJtc2ikWwVSqKihglN88V36l83zFjtgcK9CP0bREgFhdihDBOZgFdh681H35/L4Y9/9nOgYjMeqn2Q+KXjgWZzMvN5E2RpwZIB650v3HonTAM7b6KNjPR+qRIVFJ8XQywrpklMww0cd1+DaOFRHeg+ujifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQliHrdH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3297a168470so1861090a91.3;
        Tue, 02 Sep 2025 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756812050; x=1757416850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2rcHOEeIqXUh6SmijH737wtMIpFUvfl+GtBU3P4v8I=;
        b=BQliHrdHii46EnToP6//OMsJb2TUfvutiMSy9RD0YSwBi0fbpnF1blYj3zvBbGLtN7
         b8kN6UxMoKJt0bJzL+JyraEgpalAN76H2IQK4uLzdL2Gzs3E+mbHrMTrL3eywPZY2M1+
         gN4auh97JUtY5Oz6zbD5ogF3H5vxktCQbpaQXYq3eTrpc1ASQo4YdQrY8Vq03bbzntFe
         QfypF/jc3gV9nkIJpBf2q2DwHfaa/9JkStWdb/iFk/9GgN7ro7mpwAqXhJWpjE9G75C8
         8uhiacRCcM00pXYnbRFqDPmbLOHuh8Xgq2k9SI+4mZmuHv74vZhwhol8OsHzWp6weEST
         svsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756812050; x=1757416850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2rcHOEeIqXUh6SmijH737wtMIpFUvfl+GtBU3P4v8I=;
        b=RqVLInb2WlWTVo1X6V8vvch42y0/Swht55WpsMBATBsptsD/iZRUdg+cCb7cQd1tyV
         ZoxvcBgLHQkiwOAKCG0k+QEql8/j4aTZfKAQDPHwf10vlk1vz6WH4OdZed4zrt8RKDMk
         hfEqeXHW1QUbEPhks0B+Wzt0h0JHmVk7vO3w7sovyNVH0iQhWzA/iUTbZbVPTYeqPsO5
         8BCBSBHtkpL15mXSs7xSU0GEOhROH0VldrNmATl9sQ/rbKiw1dsl3Mj82kzIBHLKrj+p
         P+00yWqczSdQxDS7+MMWe7MJO6ywlaIWHk+eYNWWIrb8VdVSNFj54CJEh0YlReJ73UXe
         TS/w==
X-Forwarded-Encrypted: i=1; AJvYcCVGi+5JHTZzDdaJhcn8mxwDEty2geZjU6Zx9KhA4HELKlXma63J2N5mKhccLo+V4njWZzyBC5oLA8VPHQ4VJuVGhrI=@vger.kernel.org, AJvYcCWZn7LHAbmP+8S+J5XuRtUMPUxeg1Mjp35qN5puhhBXPhQqpSw4Iu9erXgPrPKfgTeWH7W+R+q+AviBGQs=@vger.kernel.org, AJvYcCXnUqT3gtoQRjaGl/mgt89f72cjowpdJ18E3eluxbwK7ZWG8lReQBttpZJr2uCa7EuGWf8BXt8n@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8IAUbLq8v0caaj6QYJLHe+OOriRsrXF6CsF2rIecosolETQe
	urO7rVC1a/sOmg5ufegP5SSGRmcB6WVMRzIW90dCy/lHx7W30yDABZcQ
X-Gm-Gg: ASbGncv3qGEO/oCjC2NZuvf0EpGeAPXX0O6mcVoGi5XJv92q24/MA9CroE1oSTUcbFi
	oMcjFVUU9CiptzYqIIEktpNPFvU/UlYrRw+bj3/WxJj8EVTif75eTJlSomPPaDmj5sMmOdwM5sQ
	tyUJRP9SZCSNp0rT2ql5abtSd4Xl0UxkSAw47o4cvt8uzK9P5GUSpWcTxBCXFB2vucYIOmHMCkB
	xjubflXiXEsYvdwLAvQKee4x+F3wDLId4IpyLpTwMKlXONpA2Lq5y0tHSf4ePdiMjFLBb1JTJjp
	TD4GI40vhwr9Pi4NtA3PToZW2sOIB9JO3Ac9sW5bPL0sPu95HtVmNE/IfTiTu3VqzjULMk9bwHJ
	ln3PNO9vDl6lI1U7+VfZsbGHJ2jdruxgLTt6COHQ/I8IPKNWKJbfUTwHWMeRk
X-Google-Smtp-Source: AGHT+IHqll56l5WwIcczcNekaKIeM8kqWc+lVcX2zUeUW87kRMBHk1t9A7NrrAy+78FiIbnJ09AbDg==
X-Received: by 2002:a17:90b:1c06:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-328156e3774mr14270847a91.33.1756812049828;
        Tue, 02 Sep 2025 04:20:49 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e27d1sm13140645b3a.81.2025.09.02.04.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:20:49 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: krzk@kernel.org,
	alim.akhtar@samsung.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	aha310510@gmail.com
Subject: [PATCH 0/3] drm/exynos: vidi: fix various memory corruption bugs
Date: Tue,  2 Sep 2025 20:20:40 +0900
Message-Id: <20250902112043.3525123-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a series of patches that address several memory bugs that occur
in the Exynos Virtual Display driver.

Jeongjun Park (3):
  drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
  drm/exynos: vidi: fix to avoid directly dereferencing user pointer
  drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free

 drivers/gpu/drm/exynos/exynos_drm_drv.h  |  1 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 64 insertions(+), 11 deletions(-)

