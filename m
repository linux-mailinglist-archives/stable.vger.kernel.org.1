Return-Path: <stable+bounces-163345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D48DB09F17
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 11:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787A97B71AF
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD9A2989B2;
	Fri, 18 Jul 2025 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tJXDeyvK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7BPAH80o"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD12980C4;
	Fri, 18 Jul 2025 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830344; cv=none; b=VyPNz0Ll/L3OHIsP4/fuTBVmmLHdYPFLMdGFvf2kjiryuyJOnQYERayoKRISCKwO3ElyXrfoYB7fPokNzbEPbfDmxTNi4J+TUrF092+g+hewVgkQRy2fiG7zzOl7yHCxbVAHc7L4Z8SQ0IK5H/kEytjkZjbae6qV+cItwgvpMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830344; c=relaxed/simple;
	bh=i11Lfb9jCcjCdnZzfqCChhy3nAJnLHKNA7wmTDd5CRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HRgFDjlYOW3sy3V8/GftqZvJ5VR/ALLEs0v138MRaMtI70hg71YmbpU3Dg2krsXa3sxv9OgfoeoJi1zzySr2ubyHprYLyne8I2snqM1nRI91039/QqMoJpk0vL2PJVyJ9YCtZuC/RHFQTPZF/EWoHEx2y6GfXYuyR8iMjuYZstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tJXDeyvK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7BPAH80o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752830339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=svrawDf7a534xUP7RG0/R6u1J/lCaMllrkc3HWnuPMk=;
	b=tJXDeyvKZL1QpMmjYpeNNIqmIYVFMiwpv6WXNzvKDMALvlcwn4LwFl4NeBFWBoy0QQJ55w
	zHFPJX6OyL39BjlRZd+IC8bEvUKEA8mcOhabKEXGes8MQ90ZZ8JckQvpDPH/DqFYC2jkzr
	9OrBnGZvUE/UMqRl7vOBUShxxAqGElZHWwo7KkWR4zNBdTWpYMIYz7i/RxmbllCbOWUPTj
	zIJiUGecAlH5yK75XoawB2x5CAwwqSHZo7NQa/CT2CsAWdr4HWpaIUOu7zHJF1CgZQcfo2
	0vLZjK4tjWiyOumzlWX47Xp+V9wj7R5o+/lUJKRQcLKZ/lwSNI6noT6ccgpCQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752830339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=svrawDf7a534xUP7RG0/R6u1J/lCaMllrkc3HWnuPMk=;
	b=7BPAH80o/Ga/20wVy34va8eGtxoeeVLJPVgGACfdLy6ApNeXKA5D/RQth2onhTLnd3+dAw
	NWC1TT1jseZV+RDg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] rv: Ensure containers are registered first
Date: Fri, 18 Jul 2025 11:18:50 +0200
Message-Id: <20250718091850.2057864-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If rv_register_monitor() is called with a non-NULL parent pointer (i.e. by
monitors inside a container), it is expected that the parent (a.k.a
container) is already registered.

The containers seem to always be registered first. I suspect because of the
order in Makefile. But nothing guarantees this.

If this registering order is changed, "strange" things happen. For example,
if the container is registered last, rv_is_container_monitor() incorrectly
says this is NOT a container. .enable() is then called, which is NULL for
container, thus we have a NULL pointer deref crash.

Guarantee that containers are registered first.

Fixes: cb85c660fcd4 ("rv: Add option for nested monitors and include sched")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 include/linux/rv.h                                        | 5 +++++
 kernel/trace/rv/monitors/pagefault/pagefault.c            | 4 ++--
 kernel/trace/rv/monitors/rtapp/rtapp.c                    | 4 ++--
 kernel/trace/rv/monitors/sched/sched.c                    | 4 ++--
 kernel/trace/rv/monitors/sco/sco.c                        | 4 ++--
 kernel/trace/rv/monitors/scpd/scpd.c                      | 4 ++--
 kernel/trace/rv/monitors/sleep/sleep.c                    | 4 ++--
 kernel/trace/rv/monitors/sncid/sncid.c                    | 4 ++--
 kernel/trace/rv/monitors/snep/snep.c                      | 4 ++--
 kernel/trace/rv/monitors/snroc/snroc.c                    | 4 ++--
 kernel/trace/rv/monitors/tss/tss.c                        | 4 ++--
 kernel/trace/rv/monitors/wip/wip.c                        | 4 ++--
 kernel/trace/rv/monitors/wwnr/wwnr.c                      | 4 ++--
 tools/verification/rvgen/rvgen/templates/container/main.c | 4 ++--
 tools/verification/rvgen/rvgen/templates/dot2k/main.c     | 4 ++--
 tools/verification/rvgen/rvgen/templates/ltl2k/main.c     | 4 ++--
 16 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 97baf58d88b2..094c9f62389c 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -119,5 +119,10 @@ static inline bool rv_reacting_on(void)
 }
 #endif /* CONFIG_RV_REACTORS */
