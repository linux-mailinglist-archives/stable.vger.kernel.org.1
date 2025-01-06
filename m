Return-Path: <stable+bounces-107743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547A1A02F57
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 18:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C4F7A1F1E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41F1DEFEE;
	Mon,  6 Jan 2025 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzRNIhHJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165614600C
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186017; cv=none; b=OnnwqVryz6qLRL0yb3bvqsoydqL56oxaZtnRJuXPBpwqj0dpt+wEqm6UzP4rM4nKKyYxbUheKhNg7z7jqNVwcaiy53Oxa+ot4+ZJcPpaWBsEQIfseh/qg/gMmQwZFweTWzPlrUqXxAlUrRB41kXIYEopY8LdCsoUTGs2igYXF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186017; c=relaxed/simple;
	bh=eYi1147B35Q00JC37zdPENis23ZxZk+iYmYCwbyeO5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QX0BU7Pr8oc0IRTkcJ8AEfEgTI0eUFBpTaZPFiucue5OGnQiUTiaTntpDmsl3J+p4ky0rT2M02LwVJwq/9x9eQOIj/tFz7Q5aQHY8hl2sbyyVsimohr396r2RvnZ3hpi1+dHF5zM2rV6DibOIB9n3jrDfx3xhm+cztn8aFrp3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzRNIhHJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21628b3fe7dso205416155ad.3
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 09:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736186014; x=1736790814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZlsjB+xkhGgc0AqfkXua6V5y7D9WflVCAYdHA6CIC0=;
        b=fzRNIhHJZCmq/PoJYj3lGhe5Kh/SquVBjbThdBwkB740vy1KH0Uq70p/UK88boS7Dt
         kqDZbPzdZ1++sKFiuFeDmoWEmnD/2mmQjdLJlCbba3Az8+d1CqOzso68rDMTPvqOQr/N
         3pQZpX8YB6wydZVvhUX74nJ4BxZOJkFm+s2nw/TZxl01J4jOS+1iiu66WuZ/X2UIv02U
         z1z1YLGU529TXGq6th35qLGpgGtnYqsmJYk2T5TFU05fzl3fk7CISuWVOxCIeQEKsX3n
         2+kHOtf/MuLjwPGFcD8rPzVgQN8uSmPEAMXy/6YKIiix0Qkqw/Wh+dUZvsmmHpz4w1Br
         lGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736186014; x=1736790814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZlsjB+xkhGgc0AqfkXua6V5y7D9WflVCAYdHA6CIC0=;
        b=vpI9bu/5jQZRJ9KKGtgR4oazNlIDKHjwVxHtDUYiYf06mNhOKucBmJW6UlSulYI0M5
         uPpWo5V/+9XluFSV3p92By+l9GdTHjlyaL6DwZegUOOTPiyYYW2ZUX74of3hpzGPQ0DD
         a9qBAzrr9QEsMvAKQ0zQ5YTkC2fOIDFS7OFbeJacTQ5LPgMUR7CC1v/K7LddD7LO31A4
         7Jtnnuz3vSYax/llsNzEAsIBV+exDFeh0REyv5FF+ZdecwpE/Wnx1wqCbbiFPArbwwP8
         YwoVBV2s57TuoW2DMF4a8f8v3/RChFJtaHTzgrCpHdEI6Wkd5d3pfKPtVGDugr69rMp5
         WPeQ==
X-Gm-Message-State: AOJu0YzyKgNIGHmdJxiUFw4Qhka7bJvlSXXwhcKqgzgVgTZZVe3SLSRD
	bzMqXnQCvrzfV8aksgzpmTivWKtRPjcoOOMe0MwMkQPgTNk8GDLaXAD206xx
X-Gm-Gg: ASbGncu5P4nPIhLcbEzUsbdL/vcepXQJXQHWDx7x5vk59rHm6qSzLsYmdSrLbgW6CiJ
	co2kfCAKX92YGzjrv8hlWnIqQzAHrAhSXQynvH5b7gEs1ot7LNAYDzb07AsV3/wd81DnJPizkpE
	5Zv3wCajetX5jtiQEPX/D/lQ3WswVkBb7fR+bO39LPjBh18PZ9rg/8V1aVLlYJKL8i4e/0AUe4G
	htHqAfN+UP/2x93XN6Nw1aYvktd6muupmp+FbplavhZr7JLecCaE/IKfsYnlIOJxs6OmlDFemib
	ht5RVfNW+v0=
X-Google-Smtp-Source: AGHT+IGVSW/60CyfHX0i+svkOZonnKdXNHXgQKHACAc/csIdS7p835lJoKgFZje6wUQQQy+4i+dm6g==
X-Received: by 2002:a05:6a00:3910:b0:729:49a:2db9 with SMTP id d2e1a72fcca58-72abdecbf94mr83759262b3a.21.1736186012893;
        Mon, 06 Jan 2025 09:53:32 -0800 (PST)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c1c7sm32557696b3a.182.2025.01.06.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 09:53:32 -0800 (PST)
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
Subject: [PATCH 5.15.y] scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity
Date: Tue,  7 Jan 2025 01:53:18 +0800
Message-Id: <20250106175318.3256899-1-visitorckw@gmail.com>
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
index a2baa2fefb13..9013b6984d68 100644
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
@@ -121,6 +121,10 @@ static int orc_sort_cmp(const void *_a, const void *_b)
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


