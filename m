Return-Path: <stable+bounces-184014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23274BCDB5C
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 17:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76917543ACD
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60352F8BD1;
	Fri, 10 Oct 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3ebBdV0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21542FABE5
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108611; cv=none; b=dwNjBsE9PJz0ir6mB41J/kLWCVC5kRVRgSxcSf2V0UMcM+yGo9OJd7a/6mDZ4S1Tdta9rbj0F4EUpvok3irubbaXk5wwnMqIUwftzGZJv7UjdS3h6y2DiFbxo4xNySrC/6Vn+GE/oGh9F7GVxfAO2L1z130FrKMNdajnXaAmiTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108611; c=relaxed/simple;
	bh=upWSCwkwQ09Z4avIiv+Y6wEsIG3+TFZ3n19V8cmDwBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yclwu6k3FVNn1IYgRoxP/jmsdfCQkZ6a4oxJS01VHHBeRK8SZp34UZiFwuvU/E0vzIdY7b/O+/KglW6Hl9N4ZRMA0uOvoSa2o57qoDMQqgIqyhCHjkFUiPvxamScaYj+kcBkjXWLQG3GXOg9k5dlgup67OytzuyO1hJLY6YevoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3ebBdV0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so2019937b3a.1
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108609; x=1760713409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwuFHJSwTOh44O6o4YH5Gva/YZZ2KpNq4JaQIOiJzpU=;
        b=j3ebBdV0f27NllV4M84Aq5WqvJyjERzw16JkhpGOL3fG3nabFHCrKsrnzZxeNe13gg
         DLCiJ28c5VWw/7XfTLM74iQ1Jj13Uj5RS/2ZQoaP6hIcu/Wpfn5YB206GlQWlz6R2pfK
         Hvm8W1ghvLER5NYgbb5M4YvsP8aPISqhxnXOBcO9Hljo2qVpODyCGcjvQecSuFgsvmUQ
         7IR839Cfs5pW4SZe+TmYG+IyN7BhJZFFOJw6TvVuDu3r6GZgf8sR1GvbSz61QYUXWody
         oHY8izBg+tUysRGLohk9B4WMiF7jb8EUSIsRHufAviBFUzC6IHyf5ElKlUGlU3yixcjy
         MDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108609; x=1760713409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwuFHJSwTOh44O6o4YH5Gva/YZZ2KpNq4JaQIOiJzpU=;
        b=fX5S71uhMqX/8zugpzwYjdKYEdV/QJMFZfmKmJ27aQ5yTOgcq9J4qHPhc5to6d7Ehb
         8Gve4OHnduMM9/ogXAHhzKBpAUOBdwvLItiokXQUXFbajb7kDHdNwKaOyEPm+EXZ9Tac
         cEM/tlM/xUCyzkD2VxFPPRHEhk0sBCSKXVkB1N0Mk2TDcYQtj2nRUIlfD9OuKMBVziwd
         Qzx+6+YRGP36JI3tMzwZNiBE25ULUMlmaYjXpnqF7Xj3EkRGcPPhTQDkcpwHht78xb/a
         R9ANuC3KO2XGH5n6bK6SLk7TzzJYvyaiNLYmEpH5RdSFBv3XAiRbL6R8+bM1X5wUC+yu
         nq1w==
X-Gm-Message-State: AOJu0YwV34GJs1vbUrtm0cB+gF9DMzQ9XCyh3JnTWEDXUd6hxJLoaM9h
	ez3j7SS9OFKB6Ox4gNztrBdeM7gw/N1ykn+Kr+OPx01pcUvx9t+UfKCSHGSvcljC2jfgpA==