=20
+#define rv_container_init device_initcall
+#define rv_container_exit __exitcall
+#define rv_monitor_init late_initcall
+#define rv_monitor_exit __exitcall
+
 #endif /* CONFIG_RV */
 #endif /* _LINUX_RV_H */
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c b/kernel/trace/=
rv/monitors/pagefault/pagefault.c
index 9fe6123b2200..2b226d27ddff 100644
--- a/kernel/trace/rv/monitors/pagefault/pagefault.c
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
@@ -80,8 +80,8 @@ static void __exit unregister_pagefault(void)
 	rv_unregister_monitor(&rv_pagefault);
 }
=20
-module_init(register_pagefault);
-module_exit(unregister_pagefault);
+rv_monitor_init(register_pagefault);
+rv_monitor_exit(unregister_pagefault);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.c b/kernel/trace/rv/monit=
ors/rtapp/rtapp.c
index fd75fc927d65..b078327e71bf 100644
--- a/kernel/trace/rv/monitors/rtapp/rtapp.c
+++ b/kernel/trace/rv/monitors/rtapp/rtapp.c
@@ -25,8 +25,8 @@ static void __exit unregister_rtapp(void)
 	rv_unregister_monitor(&rv_rtapp);
 }
=20
-module_init(register_rtapp);
-module_exit(unregister_rtapp);
+rv_container_init(register_rtapp);
+rv_container_exit(unregister_rtapp);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
diff --git a/kernel/trace/rv/monitors/sched/sched.c b/kernel/trace/rv/monit=
ors/sched/sched.c
index 905e03c3c934..e89e193bd8e0 100644
--- a/kernel/trace/rv/monitors/sched/sched.c
+++ b/kernel/trace/rv/monitors/sched/sched.c
@@ -30,8 +30,8 @@ static void __exit unregister_sched(void)
 	rv_unregister_monitor(&rv_sched);
 }
=20
-module_init(register_sched);
-module_exit(unregister_sched);
+rv_container_init(register_sched);
+rv_container_exit(unregister_sched);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/=
sco/sco.c
index 4cff59220bfc..b96e09e64a2f 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -80,8 +80,8 @@ static void __exit unregister_sco(void)
 	rv_unregister_monitor(&rv_sco);
 }
=20
-module_init(register_sco);
-module_exit(unregister_sco);
+rv_monitor_init(register_sco);
+rv_monitor_exit(unregister_sco);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
diff --git a/kernel/trace/rv/monitors/scpd/scpd.c b/kernel/trace/rv/monitor=
s/scpd/scpd.c
index cbdd6a5f8d7f..a4c8e78fa768 100644
--- a/kernel/trace/rv/monitors/scpd/scpd.c
+++ b/kernel/trace/rv/monitors/scpd/scpd.c
@@ -88,8 +88,8 @@ static void __exit unregister_scpd(void)
 	rv_unregister_monitor(&rv_scpd);
 }
=20
-module_init(register_scpd);
-module_exit(unregister_scpd);
+rv_monitor_init(register_scpd);
+rv_monitor_exit(unregister_scpd);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monit=
ors/sleep/sleep.c
index eea447b06907..6980f8de725d 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -229,8 +229,8 @@ static void __exit unregister_sleep(void)
 	rv_unregister_monitor(&rv_sleep);
 }
=20
-module_init(register_sleep);
-module_exit(unregister_sleep);
+rv_monitor_init(register_sleep);
+rv_monitor_exit(unregister_sleep);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
diff --git a/kernel/trace/rv/monitors/sncid/sncid.c b/kernel/trace/rv/monit=
ors/sncid/sncid.c
index f5037cd6214c..97a126c6083a 100644
--- a/kernel/trace/rv/monitors/sncid/sncid.c
+++ b/kernel/trace/rv/monitors/sncid/sncid.c
@@ -88,8 +88,8 @@ static void __exit unregister_sncid(void)
 	rv_unregister_monitor(&rv_sncid);
 }
