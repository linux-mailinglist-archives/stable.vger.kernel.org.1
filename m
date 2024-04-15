Return-Path: <stable+bounces-39879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0AE8A5528
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31771F2266B
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8EF2A8D3;
	Mon, 15 Apr 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vJCz1+L7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B309445;
	Mon, 15 Apr 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192092; cv=none; b=pXTTcrCKAdat+hJRu0JFnQBTeIw9CXr4qZBn6R5P0mlR/ZgvBQT+hhdGvhSCLKr9Bs6azGwST5JZXQhQGKVjijfXu/TywkXjJsn6NcZULK+rns4gNII3gKS2TXvK4ayx9vBNh+BDX9PXCDg7xruOjsOo4T8I8l4O6OIYzl0AVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192092; c=relaxed/simple;
	bh=3xEyy4uTl+wBQg6N0I4zrHD0+TL4I/+RcY/fKKOpAw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehne3F9LPlT0k5p8oijsttUtE10LnVNJT/Hc7g5SUY8fIq20YFLa2MiIkpnpbAP/EKdCO9/2XRdWWRTJTGDS2emEXGLMKLbF7d9INpi/aBrQe4LViuKe/h0xfSnUjSyRmHdSzrNbiH76JUTwu64CTVk/7MCV3ZU42TICIuKjbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vJCz1+L7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46AFC2BD11;
	Mon, 15 Apr 2024 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713192092;
	bh=3xEyy4uTl+wBQg6N0I4zrHD0+TL4I/+RcY/fKKOpAw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJCz1+L7WoBc4MO1QGoz54rX9th4LqSGqrWnfc/QrDadtUzTfHoIN4qLB5L5t2RWt
	 FuFxUidGxJrvSrk6KyqXvK38FviZzr5qqf1sKmMMhOu9nkSrZVqReK9OLKIm1kaSkk
	 UxzcvrIWJUE/iI2f5ef77o7pOLqJ531CtXfIL1jg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 6.1 64/69] x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with CONFIG_MITIGATION_SPECTRE_BHI
Date: Mon, 15 Apr 2024 16:21:35 +0200
Message-ID: <20240415141948.096683138@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>
References: <20240415141946.165870434@linuxfoundation.org>
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

From: Josh Poimboeuf <jpoimboe@kernel.org>

commit 4f511739c54b549061993b53fc0380f48dfca23b upstream.

For consistency with the other CONFIG_MITIGATION_* options, replace the
CONFIG_SPECTRE_BHI_{ON,OFF} options with a single
CONFIG_MITIGATION_SPECTRE_BHI option.

[ mingo: Fix ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/3833812ea63e7fdbe36bf8b932e63f70d18e2a2a.1712813475.git.jpoimboe@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/Kconfig           |   17 +++--------------
 arch/x86/kernel/cpu/bugs.c |    2 +-
 2 files changed, 4 insertions(+), 15 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2563,27 +2563,16 @@ config MITIGATION_RFDS
 	  stored in floating point, vector and integer registers.
 	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
 
-choice
-	prompt "Clear branch history"
+config MITIGATION_SPECTRE_BHI
+	bool "Mitigate Spectre-BHB (Branch History Injection)"
 	depends on CPU_SUP_INTEL
-	default SPECTRE_BHI_ON
+	default y
 	help
 	  Enable BHI mitigations. BHI attacks are a form of Spectre V2 attacks
 	  where the branch history buffer is poisoned to speculatively steer
 	  indirect branches.
 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
-config SPECTRE_BHI_ON
-	bool "on"
-	help
-	  Equivalent to setting spectre_bhi=on command line parameter.
-config SPECTRE_BHI_OFF
-	bool "off"
-	help
-	  Equivalent to setting spectre_bhi=off command line parameter.
-
-endchoice
-
 endif
 
 config ARCH_HAS_ADD_PAGES
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1605,7 +1605,7 @@ enum bhi_mitigations {
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {



