Return-Path: <stable+bounces-197216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B3C8EE8F
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7CA24EDF4E
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51430DEC7;
	Thu, 27 Nov 2025 14:52:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C22FBE03
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255123; cv=none; b=d19mq67cPSwN3dtI5A05rv+s+TKC+2zfJ2O2l4jhHITNLIlDd6u+8FDNeZllLxb05K5lb3xRWyBeBpIRYNtBh+NfWvGuieCgHPG5tDR2W1IFWhVd/2Ut2hg8GoSijYOGrzgPvOgKv2AKu2o6Gqs3S88nKcKWys7jbNEJUo0kZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255123; c=relaxed/simple;
	bh=La8G30hl9qem1PV0MHxUCDzheJkZdQA86wiUtuO0D5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jptORcy9oZar3KU10az2HvDVxAQf4uSYKKPlGzPuqKON7A6GsClllFMQ3lxxpaMBH8S1ZZZ8KV/RY/QKeBMjncCF2015qn4R2Ln1CV8nB4JDGOjUgsxz2lUyDLYFo9kSBMHYHtHbVZQXIqUchJ5fVL1++Fvjpx/pIilXo2nqS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ec96ee3dabso691319fac.1
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 06:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764255120; x=1764859920;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAIzZlwt931JkoUZjg2FOr5ixA966v/JOvVIg0npcNI=;
        b=EfOHcGsaWvZrKPQ1/Kedz01xor5Lr0sfG3pXBmOKeT46AWr2chosoBfOTTocG2A6Lp
         hcV3SMtZBLjrKs8FYY41NTRGRGUOml7W+9dxIU5Ca0oIkxyhY8NxtnRw+ip7eK9zxPsR
         LNL2EYfhEhGVCX8bohbEyc6ff+JvGieHTb0RP+QoBho/rLfbE260oY+g/YBeXbpIHqKe
         3vqWGmhmFQf63IuSSThk7lhpS33BTRlcgtGBOKEKt/GDMpl5f6zqE9exulXDsouire6A
         BY3VjkWYMNwPnv0QFI1c6ZIw9OMw6JhHE5IAAX/uh3vFA1kprZcesueFsLL7Fp+l9/tm
         Norg==
X-Forwarded-Encrypted: i=1; AJvYcCWPK6N30pmTuuNuEfLF5t4PbRkUVUwnCZip+PBFEWW858KfExfHZiq15ATex3z74sHfOB/xp9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Q189luQwUFEn6DOefXF9iGSLHGReb51sLqBbMBTal6DTDgVC
	I3BXD1vzarrCgPBrg8kTd6TMr6xuU4t/ovEKS2EjaHQsmc0Ml+tVLHmR
X-Gm-Gg: ASbGncuAwe9uczV4OhvVTuRH0WiYsa280SlojU1eZYnOewzOMHoAD2glrh4jRPCls4U
	yKUAYmJm3nggJM1qWSIAJrwGNg3chQmm/Tz2NxCznkWyCXf3GM4n+0JKSI3VgTAPOl66J8ikfec
	bDR89BWRyuxeIHBjmEX2MGGSqfHEIcjcwhr9AdxVZU/Yhem0MqfFcT86ov6HtZr1cOMlA/dttjl
	JtHQ66uKQzeItoTcORfv7JH+mzSGwej/udxRNA46HkR+dS5LRWEsucHtIkkfbckZsZI+aJgl3lF
	GrLItiwzOlMq0H4rTQv4B71Sr27mSmroKsXntFEJ0M34WSx8b9XQvCd5yIGf3zSOhL58tCVN28P
	0XUiY7YW+N5/KXoqkAAVoPZSUyAL6SD8JkTVxo5bAsjTYH/VK9JdaCVOFoSfabEwARS5RuRf8kW
	Nt8H2DSQb4AQQlQw==
X-Google-Smtp-Source: AGHT+IGjXOzX1/INjAxLcMiQb6vVvjsDvCY0JqSDikDDbIziJmMNiu2ppTrz8kRjx6Znh9+6s5DyAA==
X-Received: by 2002:a05:6808:21a4:b0:450:f45e:f4a9 with SMTP id 5614622812f47-45115a2eb3amr8969148b6e.19.1764255120607;
        Thu, 27 Nov 2025 06:52:00 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5b::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4531708e744sm431286b6e.11.2025.11.27.06.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 06:51:59 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 27 Nov 2025 06:51:54 -0800
Subject: [PATCH v2] mm/kfence: add reboot notifier to disable KFENCE on
 shutdown
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-kfence-v2-1-daeccb5ef9aa@debian.org>
X-B4-Tracking: v=1; b=H4sIAIplKGkC/2XMsQ6CMBAA0F+53EyNVwRsJ//DMJT2gItJMa1pN
 KT/bmR1fcPbMXMSzmhhx8RFsmwRLegG0K8uLqwkoAXUZ90R6V49Zo6e1UV7085mas1gsAF8Jp7
 lfUT3sQFcJb+29DneQj/9KwopUp3rmcLg+yv5W+BJXDxtacGx1voFZj9m850AAAA=
