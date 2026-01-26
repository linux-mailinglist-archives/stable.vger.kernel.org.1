Return-Path: <stable+bounces-211497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ2yHVa2dmkGVAEAu9opvQ
	(envelope-from <stable+bounces-211497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 01:33:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9808333A
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 01:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C79C930045AA
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 00:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1113A258;
	Mon, 26 Jan 2026 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AcETk8PD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B72AE77
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769387590; cv=none; b=r5t3KlmT0hz7Gfm4SnQk9GQRXCyYToNgdOX4gZKCtA+5D72E86MqkvV/zX8xLJXBfIyRV4qGjdRt/ZocaBQjdP14ER3kHgOQjyDdf3WKCXmMyj608nkkWnVpOg/VblpcO+HJ+IOg6pMJv4QBUFy5k8QKB2rbR6wqu2qY09zpUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769387590; c=relaxed/simple;
	bh=LHP7vc+QAjKrcQ/nSd8XnShnI8hVZmkUtqzqx890SiM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bi+RRpDZ1hlnS0kJ0KXuqphjYJTZ7ijZHfK/CVpBBkF89P8dX6QdtjSzOVWH+hNwbXMCOaYnnXkflQjXjHDwS4enWsNVeYewYHQFhDSyBIO/4g4iObUzKREteZ/hhuXtW+84MeN4Vr1h2KCj9yj0c1WbTfXAmnaH/1s9ftR+Zyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AcETk8PD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4804157a3c9so43412935e9.1
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 16:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769387587; x=1769992387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+0aVR3neN19eb/78h0OkLoTFjYmtJx01fQbpzy1/E0=;
        b=AcETk8PDSMv8aVjSO+RdYOzTLb8vqVLKzAkIFVQ9+RAZJKz/9iYUVFDqUf6B3o3mM+
         vw6y82JsMTl5hk8I83HFvpXzeqMsMOpLk4/GR2gVQ1xbSjfhENJu+hozVCk6h8DK1m8Z
         3LZGmMatTig0blpyjcExkLhq2y65OCRtMc2Y/R0zmC3e+h48yJRitfTMjycJpZGk1HrR
         OMCO70jYyqTWXbPZqI4h05rQz2yn6Tmz7Tkbrf4sSfapav2CEJt1QBsfq+mkpY990IWL
         asvrt68VulZ0UIpqjvy6ERf8yBcD8MWrbYt2g99MvKCItp6VBZtt/Jk8EoqwWVP1ZzaQ
         ogug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769387587; x=1769992387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+0aVR3neN19eb/78h0OkLoTFjYmtJx01fQbpzy1/E0=;
        b=wW+14z6LK3AMg7yamorbrrlaZ94IyaVO9xbN/f2uu8V3wr3+AnmcXiZUQU4KIbCRJu
         UaMjX5XIdXcdhiAN6YQR0qOrzWGguDwP5LRHXKaJcRqtcdJa/9Ln+UI8fxSdr0bmSca8
         v3H2EFALpY+z5tSrdX8ewrumxanhWLdpzscwTgrkTRE0SBh1rc2MfwSlmIQIDedsxAdd
         rI8v2wYSVCkE2RRF2Ncb8i/b/IA0Kwf79a5opydysIcmaA8MvqmvhdftYV1p8cD8Emxi
         brJRs8rhzlMF0tX7QmXFToAiYiMh+r6mU2H2KJ78BgtPSm95CbgVOQlYZk/sIaUwQpaB
         1Gog==
X-Forwarded-Encrypted: i=1; AJvYcCUma/7ZVDqzxHoi0MUrOlUNq6phEouP+z8AcnrQo57iKMn2FT36NOKxPLeBee9r80wmJ0eTci8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0FoRSMfT4vSztgaiAn+oxU5jDrxAr5bPFc1tj18YMODsQ1GZ
	tVIw3iTMm5A6bY2MYHwvJO7GBHWXvCq7cQi5WSdY2UEvr5Nl78iEgTbDLEFFsjO5krZ1c5qFU2u
	8Bg==
X-Received: from wmne21.prod.google.com ([2002:a05:600c:4395:b0:477:a181:1922])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:6405:10b0:475:dde5:d91b
 with SMTP id 5b1f17b1804b1-4805f624d56mr26596795e9.17.1769387587598; Sun, 25
 Jan 2026 16:33:07 -0800 (PST)
Date: Mon, 26 Jan 2026 01:25:10 +0100
In-Reply-To: <20260126002936.2676435-1-elver@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126002936.2676435-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126002936.2676435-2-elver@google.com>
Subject: [PATCH 1/3] arm64: Fix non-atomic __READ_ONCE() with CONFIG_LTO=y
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211497-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA9808333A
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
2.52.0.457.g6b5491de43-goog


