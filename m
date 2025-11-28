Return-Path: <stable+bounces-197610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7687AC9285E
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A78234381F
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4960933030A;
	Fri, 28 Nov 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcQPz8uG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857642882D0
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345994; cv=none; b=fsyw6dOPhjkOhgwRi1/R9VpweYqAr/dp+vVwNbJ/uW/d3PUTl9NkU40HErFONWJEuSJKjVCwHsZfx48OHEo/OLiGDsJgP3gD3iN399SYSskFdF+7n0dzIi2MqN4mjo9N2emhGoelrgzmNgdFtsyBmm/rU0qC9pBsiOGIu1gPUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345994; c=relaxed/simple;
	bh=upWSCwkwQ09Z4avIiv+Y6wEsIG3+TFZ3n19V8cmDwBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFXQuiinQitpls29Hj85R8P++jmzM8gQV8m8FvC8O9c/k36dTaca7XRjArUO3DNqoWp7fKi9QZHL+C44HTegBYsmB4dGMj7wWQrnHblnwh5KRcybmClOR3pcC3VRepS+tg0yEftjgSnvVRE5B5UlaDxDU5ti7pNtyJTZBicue+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcQPz8uG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso2375881b3a.1
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345990; x=1764950790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwuFHJSwTOh44O6o4YH5Gva/YZZ2KpNq4JaQIOiJzpU=;
        b=EcQPz8uGQl4K+txb3Y9EM2dWKSUYXg6OdmgUo3d6PJ4cH2DlBvOHkRBqQnEXN8cvhC
         3D/HSsJoU9IceNabHiudkyVLNmzgv/DkxytcDhQN4thfvuwDCadGgF9F+JWCG6QgAFZ8
         /xxvDFP0S15gRiX9gpEUpYdo/2aERv2edG37L/4COtKaU43u4JlfL3/IKJANIvIL6YN6
         Q8sLulTac8U9M5dHSgjJ6WHZL1uko0Zr2bAFKTUkSeZcffOoHhPShxbCU6WUP1UVnFyt
         twfb93Bg1b45IqzxsT5UsNWXLcEradh4CO9zttXwhe9qSul4+raj95xhrKMXieIcob3+
         wBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345990; x=1764950790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NwuFHJSwTOh44O6o4YH5Gva/YZZ2KpNq4JaQIOiJzpU=;
        b=GAzgZUdpc4/rLctGXVSKMdq7KAY9ckP1roR+qxxdNH3mcAqhxks97WrKUd5N5GDWPG
         xtLPNL8H7VZ4prb9CAzovA0wTItMjw6YMYtXsMNsp3LTMXDQzOvI/75DAYzqSvGCjtiu
         b5VJU7Nucrv1Xn5p8pP2UI3ptf1TYT7AbFWIk7heUyV05uGibo8++hYnoE3wQBFSxwH7
         surRReaHFGn5ILgEguGYFHnMcHeHYh6rEvO5kkHYBBqLU7ieKzRiTzDAtHRaqlu7DG7m
         b4ff+Zt0QEyYtfxtaRESx0eB6R0BR98Rq4Xvox7w3YH1yTzgJoVEDtzBUpDPAF62fyz4
         GbmA==
X-Gm-Message-State: AOJu0YwsbBOxClFpvJKC5tGHjnS+I0CPL0YJZqAgQy8EJ5ejE+q5mMy9
	kfVuP6iy12VnGBUezlCz2+Inn02pKurDyCjs262gK6ovVMesxzxxXd0wvlDchhbn5+NxXQ==
X-Gm-Gg: ASbGncu0C3DOCo9nWy1LApdC42Y98GJEWHxfBWQqvAqNHQ4TtqCSy0weBU5m38Ua9EE
	WHy8h9HTpf21FHLONdGKIBxqR0E+kXNq//fyNIcW9pT2CyXt0Go/mqVZkXk27kUEGU96X95Ynmq
	fJ9Pvuf0ThNm+HBNnrFuhy5ToYd3meGWBvKULtnXLSlFxzzTBS61fptUyCR8i0XANtITiTY37oc
	nU1cbtS1ENU+rU6pAl2GkJH9Y1ETVITFMquqs91Uv0jKIZFuw45TXgUkqNQEwrAZNYpPWjJfH8V
	+OXB7LJ2emB8oHLVuaC6RCb9Do3TiSIqeZOI/kLve7L3B4rsawIZoY6cLFSc2boQzyAPLFzpOdC
	OAi8MWGUwBt+MHPR2oXR3g1obVlF2U940Vc0hOwqUwqFicflFYsDSMqQnRzX0D795Ti/cr6yH7R
	/wDxGVnssrQ9yGChM04VGT2qh8sxBxPNYmXBA4Nw==
X-Google-Smtp-Source: AGHT+IHkZ+vfxp4JqrSHcbC8AyzXlNJ0OxaL9SKjjazgTqeaBUUhfQyzRwIoWRt7hmUNiS6wX+LdAw==
X-Received: by 2002:a05:6a20:430f:b0:361:2f3e:cac2 with SMTP id adf61e73a8af0-3614eda843dmr33153993637.33.1764345989932;
        Fri, 28 Nov 2025 08:06:29 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:29 -0800 (PST)
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
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.15.y 08/14] Documentation: Replace del_timer/del_timer_sync()
Date: Sat, 29 Nov 2025 01:05:33 +0900
Message-Id: <20251128160539.358938-9-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128160539.358938-1-aha310510@gmail.com>
References: <20251128160539.358938-1-aha310510@gmail.com>
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

