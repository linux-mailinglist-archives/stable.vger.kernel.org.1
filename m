Return-Path: <stable+bounces-53658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E2C90DABB
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 19:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F01E1C23399
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D181304A3;
	Tue, 18 Jun 2024 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEuu1M3p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7A41C89
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731982; cv=none; b=n7CGvQiwOQrsXxECnTcWk5JWG7Rs09HA4aQPKjerGeIf8B0inbte3EXjNtAsINZsLyQhvw9kpJV9Pq+mc7yb5bSshMkgsHRIWID4fNKSkUmCKj0NkiWbobcR1V4H6wNGVyiDHE/y0VjpawvuBJDxGLA598wbshOVpsKalgzY9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731982; c=relaxed/simple;
	bh=bi6RNh9JfsVPs7IENa8E5Uat8mnMfqfyQxaw1R+dWWs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TE2Tj8rOkjDvzDhXjQhGMkVMsw73P9LlSGkAHS8ErMnej/UOzNVBTAEtaraUpkN5k0OsFEHIjxc84aiin5A1vhAFNUpTUn2jCe5SSP1mZUfZoY/+GvuixHwZFn579+Z4ye53bETuLnbz6mEokRSmp/RibKdqZjOBbgJyQGbeEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HEuu1M3p; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7048ac4dcc5so5446488b3a.2
        for <stable@vger.kernel.org>; Tue, 18 Jun 2024 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718731980; x=1719336780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XkZtxTGAqdMpO3B8tyKi0UZ95noOsm4AuSLJoecfARQ=;
        b=HEuu1M3pZhyxnP8Vb3buSSazWQw7HgKzcX9g9BMITDCeefbVCGN05MF3QoCcEX2Ucv
         gbW2hMBpIjTL3cQCY9yms/RjRbELLEOZFxiFaQEO1QyxZW5stkQVWfpLVgX4eXA3d5l9
         9/7fr016D7Tv2QIg26oNTvfZyNycRImhiGOa/FZsmamTSfdC+Ph94oSrr/l1T1qXUcSe
         Wcl65Rrt2QUlGpTf39cGS6WiQLvyu0TvOd4CchDeGVyqXCS2/G2A0n3Wxqh1xco5o7ps
         yCYeeP4lRz6vZrPkKMnrzU9+j6cCkWDc2nv4cwip58UDvbgWAVN4cr5j1dwl5hQB4aAk
         K7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718731980; x=1719336780;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkZtxTGAqdMpO3B8tyKi0UZ95noOsm4AuSLJoecfARQ=;
        b=i3qccO0vZZBhT3ALvqmMBu1yUAeEQ28kOzYzII00yihGLgYSBqqWTTcTWainI+YvYS
         PjYENR15gEu8X4yqMxkncN7Ac/8a6Uw1YL4/3h+atcEy/sPOO1cGmfgTiZe+w/K6SwcS
         EyC0hOw6sIE2ebwKbbN4O5ThRLRkGNc7HowA4aRUaPeG35kMFylo6Uj6M114qjcWeV4u
         sVWg/GK0gwq6+ViIHRnW8+RQn3mQ9Tk9otyqmLOM3YtrIaSmsBe8N8siEZJKEO5BpD6S
         XpKFRN/zZDLjYvNro/WMvXed6TsN6IXed3TcT7tfm+5FGiE+SfGM2MDp1pEATSbG8D+b
         EVyQ==
X-Gm-Message-State: AOJu0YwnxU2u1H4bwcO6bFP3vG82/7P9jjEWxPADVOPzhgr/WGX0cH/H
	fnH2jESMnOMLJBOK0siVe5hkTRiTlgzz48+ghKy3m9l8y9R2ZGKS0PojdGC1n254/yCZB/ik4OP
	yukqQ8k6sJdRab0Tm8Rb0R7+q+tLyqM3jlyGk8x/C+J/X5oavFCo6P8zidt9pZMz/egqgPNxeOY
	Owrci9r2YeR6ew3A97JVN+XoifA2h1mLAiZbLuUy1gbg8=
X-Google-Smtp-Source: AGHT+IHbnwaUeZudorMQa+MKBql+fblg+60d5bTcd7jTLf9+QS3jy8YHpRq75n/2zzP0ROKV5doZkOht16pusw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:4c0b:b0:705:a3bd:9af9 with SMTP
 id d2e1a72fcca58-70629b1f0f5mr1477b3a.0.1718731980069; Tue, 18 Jun 2024
 10:33:00 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:32:56 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240618173256.1116942-1-cmllamas@google.com>
Subject: [PATCH 5.4.y] hugetlb_encode.h: fix undefined behaviour (34 << 26)
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


