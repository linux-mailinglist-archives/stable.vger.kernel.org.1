Return-Path: <stable+bounces-172198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6678B30038
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E110B3B4DBA
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87EB26B2C8;
	Thu, 21 Aug 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7OZARhC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2660D2DC34A
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794107; cv=none; b=CcIklnjdVHzD5AGkTMVv+jNdo9YOstpxfvCn/3JBgjL0aTGNt9ucsBaBFb6+2ZFlWUIvrYgEA8FnNW1ceQwTcPH71/rK70dEgjfXp79a754wzuQH+FP++F2XMkZ2skyc62mjNbCcrGzLKK53EUK9zumEWAbrf48K+fFHMOHoflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794107; c=relaxed/simple;
	bh=ER20uN3ophbDodXA0V2P/El1StgLE1H9mf8h2Z2UIMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUywd03HiOHdxR0+BppJ79GW/r2e6uo3foe+AgyORoun+7EmMBNoWFL0EcfIhbZWkgsMPF+SK4GkqrTEGLhJnwx1E4Ow7f/TdSgGQQ/hD5cHiHERXo+7ZkcufYor+weeb4DLjsuO2TBtf7nclowOukhXMBynj8trGey84RqOCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7OZARhC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24458263458so12118475ad.3
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755794105; x=1756398905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=flb2E4kjGcDlTRu530Vt8i5Q+Cs64zRzjln/3+D2F4k=;
        b=K7OZARhCr+6TKUt+AEwLBT92nuDUlPCFKglJVpmMOyCHuBtTEkwu1GzWtu7dsNTNxl
         yD9MeEygDWxSgmzymf+PtMZAq/oPIDlVYXlsWVQ3FNzYeTYm5+6rYz6b/IJuLKz93oSg
         id4ZrJzAMP9Tu+AWgLWDbl0r0ge1krIMlQScL60c+LFch/kUu8N54dyHA5GtLbvbsnmA
         53+vGgMf3HbMLa5xRg0flTdqA9OLpZFIht83zvx+QMX1p46AAzk0Lv+PryNOA1EHNYY+
         KTDo4cN5lywf+cMJ6ISfODCVeIiDBsl2+1N8/lj9zWibbMfYsMzyW3hrT9b93MTCb9+c
         eXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794105; x=1756398905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flb2E4kjGcDlTRu530Vt8i5Q+Cs64zRzjln/3+D2F4k=;
        b=lIylojAGBZs0AXuqypHruC2yYoZi5PYfJT0A+l+R0yHAul543C6kFlrnHyF+JbWDzx
         Vo6MDYw4BiE237GbBI3ntAxNVCM4vCMC7wl2imWT5TUjFOhLxzx5y/PupLzzMyX1Uivd
         tRBVBXX5qfCI1rWZyWxeM8kgbjZtwosBfKQ1Kw70xTUsBAH9pFliKW6H9OTrVdXDOkgp
         ecDNozEXygSmYbbELWRBPvxSueuziwVtfjw1J1jb3C1j2ri9u37ekuDl+xvrH96Mhwp8
         YeH+vWtoiMuPSI2vgHURuq0OWAI5qgQLN2pxnkBLMHUoZvmkPykdZeu1ReWMYkgjnk9C
         s5/w==
X-Forwarded-Encrypted: i=1; AJvYcCU3AjmxdVcNsWqQBcpHz7RbEC10G3Ctlz3xUZHekMO/QQLmOeQ/929k2792Hv2T6Vm3HBDLD8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+3GxoXD3SqmYfSe/9txHtP6SAMYzqJhEzpCXEqiL1x9+ZSGw0
	Dz1lcourIF7v7jmcP3fh8xH0Q774ue+a/nsPpQma3AoPuJ/1r8G6MSkV
