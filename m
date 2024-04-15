Return-Path: <stable+bounces-39671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4588A5417
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA871F20F93
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C982899;
	Mon, 15 Apr 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XeS27Apy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3349757E1;
	Mon, 15 Apr 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191468; cv=none; b=FaD8lQr/HxAuqfYAO1sI1cIm1kY2Wjvq/4UHQklmwX5R0bhZ35pw29dXPbfd8giw49/4RtpGlo79i1j5bQxiGP81q87rBug+WUpydPSfmI/imwBYkNUE4HYRc597IIk+72YC72LUpsGzg5TZZg3oGYlZluTF3G9Bwv5V3DavX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191468; c=relaxed/simple;
	bh=LrzwHHbyuWkZSJ55XYfNUcQaY/VONo6v1O+NplGW4xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cG3UaI3ynW2q7e4Fn5C8vagIsAy57114bRBE4j3k6dILlxov7hDe4H1YsQRomKhCHbFPXkwCNJsjgL4zvr0SABaaAR80eKWwuq1HlHucGO8DeGPoz4sKORT1BRtYyIxfT635sDpYDMHQCRW2d4fiOFfgVVvKkCDisNSDdE6MSic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XeS27Apy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAED7C113CC;
	Mon, 15 Apr 2024 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191468;
	bh=LrzwHHbyuWkZSJ55XYfNUcQaY/VONo6v1O+NplGW4xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XeS27ApyGOVCIMkGsC+tPGxxemJqrOM0rajL4L4hzV7D50dtrDc1oToNzn6zGBNm/
	 Ix0fRCii6QKDqbey5G4s1UX6yhuAy2joYymc3Kaq9g2BmPQ+t53pkPztQzx9K283y1
	 wI31tn6Bitjc0pdpq+fQ5PgbWu+IbhUS/6/myrs0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.8 152/172] x86/bugs: Fix BHI documentation
Date: Mon, 15 Apr 2024 16:20:51 +0200
Message-ID: <20240415142004.982053061@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
References: <20240415141959.976094777@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

commit dfe648903f42296866d79f10d03f8c85c9dfba30 upstream.

Fix up some inaccuracies in the BHI documentation.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/8c84f7451bfe0dd08543c6082a383f390d4aa7e2.1712813475.git.jpoimboe@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/hw-vuln/spectre.rst   |   15 ++++++++-------
 Documentation/admin-guide/kernel-parameters.txt |   12 +++++++-----
 2 files changed, 15 insertions(+), 12 deletions(-)

--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -439,11 +439,11 @@ The possible values in this file are:
    - System is protected by retpoline
  * - BHI: BHI_DIS_S
    - System is protected by BHI_DIS_S
- * - BHI: SW loop; KVM SW loop
+ * - BHI: SW loop, KVM SW loop
    - System is protected by software clearing sequence
  * - BHI: Syscall hardening
    - Syscalls are hardened against BHI
- * - BHI: Syscall hardening; KVM: SW loop
+ * - BHI: Syscall hardening, KVM: SW loop
    - System is protected from userspace attacks by syscall hardening; KVM is protected by software clearing sequence
 
 Full mitigation might require a microcode update from the CPU
@@ -666,13 +666,14 @@ kernel command line.
 		of the HW BHI control and the SW BHB clearing sequence.
 
 		on
-			unconditionally enable.
+			(default) Enable the HW or SW mitigation as
+			needed.
 		off
-			unconditionally disable.
+			Disable the mitigation.
 		auto
-			enable if hardware mitigation
-			control(BHI_DIS_S) is available, otherwise
-			enable alternate mitigation in KVM.
+			Enable the HW mitigation if needed, but
+			*don't* enable the SW mitigation except for KVM.
+			The system may be vulnerable.
 
 For spectre_v2_user see Documentation/admin-guide/kernel-parameters.txt
 
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3419,6 +3419,7 @@
 					       reg_file_data_sampling=off [X86]
 					       retbleed=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
+					       spectre_bhi=off [X86]
 					       spectre_v2_user=off [X86]
 					       srbds=off [X86,INTEL]
 					       ssbd=force-off [ARM64]
@@ -6037,11 +6038,12 @@
 			deployment of the HW BHI control and the SW BHB
 			clearing sequence.
 
-			on   - unconditionally enable.
-			off  - unconditionally disable.
-			auto - (default) enable hardware mitigation
-			       (BHI_DIS_S) if available, otherwise enable
-			       alternate mitigation in KVM.
+			on   - (default) Enable the HW or SW mitigation
+			       as needed.
+			off  - Disable the mitigation.
+			auto - Enable the HW mitigation if needed, but
+			       *don't* enable the SW mitigation except
+			       for KVM.  The system may be vulnerable.
 
 	spectre_v2=	[X86] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.