X-Gm-Gg: ASbGncufWaDkttSwlCO3z1DgxTRyVJ7RHqHAYjE6z47zehkOziPFUk1nT9TajsLvelH
	+3uKU9d4ttZni4sbP23cMTK1FO9R8ljheJqCoxm7+yMDjQm6rEbKb5lYQH5+kPaOleoOHcR0Akx
	PbQ6M1Qg1KzFkqj6hlsqxkGJ12/GVwFgg+jDPioSuts02yNT2HNDxL88tWs+IkbUGxzxfQvFdxq
	C9HEj9D+XLhCB/A7TMc0BNFQaheJfRfmzjFC/ZGFilJwOiSqtGqV+WoDvhqh87ZvlqAFL/9xd1P
	P2XXQXd2xRCzrX6FbjI7fNanLwgKMsrl7YG+LKK3XwA050PCNA/JNXRMZtsITndWjAIZjJ5u/sJ
	3XCjoNFlozVIrLRw4VRrV43Qbj0WS76LgotNKdTGsSctQT6LdLvrRKYr9EPyd+v1R8MgachFp77
	JNMUU=
X-Google-Smtp-Source: AGHT+IGrDwmfrnVEm5D4rgTHSnbaTxomjsjy9CWkSu2xSVcHS1XWQn3WGuYclGMtqODR1Njkj+ffLA==
X-Received: by 2002:a05:6a00:3e08:b0:781:1f28:eadd with SMTP id d2e1a72fcca58-7938763716amr12015599b3a.20.1760108608457;
        Fri, 10 Oct 2025 08:03:28 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:28 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.1.y 06/12] Documentation: Replace del_timer/del_timer_sync()
Date: Sat, 11 Oct 2025 00:02:46 +0900
Message-Id: <20251010150252.1115788-7-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010150252.1115788-1-aha310510@gmail.com>
References: <20251010150252.1115788-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 87bdd932e85881895d4720255b40ac28749c4e32 ]

Adjust to the new preferred function names.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201625.075320635@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 .../RCU/Design/Requirements/Requirements.rst          |  2 +-
 Documentation/core-api/local_ops.rst                  |  2 +-
 Documentation/kernel-hacking/locking.rst              | 11 +++++------
 Documentation/timers/hrtimers.rst                     |  2 +-
 .../translations/it_IT/kernel-hacking/locking.rst     | 10 +++++-----
 .../translations/zh_CN/core-api/local_ops.rst         |  2 +-
 6 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index a0f8164c8513..546f23abeca3 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any attempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding mod_timer() must be dealt
-with via del_timer_sync() or similar.
+with via timer_delete_sync() or similar.
 
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke call_rcu(), the callback function is eventually going to be
diff --git a/Documentation/core-api/local_ops.rst b/Documentation/core-api/local_ops.rst
index 2ac3f9f29845..a84f8b0c7ab2 100644
--- a/Documentation/core-api/local_ops.rst
+++ b/Documentation/core-api/local_ops.rst
@@ -191,7 +191,7 @@ Here is a sample module which implements a basic per cpu counter using
 
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            timer_delete_sync(&test_timer);
     }
 
     module_init(test_init);
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index b26e4a3a9b7e..c447d55fa080 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -967,7 +967,7 @@ you might do the following::
 
             while (list) {
                     struct foo *next = list->next;
-                    del_timer(&list->timer);
+                    timer_delete(&list->timer);
                     kfree(list);
                     list = next;
             }
@@ -981,7 +981,7 @@ the lock after we spin_unlock_bh(), and then try to free
 the element (which has already been freed!).
 
 This can be avoided by checking the result of
-del_timer(): if it returns 1, the timer has been deleted.
+timer_delete(): if it returns 1, the timer has been deleted.
 If 0, it means (in this case) that it is currently running, so we can
 do::
 
