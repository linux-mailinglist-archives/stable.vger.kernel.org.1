Return-Path: <stable+bounces-180502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D4B84071
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 12:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F7D3AE92D
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 10:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B7B2F5467;
	Thu, 18 Sep 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRvvxQlM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A132F2914
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190545; cv=none; b=XOlBiGYXcOo0hWtlXtS7eHnvFhojw3UUBFqaV7RBBXc8fEXOWbDnpd59kk0Rgl4AZIqDrl9tDeSFwF17A9Fo7A7eIEphgHT7tsFZs36CVU/AkZlop2KtBNwmYYgupHhbs9qU4EEBPV24YSZqGM6QbEPgDdF1R0vJdDZYrhc6Oww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190545; c=relaxed/simple;
	bh=a5KnwUSk1PbWVS7mlC52gOqleynRC/2hkubAYqM6uOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JIsifRbhKHeWMKF9xnK3caL6kzomsvx0p+KZwTS8BpaZfReO5l+PwadIKxzZz0WjBl47fdRKZQnaGXKVgAalemX++/HeekC5iM/eVua1/Sg05MJ5mvnS2ez19rnf8GtbtA6AvnSpBRCpkuDtxRHKW2OgioYU6ZZXJoCmYTsk2M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRvvxQlM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77d94c6562fso389734b3a.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758190543; x=1758795343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ul8ElkgeTFthD1gCeDvetsXA/BGz8nMUUjjJgS8RCvM=;
        b=QRvvxQlMTgmOQveuVYZR0m7E+KUESnOo2MdlzhZ+kFxcCd0k08SiZqj/BVge0KC0Gy
         Koep0aQP/rQTAjGtTMLcz0ppDXQbzBeLtAKoYA0mdhVsYYqffCVlXFGryfpDjBrv4jqC
         NqBLLa6rzzMXnMH6OGthoYkJvuxkmqi97+dimLq/7i1kfG10XaW59F8q99QWRTGm66sq
         Pr5dsTn0+O49ki69J1ZFWLhukiR2Er8z1e9CVeT2l7BQXSuRbyYd9le2EoAoLI2033SG
         18Ao/H8+Mucqaiz0ig3u7GEBhfDll3b0jN/PsfCsYHvxfVGKNw2s7/lF1Lp0m5cLHMRu
         FK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758190543; x=1758795343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ul8ElkgeTFthD1gCeDvetsXA/BGz8nMUUjjJgS8RCvM=;
        b=SpEAtiRLkHhv/K2vNQ73qKbc7SsX1BYILdILtFyhbk2CZmkenSYcvrR2hx6gDcoQGa
         oVzoJ1l1sZGYREPZVavPaQCLhe71XjGCCTZqu7T2prdko8uHNgLarESr99BFk3SIcpb5
         5GzEI3G98ZdEERgnkmlgtePLRvo0yhdnj6NJfb5JCajLy6HL8UyRXc6ojna18blRPTiv
         EUEEnegZ0uDAbRP0oBNX7XsEkoZYhnWkNT8aaY/Pk/RlTO1FEJldb2EzqVlNnAPVsVBL
         jksOnRL6F3ZvsUWPQzM6rEROoBvgcEtX8bNdg9Wd3X09fQIr40QACSLItmGDDVwvhyOQ
         2GOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMXJXoXyiD/B/MZvyWu549KLQ5lz3J3/0v4coxTLZq4gJPQj5lcEcQ9WQxfiWjhN3WxWCNkbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmN/lwZkqJUeODLBSAr0W2Fw1RHaghjSVPZFxXZWoOlyLNs3aG
	MgQGZdNATfA6KMy+INfupv/qleqOZZ293ypEnTEgvm2QhhWdLlmlXzqLLvQnFfW4ZoE=
X-Gm-Gg: ASbGnctiJvff4Eb5i3dWsitpNoumOKXpwk8CBDTZAIIMvkP+JwJZo+4+8V2LdNaNnPI
	m/R8G3oYkrq7g/NrW/bUIvkgpNxxoSyOmWfzXNf3QCz11xfBD9owx4iwC3cBL3wTAu3cJivENEG
	xyYhZ7VBuOuYcTXJ1DR5Xr6kNLDRoSE9B3hbMo1+s4t+/9V33ArZEDghp43J/Ias15mQ6lRUJJH
	+LbyxR2Ob8grT6CkKmXOTd+KScugMu3BaMY7gzsPNESvg/yt98EQm52cjC96QblY5qEOLpLKVw/
	kQI7IvthJxk81VcpAArjZ9Dk2rizHnkJPts8hMdTVI//uk49/9h9GuLTOKfSeuJH/kIBskBY1cR
	CnbpJ2BIzW6qUr+UvWvnAz0yPi3DlHuQyqtReEH0=
X-Google-Smtp-Source: AGHT+IEh098LpUQZCcn5N0gPt1Pj74yLqq4l/+KzbDeFs5lavn9UHh3TfGQl7xx/Rwo1+Q0mJENLyg==
X-Received: by 2002:a05:6a20:12ca:b0:24f:f79d:6696 with SMTP id adf61e73a8af0-27a9a7e77eemr8131532637.2.1758190542727;
        Thu, 18 Sep 2025 03:15:42 -0700 (PDT)
Received: from lgs.. ([223.80.110.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32edd97fe58sm4740780a91.13.2025.09.18.03.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:15:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Douglass <dan.douglass@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: caam: Add check for kcalloc() in test_len()
Date: Thu, 18 Sep 2025 18:15:27 +0800
Message-ID: <20250918101527.3458436-1-lgs201920130244@gmail.com>
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
 drivers/crypto/caam/caamrng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index e0adb326f496..d887ecf6f99d 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -183,7 +183,6 @@ static inline void test_len(struct hwrng *rng, size_t len, bool wait)
 	buf = kcalloc(CAAM_RNG_MAX_FIFO_STORE_SIZE, sizeof(u8), GFP_KERNEL);
 
 	if (!buf) {
-		dev_err(dev, "RNG buffer allocation failed\n");
 		return;
 	}
 	while (len > 0) {
-- 
2.43.0


