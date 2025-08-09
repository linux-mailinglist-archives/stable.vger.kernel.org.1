Return-Path: <stable+bounces-166909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D791FB1F4B0
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 15:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E044E561BE0
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 13:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9729993A;
	Sat,  9 Aug 2025 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFlSPj5l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C9224AF9
	for <stable@vger.kernel.org>; Sat,  9 Aug 2025 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754744893; cv=none; b=XTUMyQt30jPk7nn6HTcjYK8/Mh4NCrzq/k4K3kVZ1YsWrOmW103+wVAGCvbSshTfnvq47f8NLsuq5MRRxgl0NL7hLo8ZKH+fMCiUZM2I2AeAj+9NCr7xmoWZGyvxU8vI9cBI6hiIubyonYTuFokfE2lGHcW0xLV/5uR6a0kOEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754744893; c=relaxed/simple;
	bh=HQNmj4ADGnraIrHVGpp30wYTtxeRcrQVoc0KRyjgRkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geNkhuZYbx6yywsguYIXOKYqkurMTEEsQ/yc/++F3DrrC9l5CLSZLP3emfup3Ov4bTmn+yyQLmd26PnLR6XzvAus2hFvujcWEtINW6Gu/nkn4/vbj5Ikif7l6/yVqaPfBYLR8h1fIVoWP1Yu1ac1idEmB7Une93RucFfUJqMC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFlSPj5l; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso2731975b3a.1
        for <stable@vger.kernel.org>; Sat, 09 Aug 2025 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754744891; x=1755349691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5iH9iV5VsYBnBlg9QnKRLf9bBCyT3yBhK5kP+dnWFA=;
        b=IFlSPj5lhatw5Q+TNFVAkGiW1nwWoe1dZ+/0aTPUdXWc60cpXjZOKcyXllfAbqH4oi
         SysuJ3zj7LRTvxWk/RVLRIJjt+QVwDrBVJyfEXUkdhcXKaBXNMC7hziEQYH75Hx9LCA/
         dSA5u1+cD4tfZU3+TpE9LC0C06yA7WbyWasiHezV7/9Hx27vdPlQcgUJr25Y9EzV5bGf
         kXa2HMSrDQ5wvJTo8jR0tAOV6FoKmUzyeoMpwk2fWgrsbbsc89Ie2TJjIrF6jIPjTQYJ
         ck7m2lZpZ8MhlXeWPl8CRp2PIzjN6OEaCGgpOEUo9XK8Pqwayzn1BpiS/CFPlE/cTjlB
         3BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754744891; x=1755349691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5iH9iV5VsYBnBlg9QnKRLf9bBCyT3yBhK5kP+dnWFA=;
        b=fDPWLCcBp5a8enkVHHmExHVk0P96Jt6kT9kJEEU63BDq92N5yI1UZlUMUvj/WsFgka
         EBUXxKwlxZl8T5xk7iCs0xNKwUsR7WpEq5UocmErbHtPVAoappLqvL9/Ve2pDzmJSW4i
         H/CP3tA20NzNa9y834Yv7VNQHH4TzrmI97whGfpgVUoMZPqOPW9u8gC1Qg1tJT7hpdjd
         sBdkUPbT6T7feeSYyeuKcfPx2f1svvGvb3R4gQ8a4YcAhZ6/SJBSeBYmhQXAA/G+K7Jk
         xOXkvjIHRHcnq5dO0F9sgDQF96WXFOWIzGS2FyKLbyyVuy62DmjS5Bgrl5K0zEHKQhqK
         zigA==
X-Forwarded-Encrypted: i=1; AJvYcCUq2KGY0zfkE/OVKW9VKQeqlsTf7KT9fLX6NKlwmFs4EXN965KkeO+GlmO79F9G/nsiooX9ufs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0KnU94JsZqDy/DnYLBTzyBjPcNrMQY1cI5IK1vO0+Oa3r1AT
	6SAw0Mxo9rjRl0f96Husie9/FqOYA1/1IpsDm/ucJ8hFqwVF/5uX5Fb9
X-Gm-Gg: ASbGnctpJAzVFBomhbd6aDmHHBFoJaUHr0Oj6eRW2cmS8QXYzcXU5tn9ZepRWiWJvdU
	Sq3EsfZaVLpRNcpanMzzLBDc3J0OlXrSjpKfhQjd0w3+NIyiDBRYatrd75vkNHQsoCwoj8i+tUn
	ENjxxBu9Ll2O36aSJXZVj/TRWVSw9oBnpVog1DAaEckgZWCypCC0FHsOaGHfNDLMd/8DnirWNOf
	mMMj8U/KsfSXqBhzN8hhyRtzkDYrf60ISWgWI7yfJ4m8eHrnZZgeBQ3g01OkKgllX4LxdjsSr7a
	4UkJ4niT1U43B1BIkh9/fQkzrjoNBQuiFwAiDqgiGuzlB7roL9uTnopyhJjwbZe33G3Dw/xsXM8
	ayaSxens/FCt3iSjxlqFNSenwiD4=
