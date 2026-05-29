Return-Path: <stable+bounces-256568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDuHB8BaGWoLvwgAu9opvQ
	(envelope-from <stable+bounces-256568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:22:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 226EB5FFD92
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7F83306CADB
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7143B6C05;
	Fri, 29 May 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xMQ5Kc5i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QiAiAg2c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xMQ5Kc5i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QiAiAg2c"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F8351C13
	for <stable@vger.kernel.org>; Fri, 29 May 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046267; cv=none; b=iJODUghuBH+3z78hsdyLQ9h+/Z6qLghZi6okCoo7dMtdZnXQDL8nZzXgipcZlFoIQweNz0+0B7t3QOD92A2y0PZYIsRTtn0pil4+HoslcSwyiWvnPzBUBw675CLEam7whw8yGp4PmYkXn7BGFxR9gZTuqgDPDPH/+u5UxTf2ivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046267; c=relaxed/simple;
	bh=aIMXXMmdGFJQMy3lk/GrhI7bsQb0dQo6GQ6Q1+ldTZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TeWWoL2ZCFrstaN8jvR1PkkCgWTxq6tqxKCodgmlk8G9+rMqjVRyDfxcl27F4nVW63n0iXGvXz+SNUdY97LLtwYg5uMs4ILRieEbkgswQsYtPEC2RaCHeWM2uw8sNZRJGlyvq/0BUbT0UOmryfljvelrQYugHDRT2XsKTwK7Ges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xMQ5Kc5i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QiAiAg2c; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xMQ5Kc5i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QiAiAg2c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B60026724E;
	Fri, 29 May 2026 09:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780046263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YMzWa8hGe9L9/zv4+cFX6ZWXDFKfDHw88RAycQYHp9A=;
	b=xMQ5Kc5iQHQxbZThQ3G59fersrqkSJOTIaUtMgTBmoo49BXYNMq6MnMXBXhHUxijRktkwa
	lDkeBO3fgobhjXR7olUP5+nRayASZbuufCEn6w1I+I7FvEUpmqVAwBH0b8QgwWhqykuXF+
	B3VoGhECzKvSRjNOAJ8TNMe4pl8QXyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780046263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YMzWa8hGe9L9/zv4+cFX6ZWXDFKfDHw88RAycQYHp9A=;
	b=QiAiAg2cfyf3Yl0bwhOyCHJhruzP/GaOX0a9ho4kyyR94bq9ib0b99yeXApRFBxkY2hDtJ
	hPz/btxOGGY+P7Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xMQ5Kc5i;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QiAiAg2c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780046263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YMzWa8hGe9L9/zv4+cFX6ZWXDFKfDHw88RAycQYHp9A=;
	b=xMQ5Kc5iQHQxbZThQ3G59fersrqkSJOTIaUtMgTBmoo49BXYNMq6MnMXBXhHUxijRktkwa
	lDkeBO3fgobhjXR7olUP5+nRayASZbuufCEn6w1I+I7FvEUpmqVAwBH0b8QgwWhqykuXF+
	B3VoGhECzKvSRjNOAJ8TNMe4pl8QXyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780046263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YMzWa8hGe9L9/zv4+cFX6ZWXDFKfDHw88RAycQYHp9A=;
	b=QiAiAg2cfyf3Yl0bwhOyCHJhruzP/GaOX0a9ho4kyyR94bq9ib0b99yeXApRFBxkY2hDtJ
	hPz/btxOGGY+P7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF0CB779A7;
	Fri, 29 May 2026 09:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gtLGM7ZZGWp+SAAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 29 May 2026 09:17:42 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Avi Kivity <avi@qumranet.com>,
	"He, Qing" <qing.he@intel.com>,
	"Yaozu (Eddie) Dong" <eddie.dong@intel.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] KVM: x86: Take PIC lock on KVM_GET_IRQCHIP path
Date: Fri, 29 May 2026 11:17:15 +0200
Message-ID: <20260529091714.287963-2-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256568-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clopez@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 226EB5FFD92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When userspace issues the KVM_SET_IRQCHIP ioctl to set the state of
the PIC, kvm_vm_ioctl_set_irqchip() grabs @kvm->arch.vpic->lock before
updating the state. However, the KVM_GET_IRQCHIP ioctl to retrieve the
same PIC state does not grab such lock, potentially causing torn reads
for userspace.

Fix this by grabbing the lock on the read path.

This issue goes all the way back. The bug was introduced with the
addition of PIC ioctl code itself in 6ceb9d791eee ("KVM: Add get/
set irqchip ioctls for in-kernel PIC live migration support"). Later,
894a9c5543ab ("KVM: x86: missing locking in PIT/IRQCHIP/SET_BSP_CPU
ioctl paths") added the locking for kvm_vm_ioctl_set_irqchip(), but
missed kvm_vm_ioctl_get_irqchip().

Fixes: 6ceb9d791eee ("KVM: Add get/set irqchip ioctls for in-kernel PIC live migration support")
Fixes: 894a9c5543ab ("KVM: x86: missing locking in PIT/IRQCHIP/SET_BSP_CPU ioctl paths")
Cc: stable@vger.kernel.org
Reported-by: Claude Code:claude-opus-4.6
Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/irq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 9519fec09ee6..251df563427b 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -584,14 +584,18 @@ int kvm_vm_ioctl_get_irqchip(struct kvm *kvm, struct kvm_irqchip *chip)
 
 	r = 0;
 	switch (chip->chip_id) {
-	case KVM_IRQCHIP_PIC_MASTER:
+	case KVM_IRQCHIP_PIC_MASTER: {
+		guard(spinlock)(&pic->lock);
 		memcpy(&chip->chip.pic, &pic->pics[0],
 			sizeof(struct kvm_pic_state));
 		break;
-	case KVM_IRQCHIP_PIC_SLAVE:
+	}
+	case KVM_IRQCHIP_PIC_SLAVE: {
+		guard(spinlock)(&pic->lock);
 		memcpy(&chip->chip.pic, &pic->pics[1],
 			sizeof(struct kvm_pic_state));
 		break;
+	}
 	case KVM_IRQCHIP_IOAPIC:
 		kvm_get_ioapic(kvm, &chip->chip.ioapic);
 		break;

base-commit: d1568b1332b6b3b36b222c2868fc102727c12a34
-- 
2.51.0


