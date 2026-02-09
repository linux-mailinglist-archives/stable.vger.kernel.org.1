Return-Path: <stable+bounces-214885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAZJJoiGiWkn+gQAu9opvQ
	(envelope-from <stable+bounces-214885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 08:02:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4036A10C4B5
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 08:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29E83007F48
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 07:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75262D0C62;
	Mon,  9 Feb 2026 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4L4Gdck"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91729450F2
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770620546; cv=none; b=qcoENQCbLspWNU077fHpTdpY9eZAsmsFy0jBQzM2zDrothDeFZ9y/ZQa1a5O/dylPWHmte+S1JpAIzoj2RfYOEyuQMuW4issSDE4reQczokFsXBZISlA4ywa6JCrRonTTXII9muMhk0Fx3KGBodM8SV78b2H4g2mv5eqB/HLfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770620546; c=relaxed/simple;
	bh=IOtBl8MKHrgNuRhXhPZVlOsJtxt9RN8qVWDNq6+9ARQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cp1M1h0Z87Oo0FoDQB6BI1/n5ANIHI5vln+kLKX96NxckI/k0qUC+IG54mPHfhDjPL+A7aP3FoD1KuZtLlUXmuZoEJaXG7jdicV+oFs415AXAzCf5FgNBNIVZIs4Ax/Fv6Vqtu+Q5ofbrsOAFF3JR+Z5/+BTEc9eiy+CsVVpKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4L4Gdck; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b8675d4f93so1243020eec.0
        for <stable@vger.kernel.org>; Sun, 08 Feb 2026 23:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770620546; x=1771225346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTQsukcOvGgA1IOwGu0V6U/4Hj9O7nggXaNLrVfcPCU=;
        b=i4L4Gdck2pRYyWTfLd+BwWzgMD2mp3jybKtsiMskNmG3ALh/dTzi9aRyKkaLvO94Ab
         375+tTtGA9afCyIz9YUNE4e6FkVJhjjItpsLd1NK7Z4pEfRrPWACT8/k7HHbfZUg1GpK
         LfTAyA00vEigr4C3otMrmZJEDI+X4yRU/1fn//SwipRqYbqc11yREZzBGornsvWUqKDf
         NQvPrV9zF2JswziCuDIy1U2u6hXm3MgJgveBYecahRN3FPdJzn/A82JvXw6Y3H9N7w6C
         2rsD45f/kL6no+wNwCsPhsOyUqafaoJr2sSLuCtsQdzUjO0AMVbQbDht9IXsr4vAPreg
         g3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770620546; x=1771225346;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QTQsukcOvGgA1IOwGu0V6U/4Hj9O7nggXaNLrVfcPCU=;
        b=nvFihN9JG2ExjteDQGaR6U/9XFQgBRnp9HBqX8WAXcFFbU3EJCXZiziuLGwJrssqOu
         3Npp6Bd9BrihTOvoksrKLXVhF80ZH4n2fcEQ14pOXyWCoNaxySJ8SP6AC4SlPRU+Ghn0
         CBKFPwrsS3MqkhlnpH3gyDet94M+0rVitWb1697eV9rXK5m8/lLjVLC7CRkNmRg9RXwR
         q4iWN72SgKpDUxfVVZ4USe2HU3EBTw21+2StC2h0ClCNpY/U8ecUrXRrMnbWSWrE9KI+
         AzBrWHCBqrrrmvPAkQb6lrGvWypL0kyH4bo98Mfa1IhxOnlG8QgACCvwkBaOhpbUItLu
         fAXg==
X-Forwarded-Encrypted: i=1; AJvYcCXeNWtR7JuUAwaeG8D5OwctGh5dvLA079znuBGYUpOhau8NgArWYokI2zurwM935u5XkR1Qc2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgpaKMXKhu0kV70BhsdYDscYumxgXNX7C+4M8rMU730coHUqdO
	ESKy5ioAAGKhbHaCmdg4YdEuvKp9JmVEz5XU7BReJWzpDoby8HUdjgdk
X-Gm-Gg: AZuq6aL1Ht+YO12zOpm0D4mgV7ycqytjRCjW/ppVzUeO6/Y7otUgfFmnw4m3FAn3P7/
	5WlC3S2V6AXgBh0wC+rSKFWqGoc/71LH7Sc1E2hfhRbsnUyxxL+/0W9wdVXS2rpe1mro0wkZqMx
	fOCKBjHGgDh2JLa/9VPvwb+GsW1BRCPxwND5K1wUwfX7cD43xCE0wIU5ZuC4i+1rrQAZJh/J/6P
	2H40XwgfXdKIRTgNEKexpNbpWoRDzZ3tFcs/mRVt73nMjJY4ctfb6Ha5nCXj6KS64ZprwFyJb/b
	wcaXWI93nrWwttAu19jUN5tSj8QQrin349/9oapnRCiPE7jk+FVasbc49+xd/CbsscaCtQc0sYX
	OEyuFk8F+KgG0DJpVYT9MCwz6PNnfPywi7Pa3whXp6ZXKDOhlBaT7d2NuJg7AzquOD0CauDWjMv
	4AGdrdCYMcxB6Qmbunb+YJ3+feSCMSYQ==
X-Received: by 2002:a05:7301:38a6:b0:2b8:31e5:918 with SMTP id 5a478bee46e88-2b856a4c311mr3244690eec.37.1770620545505;
        Sun, 08 Feb 2026 23:02:25 -0800 (PST)
Received: from mhkubun.search.charter.net ([66.91.163.55])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12706faa047sm6966305c88.14.2026.02.08.23.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 23:02:25 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: drawat.floss@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	ryasuoka@redhat.com,
	jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Drivers: hv: vmbus: Provide option to skip VMBus unload on panic
Date: Sun,  8 Feb 2026 23:02:00 -0800
Message-Id: <20260209070201.1492-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM_DOM(3.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214885-lists,stable=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.925];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhkelley58@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:replyto,outlook.com:email,outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4036A10C4B5
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com>

Currently, VMBus code initiates a VMBus unload in the panic path so
that if a kdump kernel is loaded, it can start fresh in setting up its
own VMBus connection. However, a driver for the VMBus virtual frame
buffer may need to flush dirty portions of the frame buffer back to
the Hyper-V host so that panic information is visible in the graphics
console. To support such flushing, provide exported functions for the
frame buffer driver to specify that the VMBus unload should not be
done by the VMBus driver, and to initiate the VMBus unload itself.
Together these allow a frame buffer driver to delay the VMBus unload
until after it has completed the flush.

Ideally, the VMBus driver could use its own panic-path callback to do
the unload after all frame buffer drivers have finished. But DRM frame
buffer drivers use the kmsg dump callback, and there are no callbacks
after that in the panic path. Hence this somewhat messy approach to
properly sequencing the frame buffer flush and the VMBus unload.

Fixes: 3671f3777758 ("drm/hyperv: Add support for drm_panic")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel_mgmt.c |  1 +
 drivers/hv/hyperv_vmbus.h |  1 -
 drivers/hv/vmbus_drv.c    | 25 ++++++++++++++++++-------
 include/linux/hyperv.h    |  3 +++
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 74fed2c073d4..5de83676dbad 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -944,6 +944,7 @@ void vmbus_initiate_unload(bool crash)
 	else
 		vmbus_wait_for_unload();
 }
