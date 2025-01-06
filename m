Return-Path: <stable+bounces-107742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9332A02F3A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 18:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B923A104D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB5F1DF269;
	Mon,  6 Jan 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9QP4Ns5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CD51DEFF1
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185547; cv=none; b=uQyzgPw46jn20rQSrBJXm58gWNmijAd22sUVDs0eN3AxwdTFI1Ymokh9LHEtUik84Ww0bmeszR/z03CxDlpN33NPtm17jC7SCqDwxOwDc1O1zK30xRfq+S2m0qg/3ae+eLOWIIztykTcJoKH19uxUDX6IJgxABYi8Xaol3CuiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185547; c=relaxed/simple;
	bh=0IC7yMFjZC8G+vkeou5M/K02sqJWzLSUoF/iPbgiDlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mKwDYZs4mjCeyXjYfgr3ZJqdEClC+xMYVtehCuqWrOcXgce/kDr60UFNGfeZeQdu2zXEYHbqcasOmMnBO0ubSXIRLlwZG9/8e8HR86tZQb6Ie6QDszX3KpjeGvX4fAlIcyFQ3KCAOKak+HZCZz3gd8lkAgdkzQgP6ZJQEQerVf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9QP4Ns5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee74291415so17236471a91.3
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 09:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736185544; x=1736790344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9slCdyJ1Dq49ypkOy6VrSFCrbQ2Jm984D2G96XSnD1E=;
        b=i9QP4Ns5nb05YoY9tIj+iP19lZrEeJ1tOdagNYJK89NmebNMi0xyiZt6lbtxNIs6mR
         B+OXE27b5nlG6vEAk5HJx4LMdlxmCsA8k1o8RhqSxMpcMO+K188yY65tL4IvYjUzhnXv
         CE6KTUsSoYXQW6ndQE1WhQGy56U7i2fbMJAOS7q9f/8J/gjkodgmxR/E0gURCCp6bs3B
         0B5Eqk/gbmZAAbOkzzhp5xmQ+Vfwb7rMMHV1t+WUC1GwRCCvyncl/Lj+o8YOWzkgNqkb
         ki6ddz1tCPDB9/4cZNpU3B/Fb2Xuw42p+XiGZ/BTeZRzcVOjdJMbiaCZkyB/m4ENHmQW
         tJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736185544; x=1736790344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9slCdyJ1Dq49ypkOy6VrSFCrbQ2Jm984D2G96XSnD1E=;
        b=Lnzfrlhl/8mmyHAmRoAfurvd6yt9eRGM2lcmP+XWVmRiYsvfvCEVwonv1vOPGyy3Rw
         rG8XyXDdDbKrjecl/Roge8VPEOxfiX5a3EcKmFzq5UwhBmKdpPw9rdgSE6nSOWctfMmI
         /P0zzYNn/dtLGKU33DvRR4mvf+cE2zbHZkd/lD5yo/511xK39xCYzT18jkS+LMpou8Lv
         ICcLIGILrCUItuNBCC9QOEjgq098Rpyz36bquLAIB1rTQ1j/VqPz+Lv+8C5FDcWUlRPY
         hyuqd8hrlaAzYDJ7xxSwl8MkzhVHT29rlkBo/N0BILb3iW/tmdvXGNJvnteV/CmxtjEp
         cjWQ==
X-Gm-Message-State: AOJu0YxL4Vn9ooTUpd23NkO8u+yeX2vZU32c1PhBi4qKZFwb9TK6ltr2
	hjMp8qpjRjrm+1dqCK20l9t3y1BrWloXwR/bsWA8XixIZdsjB+thpVZkrl+9
X-Gm-Gg: ASbGncvkUZiQYqY7sT2buV5DzW0VNi9Mh1yoOY5rUmhSXa8X/kDJe1hjIHgOOm3GTcM
	7gC5ObZox1Y1KWt2NptRxto47gI+rI+6hk4BTeBMSN0D7El3jNZ3ok61EdTvknbEyTXx0F4ndx8
	RiJhB+Jv/Q4IohHhi/pbONM/CmmDvr72dqwWtFrM97JHnLCA0Uz9vdLosBERKUfacTjhT1fS2vv
	nISkyhySb77p2b9q1KSQ4norHaPsfZWXsnd7GmbrwxNjUO7UhluqhWTN4Pd9MoTJu8oxE3h5NPi
	T/zbpuWoJtA=
X-Google-Smtp-Source: AGHT+IEYiNF3g81SstGifC/2aQMwVhOV5FUSPufd/z+U1EyIER7lh1ELXVW2Fs8tP7K+CJA9ld46gQ==
X-Received: by 2002:a17:90b:2e0b:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-2f452e4b9f2mr93736526a91.17.1736185544544;
        Mon, 06 Jan 2025 09:45:44 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26d5c7sm36009838a91.45.2025.01.06.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 09:45:44 -0800 (PST)
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
Subject: [PATCH 6.1.y] scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity
Date: Tue,  7 Jan 2025 01:44:59 +0800
Message-Id: <20250106174459.3206507-1-visitorckw@gmail.com>
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
 scripts/sorttable.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index deb7c1d3e979..f0ba2bf5a886 100644
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
@@ -128,6 +128,10 @@ static int orc_sort_cmp(const void *_a, const void *_b)
 	 * whitelisted .o files which didn't get objtool generation.
 	 */
 	orc_a = g_orc_table + (a - g_orc_ip_table);
+	orc_b = g_orc_table + (b - g_orc_ip_table);
+	if (orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end &&
+	    orc_b->sp_reg == ORC_REG_UNDEFINED && !orc_b->end)
+		return 0;
 	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
 }
 
-- 
2.34.1


