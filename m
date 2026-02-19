Return-Path: <stable+bounces-217479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGb8A1RFl2lMwQIAu9opvQ
	(envelope-from <stable+bounces-217479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:16:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA01610AB
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FAAC3055573
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1022A352F81;
	Thu, 19 Feb 2026 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+y3nH+5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C8350D55
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521252; cv=none; b=Dl09g7r5VFAKrUmeQNilxA5ah3y94G7HoUunWICZBXB6kvnC9HuviTegrgNZKMDDAXUiuHK2Di07rhwDtaaRjl1z7ZvgTukHUzR9rHnCEXn/kLsafHajs23qc+N2rpK1egjydur/ZgJu7l0G7z3xeGmCznEeV9PAvy2EZo+9wNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521252; c=relaxed/simple;
	bh=KahrOTGFxHDsPLdgeyQZNnXk2bivNdYNaTpq/NJnvcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2UB7PyT4R8tHTI7z282eVfZm5Y/qi7ahk2FlbZcFuLTm9kJvXI4qXaaKO94ragXU92KL+A/mz8J1aKoH22Ct+Z+dWOslve2+J3DClMONaHEU+s/SlYIDEUOoYEN0Puxf/RGvRz6q2oUWkr1cm3qt78Wwz8Jd3wAJZk60AJ1Yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+y3nH+5; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c70942441ebso732181a12.1
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521250; x=1772126050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9Ys25lUX49p5aMZ9MF04Fc/6uWbxWTtkfKKvleWffc=;
        b=H+y3nH+5udxeJPaKUZRwmeUgCmqkm7YFHPnKJTNeDr3CfyNHftRhVT40mM/Petkfby
         JZUa9gBuCzTIEqAOkBue2YF9cPXtetwjNWQHnSKrtit/9mtFTjSTma2/ZwrqeZ5DW03c
         cOJ5LkbTZxAHG7UA0XvpzH3YSzmit8QsXOTyWxG8vpTX0j2QEX8jEsH4N0lsu+UVNt1K
         oFjhWbPktQv0rpIqayOEuhg93WaLjpJymoLlmVk8u3F66eBkFmfJRwDfdJbmWLBsdHJ/
         fiijiIpW6wDG0bb4sPKc7n/WCEIb5rwoe7/yzt9FSqbqiX5xiKOCfcVHye4eM8+BpTsg
         Su4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521250; x=1772126050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9Ys25lUX49p5aMZ9MF04Fc/6uWbxWTtkfKKvleWffc=;
        b=AO03+ohsg+HNW+gX+V8lq+DC8cPjh+e1UyF9ByIwuOH90x9EoWpCatr5QrsaFZi7h/
         FI+ncjsk5WFsTAfVkyNnQemzKENp4GZSxz5qgDbtzbHaZasg4XUmCwsLupuz7HsIKzXs
         vc/WHsHtWVlh/+yaOy1BwLtwyU+Fg8BdJuYuecIA/Hj9L8aQd80kaMCzRsBa/2g0ax4O
         IAaLPR0bDFYg2qKr9kB5xMHkVTxOC3KxStnPgSC0DnKP61vgmsH+kSLaBejyrvl21pTr
         C+VY5R4Yk+D2A/cejxEZTLJgapCaqLH1px2255kYjWBz0sumpMystlpL57S7cw4JFvSW
         Rxkw==
X-Gm-Message-State: AOJu0Yy4HKOOxm6/AuHOhA/MPlDbP08HxcgEUlsaMkiE62aZGahKeqh+
	ZS1DH4J/lHfQEJV5mN1B5m/ih0fjxhsIpj8ruIvTk3QkP65VFkPtpaC2uFFQoGuudSY=
X-Gm-Gg: AZuq6aI9Xj1fpjP1tQ8FeUI0jiYwFRZhWJ08eV8vniWBMCtYGrfKtCu5xl2FJ5ETVOV
	XR1BRHeZGV2ckecb4es/OP2JFxSiPY0PhsZim+J70Rx6yOvbIcjrbzLDedju4W5XbRD1N3FC0NX
	opzPvh9TJCJuXvh5CCfhT/dbrJPhQ7DQHTX0GI/aCmXCAhVTqw/QDy/wl6ieaQW+DokhdJ39Y0S
	Jgw6KNHzICuQ6ckzzJTkgVLDw8dkDs20IVLu2Xau1d0bn7xQscyKnmn3ZCi09VZ+bo9uzbKGgNK
	IhPUeeY4Ac5qxLMvzV3pgD00avLpMysa4E+qcFx6E+gZNs2Cp1Mo9Rzxm4tXqHj+lG46pm/sNM7
	ji7Apnl2xKD9npo09AQIJANvMlswft9MaL3zkdfAIB1z/oGeK6nFo/qYMDU8oz/Q6/uC/Orz+UX
	QeZ1X2GLJGE/5kSCJkPak3ttkPFJaj/tIkMfMNTnUMT2e+DmwwOg==
X-Received: by 2002:a05:6a21:7785:b0:395:1869:f63c with SMTP id adf61e73a8af0-3951869f8e7mr1782258637.18.1771521250511;
        Thu, 19 Feb 2026 09:14:10 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:14:09 -0800 (PST)
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
	zouyipeng@huawei.com,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.10.y 13/15] timers: Update the documentation to reflect on the new timer_shutdown() API
Date: Fri, 20 Feb 2026 02:13:08 +0900
Message-Id: <20260219171310.118170-14-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219171310.118170-1-aha310510@gmail.com>
References: <20260219171310.118170-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,vger.kernel.org,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-217479-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,goodmis.org:email,roeck-us.net:email,linutronix.de:email,intel.com:email]
X-Rspamd-Queue-Id: 8DAA01610AB
X-Rspamd-Action: no action

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit a31323bef2b66455920d054b160c17d4240f8fd4 ]

In order to make sure that a timer is not re-armed after it is stopped
before freeing, a new shutdown state is added to the timer code. The API
timer_shutdown_sync() and timer_shutdown() must be called before the
object that holds the timer can be freed.

Update the documentation to reflect this new workflow.

[ tglx: Updated to the new semantics and updated the zh_CN version ]

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221110064147.712934793@goodmis.org
Link: https://lore.kernel.org/r/20221123201625.375284489@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
 Documentation/core-api/local_ops.rst                   | 2 +-
 Documentation/kernel-hacking/locking.rst               | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index ad2cc20131ec..e8af3dc3c95a 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any attempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding ``mod_timer()`` must be dealt
-with via ``timer_delete_sync()`` or similar.
+with via ``timer_shutdown_sync()`` or similar.
 
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke ``call_rcu()``, the callback function is eventually going to be
diff --git a/Documentation/core-api/local_ops.rst b/Documentation/core-api/local_ops.rst
index a84f8b0c7ab2..0b42ceaaf3c4 100644
--- a/Documentation/core-api/local_ops.rst
+++ b/Documentation/core-api/local_ops.rst
@@ -191,7 +191,7 @@ Here is a sample module which implements a basic per cpu counter using
 
     static void __exit test_exit(void)
     {
-            timer_delete_sync(&test_timer);
+            timer_shutdown_sync(&test_timer);
     }
 
     module_init(test_init);
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 86ac2f4d24f7..4b8fd764aa7f 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1016,6 +1016,11 @@ calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
 use timer_delete_sync() (``include/linux/timer.h``) to handle this case.
 
+Before freeing a timer, timer_shutdown() or timer_shutdown_sync() should be
+called which will keep it from being rearmed. Any subsequent attempt to
+rearm the timer will be silently ignored by the core code.
+
+
 Locking Speed
 =============
 
--

