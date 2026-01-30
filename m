Return-Path: <stable+bounces-212881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BMXIxqzfGm8OQIAu9opvQ
	(envelope-from <stable+bounces-212881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:33:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E83BB10F
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0091F305A975
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 13:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E463019A4;
	Fri, 30 Jan 2026 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UA/LVt28"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50946302750
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779810; cv=none; b=fxOnr3SYnab/BDDRaTnTozigjzwj9FFHhRatvDS214KMIHWV4fok2edF4+OlthD/cJdKeOzETXBfC/BlqepoO78TjeMaCIk8cK+6JiZG3kGHTs6BKavD4lerqVz9RLKdvt1evx0j/H3QK/+KbKmOO1pw5bMHzkrFvqUPBaShnAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779810; c=relaxed/simple;
	bh=26nK5ZuTSH07Hc66Z0TGP4MV/KjUVkYvGOV4qaYkpHE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZDrlSpcsU+WeMM64tdTF5gaVK9/RpXzVTlCXl1DPc012MusZXQ3FOsG/qMW4MkhKcL9+kjDuzohCUaW+uTH/ebyRAiNCFengJ12unhot0d4JJzzjneI9B7BGpYA/r3E3Jxrt0/lDNhskfs+JYslvswXfipGpQF0/oS1rLxgg984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UA/LVt28; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d4029340aso37994795e9.3
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 05:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769779808; x=1770384608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ah0eS4SkK+p5W7jb3OOf6k8LtqY2IjJqo0gqvKUDvkY=;
        b=UA/LVt28VdvUGx7LrOwb++LDTM5EKu+uZH2uIkzO9tyHque+VS3R6XSwL4Gi/ORfwv
         uoB4VCmcBI1bh4PxzvutsKJIWSqTGawLtYm5kSQl3tfb9Y9ydokw4dHPbVZLEa85pMk2
         qYTfEdbV5mSFV7HDANrpf49gGzMl3/NTSf1WPv/sEVefwrbhB0DVr+Qe5AFtYWeg2TEV
         L2JT8KDd0A7CkOAfClsxQl+kI7UpcZOosI8E0D/UncUkVqW2DVxq8ZonHCDUQXwTWGJJ
         6Oq2iWMXIkAzgmEWySvdTyWreHsTub9NFEcI2uzQyddDDn7+mwO0jkgnA6I3T0vGYxEe
         fGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769779808; x=1770384608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ah0eS4SkK+p5W7jb3OOf6k8LtqY2IjJqo0gqvKUDvkY=;
        b=b2mVC4OzPfSyv1ytWmwsZfH8lo7ZV3NviidBOLiseeCRIgRrVOznXwJgcmzSUbklfN
         qPuDti8wo+ThKWY5Io4H2kKHVkbi4ksEwb0VQw2iYQKBT6z9YrcLI6qQWiJ1IeX2jeWS
         aUIUB/YF9dGrGIdZtMv+Ki5au+4EtFn3uIUnraee+TcByupnGJ8Ckf71T4cvCIXdmDc/
         eNOboJPghBDtgyxqNovlvZ/eVZ42LbuG0IA3QE9x+fSnPNso8wUgauEnDYPaEjCuWBpL
         DMeEc9SLjzzVIvoGRdYxM/r+mvczKATHGKz23X20r9vU6+dwo6zTXDuY9HP25EgQArMB
         24Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXz1v3gFpjeHjFT1WrsF+G3PeQKF5GR65QeTo6oyeEjhdv2G1wklXcJZAkol+H3ihDqedzy43o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4nhVtVzQwfKABRlOsrTiDv8eax2rFQzG1iKA2Ia0G7JjiUxv9
	lcvK1wq9BDc6RBPuJjDL43JY4t5T9idaCO/DSu0ON+AhxXR6sQe+qRR/ZFGK3wlFL730g4vmjJH
	uiA==
X-Received: from wmby7.prod.google.com ([2002:a05:600c:c047:b0:477:a678:a39a])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b1d:b0:477:9cdb:e32e
 with SMTP id 5b1f17b1804b1-482db46014dmr37732115e9.9.1769779807742; Fri, 30
 Jan 2026 05:30:07 -0800 (PST)
Date: Fri, 30 Jan 2026 14:28:24 +0100
In-Reply-To: <20260130132951.2714396-1-elver@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260130132951.2714396-1-elver@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130132951.2714396-2-elver@google.com>
Subject: [PATCH v3 1/3] arm64: Fix non-atomic __READ_ONCE() with CONFIG_LTO=y
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, llvm@lists.linux.dev, 
	David Laight <david.laight.linux@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212881-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,gmail.com,redhat.com,acm.org,lists.linux.dev,arm.com,arndb.de,lists.infradead.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03E83BB10F
X-Rspamd-Action: no action

The implementation of __READ_ONCE() under CONFIG_LTO=y incorrectly
qualified the fallback "once" access for types larger than 8 bytes,
which are not atomic but should still happen "once" and suppress common
compiler optimizations.

The cast `volatile typeof(__x)` applied the volatile qualifier to the
pointer type itself rather than the pointee. This created a volatile
pointer to a non-volatile type, which violated __READ_ONCE() semantics.

Fix this by casting to `volatile typeof(*__x) *`.

With a defconfig + LTO + debug options build, we see the following
functions to be affected:

	xen_manage_runstate_time (884 -> 944 bytes)
	xen_steal_clock (248 -> 340 bytes)
	  ^-- use __READ_ONCE() to load vcpu_runstate_info structs

Fixes: e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y")
Cc: <stable@vger.kernel.org>
Reviewed-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 arch/arm64/include/asm/rwonce.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
index 78beceec10cd..fc0fb42b0b64 100644
--- a/arch/arm64/include/asm/rwonce.h
+++ b/arch/arm64/include/asm/rwonce.h
@@ -58,7 +58,7 @@
 	default:							\
 		atomic = 0;						\
 	}								\
-	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\
+	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(*__x) *)__x);\
 })
 
 #endif	/* !BUILD_VDSO */
-- 
2.53.0.rc1.225.gd81095ad13-goog


