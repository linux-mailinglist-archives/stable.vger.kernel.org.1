Return-Path: <stable+bounces-60729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73052939B21
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 08:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB3D2858D1
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 06:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E4C14A4D6;
	Tue, 23 Jul 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CampAaxH"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9A14A4DB
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717383; cv=none; b=g2X8G8B520raO7+ACxJ/Xdau9zGDABQjojWzOzEvMt/1yedI7q5qWxc25XvlsjigAVAYKuYjhhvq+L/ual23phN83xdfpITH7/XWFppXwkV6RpCyoOgfU/SDXiRr4w76Fp3aPmRkWXCPeMoseObTtlDxQX3kHD2UtduyANL2hVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717383; c=relaxed/simple;
	bh=iNwcFeQEp4075A0ASoRCxGVTUuDy9fJ8UmlD12c0/FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozfHcsdvxjXsVThaClLJB8VBjqe7OaFFrlOtOb8se5xWn1fZK1J28mtOMTt9PnaPE464JHGUEV1UBXJ6M6tufZjaIcSmqgl8RJOyP6+Zx3pQrQ3SsIW8r1XArHr22wllSaY/tnfvYC7CplUcoe2+FzI9YhZamAK0xvhTrKOIq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CampAaxH; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6682B400E2
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 06:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721717373;
	bh=rC35uQ15eqvudJFKCmfhKueP5euBpEMwrUgBuRH1430=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=CampAaxH3Di0LFQkZ+08akaVRVHBHWp+eWMfWj9gs9u8K17cQxubn6+F+5aoKI/Dv
	 lBQCosqAK73Q5UpqQ/21I4MSd1HAPtTNDfIXDeESzDhgRcdSKkMdBYsfFKqKCM+ro6
	 Et6UHyZM98LiZ08YYvRgPBDOIoed440VC6QnnpSbI9pI1i+xgfDWG8lB/zc4DDSf0o
	 KmksX1/E9Dfpni8Xst5+7qMlZ6Mc8/4Q9wtIUzwbwD+plYVntXwQZrmz8RGGNShLAq
	 m3tlb6ky82C1TU+eFKS4Kgu7dLEWZf4MSSrpQ7whcOsLWaVZoUuINBUN92EM2yQVEL
	 nq0IZJu2QOJ8w==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb68c23a00so4747406a91.0
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 23:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717371; x=1722322171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC35uQ15eqvudJFKCmfhKueP5euBpEMwrUgBuRH1430=;
        b=SBXDs972RQX/P1BtfA3A76rqIXMSgIzOGxx9RbiAPiQsC/uvtI5shFDVYplGhc2Qpo
         iEMQcR5+tycscvm/yHxVjYtmmUK5algoqFig/RWkVI2ZXLfWre/i6HpKxcM42AlKEJmP
         5g0n4GD9z7ix1PiwSqphRH4yPdm7ZncZROFN2iXmx5QtJOIwmlIHiPUb0y/9+y+jtaIo
         WoORBhLDpffmyKPa7aM0m9FjVhBDvk5IF0fguK80PCne7zOPggTY6TxxkiJyz6NnKMbf
         5vlIbwXEOSKBZitFCmz03TALL8DAQex+Oc5ivvhqiYjKqgiykUoQIRuD+XZK9S0I55xS
         IsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuW+Hutn6uk4a8F4rDomVbjirpr4tP+JHTN0/6DTPS2aDrQAW5BFMfinN5QRi4Dhv8iKJKkf8FN7rc7BSqp6j1SvRX2mob
X-Gm-Message-State: AOJu0YxrLIb50L8FBaLm0KtjXDXg2D+/XJc5z5A2FBmtOVyQXfofEPwo
	iwukhPB6JhCw50KQEznsjktCNxQOTQVIsAyMgbP7EXWAka4eHQgtLTX1EPIx8jtAIFf3HymNeAv
	0024OE6lOoWYZmXodm4ekQI4CuYh4aDSUAYO/wOPn7Z5M+hzK3baNuJWCCGS/KZdljXel9w==
X-Received: by 2002:a17:90b:4c8a:b0:2c7:d24b:57f with SMTP id 98e67ed59e1d1-2cd8d11c9ccmr1897652a91.19.1721717371636;
        Mon, 22 Jul 2024 23:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdcDBoDGFSCrA52BVnISHDjdXUedskgJ+Mos8j+PlbYjDf49OcjwGMpoau4hD8clEwbyyrBQ==