X-Google-Smtp-Source: AGHT+IH1ZRbmHfcbnjxqSE/cWx/E98HxIo+TMBcEPKIJ/oKES8p1wHfnek7BsNybm9elxKdvynFtTA==
X-Received: by 2002:a05:6a00:1389:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-76c46111288mr9692926b3a.15.1754744891501;
        Sat, 09 Aug 2025 06:08:11 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd8d70sm22567165b3a.105.2025.08.09.06.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 06:08:11 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: fix commit_ops_filters by using correct nth function
Date: Sat,  9 Aug 2025 22:07:56 +0900
Message-ID: <20250809130756.637304-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_ops_filters() incorrectly uses damos_nth_filter() which
iterates core_filters. As a result, performing a commit unintentionally
corrupts ops_filters.

Add damos_nth_ops_filter() which iterates ops_filters. Use this function
to fix issues caused by wrong iteration.

Also, add test to verify that modification is right way.

Fixes: 3607cc590f18 ("mm/damon/core: support committing ops_filters") # 6.15.x
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v1 [1]:
1. Fix code and commit message style.
2. Merge patch set into one patch.
3. Add fixes and cc section for backporting.

[1] https://lore.kernel.org/damon/20250808195518.563053-1-ekffu200098@gmail.com/

---
I tried to fix your all comments, but maybe i miss something. Then
please let me know; I'll fix it as soon as possible.

---
 mm/damon/core.c                               | 14 +++-
 tools/testing/selftests/damon/Makefile        |  1 +
 .../damon/sysfs_no_op_commit_break.py         | 72 +++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/damon/sysfs_no_op_commit_break.py

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 883d791a10e5..19c8f01fc81a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -862,6 +862,18 @@ static struct damos_filter *damos_nth_filter(int n, struct damos *s)
 	return NULL;
 }
 
+static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
+{
+	struct damos_filter *filter;
+	int i = 0;
+
+	damos_for_each_ops_filter(filter, s) {
+		if (i++ == n)
+			return filter;
+	}
+	return NULL;
+}
+
 static void damos_commit_filter_arg(
 		struct damos_filter *dst, struct damos_filter *src)
 {
@@ -925,7 +937,7 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
 	int i = 0, j = 0;
 
 	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
-		src_filter = damos_nth_filter(i++, src);
+		src_filter = damos_nth_ops_filter(i++, src);
 		if (src_filter)
 			damos_commit_filter(dst_filter, src_filter);
 		else
diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 5b230deb19e8..44a4a819df55 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS += reclaim.sh lru_sort.sh
 TEST_PROGS += sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 TEST_PROGS += sysfs_memcg_path_leak.sh
+TEST_PROGS += sysfs_no_op_commit_break.py
 
 EXTRA_CLEAN = __pycache__
 
diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
new file mode 100755
index 000000000000..fbefb1c83045
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
@@ -0,0 +1,72 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import json
+import os
+import subprocess
+import sys
+
+import _damon_sysfs
+
+def dump_damon_status_dict(pid):
+    try:
+        subprocess.check_output(['which', 'drgn'], stderr=subprocess.DEVNULL)
+    except:
+        return None, 'drgn not found'
+    file_dir = os.path.dirname(os.path.abspath(__file__))
+    dump_script = os.path.join(file_dir, 'drgn_dump_damon_status.py')
+    rc = subprocess.call(['drgn', dump_script, pid, 'damon_dump_output'],
+        stderr=subprocess.DEVNULL)
+
+    if rc != 0:
+        return None, f'drgn fail: return code({rc})'
+    try:
+        with open('damon_dump_output', 'r') as f:
+            return json.load(f), None
+    except Exception as e:
+        return None, 'json.load fail (%s)' % e
+
+def main():
+    kdamonds = _damon_sysfs.Kdamonds(
+        [_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                schemes=[_damon_sysfs.Damos(
+                    ops_filters=[
+                        _damon_sysfs.DamosFilter(
+                            type_='anon',
+                            matching=True,
+                            allow=True,
+                        )
+                    ]
+                )],
+            )])]
+    )
+
+    err = kdamonds.start()
+    if err is not None:
+        print('kdamond start failed: %s' % err)
+        exit(1)
+
+    before_commit_status, err = \
+        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print(err)
+        exit(1)
+
+    kdamonds.kdamonds[0].commit()
+
+    after_commit_status, err = \
+        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print(err)
+        exit(1)
+
+    if before_commit_status != after_commit_status:
+        print(f'before: {json.dump(before_commit_status, indent=2)}')
+        print(f'after: {json.dump(after_commit_status, indent=2)}')
+        exit(1)
+
+    kdamonds.stop()
+
+if __name__ == '__main__':
+    main()
-- 
2.43.0


