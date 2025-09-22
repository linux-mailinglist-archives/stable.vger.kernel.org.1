Return-Path: <stable+bounces-180985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170BB92133
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830321903DDA
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE030DD11;
	Mon, 22 Sep 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL+zgoWg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCA2EC0A8
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556428; cv=none; b=rYxzXFHNzaIdONKXIif7HlBhrD25J07J2ad/BGvtykWqxsDvPBWV8YJp/ZNUFiFklQTvW5/MqxRiUz9DlNK4K6S4BMMoigAj8ySX8DdCWN5g5ML2fZa1NzaCGxgXF2+je7kF9rxDm2wHGbuhIyTvugdmjbsvVxet+AdM1a+LKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556428; c=relaxed/simple;
	bh=xmpykvsefbZg4Z3d0+EhES58b/1383121uJSOrYR/s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dy4lv32tlhVDZLgJl+7GZNwv/Hs18fseu8poZnmUwl63nNk9WY5LMhke2FIizfwj21y34PpcRfadfeZ2k1imW3+zDArdJagTYMV5ltbQ1vyc3gn1QXxAPsZB0h+gSOquJkC9aSKg3MnTp9W4DO+IsrOSAPxbwCJnL2bR5pw1rkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL+zgoWg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445805aa2eso46748505ad.1
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758556426; x=1759161226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q61xyED0iZHvT227a823myA5nC6Bd8yB77AGxFVjBQs=;
        b=iL+zgoWgN6zTX8jArXdOFpzYAiiPU2CQfKhPcEMUtVmH+8xWKGs+ftHIwq+TdcKHmm
         SCDeaBxoGfR6RIcEH5uHXTCS/Z6awE65ZDx/3LFgkKma0FNLQxT2SttGujckCvEwO/3c
         BsxGaqNdl0d6MTzEd10JHCfNbGgoJCZOh5a6ySYjfmMmH8KxNJYyZK1BepWjIEkeypZx
         kHczk+rfU5kmvgdOPu6IbuSdC+hunG+nuQ5RIn5TCzKZH1Qo9PHzM9zCyzngtT+MuVvs
         Fq1inofVb42mIPmqPKW2FEEcRKSl56ee8xUYoBfjNx0YJzJzZsSma9f2HkhpXdUx9/RP
         KciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556426; x=1759161226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q61xyED0iZHvT227a823myA5nC6Bd8yB77AGxFVjBQs=;
        b=mBY4+mhH1sShJZK8A25tnJc3U7Nw1tBEnmTqbJnpV4mtKcZPwk/IDNA30oKATBOSwf
         JcwFYb0bp9ZW7hx3pPmJu3WaF2qQV2pCkCoyg1LYrSbfrP9i/rBopyVK2tps840ptPqZ
         IcRIaeh59ioPUv6E/pGSk53Vc5vDJqm9ijNm1UYv6YuF2H/OGOh1QIU2pzAPPxSWv9sN
         n9L+Jmu4f9OfxM+mwsxMGkZErw74mrx70I0ozhAHwQ/BQB53lofTHqOJ+VqiJtqbWgmD
         27OGp/TDu8O1neNMxMOpOu5rl8AhUhN4kCadBmlEpSpyf5zvukHRkBGjIiXcrXhA2gPP
         +ZwA==
X-Forwarded-Encrypted: i=1; AJvYcCVkIsMBkO+NtRnROdrmxTMHnjJ+Und1E7Qkg8wP0RfJPZMTlfPClMGeLmoKGSn8gwC3tMbnUJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DaGAuFRArKIn+7nt4tunGdjGOVe1lqzjm3aNhN9KizEqK2Mr
	shUVIienLO5Bw9bo0xZoIXS5jkgyio6Qfp8ZEvuPx1TFhwRVOo7dxP+I
X-Gm-Gg: ASbGnctUAAF2+tiUFmppMa6m5Mn+sUs3xTD9+HHTKR6gkIUIstEpCMUt5hCnh1t7fdj
	6JcD8eDU3PKEaPJ1n/wrZWt6e0dF/b22RQEhpWs+02U1uoOhaiFnimK1f7UPuDaDxns/ZK8tOxa
	9ISZelAoaQnAHsYr0KRVa/tH1wTfy7Kgqxj3mG1STOji4dXtQa8xP4rJtZErCocg/aSyyxVhRu8
	WklsG0Y6rXRLvUKyYVXvUqaOPLOSU/4zuAv2zhW5x8hpeip6RPhXYiNy93JKFHqS9RZb4ylB86N
	S5iL1ds8druWD4asW+BanyFsvMvCUcYueZJZS/Mo7vb8cN9w4eZy853PLP38FNTJtMvGFHD364Q
	KeqRs/E4nF0++RPmMVdFvaHdT
X-Google-Smtp-Source: AGHT+IGEGQomxsa7WNV0T03rhAK/xcvrrheXR+pMEm9N4EM2OSbc4zcfLSj+YjG8nGLLs8dfNA9reg==
X-Received: by 2002:a17:902:cec4:b0:275:2328:5d3e with SMTP id d9443c01a7336-275232861e2mr82210535ad.18.1758556426155;
        Mon, 22 Sep 2025 08:53:46 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:3d9f:679e:4ddb:a104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bf96sm133924265ad.38.2025.09.22.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:53:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Victoria Milhoan (b42089)" <vicki.milhoan@freescale.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Dan Douglass <dan.douglass@nxp.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] crypto: caam: Add check for kcalloc() in test_len()
Date: Mon, 22 Sep 2025 23:53:22 +0800
Message-ID: <20250922155322.1825714-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing the buffer to rng->read().

Fixes: 2be0d806e25e ("crypto: caam - add a test for the RNG")
Cc: stable@vger.kernel.org
---
changelog:
v2:
- Return -ENOMEM directly on allocation failure.

Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/caam/caamrng.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index b3d14a7f4dd1..357860ee532c 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -182,6 +182,9 @@ static inline void test_len(struct hwrng *rng, size_t len, bool wait)
 
 	buf = kcalloc(CAAM_RNG_MAX_FIFO_STORE_SIZE, sizeof(u8), GFP_KERNEL);
 
+	if (!buf) {
+		return -ENOMEM;
+	}
 	while (len > 0) {
 		read_len = rng->read(rng, buf, len, wait);
 
-- 
2.43.0