X-Change-ID: 20251126-kfence-42c93f9b3979
To: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3057; i=leitao@debian.org;
 h=from:subject:message-id; bh=La8G30hl9qem1PV0MHxUCDzheJkZdQA86wiUtuO0D5s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKGWPOQkKx1HnYBIusPuWFSi1zEKgAagB3QQqt
 OCZwoLBZX6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaShljwAKCRA1o5Of/Hh3
 bb5qD/sFLPYK6ITq6kgbAyxqkbZNfmJ60A+CPwbjNtm8XT727QN5Zu9W3ONIdtd4AasadA+qGOM
 qjDQscvF6Jqm8M5++IbkBuAb/dOGZ9TEiD5WtK8qwFeWFDdItO6H+pvFxUHj/hki3zstK70/9BA
 dB1ILdAJBqtzW0SM8zJ+mNN5uQCAIbh8QNamqioC6twnkJ7WoK9u39f9FfyC+ZCIQ2HL/mFGwtC
 EmKnY6+9hYwruwBF++2d44yCoaHTRjRnMHrFhsrJbhR2sYnhN3yC7M0G5OqwYhjserxdcmYVAxB
 oEm48SGyNmeK2r+9vcJOpSzh7yF3Yv+YMh70dZbY58he1kXuACNklOMwe+apkA1k3BT5nkRIu8l
 275PckhkwGZhlXVZkwqQ77hNYV6oJrkeh/CHHA8gfRbPysFcnlIn0z2E+cl2S58D6rEttEMJH7A
 QjPJT2prC0+KKql8M3EGoqhZ6l4zJlIbFhZLft1V1MypIsLIbgTzfd0pcdyEEDyTA3VvJO1Y9Ra
 UAjKln6TFsArkYDcZimLTeTVRxOAkvlgvhZDs49MGFtvyYCzBp53BCLXv+mV4+GnMfD3rqcF09+
 ktyKFkRGNqJEb/J+y2SaGlte+it0n37XphkvXKIjM7GYEQey9yI6ZWLGQtzULDou7EIeLx3l85Y
 Cbq0Nap2eYSJfPA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

During system shutdown, KFENCE can cause IPI synchronization issues if
it remains active through the reboot process. To prevent this, register
a reboot notifier that disables KFENCE and cancels any pending timer
work early in the shutdown sequence.

This is only necessary when CONFIG_KFENCE_STATIC_KEYS is enabled, as
this configuration sends IPIs that can interfere with shutdown. Without
static keys, no IPIs are generated and KFENCE can safely remain active.

The notifier uses maximum priority (INT_MAX) to ensure KFENCE shuts
down before other subsystems that might still depend on stable memory
allocation behavior.

This fixes a late kexec CSD lockup[1] when kfence is trying to IPI a CPU
that is busy in a IRQ-disabled context printing characters to the
console.

Link: https://lore.kernel.org/all/sqwajvt7utnt463tzxgwu2yctyn5m6bjwrslsnupfexeml6hkd@v6sqmpbu3vvu/ [1]

Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Marco Elver <elver@google.com>
Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
---
Changes in v2:
- Adding Fixes: tag and CCing stable (akpm)
- Link to v1: https://patch.msgid.link/20251126-kfence-v1-1-5a6e1d7c681c@debian.org
---
 mm/kfence/core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 727c20c94ac5..162a026871ab 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -26,6 +26,7 @@
 #include <linux/panic_notifier.h>
 #include <linux/random.h>
 #include <linux/rcupdate.h>
+#include <linux/reboot.h>
 #include <linux/sched/clock.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -820,6 +821,25 @@ static struct notifier_block kfence_check_canary_notifier = {
 static struct delayed_work kfence_timer;
 
 #ifdef CONFIG_KFENCE_STATIC_KEYS
+static int kfence_reboot_callback(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	/*
+	 * Disable kfence to avoid static keys IPI synchronization during
+	 * late shutdown/kexec
+	 */
+	WRITE_ONCE(kfence_enabled, false);
+	/* Cancel any pending timer work */
+	cancel_delayed_work_sync(&kfence_timer);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block kfence_reboot_notifier = {
+	.notifier_call = kfence_reboot_callback,
+	.priority = INT_MAX, /* Run early to stop timers ASAP */
+};
+
 /* Wait queue to wake up allocation-gate timer task. */
 static DECLARE_WAIT_QUEUE_HEAD(allocation_wait);
 
@@ -901,6 +921,10 @@ static void kfence_init_enable(void)
 	if (kfence_check_on_panic)
 		atomic_notifier_chain_register(&panic_notifier_list, &kfence_check_canary_notifier);
 
+#ifdef CONFIG_KFENCE_STATIC_KEYS
+	register_reboot_notifier(&kfence_reboot_notifier);
+#endif
+
 	WRITE_ONCE(kfence_enabled, true);
 	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
 

---
base-commit: ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0
change-id: 20251126-kfence-42c93f9b3979

Best regards,
--  
Breno Leitao <leitao@debian.org>


