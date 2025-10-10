Return-Path: <stable+bounces-184019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE5BCDB32
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45A64356241
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69D12FB963;
	Fri, 10 Oct 2025 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8yg2lEK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157872FB62E
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108635; cv=none; b=qJ4oEs507gu01ztJ5ThkKasQ8qV8tkt/Cvno7IdeHD5sCkF+ytmGXnAQiOHAQF7ufCpCHIJvdGSFpGwW8YrzW/ZoN4Ro0pgRIrf/4vJnDTpSUTqGkpoooUo24mhWQ4BkNuDgaXU98O4NThhuhhTqZAg/jLZbEt74w4vZMSGVPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108635; c=relaxed/simple;
	bh=e1DK8j+FiXmlj1eFN8Izgd5UcqsQJns59AycqwDqK3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPo1C4UUYtk7/DWq516HV7bIrsuCX1S6RpdMe4+dU8lH1un2F88TRplNJJOlTYM9rzfccTcaAIMPy9HoUh64Y0C+s21ivqOXPbU8lQnNeAYlZFdiF95NUMUMSAiLNOo0NlVXopEr7mUk3h4Jg4gkSD81v9myEZCYDIP8u2HkR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8yg2lEK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-796f9a8a088so1954592b3a.1
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108633; x=1760713433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGmuQqZjeUhbRmxIHTmmKtGFb/p0zxMormCTfTuA8dI=;
        b=M8yg2lEK0eQ8LABS4EHF3G0aJHw0OO9hjmn7LMbj8YoIrf0ZAKiZClHet5XquX34p8
         VLhGv3r26y59xEjMUaR8ZT+Y+CJhhYp88SbYQ7vRAMD/afi0Edq2C9UtCjNssYRHFMWO
         RMSDJRpubVBdpm4j79o5URT4OI+Qjz4r2cO+5aKxT9GjiuUVHQ0VIM3T/0txvVCj3YNI
         ZG3kG79jddBzjBzycdS8wPMbCAc69wDV2O1QXYB5c8NYXsbRzM+mBj7BZLjKm3FsbqHH
         onm5sHpkwst+yp1/g32p0gLMnlqrc1OTS0khf0bJGPRGtB49u1jx6eH/vLsGLSlBYlgB
         GbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108633; x=1760713433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGmuQqZjeUhbRmxIHTmmKtGFb/p0zxMormCTfTuA8dI=;
        b=KfXcDHmzXgWKNg1yLoNur5ErRSQTcKUOgGQYiczkgg+9Y7tLqigw7HTzYM1XsXkqYO
         JqpC35jPZOSu730Qd3AScCqyavAdZeu+lagup1FdSTuTm/oEukhKACqJR5O27qES9fo/
         BCGh6ajYBWITNy3danx2vJtFoU2ltFClH2k66GHt6PU/ehAXU+v2UCmatD5QY4qtlYlp
         TxhHotD609Jl48frnyqT4qyS5AU8j49NHoTu0MfVRGeW6srhh3c7DLigaYdooe6Q+6wx
         5x+dPaTGQxvuUnM9XEeiZH4Pp3ig6OR8GOfPerE6UtMKLDa2eb/Wa2xWW+mOmyOmUCQl
         06iQ==
X-Gm-Message-State: AOJu0YwANKqmI3LKqyfjN3GGlciQTNlDGENGmjDRjQRWMBmR16eQDFb4
	qTLcoDpEFKW8UlyRcE267+PG6x5UNzu4WZTs8viq1XYloVji85WEWNdAabOGGo3AOrE0Cg==
X-Gm-Gg: ASbGnctP0n6NN/np8tFldEi6wn9Ws6hGRP/M0KapTlt9zcniHjWFBFkUjXOVEVeLrww
	Lfz6wW+HByJP9RwVJCXMdVCNUgkMDqK1oRQlUgLWArfxXCmxzNpDrDxvfIEUwWiaVFjWQT0CpVC
	m6O3AdpNY+fd7pT4B5SqvTG6I5Hz7wlo95Knf1AX3bMzD/eV8HFArHclivnzb8Q6Ahbz1hq6cdE
	7oKH7ibFY98AdSg0CTmlsyWXiiV/cEFvfSFhRkGeSzDpHWLCx1S7XeJk+ZFVvPbX2tjwooWDneQ
	BBhrLQ16iR/fjNrRQQ7u0MJK12lPaEJenhGi5LRbpHnmVcwxhFHLo5uANixYew/m30pAPDfurmM
	JxuKxuHcnA6Da236pUwekdIjXB2DTP4hc9EQNWiXnTKflMr38198s+5Ll0J372PsdlAGi
X-Google-Smtp-Source: AGHT+IGjzwugYg2s6sAV1EGo1X7orkT1LFT21fxzMkAVvt7JQEZDZ/htyUsq6DK7NaGUctCAjKtjzA==
X-Received: by 2002:a05:6a00:1495:b0:776:20c2:d58b with SMTP id d2e1a72fcca58-79387435d86mr15675430b3a.24.1760108632753;
        Fri, 10 Oct 2025 08:03:52 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:52 -0700 (PDT)
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
Subject: [PATCH 6.1.y 11/12] timers: Update the documentation to reflect on the new timer_shutdown() API
Date: Sat, 11 Oct 2025 00:02:51 +0900
Message-Id: <20251010150252.1115788-12-aha310510@gmail.com>
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
 Documentation/RCU/Design/Requirements/Requirements.rst  | 2 +-
 Documentation/core-api/local_ops.rst                    | 2 +-
 Documentation/kernel-hacking/locking.rst                | 5 +++++
 Documentation/translations/zh_CN/core-api/local_ops.rst | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 546f23abeca3..49387d823619 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any attempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding mod_timer() must be dealt
-with via timer_delete_sync() or similar.
+with via timer_shutdown_sync() or similar.
 
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke call_rcu(), the callback function is eventually going to be
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
index c447d55fa080..3bbb11ba647a 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1007,6 +1007,11 @@ calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
 use timer_delete_sync() (``include/linux/timer.h``) to
 
+Before freeing a timer, timer_shutdown() or timer_shutdown_sync() should be
+called which will keep it from being rearmed. Any subsequent attempt to
+rearm the timer will be silently ignored by the core code.
+
+
 Locking Speed
 =============
 
diff --git a/Documentation/translations/zh_CN/core-api/local_ops.rst b/Documentation/translations/zh_CN/core-api/local_ops.rst
index 22493b9b829c..eb5423f60f17 100644
--- a/Documentation/translations/zh_CN/core-api/local_ops.rst
+++ b/Documentation/translations/zh_CN/core-api/local_ops.rst
@@ -185,7 +185,7 @@ UP之间没有不同的行为，在你的架构的 ``local.h`` 中包括 ``asm-g
 
     static void __exit test_exit(void)
     {
-            timer_delete_sync(&test_timer);
+            timer_shutdown_sync(&test_timer);
     }
 
     module_init(test_init);
--

