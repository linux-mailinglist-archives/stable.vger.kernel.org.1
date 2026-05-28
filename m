Return-Path: <stable+bounces-255053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKwZFXBqGGrcjggAu9opvQ
	(envelope-from <stable+bounces-255053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:16:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0C45F4DB6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3E8531AA853
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56523FCB03;
	Thu, 28 May 2026 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="i+oYMtE2"
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DDC3F9293;
	Thu, 28 May 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983483; cv=none; b=UZA3PdGM1Z/wjOMpmAo4hvPr/0UTFzGWG0wzwBBHbFKiuy8wT30ALrofS043JVXYWMsbrajoHkyZ0iyyRMhhmcE44nKzCj2JF+p5lQVek9mCczgmeIVvZtgQ9ZZuJ6cDZreZsMZjOJlIZQrmmhHo7/z1WVQfFACu9jwhJmEUctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983483; c=relaxed/simple;
	bh=C9nbPprPSzvyG1eI6izTWL/Iwk1S4ELptvpZgAnKHhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F0AIMjfLSdWkO4LI7568Ds8aZECkIsjScEcZRLpQYNK50uMKLDxEjMtTewIDvOtncrHKxmjJthm2IXX3iA4rd087s8GZhYc2RESJM4vknJmyDpCe6sbQCO2bAEOyHTd8vvlKHzPkyPFmr68fewhdH+HQWqdDqZdW4f8XNDRXYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=i+oYMtE2; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from PC-202605011814.localdomain (unknown [IPV6:2409:8924:2013:1a6b:50af:214a:ea2b:7da2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 403418ca8;
	Thu, 28 May 2026 23:45:58 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	jerome.anand@intel.com,
	pierre-louis.bossart@linux.dev,
	tiwai@suse.de,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE audio irq
Date: Thu, 28 May 2026 23:45:51 +0800
Message-Id: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e6f438ac703a1kunmeb945bb5695a4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSExCVh0YSUkfQhkeSUwaHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSU9BSUtKSEFKGk0ZQU5LGh1BSUpPGkEeGkkZQU
	wfGklZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=i+oYMtE2Uw987NRwaIDLItV2PiXrfbsCTGptQqXsNBgKX6eSnYckWaW0ilkf7Z7q+7yAlojA/BSfPcWvvYgWDMC+MwDVjA1CKybUCLSlyt7b5omxUKGD8J1isNfRVgCxMr1Zzr4PoQ2O/iAqTsdK0sc00d6YEq5mSmAC+XtT38o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=loucx8xe4IYiCrHUEihfpijKrZOkZGAVA8/7vYAgfsM=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.intel.com,ursulin.net,gmail.com,ffwll.ch,linutronix.de,kernel.org,goodmis.org,intel.com,linux.dev,suse.de,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,seu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-255053-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EE0C45F4DB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

intel_lpe_audio_irq_handler() forwards the LPE audio child IRQ from the
i915 parent IRQ path with generic_handle_irq(). The forwarded child top
half is not an independent hardirq entry point; it inherits the context
of the outer i915 interrupt dispatch path.

This becomes a problem when the parent IRQ runs in threaded context, for
example on PREEMPT_RT or other forced-threading configurations. i915
requests the parent IRQ with IRQF_SHARED and without IRQF_NO_THREAD, so
the forwarded child handler can run with local IRQs enabled. That
violates the expected top-half execution semantics and can trigger an
"enabled interrupts" WARN.

The issue was identified on Linux v6.18.21 by our static analysis tool
and then manually reviewed on the i915 child-IRQ forwarding sites after
commit 8cadce97bf26 ("drm/i915/gsc: mei interrupt top half should be in
irq disabled context") fixed the same helper contract for the GSC path.

It was then validated with a reproducible QEMU no-device parent/child
IRQ harness that registers a threaded parent IRQ and a child IRQ
handler, then exercises both generic_handle_irq() and
generic_handle_irq_safe() under the same threaded parent context. In the
plain-helper phase, the child handler ran with irqs_disabled=0 and
triggered an "enabled interrupts" WARN. In the safe-helper phase, the
same child handler ran with irqs_disabled=1. This is family-level
runtime evidence for the same IRQ forwarding misuse pattern. No
Baytrail/Cherrytrail hardware was available to run the real i915 LPE
path end-to-end.

Use generic_handle_irq_safe() here so the forwarded LPE audio child IRQ
runs with local IRQs disabled even when the outer i915 dispatch path is
threaded.

Fixes: eef57324d926 ("drm/i915: setup bridge for HDMI LPE audio driver")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/i915/display/intel_lpe_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lpe_audio.c b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
index 42284e9928f2..ac1dfd592a9f 100644
--- a/drivers/gpu/drm/i915/display/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
@@ -263,7 +263,7 @@ void intel_lpe_audio_irq_handler(struct intel_display *display)
 	if (!HAS_LPE_AUDIO(display))
 		return;
 
-	ret = generic_handle_irq(display->audio.lpe.irq);
+	ret = generic_handle_irq_safe(display->audio.lpe.irq);
 	if (ret)
 		drm_err_ratelimited(display->drm,
 				    "error handling LPE audio irq: %d\n", ret);
-- 
2.34.1