@@ -990,7 +990,7 @@ do::
 
                     while (list) {
                             struct foo *next = list->next;
-                            if (!del_timer(&list->timer)) {
+                            if (!timer_delete(&list->timer)) {
                                     /* Give timer a chance to delete this */
                                     spin_unlock_bh(&list_lock);
                                     goto retry;
@@ -1005,8 +1005,7 @@ do::
 Another common problem is deleting timers which restart themselves (by
 calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
-use del_timer_sync() (``include/linux/timer.h``) to
-handle this case.
+use timer_delete_sync() (``include/linux/timer.h``) to
 
 Locking Speed
 =============
@@ -1334,7 +1333,7 @@ lock.
 
 -  kfree()
 
--  add_timer() and del_timer()
+-  add_timer() and timer_delete()
 
 Mutex API reference
 ===================
diff --git a/Documentation/timers/hrtimers.rst b/Documentation/timers/hrtimers.rst
index c1c20a693e8f..7ac448908d1f 100644
--- a/Documentation/timers/hrtimers.rst
+++ b/Documentation/timers/hrtimers.rst
@@ -118,7 +118,7 @@ existing timer wheel code, as it is mature and well suited. Sharing code
 was not really a win, due to the different data structures. Also, the
 hrtimer functions now have clearer behavior and clearer names - such as
 hrtimer_try_to_cancel() and hrtimer_cancel() [which are roughly
-equivalent to del_timer() and del_timer_sync()] - so there's no direct
+equivalent to timer_delete() and timer_delete_sync()] - so there's no direct
 1:1 mapping between them on the algorithmic level, and thus no real
 potential for code sharing either.
 
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index eddfba806e13..b8ecf41273c5 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -990,7 +990,7 @@ potreste fare come segue::
 
             while (list) {
                     struct foo *next = list->next;
-                    del_timer(&list->timer);
+                    timer_delete(&list->timer);
                     kfree(list);
                     list = next;
             }
@@ -1003,7 +1003,7 @@ e prenderà il *lock* solo dopo spin_unlock_bh(), e cercherà
 di eliminare il suo oggetto (che però è già stato eliminato).
 
 Questo può essere evitato controllando il valore di ritorno di
-del_timer(): se ritorna 1, il temporizzatore è stato già
+timer_delete(): se ritorna 1, il temporizzatore è stato già
 rimosso. Se 0, significa (in questo caso) che il temporizzatore è in
 esecuzione, quindi possiamo fare come segue::
 
@@ -1012,7 +1012,7 @@ esecuzione, quindi possiamo fare come segue::
 
                     while (list) {
                             struct foo *next = list->next;
-                            if (!del_timer(&list->timer)) {
+                            if (!timer_delete(&list->timer)) {
                                     /* Give timer a chance to delete this */
                                     spin_unlock_bh(&list_lock);
                                     goto retry;
@@ -1026,7 +1026,7 @@ esecuzione, quindi possiamo fare come segue::
 Un altro problema è l'eliminazione dei temporizzatori che si riavviano
 da soli (chiamando add_timer() alla fine della loro esecuzione).
 Dato che questo è un problema abbastanza comune con una propensione
-alle corse critiche, dovreste usare del_timer_sync()
+alle corse critiche, dovreste usare timer_delete_sync()
 (``include/linux/timer.h``) per gestire questo caso.
 
 Velocità della sincronizzazione
@@ -1372,7 +1372,7 @@ contesto, o trattenendo un qualsiasi *lock*.
 
 -  kfree()
 
--  add_timer() e del_timer()
+-  add_timer() e timer_delete()
 
 Riferimento per l'API dei Mutex
 ===============================
diff --git a/Documentation/translations/zh_CN/core-api/local_ops.rst b/Documentation/translations/zh_CN/core-api/local_ops.rst
index 41e4525038e8..22493b9b829c 100644
--- a/Documentation/translations/zh_CN/core-api/local_ops.rst
+++ b/Documentation/translations/zh_CN/core-api/local_ops.rst
@@ -185,7 +185,7 @@ UP之间没有不同的行为，在你的架构的 ``local.h`` 中包括 ``asm-g
 
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            timer_delete_sync(&test_timer);
     }
 
     module_init(test_init);
--

