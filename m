Return-Path: <stable+bounces-47952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0958FBB54
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 20:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79B4B27719
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 18:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B276014A635;
	Tue,  4 Jun 2024 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMI3/ZyP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380014A623
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524655; cv=none; b=OqFbJxFRelfYr9JsWnxB76W2pf9aMplEP4h7zgOjzovNTlo6mhD+a2pFkm+4zrdoxOTsV4mgVnUhXayUVtxnSy+oNfOy+x2dalCaHAKjk3aQHmczqMAJea7cXsgZqLk+GgNPiOh2bu2cQ6t68xzbOO6w/9z8utpWdNc9J9Upl4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524655; c=relaxed/simple;
	bh=vzeFpwHDiTuJOyn+mot3dnYATW3aJqqCp7gwCO5QEaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pA4tXXXg3UHhZZnkpLpCCd6t2JLUlB2hZRUkc5Vrz6YInn2zxFfdNVq6aH3K6jkTShs+xlqusG5VjvBvL084K6MLEn1KK2bddf3Gpf5WeqBd1LrpTMPbFoMsasew/HrJXJRv7gI3ml7wz3qXU/DiQoYo4KOc1D3XkFz5I97sOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMI3/ZyP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7026063a2fdso152313b3a.0
        for <stable@vger.kernel.org>; Tue, 04 Jun 2024 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717524653; x=1718129453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gyr1zxv5ZH6H8xeXFMyZIoJ+UJ94PJla19+uaioky8I=;
        b=FMI3/ZyP8lMDwDpVMjZ8EznEojFgZPZtqF9EqJizAikrD/XYFrgqldNBAMvlWvu8Qs
         aA7ntz8KJbZFFIfUtYt3z/RGdATjF5fOD0QvLo9v8NrulwwMFkPE2NXk6Ew+BS1jpFtw
         z7q6ySLURprQgzQV1tqWrdmZcO8xme+ppugIFpyno7ltP9zugDFkx//c1kXQXNebQcnV
         jGm9xSxJuD+qSGwg8L3WTFhvrT9KNLUl69agIlGlO7UaB4jR3dNLuxPPs7ZlKQd6cNij
         CgcTsD+yyus8aIYUjc4JQg9z3cWwqyKS/tS5QQYZE+yXa4ESoh84I0Dyl6Llp/KqX5zf
         H+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717524653; x=1718129453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gyr1zxv5ZH6H8xeXFMyZIoJ+UJ94PJla19+uaioky8I=;
        b=ldoekEtB87MrG0xtlkGjx5AcldEVhg+dOfqKr5NanMDa6hGnN8eY4/80hCaUua42+X
         KAGsqNFYAFoxJTNQsec2PUcnikWUpxhA8KKPTTlxiRXiC7VzVxwkestJTTYC7DhqtyFr
         tNQqRYRMLBUVfvYg0/nmGu0hLOFHw6Ddi7Z3hwCZd7bDw9QssqvWsKmQ1vpggPFVuvER
         Y1Y813CymqrT4SEne1S+FFEaes8eLST78RCAAyyGdQuRUZFt4q65Hu3BCMDSEzKmef0M
         JG0z3EsGTYfdbmuH6vj5PMNW+5ps6ApNFfPyVRDy2lZM3mXFHcfN5qtMRd3iQRYiCcdF
         75Hg==
X-Gm-Message-State: AOJu0Yxn/iyaujNLRob7FqqKx446nxViApNT7/rV5uCMM8aoxdNjV5J+
	wxJcLBOe1N3JKfuOIsgPdrLdP1obPXCoMKECS1sphhtKssMug24uw2neHCA0
X-Google-Smtp-Source: AGHT+IFmtTwwLOOg7z0OYk5Sk3Yoo5JmdBJVvbbi9jYYs8uTa18K59VQNq80CgNfPfZ036AoXGa35A==
X-Received: by 2002:a05:6a00:2d1d:b0:6ed:cc50:36cd with SMTP id d2e1a72fcca58-703e59fbaa3mr239280b3a.2.1717524652792;
        Tue, 04 Jun 2024 11:10:52 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:e7d3:fdd2:d8b9:aee6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025aa3cb45sm5118592b3a.135.2024.06.04.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 11:10:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: Martin Kaiser <martin@kaiser.cx>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] arm64: defconfig: enable the vf610 gpio driver
Date: Tue,  4 Jun 2024 15:10:43 -0300
Message-Id: <20240604181043.3481032-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Kaiser <martin@kaiser.cx>

commit a73bda63a102a5f1feb730d4d809de098a3d1886 upstream.

The vf610 gpio driver is used in i.MX8QM, DXL, ULP and i.MX93 chips.
Enable it in arm64 defconfig.

(vf610 gpio used to be enabled by default for all i.MX chips. This was
changed recently as most i.MX chips don't need this driver.)

Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Hi,

This fixes a boot regression on imx93-evk running 6.6.32.

Please apply it to the 6.6.y stable tree.
 
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 24f395d9ce2a36..9f82eb906a8a34 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -632,6 +632,7 @@ CONFIG_GPIO_SYSCON=y
 CONFIG_GPIO_UNIPHIER=y
 CONFIG_GPIO_VISCONTI=y
 CONFIG_GPIO_WCD934X=m
+CONFIG_GPIO_VF610=y
 CONFIG_GPIO_XGENE=y
 CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_MAX732X=y

