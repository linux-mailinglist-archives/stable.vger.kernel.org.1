Return-Path: <stable+bounces-189763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0241FC0A54E
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 10:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D663AE13A
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB0328A3F2;
	Sun, 26 Oct 2025 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF4AZV6m"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6E2273809
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470050; cv=none; b=faHWQv6atsJNPEVStFv5nfrq7FF0ztq+C8P/xVga+//Fhy/f69RQXuF4X0DoArWcDMH50z3b6d6syotvlFrE0d7JI4ZsrT/IYXq+39UDXVxtmneg0MeJnQayo0TSUEmndY2Lx93ImaLqQRR950X7D3geYTrM7IMUTJsUslX/Ang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470050; c=relaxed/simple;
	bh=yYW/ak1UJm3E5gbSPOy3veYjolaLM2LzMiaO2+3Xn2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HMXRrfwnOx/qBw6ztkhUuYtAsQZXRDaPW9Lyh3gtUItB9krDya+vw8HMNv68C+TXlISR+TqdRQGz2WsQMEE1G3M5iJhu+LQBC92E5BiFeDkm+jjkrd8XlCq7hlcmY+yKnMWggn5G8B1KTEd82q4jGK2F+5GA0zLYcS+FkCGi8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF4AZV6m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2907948c1d2so37628215ad.3
        for <stable@vger.kernel.org>; Sun, 26 Oct 2025 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761470047; x=1762074847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QKaKeVhm5UnUNE6DNnz1ldVsC0c/aJHI3r3WJDhZOKs=;
        b=kF4AZV6m1tneegcMM2wixBcccRSfwk5zcS/uYPlAqNsYE/vddP4wYRrK6siY064vRJ
         loyTut8uMFLWYzACAo1NQfY+sm/r0KNI1Y5mUUshvnm7SFVcnaVN7GuNRP/NI4UY6uCM
         M4vVrnFzrqnDF7lpj31GH5+8L5f5uaiI+N7rDaVJuiGwQve8BEJUb8zfroq2CXoSAisB
         RYV3Jpb4ZVbxHjYyf3P7ickYXHZfvTHKn8AFxbVsLgTAUx6p1hR+Jxz98iKenZ3TGAFj
         0Azp3fmNunv94+5+6SsDLAwMdf+dGRp0tFRP8pUF09nSIhGD4qE4EF2IZ4FUeHFoDQzG
         EexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761470047; x=1762074847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKaKeVhm5UnUNE6DNnz1ldVsC0c/aJHI3r3WJDhZOKs=;
        b=VIHQr886Gem/dFSOsPtc2PbzxoIdCSftMH7jWyUfAbJA4ukFA0vPb0O+OKx10S5F5m
         ALDDku/h0qWeRJy3SN/VpbnXnwFkv3WomBsljTxFm4wGHn9KFFssrvD8lLqcWJxCfTvN
         kHWAdcNrGmyb7AnWfbMNGCQOxvcmJiEtDkOddTLKtPjOXk0wrBltBOFABWGEAN77F7od
         EmGb58M1mDccO5+LSZJ0RwU+cIgFEaqCSPVUFe/JoogT8Y+4mg2ZpO7ZaMJBz3fVkcX2
         7KHTswN3/bZm/GkC8Su9V0jBzZm6o6pfIHGj2RkpByNNcTMu3aDXRgBRF7D1ziPPsPuS
         y0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkeLjBBpiXQKsZ9dE0bZWwuZRDO3DlNPjwRv84P4PN8EY6D/6PgTBrU1wZGzoa1SREQgPaMHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWf3mSkj9i2qYWpVV42+4ukQDlYHXtuObxyYqW9d74NdKPSNNe
	v2ly+ri8FBDedlvEsuzI3cTjha/MOzCz6jS/rILcUHlv5NXaU4JmdiwP
X-Gm-Gg: ASbGncvYi7kg25FRCvVPV8fbxJl3bJcaDs7Af59ofpHoz//2wHidQrjML/NDDnZOUI3
	BAFP1LcCU3GSJtqgU4cwm8Id1Mol7PG/j/N7RqU/4aNFWJtZSXSXGXRGdIkyi95WUKLWxwZZOcF
	zkWAnMyHhEzBQK7XLJw6M5P/Rp3tNHiIV+uCY9gV8Y339FFMcdwFISr4DJhbaHH78PDPF1PK1O8
	N1Bn83EGXwsouAYBSdlwU/fS7dCrgsBTuXeuZrFnaVSCkkPqDblHcew0ubhvNR4iF6pO3V6DwGC
	qPwrSdnJKR+AzTIue32c/LH8ScMBLrmujuaXzYsgxGFb5b2OimcjHSJmbM3ib977eCGkNee6W9l
	ft1ZzuCt1t12Llc+EaM1JO5/ms6aAiIg1bbQGWpeU+Tsss6X4/UFCB8u4BByGdof5zj16++CQ9m
	7XIm6fv0Qi8/0PhRGgDcsu2A==
X-Google-Smtp-Source: AGHT+IEe619zwvr7QyCnZh0FhG1JilOPvnQxrGb0fx5QjWMkrsvOWzzaRjQT6fRCzSTx06geLcWkig==
X-Received: by 2002:a17:903:32ce:b0:290:b928:cf3d with SMTP id d9443c01a7336-2946e299a01mr162561475ad.59.1761470046967;
        Sun, 26 Oct 2025 02:14:06 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fed739b81sm4732043a91.6.2025.10.26.02.14.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 02:14:06 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] s390/mm: Fix memory leak in add_marker() when kvrealloc fails
Date: Sun, 26 Oct 2025 17:13:51 +0800
Message-Id: <20251026091351.36275-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kvrealloc() fails, the original markers memory is leaked
because the function directly assigns the NULL to the markers pointer,
losing the reference to the original memory.

As a result, the kvfree() in pt_dump_init() ends up freeing NULL instead
of the previously allocated memory.

Fix this by using a temporary variable to store kvrealloc()'s return
value and only update the markers pointer on success.

Found via static anlaysis and this is similar to commit 42378a9ca553
("bpf, verifier: Fix memory leak in array reallocation for stack state")

Fixes: d0e7915d2ad3 ("s390/mm/ptdump: Generate address marker array dynamically")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/s390/mm/dump_pagetables.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 9af2aae0a515..0f2e0c93a1e0 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -291,16 +291,19 @@ static int ptdump_cmp(const void *a, const void *b)
 
 static int add_marker(unsigned long start, unsigned long end, const char *name)
 {
+	struct addr_marker *new_markers;
 	size_t oldsize, newsize;
 
 	oldsize = markers_cnt * sizeof(*markers);
 	newsize = oldsize + 2 * sizeof(*markers);
 	if (!oldsize)
-		markers = kvmalloc(newsize, GFP_KERNEL);
+		new_markers = kvmalloc(newsize, GFP_KERNEL);
 	else
-		markers = kvrealloc(markers, newsize, GFP_KERNEL);
-	if (!markers)
+		new_markers = kvrealloc(markers, newsize, GFP_KERNEL);
+	if (!new_markers)
 		goto error;
+
+	markers = new_markers;
 	markers[markers_cnt].is_start = 1;
 	markers[markers_cnt].start_address = start;
 	markers[markers_cnt].size = end - start;
-- 
2.39.5 (Apple Git-154)


