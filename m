Return-Path: <stable+bounces-49533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0929F8FEDA9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA0C1C21F0E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F62C198E9F;
	Thu,  6 Jun 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EmsJmRTZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05DC19E7D0;
	Thu,  6 Jun 2024 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683513; cv=none; b=e/AhNI/XtGif3Aw99kNcfMJ9lVgyXHjfyFYCJSDKBy0uP0Eh4zncWpmCNa8K0OukcMdwEzzcxaWp5k9WDlaAL78xvk4MgykI1ZtPocrRCavWVfXn6/90F997x4nD6krna7xtD0YmFE8Jeokma8afm0kRX2dPl925jNsE+P9ijRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683513; c=relaxed/simple;
	bh=H3pA9LvdivQ8Q00E6lnNhil217UA7v6xnK/Pu7xkzC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8NHPS6YZeS/pc2tosOHMKjlFfIwvn47mP3OZbMoFMYe0XR0R+1O3inxO3PJl9W1viK1H74n7WNEWPfjKrv53AJzjCSjy8ZfSpBLdeY6B6wp1ahK06Rhjuzq2CU8p2pjcd7DcGQW1hI5WbcjbQss0noddJv7GxNgCEKFsmV60p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EmsJmRTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD946C2BD10;
	Thu,  6 Jun 2024 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683512;
	bh=H3pA9LvdivQ8Q00E6lnNhil217UA7v6xnK/Pu7xkzC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmsJmRTZT+svCrFRIXBK6CjVm7YMrimJqSePNId91PdxnsI7Eq0lH4Ypmvd2gMfzp
	 JYgRbrajrFrsWm8j/wsEo9p25OPsR6UiFv4f0Y8cMaCgADcEwJ4hGfHrAjBhj+SZ5j
	 0yg75ImTl7YNB8djxrlUNLnxh2r0OTsEK+lIKeVU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 401/473] x86/kconfig: Select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y
Date: Thu,  6 Jun 2024 16:05:30 +0200
Message-ID: <20240606131713.078223026@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 66ee3636eddcc82ab82b539d08b85fb5ac1dff9b ]

It took me some time to understand the purpose of the tricky code at
the end of arch/x86/Kconfig.debug.

Without it, the following would be shown:

  WARNING: unmet direct dependencies detected for FRAME_POINTER

because

  81d387190039 ("x86/kconfig: Consolidate unwinders into multiple choice selection")

removed 'select ARCH_WANT_FRAME_POINTERS'.

The correct and more straightforward approach should have been to move
it where 'select FRAME_POINTER' is located.

Several architectures properly handle the conditional selection of
ARCH_WANT_FRAME_POINTERS. For example, 'config UNWINDER_FRAME_POINTER'
in arch/arm/Kconfig.debug.

Fixes: 81d387190039 ("x86/kconfig: Consolidate unwinders into multiple choice selection")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240204122003.53795-1-masahiroy@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig.debug | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index bdfe08f1a9304..584fb1eea2cbf 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -248,6 +248,7 @@ config UNWINDER_ORC
 
 config UNWINDER_FRAME_POINTER
 	bool "Frame pointer unwinder"
+	select ARCH_WANT_FRAME_POINTERS
 	select FRAME_POINTER
 	help
 	  This option enables the frame pointer unwinder for unwinding kernel
@@ -271,7 +272,3 @@ config UNWINDER_GUESS
 	  overhead.
 
 endchoice
-
-config FRAME_POINTER
-	depends on !UNWINDER_ORC && !UNWINDER_GUESS
-	bool
-- 
2.43.0




