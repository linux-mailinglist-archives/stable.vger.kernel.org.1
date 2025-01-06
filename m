Return-Path: <stable+bounces-107744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A4A02F5B
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 18:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07877164009
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3132B149DF4;
	Mon,  6 Jan 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muNGjaRG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B086354
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186265; cv=none; b=QNrv/goSMSmsEfSwj29lVGLRjNy7qv3wTQq/g/p6O4EdaH8SRCW9VwPR3rfbTtGEfQQdTGPtVXsq3MhLBaRo59iWS+vml5t/56S8XiYzeadYdUPuyb1E85476aM/Oz5MDOy7WF/Vvw/P7zdKFmVL5FwCv3SLncdd2/VrZ1tP+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186265; c=relaxed/simple;
	bh=R4JQOtYlTUFajzbV7YyIQKl3143V78VG1JS3NLsDLqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fj/rg1raT7heotXN7piHhFBfldC58aHsUNt6ntBiqgoCa0+3KkbN3Ukb63NALLtyyBmInLDn4OC1K65aT4eyq1s4+19OJV+dGfXDf8ir5T00eL/5kJYpvbxGyRzqMh3ZsUqfJBUxoW8CgUr7IaZacZtY8uag8RSifIZFw+rTTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muNGjaRG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166f1e589cso256875525ad.3
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 09:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736186262; x=1736791062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRPyFEKrFrH1a00CfMb2ahbedqviTeRDw5NY0cno9i8=;
        b=muNGjaRG9kMIhViWPwJvzypkYaCC/H0HEc03LrcKbbMaJvBjUpx1TnqMPwaIQW0zr3
         CVuAWoQcSjybbU32JeWCXF8DOH5K26NU0pFs83FFO9fNDtpR5v9o7Wy18ffNPs2jYXI0
         7yNsNlzlh7CRX87r6CQDlpOtRl3B+s9IGVrV80/SXDKuW6lqCdWKvegqHJAx8AHNZV9i
         ehV30mgVnQhGV7yWjvev77RB6QoLY+2y5jR/zOaQxOIwap+Kefcwe6K7esGmmOlyWko0
         9AaLxhl0LwiuumAu3mElmnaNxtYitRenzG3GlweWNK9FeEsCDCO+/cGchd63JqKIvSp/
         JMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736186262; x=1736791062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRPyFEKrFrH1a00CfMb2ahbedqviTeRDw5NY0cno9i8=;
        b=L+YdKyCo3S69fFAPvq+GkZtmbjAAuUdpLUVW1f3pI0j7zVn/0hnu5ALW+6awVkCMd/
         jzKk+QjanA8LYIMU80c8TGVs+4f7BKcVl+foH/Pre1/bSj0FBn6dBjgrlwaojZ0siNnq
         R1Jb3TQl0jFEBr0sEb6R1hBQwug/nBpTM7AvKhQS+BdxU8/MUCzwmzsy+RTZR5ZEx07z
         K26kMTHiF+ceUkdUVcJCkkZ0dqMXT0R1xNp3N6WvM7+DIKCy4ihcOIAo1/mkANhAjlzm
         oBKsojbwtvvh1baY4H5RFLT/fapTYPflVSeVy4wxrnbFBtsDihZf4Zr/VVB1VlnfR9Mt
         o7SA==
X-Gm-Message-State: AOJu0YwBo9ID0sO/OyRlf5zUcUADiC6g9AoW83dQ3GKjBAH6fQjzViPz
	s/UMFMbfwkYheaU+0Y8Q9qpKJo7m6V8eg/RdWPJn6DFV+JIqCfD1ekPzzj0q
X-Gm-Gg: ASbGncsCjM42YZqtB9sVZWvzAsrwrO62f3i9fbTtY2xnRjuTzXQTc3QqLRS8xFedeMi
	R8WzLN0lpHzi12KoJ7BMlb1iDxK2ylfAhLPnLAUxJBXZNRi03+wWPPE/yRJTtpm6t/I53dp5d2v
	KWgwX41wMcJH38fKct6Jg3dWXMyVPgTFQh/NHPdblPykh+RyCNHBFkAqtiYHuJJgRlCv5on0q44
	KLnwKZL3Z3erm3/fk4RyXE3HPaKDOzEFSDBQqtvfvTa/cCojoal45zZqhw6+TTDHSO8H0wbUYJn
	/7dMDgGYJt8=
X-Google-Smtp-Source: AGHT+IF9RxByvW6M4Ah4zdeIypROpuciGt4gOphc5vGCgJPs0kiV2APkcG0Edkc9o8y7KvFrOJZ23Q==
X-Received: by 2002:a17:902:e946:b0:216:281f:820d with SMTP id d9443c01a7336-219e6e8c7abmr912291345ad.11.1736186262226;
        Mon, 06 Jan 2025 09:57:42 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962d15sm296494905ad.11.2025.01.06.09.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 09:57:41 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	chuang@cs.nycu.edu.tw,
	Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shile Zhang <shile.zhang@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10.y] scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity
Date: Tue,  7 Jan 2025 01:57:31 +0800
Message-Id: <20250106175731.3308310-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The orc_sort_cmp() function, used with qsort(), previously violated the
symmetry and transitivity rules required by the C standard.  Specifically,
when both entries are ORC_REG_UNDEFINED, it could result in both a < b
and b < a, which breaks the required symmetry and transitivity.  This can
lead to undefined behavior and incorrect sorting results, potentially
causing memory corruption in glibc implementations [1].

Symmetry: If x < y, then y > x.
Transitivity: If x < y and y < z, then x < z.

Fix the comparison logic to return 0 when both entries are
ORC_REG_UNDEFINED, ensuring compliance with qsort() requirements.

Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
Link: https://lkml.kernel.org/r/20241226140332.2670689-1-visitorckw@gmail.com
Fixes: 57fa18994285 ("scripts/sorttable: Implement build-time ORC unwind table sorting")
Fixes: fb799447ae29 ("x86,objtool: Split UNWIND_HINT_EMPTY in two")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
Cc: <chuang@cs.nycu.edu.tw>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shile Zhang <shile.zhang@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 0210d251162f4033350a94a43f95b1c39ec84a90)
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 scripts/sorttable.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a2baa2fefb13..fb385d0f3cc2 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -103,7 +103,7 @@ static inline unsigned long orc_ip(const int *ip)
 
 static int orc_sort_cmp(const void *_a, const void *_b)
 {
-	struct orc_entry *orc_a;
+	struct orc_entry *orc_a, *orc_b;
 	const int *a = g_orc_ip_table + *(int *)_a;
 	const int *b = g_orc_ip_table + *(int *)_b;
 	unsigned long a_val = orc_ip(a);
@@ -120,8 +120,12 @@ static int orc_sort_cmp(const void *_a, const void *_b)
 	 * These terminator entries exist to handle any gaps created by
 	 * whitelisted .o files which didn't get objtool generation.
 	 */
-	orc_a = g_orc_table + (a - g_orc_ip_table);
-	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
+ 	orc_a = g_orc_table + (a - g_orc_ip_table);
+	orc_b = g_orc_table + (b - g_orc_ip_table);
+	if (orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end &&
+	    orc_b->sp_reg == ORC_REG_UNDEFINED && !orc_b->end)
+		return 0;
+ 	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
 }
 
 static void *sort_orctable(void *arg)
-- 
2.34.1


