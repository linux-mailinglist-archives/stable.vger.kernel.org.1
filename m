Return-Path: <stable+bounces-60661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE63D938BE2
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 11:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D30F1C2120F
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4F016A938;
	Mon, 22 Jul 2024 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="L0eRPDW6"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4961667E1
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639886; cv=none; b=TAyfCEMNTmq0TMo/ei6paLl7EqXzPEUX1vj0vNipUF3MCVIsmL/ZHbUjKLxvMBD0HwCW8Pp2virvUkr7dtLznphPuroTZadpPf+isd3O2Lx74LfdOLlxToD5BsNGGSf/ifkbBeep2GyyfZ2ZQ1L6hrcj1WCJ17avy3VXhwVsbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639886; c=relaxed/simple;
	bh=iNwcFeQEp4075A0ASoRCxGVTUuDy9fJ8UmlD12c0/FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNW3xeF/4sLd/HzQ8pmI/V4CWS8lhK1Dv+5Jzt30bfqPFrJ0ZuoSOYSJ1wZLUUUrYIQnYuXecj+bp1FkeZf6HWhxkAM4nRedNRRf8d5qUphdSRWrgZJhJGs/mEmo9m4HhRDay1ufF0nGX6McnNp2dffZ1g0xH0TtyotvW7Qk3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=L0eRPDW6; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4C5E93F13F
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 09:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721639882;
	bh=rC35uQ15eqvudJFKCmfhKueP5euBpEMwrUgBuRH1430=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=L0eRPDW6DcKov9PIdGKz9tTbUMniz0aO9FWkUSqpdn9XSLAVqnaIGUJmmV4Tv+CHb
	 4xZl3VhXQSDnP2uJFVI3anC8EmcDulDJ+Y0jdsLvghEyqZZXE83IRyvpH31Jmvg/K9
	 b82RAcLu5L8v9kL5swfxxY/OroDEUMbwPiRGw0rRyu13bklZT2FuZ4i26r46O/U/TZ
	 q6a3bTgGv+4XRBzuViai6Er6KG88KlfoF75D1TDzjzauJx0p5CMzwZPWON3nMK46lT
	 hspriN8HKFV31Q7zqsAbM76SMcMSxe8Dh/KJ1lQ1DLxaaXP3BpNeYUFZGrouxkLZmb
	 t4I5jCuv8qICw==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70d14d11f42so1029358b3a.2
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 02:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721639881; x=1722244681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC35uQ15eqvudJFKCmfhKueP5euBpEMwrUgBuRH1430=;
        b=xIz5uv5dFw+2IE9yeR5LkSPl80ZvqW1hbcMsurUMN6F0jxhAErA8U8k+Ms00R3kJLO
         KoVgTcylL3ZJXdKUPHS3/fm9LLGbItUEGpfXZUO6n9ZvUYWzf6rq+XnyWc7+Q0sFF4GN
         h6V4wOqo0zBgzAH8i5MyZL43+pMg7sNe5fAzlQA5/cNeO8TOc+kZPhZkkAEid5wTxpSh
         /nSbncRBCiNe6TzfTaam3PVirEtqjgkBsB8RH8L0Rb63o6hcWJqqMjaZib7WtrfDXcj/
         sFusUv35nV1CNXnC4ig7zW1Drkyu/u0/h8NDreS8ddr/umi5q+KG+WrCUgwtidcc3jIF
         ITzw==
X-Gm-Message-State: AOJu0Yy6g5duEsqw+KK4vdbMRA88dcWrBwc4i1j5tYCWXWtU7xX9uGQ5
	2UPmdCWnOkXIksJNxhyI7BIjhIoeh7TYduGiHZDX7HaI6mh8SAyP5u4WA+JEWy5pnpp+m8Tldej
	OWJJoclWIGy4hDlaLezxSlR8rS9Yijz10ay97gWkrk7MDFt/1lxzJVpyblEsWlNXiEwn7Aw==
X-Received: by 2002:a05:6a20:7289:b0:1c3:b267:4261 with SMTP id adf61e73a8af0-1c422896e43mr6821015637.12.1721639880861;
        Mon, 22 Jul 2024 02:18:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3aDHOhtOi0AKUGNdxUel0qJvuLHcnsvj57xOhtEhkQ7pDTZKxnziU/t1w17SduknmvGTUtQ==
X-Received: by 2002:a05:6a20:7289:b0:1c3:b267:4261 with SMTP id adf61e73a8af0-1c422896e43mr6820997637.12.1721639880525;
        Mon, 22 Jul 2024 02:18:00 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77506757sm7582264a91.35.2024.07.22.02.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:17:59 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/5] scripts/gdb: fix timerlist parsing issue
Date: Mon, 22 Jul 2024 17:17:42 +0800
Message-Id: <20240722091746.91038-2-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722091746.91038-1-kuan-ying.lee@canonical.com>
References: <20240722091746.91038-1-kuan-ying.lee@canonical.com>
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


