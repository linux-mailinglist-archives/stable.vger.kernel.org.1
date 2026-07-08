Return-Path: <stable+bounces-272737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KWaWF9zETmruTgIAu9opvQ
	(envelope-from <stable+bounces-272737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 23:45:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AEA72AA18
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 23:44:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=YP7XSUcb;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272737-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272737-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DD033131CF4
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 21:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA71B3DFC67;
	Wed,  8 Jul 2026 21:40:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C93AB29E;
	Wed,  8 Jul 2026 21:40:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546831; cv=none; b=o8f0ez3hrMDN5TPGVDTEGZ0sGlNNBpzaqLD064gOw+L7EkpG+Rzek0i6gtNmpp8IbAMuigiqohz+dYFED2yU45Jsq9WEDoKXWVHaMb3DlHXuA9HiVB/NgJ4QjBNIQdPFdyo+G0i9mRcu7E9triNhl1mtszCdt1phlHkii4pKaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546831; c=relaxed/simple;
	bh=7wZx8W2Sv3cy4CnMWXvjGDb632ddGXU+BRwNqDWCGXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKa8Dh2uzNWop/LutKH6uB5BWt/eiHDmujxEvRhJ23sr5HI5uk/kdU4Lcf5TKlIaNOadzUNmFqucEaUD0xZNMPUA8M44llqTjkplgGe1RWUaMue/73sLORSlwEonpf9kVFbFKCQRLGNV/wy2CWZsF2B/BFT7drGrIDRBNBVSzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YP7XSUcb; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783546830; x=1815082830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7wZx8W2Sv3cy4CnMWXvjGDb632ddGXU+BRwNqDWCGXg=;
  b=YP7XSUcbIwOy+CkEnlaGfSDR728ArV1JNBsP9GcuFogutX5pfKooO8Hz
   QFCwDxzXacXx/JM2coQr0t775ct2LIY04+wd4MZveN+Ddypee6sDym1td
   bdboEbDFCY5nY15fx33koRQq9lT1TLEcF45FiU7BYkFOtdkYn5abvPqHw
   jIeMdD1h6jW1rdtWTtQm0f29jYIDyIvOdyCrqQ6j4Q4eQ9zxXjfxAst3C
   x60BvNI7vTCPTOgA7aRCfTaM72+KtZXW8ed1Pull4DVkIlftxKJ4t8+AQ
   KpbGNJxAsR4/RrLq2UtSHRdsTFH/4W400Xw2S80b2i3Q5oNJBnf17Qv9j
   A==;
X-CSE-ConnectionGUID: 0kGSJDBrQPy1XNyBH1Mxvw==
X-CSE-MsgGUID: Atgzsri6RqKMq/SjUR0hZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84414860"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84414860"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 14:40:29 -0700
X-CSE-ConnectionGUID: vb1/VhgBSOil9werL224tQ==
X-CSE-MsgGUID: UPpyXBVySSOvQSxMBCGrDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277629872"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa002.fm.intel.com with ESMTP; 08 Jul 2026 14:40:28 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	chang.seok.bae@intel.com,
	Omar Avelar <omar.avelar@intel.com>,
	stable@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] x86/build/64: Prevent native builds from generating APX instructions
Date: Wed,  8 Jul 2026 21:14:35 +0000
Message-ID: <20260708211435.402426-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272737-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:chang.seok.bae@intel.com,m:omar.avelar@intel.com,m:stable@vger.kernel.org,m:ojeda@kernel.org,m:nathan@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chang.seok.bae@intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chang.seok.bae@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3AEA72AA18

Omar reported this broad concern to me, when resolving a separate issue
with his custom module. CONFIG_X86_NATIVE_CPU=y allows builds to
opportunistically emit APX instructions when the build host supports APX
since commit:

  ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")

The kernel is not yet prepared to use APX internally. For example, there
is no context-switch support for general in-kernel use of the extended
GPRs.

Explicitly disable APX when building with `-march=native`.

Since GCC 14 and LLVM 18, both compilers support APX. LLVM 19 is already
the minimum version to support native builds from:

  ad9b861824ac ("x86/kbuild/64: Restrict clang versions that can use '-march=native'")

RUST supports APX detection via XCR0 since v1.91 release. While the
support is not official yet, conservatively set that version as the
minimum.

Reported-by: Omar Avelar <omar.avelar@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: <stable@vger.kernel.org> # v6.16+
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
---
I don't think it is fair to point out that commit to fix here. The issue
looks to be just in a hindsight. It was also merged at the same cycle
when APX userspace enabling was picked up.

Fortunately no APX systems are publicly available yet, but guard against
this before such hardware becomes generally available.
---
 arch/x86/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 598f178102ee..256948e65073 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -161,7 +161,15 @@ else
 
 ifdef CONFIG_X86_NATIVE_CPU
         KBUILD_CFLAGS += -march=native
-        KBUILD_RUSTFLAGS += -Ctarget-cpu=native
+        # Do not generate APX instructions as in-kernel use isn't ready
+  ifdef CONFIG_CC_IS_GCC
+        KBUILD_CFLAGS += $(if $(call gcc-min-version,140000),-mno-apxf,)
+  endif
+  ifdef CONFIG_CC_IS_CLANG
+        # The minimum version for native build already supports the option
+        KBUILD_CFLAGS += -mno-apxf
+  endif
+        KBUILD_RUSTFLAGS += -Ctarget-cpu=native $(if $(call rust-min-version,109100),-Ctarget-feature=-apxf,)
 else
         KBUILD_CFLAGS += -march=x86-64 -mtune=generic
         KBUILD_RUSTFLAGS += -Ctarget-cpu=x86-64 -Ztune-cpu=generic
-- 
2.51.0