X-Gm-Gg: ASbGncs+5qZtfiY/W7Ai6cHim5K7e4OuywuSF9q7DJB/oxiPcvY5HOGTjPUy1UK70Ez
	PLsr0UTElEbALNeX+1jvF2hQXKaghnh0Bwm6E6ZDpsR/uX9HP2mdhs4gCjh6galVwZJvNSC1aUQ
	yZKFSu9S1JeCDS4KCJO6EF6btThqN4uadsVhfDD34avYwXrE0kO6IkwdaQNiY6VT8uaWLp8nvlq
	yw4B2Rb7/W/9DKtekd5pq3DoV6AoQjgNyIX5/qN9xIRFD0gCzIGZ2cENip+soI4R+a8PRibyCCK
	29tauoYs7H1Dl+ooEBYaPUGkpD7PVyDTCxS0kUU70k+vkdV353qNbk0bH59GFsuRAna0Wkt6ZHA
	MO/Aw0qq5tRvnG52Q
X-Google-Smtp-Source: AGHT+IEoK20LGwps1UI3qxtBzFuC2UZywh32woD/WzTb07rAX67EwMDZ7TmGCqkdLFk9tfZL3IepkA==
X-Received: by 2002:a17:903:120e:b0:246:1c6a:7026 with SMTP id d9443c01a7336-2461c6a7131mr22258645ad.40.1755794104962;
        Thu, 21 Aug 2025 09:35:04 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d5242dasm8704422b3a.77.2025.08.21.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:35:04 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Fri, 22 Aug 2025 01:33:46 +0900
Message-ID: <20250821163346.1690784-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
include/linux/jiffies.h

/*
* Have the 32 bit jiffies value wrap 5 minutes after boot
* so jiffies wrap bugs show up earlier.
*/
#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

And jiffies comparison help functions cast unsigned value to signed to
cover wraparound

#define time_after_eq(a,b) \
 (typecheck(unsigned long, a) && \
 typecheck(unsigned long, b) && \
 ((long)((a) - (b)) >= 0))

When quota->charged_from is initialized to 0, time_after_eq() can incorrectly
return FALSE even after reset_interval has elapsed. This occurs when 
(jiffies - reset_interval) produces a value with MSB=1, which is interpreted
as negative in signed arithmetic.

This issue primarily affects 32-bit systems because:
On 64-bit systems: MSB=1 values occur after ~292 million years from boot
(assuming HZ=1000), almost impossible.

On 32-bit systems: MSB=1 values occur during the first 5 minutes after boot,
and the second half of every jiffies wraparound cycle, starting from day 25
(assuming HZ=1000)

When above unexpected FALSE return from time_after_eq() occurs, the
charging window will not reset. The user impact depends on esz value
at that time.

If esz is 0, scheme ignores configured quotas and runs without any
limits.

If esz is not 0, scheme stops working once the quota is exhausted. It
remains until the charging window finally resets.

So, change quota->charged_from to jiffies at damos_adjust_quota() when
it is considered as the first charge window. By this change, we can avoid
unexpected FALSE return from time_after_eq()

Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v2 [2]
- remove unnecessary example about time_after_eq()
- remove description of unexpected reset of quota->charged_from
- clarify user impacts and when bug happens

Changes from v1 [1]
- not change current default value of quota->charged_from
- set quota->charged_from when it is consider first charge below
- add more description of jiffies and wraparound example to commit
  messages

[1] https://lore.kernel.org/damon/20250818183803.1450539-1-ekffu200098@gmail.com/
[2] https://lore.kernel.org/damon/20250819150123.1532458-1-ekffu200098@gmail.com/
---
 mm/damon/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index cb41fddca78c..93bad6d0da5b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2130,6 +2130,10 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
 		return;
 
+	/* First charge window */
+	if (!quota->total_charged_sz && !quota->charged_from)
+		quota->charged_from = jiffies;
+
 	/* New charge window starts */
 	if (time_after_eq(jiffies, quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
-- 
2.43.0