X-Received: by 2002:a17:90b:4c8a:b0:2c7:d24b:57f with SMTP id 98e67ed59e1d1-2cd8d11c9ccmr1897632a91.19.1721717371242;
        Mon, 22 Jul 2024 23:49:31 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c5391bsm8354749a91.24.2024.07.22.23.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 23:49:31 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] scripts/gdb: fix timerlist parsing issue
Date: Tue, 23 Jul 2024 14:48:57 +0800
Message-Id: <20240723064902.124154-2-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723064902.124154-1-kuan-ying.lee@canonical.com>
References: <20240723064902.124154-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7988e5ae2be7 ("tick: Split nohz and highres features from
nohz_mode") and commit 7988e5ae2be7 ("tick: Split nohz and
highres features from nohz_mode") move 'tick_stopped' and 'nohz_mode'
to flags field which will break the gdb lx-mounts command:

(gdb) lx-timerlist
Python Exception <class 'gdb.error'>: There is no member named nohz_mode.
Error occurred in Python: There is no member named nohz_mode.

(gdb) lx-timerlist
Python Exception <class 'gdb.error'>: There is no member named tick_stopped.
Error occurred in Python: There is no member named tick_stopped.

We move 'tick_stopped' and 'nohz_mode' to flags field instead.

Fixes: a478ffb2ae23 ("tick: Move individual bit features to debuggable mask accesses")
Fixes: 7988e5ae2be7 ("tick: Split nohz and highres features from nohz_mode")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/timerlist.py | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 64bc87191003..98445671fe83 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -87,21 +87,22 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
             text += "\n"
 
         if constants.LX_CONFIG_TICK_ONESHOT:
-            fmts = [("  .{}      : {}", 'nohz_mode'),
-                    ("  .{}      : {} nsecs", 'last_tick'),
-                    ("  .{}   : {}", 'tick_stopped'),
-                    ("  .{}   : {}", 'idle_jiffies'),
-                    ("  .{}     : {}", 'idle_calls'),
-                    ("  .{}    : {}", 'idle_sleeps'),
-                    ("  .{} : {} nsecs", 'idle_entrytime'),
-                    ("  .{}  : {} nsecs", 'idle_waketime'),
-                    ("  .{}  : {} nsecs", 'idle_exittime'),
-                    ("  .{} : {} nsecs", 'idle_sleeptime'),
-                    ("  .{}: {} nsecs", 'iowait_sleeptime'),
-                    ("  .{}   : {}", 'last_jiffies'),
-                    ("  .{}     : {}", 'next_timer'),
-                    ("  .{}   : {} nsecs", 'idle_expires')]
-            text += "\n".join([s.format(f, ts[f]) for s, f in fmts])
+            TS_FLAG_STOPPED = 1 << 1
+            TS_FLAG_NOHZ = 1 << 4
+            text += f"  .{'nohz':15s}: {int(bool(ts['flags'] & TS_FLAG_NOHZ))}\n"
+            text += f"  .{'last_tick':15s}: {ts['last_tick']}\n"
+            text += f"  .{'tick_stopped':15s}: {int(bool(ts['flags'] & TS_FLAG_STOPPED))}\n"
+            text += f"  .{'idle_jiffies':15s}: {ts['idle_jiffies']}\n"
+            text += f"  .{'idle_calls':15s}: {ts['idle_calls']}\n"
+            text += f"  .{'idle_sleeps':15s}: {ts['idle_sleeps']}\n"
+            text += f"  .{'idle_entrytime':15s}: {ts['idle_entrytime']} nsecs\n"
+            text += f"  .{'idle_waketime':15s}: {ts['idle_waketime']} nsecs\n"
+            text += f"  .{'idle_exittime':15s}: {ts['idle_exittime']} nsecs\n"
+            text += f"  .{'idle_sleeptime':15s}: {ts['idle_sleeptime']} nsecs\n"
+            text += f"  .{'iowait_sleeptime':15s}: {ts['iowait_sleeptime']} nsecs\n"
+            text += f"  .{'last_jiffies':15s}: {ts['last_jiffies']}\n"
+            text += f"  .{'next_timer':15s}: {ts['next_timer']}\n"
+            text += f"  .{'idle_expires':15s}: {ts['idle_expires']} nsecs\n"
             text += "\njiffies: {}\n".format(jiffies)
 
         text += "\n"
-- 
2.34.1


