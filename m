Return-Path: <stable+bounces-182965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4FBB12DA
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140E91881CE2
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA06280CFC;
	Wed,  1 Oct 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="mJeT94E0"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F031465B4;
	Wed,  1 Oct 2025 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333856; cv=none; b=fGx3oF2w1lDYL6sGv85EF3RkpDr+Xn/hegFi+MKXOvZJVA55+tZDiZxItas/dl/TS17JNpB9V09FFImXLrWrIogRoVSxg21moHjNFGdt4q7Rhq2WQUOrOjmLm5Fxd2RQ3vCKizQqreaxmYvHecfI5Go51KHlk3VWa0LcS6noJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333856; c=relaxed/simple;
	bh=gQ8G0xeOnQ7E/sXxHqbczW2Cqcmya74PNwuLU5QLX7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEGT2B8tHagzOfAxzo17ytelM9AHR7wRW31d7HD7vu4f+XckolAx/pIZlvY/3V2O/BFJiLR1eYvmEXM3BR4c8LjNZSHqX6JrCo9eGKkWdmFjl24x6dzrztpQH6WLPKGOcfTCIzOXqY/7mqNlrpD3bRBqaQEXrIquUVIJjTqqsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=mJeT94E0; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ccKCH3GLSz9th6;
	Wed,  1 Oct 2025 17:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1759333851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5I5u+PMK88lZKctCTsHiurk+h5mxPEP/pOX31M1TABg=;
	b=mJeT94E0Y3lE3Ho3855MC7DnPtIZ6RQouVwlBQwpnq430rVu38ZuNMRyMb/j4ai/y9rYzC
	dRCsMSN9dq1wPeMtotcwCdIy2FW1OQcESARc2mWPxHg4hl1T1TRlgpdU0JXtKMsim9iK0X
	so+hpCXUouYfrDUBmnn8qxAwe59Zwc1ozCrlN7jregUyHmscy0NIvWB6ospNdbvpeMyA7b
	9MFRVyx4mdZdmb0kiC4A3L+msusnqmFO078tRGMciYn9QsFJ43SwtdtspK221tgGmPRoYv
	gFeKsIJopxLPtVHLUHTCnh1jQJ8r9xBIv0ZxEvFbUeLA8aes0tUmexCNEXkkHw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
To: stable@vger.kernel.org
Cc: linux-hardening@vger.kernel.org,
	kees@kernel.org,
	listout@listout.xyz,
	Christopher Fore <csfore@posteo.net>
Subject: [PATCH 6.16.y] gcc-plugins: Remove TODO_verify_il for GCC >= 16
Date: Wed,  1 Oct 2025 21:20:40 +0530
Message-ID: <20251001155040.26273-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ccKCH3GLSz9th6

From: Kees Cook <kees@kernel.org>

[ Upstream commit a40282dd3c48 ]

GCC now runs TODO_verify_il automatically[1], so it is no longer exposed to
plugins. Only use the flag on GCC < 16.

Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=9739ae9384dd7cd3bb1c7683d6b80b7a9116eaf8 [1]
Suggested-by: Christopher Fore <csfore@posteo.net>
Link: https://lore.kernel.org/r/20250920234519.work.915-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 scripts/gcc-plugins/gcc-common.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 6cb6d1051815..8f1b3500f8e2 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -173,10 +173,17 @@ static inline opt_pass *get_pass_for_id(int id)
 	return g->get_passes()->get_pass_for_id(id);
 }
 
+#if BUILDING_GCC_VERSION < 16000
 #define TODO_verify_ssa TODO_verify_il
 #define TODO_verify_flow TODO_verify_il
 #define TODO_verify_stmts TODO_verify_il
 #define TODO_verify_rtl_sharing TODO_verify_il
+#else
+#define TODO_verify_ssa 0
+#define TODO_verify_flow 0
+#define TODO_verify_stmts 0
+#define TODO_verify_rtl_sharing 0
+#endif
 
 #define INSN_DELETED_P(insn) (insn)->deleted()
 
-- 
2.51.0


