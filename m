Return-Path: <stable+bounces-106142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129249FCB50
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 15:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7E0161B75
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239FE1B87D6;
	Thu, 26 Dec 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdqqt5c5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB25185E53;
	Thu, 26 Dec 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735221819; cv=none; b=HR2bpdH9jWHXu9qGs7I2hT2ZV1pW3/10/hGQZucma0gRsPGrE+BBew1xgj8xrn8Blb+KsjmzMFI/bH7h7mkbNYmfwkRvCf8ir+Jk3NRhwK9mK1ZMDb7kScTmY0b2ub01fr0Y6nxjDELC4RgnUfosAZXlw0JJK9w+KaOEeyWuuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735221819; c=relaxed/simple;
	bh=rMXQCzx6Iq62cN2cfDkFLXhdBfqHQGFsw082FrMNcjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qLgtulT1iOrCbgiTET0NjUQJhf3+GRyzGaQWhKfUp4tHUlS94NjctApJMJT+LDGUfZPgwk4H8P1xgnaH5CU2XfsrpOy/b0fKZK4WpWZAmvvqx1z6BitDemjE6s7DwS3LY6NgBHeDVCfuwVztdiTM7X5TUHP1Egu1kZaYV8MuLfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tdqqt5c5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21670dce0a7so3551445ad.1;
        Thu, 26 Dec 2024 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735221818; x=1735826618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KpZCR6J820y8m+50W8figJvSeFwvKU/Et/UzonJZp/o=;
        b=Tdqqt5c50e+873oxUdk4UaKrYJ8oexT7aItkUZOO7Y8WSMFDhKVzrnrciFoflelgIR
         JBULI8oRklzGw0e6vxmNH82y46gJykJ3XV9aTZUldNALy8UPErQ8FHU5alah1svLtTCu
         8tYQ+bb79PnG0HxIVQJuy+7gcGC3C6Juc6kTaTROpfLZaD2ldqOcHS/6awdd8TjryI8w
         9SmOaqtCeDLstIGBMCZkm1E0f97+CmeM5+V1r947iLc70kicHZei80SBbHNAcp0rChfD
         T8vC4Mzz1z5at/bku1qbOCMcB/bOghRY+7X2vOZd7zi6CbAf7bdGgqV94N8UJcmdaR37
         hLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735221818; x=1735826618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpZCR6J820y8m+50W8figJvSeFwvKU/Et/UzonJZp/o=;
        b=CGhh3EL454sQM5nUFPTBsZiWdQRc/dkOJTxHOg9nVYMFrIds5yCQnE2lf56hFA2iDz
         oI1nixqVtgnwrhjMDlQXo2ikSut3LCuRePSoqYDA/aFjJV96RNCYiwPE52FVrqp/k9XI
         fCiO279VHRfAJF174udlt8dQj//r9lFeNOYil/bVyGrSwflhVXLMwOk5D2DMJUOd/e/N
         My8WstguPMmXlKobQ/hLaSJCQSsFy7lFzIn7O/mQFwFTF2Q6Y0RWU262JlIDLqepU6mo
         SiEqFWfqYQfiN9Lb3eEmtEAzes29/VaRikEjgFG+WgSFQar20bfApPt4OimCINAh55fl
         +/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ic7TyyK2Oocig7AcHYL21bV53rfESKpT4Bf9tOHp8iArSNKYv6N6CwpWUNl8OO1xpi4Cc3+F@vger.kernel.org, AJvYcCV2tvuXO7PdxWvUiyhCUrRK8tvaRn56I3mRUulosQ/W6gKyPI8paXUwjR0N9f/i5cdLo+bt5z3zvv1ckEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztSQP39fqcui6x5wCLitM/sYH4tnkDFs/Ov46fRPImzXQhSOgJ
	cu2SG1Dq/XlNV1joAJJufCuzN7NHswhovKK3WCPGpwR+yoR0HGLS6CRjWOxc
X-Gm-Gg: ASbGncs0cLhv7ssPgAz7IJ4OuNU8pjtKo0gca7Ilt+n374XyZo0G/4ovcGIjHoxKtz3
	UppaVSJLk12JLLf/RD3tRli4EqgTQPc0iddKwCUglgOOWt6ESL5oJIi9DKFlhWuV5U5QCpmyY9v
	GHPEz5rHG7b4c3DthraNBxz+RdmBKTw50SMjuPDSpOSWMi0tpaKfLXK2guP4kVIrilbw3m6IPA2
	mJBTRTao75zD+PpVyIeMb8Jkqb7wwXmLiAoeseadt0NIpsB2VQPm1sK1Po0cHACJNts1PClzJjZ
	KgSqDUmZ/5E=
X-Google-Smtp-Source: AGHT+IGNMWXcKjr21ZpBiDImQzLw3a4/VqYZMIkEj9+JhTq/EMf5c6SRvBAuY/iL8KYD1cvicK4esA==
X-Received: by 2002:a05:6a00:4486:b0:725:e015:908d with SMTP id d2e1a72fcca58-72abdd4f29cmr28116216b3a.1.1735221817667;
        Thu, 26 Dec 2024 06:03:37 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad836d22sm12912544b3a.77.2024.12.26.06.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 06:03:37 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org,
	shile.zhang@linux.alibaba.com,
	mingo@kernel.org,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scripts/sorttable: Fix orc_sort_cmp() to maintain symmetry and transitivity
Date: Thu, 26 Dec 2024 22:03:32 +0800
Message-Id: <20241226140332.2670689-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The orc_sort_cmp() function, used with qsort(), previously violated the
symmetry and transitivity rules required by the C standard.
Specifically, when both entries are ORC_TYPE_UNDEFINED, it could result
in both a < b and b < a, which breaks the required symmetry and
transitivity. This can lead to undefined behavior and incorrect sorting
results, potentially causing memory corruption in glibc
implementations [1].

Symmetry: If x < y, then y > x.
Transitivity: If x < y and y < z, then x < z.

Fix the comparison logic to return 0 when both entries are
ORC_TYPE_UNDEFINED, ensuring compliance with qsort() requirements.

Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
Fixes: 57fa18994285 ("scripts/sorttable: Implement build-time ORC unwind table sorting")
Fixes: fb799447ae29 ("x86,objtool: Split UNWIND_HINT_EMPTY in two")
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 scripts/sorttable.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 7bd0184380d3..a7c5445baf00 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -110,7 +110,7 @@ static inline unsigned long orc_ip(const int *ip)
 
 static int orc_sort_cmp(const void *_a, const void *_b)
 {
-	struct orc_entry *orc_a;
+	struct orc_entry *orc_a, *orc_b;
 	const int *a = g_orc_ip_table + *(int *)_a;
 	const int *b = g_orc_ip_table + *(int *)_b;
 	unsigned long a_val = orc_ip(a);
@@ -128,6 +128,9 @@ static int orc_sort_cmp(const void *_a, const void *_b)
 	 * whitelisted .o files which didn't get objtool generation.
 	 */
 	orc_a = g_orc_table + (a - g_orc_ip_table);
+	orc_b = g_orc_table + (b - g_orc_ip_table);
+	if (orc_a->type == ORC_TYPE_UNDEFINED && orc_b->type == ORC_TYPE_UNDEFINED)
+		return 0;
 	return orc_a->type == ORC_TYPE_UNDEFINED ? -1 : 1;
 }
 
-- 
2.34.1


