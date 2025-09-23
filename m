Return-Path: <stable+bounces-181482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAB5B95DD2
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9AF47AA19B
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00EA323F58;
	Tue, 23 Sep 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jruc0i+w"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14027F011
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631493; cv=none; b=IxyaIEqPIcq/rbZXNYygxWejmBSAOcwIoxSfNNjWFcFuxZfggTLZ13+BGHL9/F0ZPK2l2Wq8+EQzHHb7Ea7tOjYwlV8IhQvKQGquETORLuf3FDtaZqKozJyk2nMQlo+lWKMAX4IYjrEsBXnQbdGx+oOD7EG7sSPaYlPTAHdq7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631493; c=relaxed/simple;
	bh=X5SCAiSiPiJEcYEiOxRFI7I4FHTBz2CQgSgz4A8sfdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsZNi1n79NSXmCFiShTncVum5ulYGJ+GHWz0Ri5zc5aK0QrK0zjB6UZ86UkmDW74eQfKyCwX15+Am7eLKV2qEbVKxrS3mxp1Dt/E/yQ/9ByyFqkBMLj14cem6ETe8f6vTnHFnoj3wDQp81yYfxDcbBozeEzCiJvmAL86AK0Y130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jruc0i+w; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f0efd84abso2762301b3a.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758631491; x=1759236291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cgc0zGHjqKsb6Mzy0/R8YmRgjX+eUzNJLvWfwmfdlbw=;
        b=Jruc0i+wYSxjrQk6RIxskeS0j1RaZjlSXUnI5B9f7yoZ2k/KnOs2OGTIHy3Rht9kAt
         4g9he9H2+3sfbxI1yTldJgVU2a73bO/f0wUu1/NpxjCpXd6v8ujvRyEK0dFdCS5l77Q5
         cKUlBVoPEtUeo+8BHKKVsA8lBCjgcHs9IZPkHRWfX/4yEO37UyJjMD0bzljphwaVjJxb
         AijAVsv74PJgREEzt3LCdq+EmhXVnkb5OhQZ60i3MGzaiaj/VUUq3JXXI5KfvpCGZaSW
         x7VX5newM/msOWP67OX2rsB+nM1vAyT9EtlGUuos7Iu+a7B+B+yBNXI89C1kKdckUuQU
         eMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758631491; x=1759236291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgc0zGHjqKsb6Mzy0/R8YmRgjX+eUzNJLvWfwmfdlbw=;
        b=VTifh0lYHekKG04J7o+0ys1VNJCftCVteAyZU5wcTj5m3DtxglGUZgvHi3z94K0WQA
         Zrehh8QvbXDOfzim0/ctd8IC4FY7/kGyD92CkQBgTv77iuB7SJjYb3ju9/cD/8o8GNNg
         O+fZHgmPlzQT3zNa4yoHhQuFzrwQeQGwUy2AnOZIE/YdZGSFJM9HYLhruhFtSLuxQq1K
         ylbxIAsh3uBqGtYDK7NzESSLR/+XatLEPmF12I2PQsbAqYZStXSBF3wopg3yRZH4EmFP
         DLb+6WXpwaxnzJM3ASy0F6OEh7w9OhEW8hhzN6kpF6nHkNSidI+lH4FJDPw8+gyidvME
         ws7A==
X-Forwarded-Encrypted: i=1; AJvYcCWGQmjQAnELkCm3ZNwgoIhRjYwWg3ID49x4/VfapZxrDb6muD32M3FUYPFwBgYypi66MT54zew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4uP+YPHL6Acr1K7gGEdtv0ftCyUn5/FGj5+X/pYBP3OKx9PxH
	8qFWT5QBSSup1pde9NXovilzILebKSH9qmZKNyhs2ofMR4/f4C5AbXHL
X-Gm-Gg: ASbGncuiTWc+N3EwF4QeBnWDhtjqf3sA0JrWyGxptg6dJAe9g6Aq+WN1ME2Yo/4A69h
	vg7afMsPhO2ms4GCybxHPywUUx14OlnOtD34D7TrvtWls+wlGiy2/Qxtixs/qVGWrT4G/fOcQK9
	G8AsjIvyZB6AhpOAjljZw0Ny5v6JYtnMGK9RDaeXoATehq3FdAfVYDNSu9fnXF0kwkGctRsuaE3
	BSDkBR/a/f9Mexc30t/YS/2Obb/2V5xU5tfR5cDsUOquC9vlekAMYZO1/IoZsDpIeBdXIsqZVXR
	783f5ji5+5Oa28H4p8KxS048qiqylVsT0vWrWnkvquFNgIHLI3ve7LRTYsBKb1rPJvZhGLGC2nt
	XoGyx5ISneR91tzB/UybRnco=
X-Google-Smtp-Source: AGHT+IF+Z+DXFn3bgpMwnAWPeSbLtcvFzn5fzKbQO8Hcx6cZEpx6vf9Jd5Y5Z7nnPoPYPWpaRcohgQ==
X-Received: by 2002:a05:6a21:3398:b0:24d:38c:26bd with SMTP id adf61e73a8af0-2cffb042180mr4007968637.43.1758631491539;
        Tue, 23 Sep 2025 05:44:51 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:4f2e:20bc:b03d:e78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b553a0a8270sm8354998a12.17.2025.09.23.05.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:44:51 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Victoria Milhoan (b42089)" <vicki.milhoan@freescale.com>,
	Dan Douglass <dan.douglass@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] crypto: caam: Add check for kcalloc() in test_len()
Date: Tue, 23 Sep 2025 20:44:18 +0800
Message-ID: <20250923124418.1857922-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing the buffer to rng->read(). On allocation
failure, log the error and return since test_len() returns void.

Fixes: 2be0d806e25e ("crypto: caam - add a test for the RNG")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
changelog:
v3:
- Fix build error: test_len() returns void; return without a value.
- No functional changes beyond the allocation failure path.

v2:
- Return on allocation failure to avoid possible NULL dereference.
---
 drivers/crypto/caam/caamrng.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index b3d14a7f4dd1..0eb43c862516 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -181,7 +181,9 @@ static inline void test_len(struct hwrng *rng, size_t len, bool wait)
 	struct device *dev = ctx->ctrldev;
 
 	buf = kcalloc(CAAM_RNG_MAX_FIFO_STORE_SIZE, sizeof(u8), GFP_KERNEL);
-
+	if (!buf) {
+		return;
+	}
 	while (len > 0) {
 		read_len = rng->read(rng, buf, len, wait);
 
-- 
2.43.0


