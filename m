Return-Path: <stable+bounces-87349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0830A9A6488
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374FA1C21C59
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16F91F4FD2;
	Mon, 21 Oct 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ypA6nBYw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C31E4113;
	Mon, 21 Oct 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507339; cv=none; b=mJt1JjSSPK6JV3FsqZMfnLk1d0zl0Am0H/8g5UarfMOm8XxA1V86+4w1PefrfK+tzuEh0AY3mzTqjqYLlY2HHTfQloNoWFErrsOQ9zkxTDqwgxIRa+TpQIUc53rg1Te10ZlLj/j9W0st6HEH00tV6PSuXqBk7HN8rF3XrJEW4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507339; c=relaxed/simple;
	bh=6YP421sK4RRB+4qMfoodm8sIpIUb7DsljmPj8i5CjWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpczxvRVSdlLfclBtxHoKbAgg0QGsWyaOB3hHxVZKoJw9l17Jd7Ggg4TrPhVDwd6udcqf/7LsHN6MMdT9vBT5+sikbqJuqJ/Y2TW35VB2kjZxF0y3U0B3RcWUXXmxARbub0iEYLVbZQNWF9CEvxrYqLGhLrhG7lGj8LeO7bRZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ypA6nBYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D36C4CEC3;
	Mon, 21 Oct 2024 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507339;
	bh=6YP421sK4RRB+4qMfoodm8sIpIUb7DsljmPj8i5CjWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ypA6nBYwe1TmhAGpkUZgvpdf9ntm6s3/HdzQYI2nt8nZVGm6luE6zSh7SSXo99F7v
	 XmKyp8wggNAkeBhzs9lXd8xsgGP8TktXMlqL+kl+HszZHoMcIJVerWR0DQlYF+UHl1
	 sqYYzlyt6QbNU9MeJ5yGBfS4RHxZJfRZNZ/KrXXE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Wikner <kwikner@ethz.ch>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org
Subject: [PATCH 6.1 44/91] x86/cpufeatures: Add a IBPB_NO_RET BUG flag
Date: Mon, 21 Oct 2024 12:24:58 +0200
Message-ID: <20241021102251.540396641@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102249.791942892@linuxfoundation.org>
References: <20241021102249.791942892@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Wikner <kwikner@ethz.ch>

commit 3ea87dfa31a7b0bb0ff1675e67b9e54883013074 upstream.

Set this flag if the CPU has an IBPB implementation that does not
invalidate return target predictions. Zen generations < 4 do not flush
the RSB when executing an IBPB and this bug flag denotes that.

  [ bp: Massage. ]

Signed-off-by: Johannes Wikner <kwikner@ethz.ch>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/kernel/cpu/common.c       |    3 +++
 2 files changed, 4 insertions(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -493,4 +493,5 @@
 #define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* CPU is affected by Branch History Injection */
+#define X86_BUG_IBPB_NO_RET		X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
 #endif /* _ASM_X86_CPUFEATURES_H */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1462,6 +1462,9 @@ static void __init cpu_set_bug_bits(stru
 	     boot_cpu_has(X86_FEATURE_HYPERVISOR)))
 		setup_force_cpu_bug(X86_BUG_BHI);
 
+	if (cpu_has(c, X86_FEATURE_AMD_IBPB) && !cpu_has(c, X86_FEATURE_AMD_IBPB_RET))
+		setup_force_cpu_bug(X86_BUG_IBPB_NO_RET);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 