+EXPORT_SYMBOL_GPL(vmbus_initiate_unload);
 
 static void vmbus_setup_channel_state(struct vmbus_channel *channel,
 				      struct vmbus_channel_offer_channel *offer)
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index cdbc5f5c3215..5d3944fc93ae 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -440,7 +440,6 @@ void hv_vss_deinit(void);
 int hv_vss_pre_suspend(void);
 int hv_vss_pre_resume(void);
 void hv_vss_onchannelcallback(void *context);
-void vmbus_initiate_unload(bool crash);
 
 static inline void hv_poll_channel(struct vmbus_channel *channel,
 				   void (*cb)(void *))
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 6785ad63a9cb..97dfa529d250 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -69,19 +69,29 @@ bool vmbus_is_confidential(void)
 }
 EXPORT_SYMBOL_GPL(vmbus_is_confidential);
 
+static bool skip_vmbus_unload;
+
+/*
+ * Allow a VMBus framebuffer driver to specify that in the case of a panic,
+ * it will do the VMbus unload operation once it has flushed any dirty
+ * portions of the framebuffer to the Hyper-V host.
+ */
+void vmbus_set_skip_unload(bool skip)
+{
+	skip_vmbus_unload = skip;
+}
+EXPORT_SYMBOL_GPL(vmbus_set_skip_unload);
+
 /*
  * The panic notifier below is responsible solely for unloading the
  * vmbus connection, which is necessary in a panic event.
- *
- * Notice an intrincate relation of this notifier with Hyper-V
- * framebuffer panic notifier exists - we need vmbus connection alive
- * there in order to succeed, so we need to order both with each other
- * [see hvfb_on_panic()] - this is done using notifiers' priorities.
  */
 static int hv_panic_vmbus_unload(struct notifier_block *nb, unsigned long val,
 			      void *args)
 {
-	vmbus_initiate_unload(true);
+	if (!skip_vmbus_unload)
+		vmbus_initiate_unload(true);
+
 	return NOTIFY_DONE;
 }
 static struct notifier_block hyperv_panic_vmbus_unload_block = {
@@ -2848,7 +2858,8 @@ static void hv_crash_handler(struct pt_regs *regs)
 {
 	int cpu;
 
-	vmbus_initiate_unload(true);
+	if (!skip_vmbus_unload)
+		vmbus_initiate_unload(true);
 	/*
 	 * In crash handler we can't schedule synic cleanup for all CPUs,
 	 * doing the cleanup for current CPU only. This should be sufficient
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index dfc516c1c719..b0502a336eb3 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1334,6 +1334,9 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			bool fb_overlap_ok);
 void vmbus_free_mmio(resource_size_t start, resource_size_t size);
 
+void vmbus_initiate_unload(bool crash);
+void vmbus_set_skip_unload(bool skip);
+
 /*
  * GUID definitions of various offer types - services offered to the guest.
  */
-- 
2.25.1


