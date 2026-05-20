Return-Path: <stable+bounces-251085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LsqMKjuDWpu4wUAu9opvQ
	(envelope-from <stable+bounces-251085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:26:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E50593A36
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1C0E30E8C3C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A83BBA0E;
	Wed, 20 May 2026 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VuPX0j4n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B0231842;
	Wed, 20 May 2026 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297060; cv=none; b=KfIcNY0EOrPOlKxuGUecqhlWTG67ka5TL8NirBbim3GnMaRDNA5wwJ9LNJOB4WVM2zMFFKLXgvav3dv5iwet0wNEEPz56iTUfcoKPNAiBfVy0ixXMygGB2F07wJLCXNYKiPp+xrkMiCjWCD2RjoWK2S7tYWCZdwrXqWeh95Rpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297060; c=relaxed/simple;
	bh=ngMxNOuTHiQn5g/tBU4sFpe/Y5C36BJc/B/JcRVIqw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDFrP1Dyzj/aqI1lMud2z2vGHH6A2e5s6AYOlD44PX9xMB2Me75b6UBjAYHmCU3LGiSVfybeqbm1EogdLvktV3C2q/osByOVehVrKlvSCEuGIdfpxcYmx/ZVPqAVRACG6CJBIocnPQhAw3vG3y/+jm7QJJtWOk7Qn4I5odQ3wo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VuPX0j4n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0313D1F000E9;
	Wed, 20 May 2026 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297059;
	bh=4wwJY4X7qACYBTb+SYAQgspSvulU1Z9yXAs/iHZLWw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VuPX0j4n6JGxz0iOkt1Mo2sKd/uLIuUEwaVkwCtM/DddeW60/Rg5slzkrGRkIbEee
	 KC1WufUYOkLl31aTqzrTKY/EHz8Od4ipC7fEfxEC/j49Mgjr6SwWtu9I51zopRXiUc
	 63n/7yO0c8cDY3TDjQygE3ABTxANzh8nFqjFuJqw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leo Yan <leo.yan@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 1034/1146] kselftest/arm64: Include <asm/ptrace.h> for user_gcs definition
Date: Wed, 20 May 2026 18:21:24 +0200
Message-ID: <20260520162211.630707711@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251085-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,arm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 68E50593A36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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




