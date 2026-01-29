Return-Path: <stable+bounces-212716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GzFFXOwemk79QEAu9opvQ
	(envelope-from <stable+bounces-212716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 01:57:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B010BAA6A2
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 01:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7CDF302BE04
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB82FF641;
	Thu, 29 Jan 2026 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QaoWXpP9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B22FE593
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769648224; cv=none; b=pIa7cP1ZX8u0w/2GFejuLr5cm30fRmENuTIPWPdHaUQsE+Mc9W1h7eYPCykWfo1YTHs9JeU1qLIdYMeyjVVBezXeK2K/N6EFe+cUrIR0tUOaxmw3LMuiufsTG9y0gK2qg5nzeTCONVmbfAOj/VERQ6VG3/IpbR8/Ycn9wsvwAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769648224; c=relaxed/simple;
	bh=h+6CO9INn+2XL4U9JHeOtddCEAyJ9YJLjzkVO1qGO/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ConaL46F3dRJQofuaBfyHoQOpEj0RWPo/BRvahd91awu19MLAGaFNLTcRMkpV3VPwI+ZBNhgKRIA0sl1BNpUKqwwjEQfkVl+u/hVp6PPW428llA+hzcXCJkZOV7oeHOxBlAVXZkq4YCbf+q6KQEyU1UWqYwG33Z06IG7Q6iWmXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QaoWXpP9; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-480686b3b4cso3940105e9.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 16:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769648221; x=1770253021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0NjJX+kK82UqSM94A1K+UHi4bU7NWZzsNdcUlluZDA=;
        b=QaoWXpP9qSmgRYyAacsSDUClZ88ojzPy5sMFJSmfD2UcUsgJoYp5ViJFmXzvHvpG0g
         HRhovAkX/N+Jcf1SP/Xt0TEL51G8PGtq9WfY9rBJQE0A6jQ8Bx+bmef3/Ciom7wpJ4Xr
         SbYDuHQkrI+M0SvbTC5e0yKF7pkJ75699UWOmo1YV+0RhBugQxE8+ieHWoLhkCjLab4+
         6RubICnhVcbgTAYe+QNrfrlS+JKBYVF/c2vecEzOqZz2vxTX5o14omNpRq6YeQttucmk
         UBx/+Fw0A6k35iTFYU2WvfqOroSlCD7ZuEX/qQDvvL1zgVUgQM4wbqeHvogjo+a1uUT2
         cG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769648221; x=1770253021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0NjJX+kK82UqSM94A1K+UHi4bU7NWZzsNdcUlluZDA=;
        b=k5GY3jaH5dSy/5I21bYsVq9/vZiqblyXKUDKgO97yk2ZpoJi7znwvNULlAWweh9Qdz
         pyKoBOx8FowsKfhKdMGShMSMfZg3tZ25jfMv04iBxF+vZxAlHwaTc3uxRVoZiznJfj1g
         Dt1UX5XDhUM7Pxyis7i+2Bw3vqjoOBlRvvmylYp9HWrzmeIHk0N3bxqscIWjxuf/eXt6
         PdAkqvqQZLcN1igeYXzidhUIOjBZGKbYjggKQbemtn3A+J1f8amw5DooW6gb8Dgt3BAw
         1kTuahl+sN6qfD7N/4pSjV4AtUPr6OKaxYSwY25rtwfH17q9gZbxr3CbgqqBkJr+/YDQ
         ssGw==
X-Forwarded-Encrypted: i=1; AJvYcCVJFM6xetJOk2c7wJIwvzc/GBMWYwcKKsUIKINWw2RSwnWwh5nZuD7m9IXTZZxfcrdmXFeaT9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC/p3TiXErz/GVm0PPVMKLy4VWHyexhml/A/fhCOiKY+qmg1Ml
	xTw0Edp0SC5UGazk24qNxQ259/ixlwYMC4Ew1gPG120OnP0f+xPerSDvT9MUsowuzUnNaE2riTu
	jZg==
X-Received: from wmna1.prod.google.com ([2002:a05:600c:681:b0:480:694a:dd63])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b13:b0:480:699c:abe9
 with SMTP id 5b1f17b1804b1-48069c86f58mr73598185e9.37.1769648221236; Wed, 28
 Jan 2026 16:57:01 -0800 (PST)
Date: Thu, 29 Jan 2026 01:52:32 +0100
In-Reply-To: <20260129005645.747680-1-elver@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129005645.747680-1-elver@google.com>
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260129005645.747680-2-elver@google.com>
Subject: [PATCH v2 1/3] arm64: Fix non-atomic __READ_ONCE() with CONFIG_LTO=y
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, llvm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212716-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,gmail.com,redhat.com,acm.org,lists.linux.dev,arm.com,arndb.de,lists.infradead.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B010BAA6A2
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
2.53.0.rc1.217.geba53bf80e-goog


