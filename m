Return-Path: <stable+bounces-180521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 679C2B84B28
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209A01C2128B
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4F930507B;
	Thu, 18 Sep 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuhjaPrb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3562FDC24
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200144; cv=none; b=kSxSm/Q8o/+gxVildegWU7sAH/ccuSvV+M5G1UslRiqx/eRFWZ5b7pmbu4G6izZAKJe2NN5aIXZys8atOo2rGtFuyJvTfspHlWwVMAGVx3LNy566bBEb5CYm859xXki6N5QG6ZLfdOng/XkEODNw2VJ0SZDjWjHds5WOSSBiplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200144; c=relaxed/simple;
	bh=SId3DB5hqfnfahVT0z34tvWymLGz7H03e4wdeT2fwQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNZlKQkinG56aCGr1HAfIc0t5PVC2iv93C5T8EuXLSN5/J8NwL3paAieHTCV5ZuygVXQz9d3okXP3E/NqYbOTM5wWRC6mcjYbLLE7fsLQEOCxlLrAAkYpwWpmqPzwNJiUzBQoT8rqbO/ADK//fM/74U8k2PbmJUqVbzGUyJwGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuhjaPrb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445826fd9dso10873375ad.3
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758200142; x=1758804942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PMaQk64QLYvKLuvrIkNRq4RT2wpYqM3eFsm/MQrmOQ=;
        b=fuhjaPrbuoIv45XY64mm9g32pBv/ambHaaS5mOj+rNyjBG3dRHCuS+peMpVtcHwaST
         SLZCqefArI120NYYln/AEzKiQACWkN6OwINyPYQr8QT+WeLvldNHmDFPkXkPl564bCud
         jzSugu0a3EXhNMpAIZs1aDvProQQftvS/qE86jzuQEAgd2bKwfkqROH6MDxYE6ajH08S
         34o9fqu1StPte21yqKQnni1dGoRcAAeEGDwqwrJ0626APmOkujdIbh8/NNdegW9rcMP9
         u7Tg096Izi40mw4GG7jDEAOasxiVAM488zgNUsoFu1dVVh0lYYB5MEzrRjdOrgmj/Gz9
         y/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200142; x=1758804942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PMaQk64QLYvKLuvrIkNRq4RT2wpYqM3eFsm/MQrmOQ=;
        b=ee+ZO6XKEQeVse1jl8Pn9PFWYwrJGNi4RBwdJvjTy++o5yfEwwukXwd6AXt+iBFe7C
         9SU96/19h4sMNVjJ8TJBgRQtK7xDZ+L1z+G58MDBrP2G7zTjEe8qwSUp3hUcF5arvfTR
         EbUob+52I/gdn4OJuiE/l4+2p7WH6I6DDzY2YwfFpcn4MPCghLGgw4u++3TlavaENX8V
         Cbze1fI5gXXPBRpyDaMHF22OROFrTMDB3y6ImMI1FleWQic4vJLgqCFehOTERh4OmdE5
         SgaEMXLXFiSn+hEHVlDSV3dqaikZpn9cSdrsUkRdzcq8cWvHIYJuRhg0I+zVBNVS9yGv
         5jrg==
X-Forwarded-Encrypted: i=1; AJvYcCX/4xV3MR8ig2aM2BoQcr67WOSMam+zoeN4HpIVhiZNSa9HHRfEVjyjUbHUSyOdAtij2daG12Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YybsvCeOAmVN6UuAGMF+W602ww+GzPMU/8F/UJFnX49RLsDRY4y
	qTNO1/YgQYAANqod5VZv3NpswSfbZ/TipZ+t+nC+YMzBuPgS+/nYTKic
X-Gm-Gg: ASbGncuWoquPzK5Dj/emion6WBg2fhUQfniGFQ/ciw2pohrpD7V0AUHy0Ftcieb/g32
	94YAlAZojiVRUMRy08wele+5Q08SPTLhRclAkfRTQCeQpwYVy2wrkqoCSzqxgAeg0YyNOYpbLfI
	tUOv6zn3jjHVUgT8fIHa6kZv8jXrjYk17wBA16kmFyPCroHtZ/a3GvOVAFYfAcKRRu7yGPUHxrK
	TfBcFObFM5tqWTiSSwpR4d1ioWuSIKkIRk1fBktVbSkOwmtOsWEaY1KHQG7asuOCMxNCbsHtaBW
	x+4GnT62BFejgvDC6h8gHQL4xTNkk5OQQAOiDKz5S4782BqV3APRA4lJk7/1BeEIWxol+twoFiP
	JJfX3Z36TLnR/wG4yUOL9CzIt8y9t+f+/kUmUjX78TuI=
X-Google-Smtp-Source: AGHT+IE4Evwn4n7oEvkfL06fZNeaCExpJfqe2hcm3yPgDmXEurhEs6dJZklynFlriLWZbAPRGw8rVg==
X-Received: by 2002:a17:902:d4cd:b0:246:d70e:ea82 with SMTP id d9443c01a7336-268119b2be6mr84670615ad.5.1758200142591;
        Thu, 18 Sep 2025 05:55:42 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:c81b:8d5e:98f2:8322])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c076sm25939065ad.42.2025.09.18.05.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:55:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Dan Douglass <dan.douglass@nxp.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: caam: Add check for kcalloc() in test_len()
Date: Thu, 18 Sep 2025 20:55:21 +0800
Message-ID: <20250918125521.3539255-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing the buffer to rng->read() and
print_hex_dump_debug().

Fixes: 2be0d806e25e ("crypto: caam - add a test for the RNG")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/caam/caamrng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index b3d14a7f4dd1..003c5e37acbe 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -181,7 +181,8 @@ static inline void test_len(struct hwrng *rng, size_t len, bool wait)
 	struct device *dev = ctx->ctrldev;
 
 	buf = kcalloc(CAAM_RNG_MAX_FIFO_STORE_SIZE, sizeof(u8), GFP_KERNEL);
-
+	if (!buf)
+		return;
 	while (len > 0) {
 		read_len = rng->read(rng, buf, len, wait);
 
-- 
2.43.0


