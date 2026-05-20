Return-Path: <stable+bounces-252067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNkNC6v+DWpV5QUAu9opvQ
	(envelope-from <stable+bounces-252067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:34:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A57CB5969F4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3749137BD98A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9826829B8D0;
	Wed, 20 May 2026 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AgBi2Jwq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA33F4DC0;
	Wed, 20 May 2026 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299661; cv=none; b=tgqnOom4zfx2GhPMfRHm8oOistCYcAlMHFKXKsFGvKBIH0YctFq5a3JT0vHYCeMEClcoG9+ZncsyMzJCFQKd8VVy2uD5ulGco2yZSQylHCPBGJiDD5loooTUibGwbdSoCa9ywwuIOfe5LFNaA0QkGgoCNNhcgi4KqRzAy1738To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299661; c=relaxed/simple;
	bh=RgMCk+/2/Ue8o40PadZQYkSpk+mhj9Tg3EOo6YVYps0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yu0FLj87XKYnPzb6t9U8tXccEuCvNqBQ6ahqRotwFA83DV+3upOSwP999hNYbQ9V2bBvTtgcnCuHr51+Cw4JgPcFV3nJ/aBWU7RXpmFRmijUfYuBkfkaS2+7Zfl9OqkgiB0x333pp22QCgb/cqOig+HLoq8CIzeNs1cRI2WH+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AgBi2Jwq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F471F000E9;
	Wed, 20 May 2026 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299658;
	bh=GtizY04h9R/BmUhRh8CELXRXgN/zhJczU29dSXdIRaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AgBi2JwqouEkxr0bDaiK5J/rzzOYk97WDbaYRVe8YP9Cav7vUutOfx7LJV42ZWMg1
	 /0sVKgd6Rfk1jIO4zRWDjbP8NQDTJZXg+Yf8BG1POYwHC1emRQ51WYoj5ss8Ww4OcK
	 qNlZ+TKqaPChzv8YgVFlX87jxktkxV1+PShgN1r8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leo Yan <leo.yan@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 857/957] kselftest/arm64: Include <asm/ptrace.h> for user_gcs definition
Date: Wed, 20 May 2026 18:22:20 +0200
Message-ID: <20260520162153.150721719@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252067-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A57CB5969F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leo Yan <leo.yan@arm.com>

[ Upstream commit bb7235e226888607e6aac1288062fcb1ac105589 ]

kselftest includes kernel uAPI headers with option:

  -isystem $(top_srcdir)/usr/include

Include <asm/ptrace.h> in libc-gcs.c for the definition of struct
user_gcs from the uAPI headers, and remove the redundant definition in
gcs-util.h. This fixes a compilation error on systems where the
toolchain defines NT_ARM_GCS.

Fixes: a505a52b4e29 ("kselftest/arm64: Add a GCS test program built with the system libc")
Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/gcs/gcs-util.h | 6 ------
 tools/testing/selftests/arm64/gcs/libc-gcs.c | 1 +
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/gcs/gcs-util.h b/tools/testing/selftests/arm64/gcs/gcs-util.h
index c99a6b39ac147..7a81bb07ed4b8 100644
--- a/tools/testing/selftests/arm64/gcs/gcs-util.h
+++ b/tools/testing/selftests/arm64/gcs/gcs-util.h
@@ -18,12 +18,6 @@
 
 #ifndef NT_ARM_GCS
 #define NT_ARM_GCS 0x410
-
-struct user_gcs {
-	__u64 features_enabled;
-	__u64 features_locked;
-	__u64 gcspr_el0;
-};
 #endif
 
 /* Shadow Stack/Guarded Control Stack interface */
diff --git a/tools/testing/selftests/arm64/gcs/libc-gcs.c b/tools/testing/selftests/arm64/gcs/libc-gcs.c
index 17b2fabfec386..72e82bfbecc99 100644
--- a/tools/testing/selftests/arm64/gcs/libc-gcs.c
+++ b/tools/testing/selftests/arm64/gcs/libc-gcs.c
@@ -16,6 +16,7 @@
 
 #include <asm/hwcap.h>
 #include <asm/mman.h>
+#include <asm/ptrace.h>
 
 #include <linux/compiler.h>
 
-- 
2.53.0