=20
-module_init(register_sncid);
-module_exit(unregister_sncid);
+rv_monitor_init(register_sncid);
+rv_monitor_exit(unregister_sncid);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
diff --git a/kernel/trace/rv/monitors/snep/snep.c b/kernel/trace/rv/monitor=
s/snep/snep.c
index 0076ba6d7ea4..376a856ebffa 100644
--- a/kernel/trace/rv/monitors/snep/snep.c
+++ b/kernel/trace/rv/monitors/snep/snep.c
@@ -88,8 +88,8 @@ static void __exit unregister_snep(void)
 	rv_unregister_monitor(&rv_snep);
 }
=20
-module_init(register_snep);
-module_exit(unregister_snep);
+rv_monitor_init(register_snep);
+rv_monitor_exit(unregister_snep);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
diff --git a/kernel/trace/rv/monitors/snroc/snroc.c b/kernel/trace/rv/monit=
ors/snroc/snroc.c
index bb1f60d55296..e4439605b4b6 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.c
+++ b/kernel/trace/rv/monitors/snroc/snroc.c
@@ -77,8 +77,8 @@ static void __exit unregister_snroc(void)
 	rv_unregister_monitor(&rv_snroc);
 }
=20
-module_init(register_snroc);
-module_exit(unregister_snroc);
+rv_monitor_init(register_snroc);
+rv_monitor_exit(unregister_snroc);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
diff --git a/kernel/trace/rv/monitors/tss/tss.c b/kernel/trace/rv/monitors/=
tss/tss.c
index 542787e6524f..8f960c9fe0ff 100644
--- a/kernel/trace/rv/monitors/tss/tss.c
+++ b/kernel/trace/rv/monitors/tss/tss.c
@@ -83,8 +83,8 @@ static void __exit unregister_tss(void)
 	rv_unregister_monitor(&rv_tss);
 }
=20
-module_init(register_tss);
-module_exit(unregister_tss);
+rv_monitor_init(register_tss);
+rv_monitor_exit(unregister_tss);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/=
wip/wip.c
index ed758fec8608..5c39c6074bd3 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -80,8 +80,8 @@ static void __exit unregister_wip(void)
 	rv_unregister_monitor(&rv_wip);
 }
=20
-module_init(register_wip);
-module_exit(unregister_wip);
+rv_monitor_init(register_wip);
+rv_monitor_exit(unregister_wip);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitor=
s/wwnr/wwnr.c
index 172f31c4b0f3..ec671546f571 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -79,8 +79,8 @@ static void __exit unregister_wwnr(void)
 	rv_unregister_monitor(&rv_wwnr);
 }
=20
-module_init(register_wwnr);
-module_exit(unregister_wwnr);
+rv_monitor_init(register_wwnr);
+rv_monitor_exit(unregister_wwnr);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
diff --git a/tools/verification/rvgen/rvgen/templates/container/main.c b/to=
ols/verification/rvgen/rvgen/templates/container/main.c
index 89fc17cf8958..5820c9705d0f 100644
--- a/tools/verification/rvgen/rvgen/templates/container/main.c
+++ b/tools/verification/rvgen/rvgen/templates/container/main.c
@@ -30,8 +30,8 @@ static void __exit unregister_%%MODEL_NAME%%(void)
 	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
 }
=20
-module_init(register_%%MODEL_NAME%%);
-module_exit(unregister_%%MODEL_NAME%%);
+rv_container_init(register_%%MODEL_NAME%%);
+rv_container_exit(unregister_%%MODEL_NAME%%);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("dot2k: auto-generated");
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main.c b/tools/=
verification/rvgen/rvgen/templates/dot2k/main.c
index 83044a20c89a..d6bd248aba9c 100644
--- a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
@@ -83,8 +83,8 @@ static void __exit unregister_%%MODEL_NAME%%(void)
 	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
 }
=20
-module_init(register_%%MODEL_NAME%%);
-module_exit(unregister_%%MODEL_NAME%%);
+rv_monitor_init(register_%%MODEL_NAME%%);
+rv_monitor_exit(unregister_%%MODEL_NAME%%);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("dot2k: auto-generated");
diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c b/tools/=
verification/rvgen/rvgen/templates/ltl2k/main.c
index f85d076fbf78..2069a7a0f1ae 100644
--- a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
@@ -94,8 +94,8 @@ static void __exit unregister_%%MODEL_NAME%%(void)
 	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
 }
=20
-module_init(register_%%MODEL_NAME%%);
-module_exit(unregister_%%MODEL_NAME%%);
+rv_monitor_init(register_%%MODEL_NAME%%);
+rv_monitor_exit(unregister_%%MODEL_NAME%%);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR(/* TODO */);
--=20
2.39.5


