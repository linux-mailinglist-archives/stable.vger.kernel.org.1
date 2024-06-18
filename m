Return-Path: <stable+bounces-53657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA26790DAA2
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 19:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D331C23174
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0B1E480;
	Tue, 18 Jun 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0w0DCell"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8279FD
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731845; cv=none; b=MJUVnEEXVbHu3sy8UyBFgr2ZoPRw4e6PgD4XBKmEh9GmdRwUxkWi/J9TpU/mJI1vWiEJJ0cV9KMmilw7RiBKTmx+WARRrDN1G7FrtU910yBPEfC+t68IxkI9d9YeHogusfzyefbZKjlb2bcRkmMG/mXY93vaJ/XD7k/OwygLK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731845; c=relaxed/simple;
	bh=bi6RNh9JfsVPs7IENa8E5Uat8mnMfqfyQxaw1R+dWWs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P95zqOhLbUxoOamZCrrZl+ncfiTGEs0pZ8J9Kxvj9ldDujlCvQZ5XQklMgD0ajCCAy79XrbXZLJkBpckS1q/MV5WtGCHyXLz9c0jNpz9jHAAC/pnTDgcQ6igiM51TQNImHGI+vejHLBqUdd9PQFMlFBuWOgFeDIwTwZdhCOL6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0w0DCell; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f682664703so74303845ad.1
        for <stable@vger.kernel.org>; Tue, 18 Jun 2024 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718731843; x=1719336643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XkZtxTGAqdMpO3B8tyKi0UZ95noOsm4AuSLJoecfARQ=;
        b=0w0DCellpy1p2RscMgN1xl6PVzIsE9vONpUurWVQsPW9MCpBYLEMoDY+zCm7dKvQed
         4PW7gAHT1TKC1hrlTBjqmiZ/XerBSNElEwncKRjEbwxkKMApQpXWayOo4gzWk4FdD/ic
         IvpPvq/8t4Ue6Ymp6cQ33eWJQ042ekMUWAyZhgakXBPSQNfrzhtfYCXLTPs+G4Nn7FX1
         xXzheUOhIyimEuw1Nfpcs2KSZdika3rgRowTqkL9uORGuQFU/P+jy72mV2p/rzYouT/c
         OYw6b03myP8lpOgvvGXBS8rXJbjFDqVAKInmL77LnKQSBt9sfO/KFPZUAUFI4BMPqJGx
         pffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718731843; x=1719336643;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkZtxTGAqdMpO3B8tyKi0UZ95noOsm4AuSLJoecfARQ=;
        b=krxf5H1toUXQQazSEVNXKQTFL/2yE0qgK43nvGwkMhweuNDFxaEHeAFFUdlBwTaCF1
         iJY36t2pItoAWZPTZoLyx8MtUt4vyQ8z5idCHMAAo5H02+aHm/wpSlBkw38y5XFvWZY1
         rW8CDuVs/4JAOc73KuirQVPCsijNhMiZPFYNSQN8I7hDxCoevReh4SDA31lwhaapidNz
         WULtRM/NEUTwRbjsYAVZfOl+t9vCSvMcFZRjvVKlSsJO91enHKxi+GaLo0lFyJomsiVy
         yaK/0DFKeFr7BWWrxmOIcacGSgdN0llWBlPAxwYFTUuIEGY+LTZw5nrcGrOP+syPraYE
         uiGw==
X-Gm-Message-State: AOJu0Yym1ze2LpnQhWxu1f8OUcX1dPOdKBg8dqVyDHwtaU1yN5XdSkZ2
	YKIMdS7WHrFs7uPPt0kP25svpIbhNlyLUYY5fnP9hR2dtY7OM5pN5Aoj5wZ/ERTnGUnAJqcgclH
	LL/z/za4E8JeNZ0Z1IP2O71U3mE6XvdwkHtGNQceMtA4FZy0bX1NNr3C7N3umv9wuWG+NDy+zK6
	eX31ByvZdxu/pzwE835YtQSqH3jbFvfvOUtpPxtSaa/HI=
X-Google-Smtp-Source: AGHT+IEl2l9AfS57tcBoEOiLtz9+pPk/pWOcLBn33AB+YdRg6QTBCuH6ec/HS57T+br9aMDRDy2fwjPRYsB8/g==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:ea0a:b0:1f7:37f:7297 with SMTP id
 d9443c01a7336-1f9aa44c876mr8425ad.9.1718731842772; Tue, 18 Jun 2024 10:30:42
 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:30:28 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240618173028.1115998-1-cmllamas@google.com>
Subject: [PATCH 4.19.y] hugetlb_encode.h: fix undefined behaviour (34 << 26)
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Matthias Goergens <matthias.goergens@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Matthias Goergens <matthias.goergens@gmail.com>

commit 710bb68c2e3a24512e2d2bae470960d7488e97b1 upstream.

Left-shifting past the size of your datatype is undefined behaviour in C.
The literal 34 gets the type `int`, and that one is not big enough to be
left shifted by 26 bits.

An `unsigned` is long enough (on any machine that has at least 32 bits for
their ints.)

For uniformity, we mark all the literals as unsigned.  But it's only
really needed for HUGETLB_FLAG_ENCODE_16GB.

Thanks to Randy Dunlap for an initial review and suggestion.

Link: https://lkml.kernel.org/r/20220905031904.150925-1-matthias.goergens@gmail.com
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[cmllamas: fix trivial conflict due to missing page encondigs]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 include/uapi/asm-generic/hugetlb_encode.h  | 24 +++++++++++-----------
 tools/include/asm-generic/hugetlb_encode.h | 20 +++++++++---------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/uapi/asm-generic/hugetlb_encode.h b/include/uapi/asm-generic/hugetlb_encode.h
index b0f8e87235bd..14a3aacfca4a 100644
--- a/include/uapi/asm-generic/hugetlb_encode.h
+++ b/include/uapi/asm-generic/hugetlb_encode.h
@@ -20,17 +20,17 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
-#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_32MB	(25 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_64KB	(16U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512KB	(19U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1MB		(20U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2MB		(21U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_8MB		(23U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16MB	(24U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_32MB	(25U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_256MB	(28U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512MB	(29U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1GB		(30U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2GB		(31U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16GB	(34U << HUGETLB_FLAG_ENCODE_SHIFT)
 
 #endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
diff --git a/tools/include/asm-generic/hugetlb_encode.h b/tools/include/asm-generic/hugetlb_encode.h
index e4732d3c2998..9d279fa4c36f 100644
--- a/tools/include/asm-generic/hugetlb_encode.h
+++ b/tools/include/asm-generic/hugetlb_encode.h
@@ -20,15 +20,15 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
-#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_64KB	(16U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512KB	(19U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1MB		(20U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2MB		(21U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_8MB		(23U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16MB	(24U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_256MB	(28U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1GB		(30U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2GB		(31U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16GB	(34U << HUGETLB_FLAG_ENCODE_SHIFT)
 
 #endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
-- 
2.45.2.741.gdbec12cfda-goog


