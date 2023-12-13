Return-Path: <stable+bounces-5825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED680D74C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF82824B9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C693E54BE1;
	Mon, 11 Dec 2023 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KfwZc6TP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B239537E3;
	Mon, 11 Dec 2023 18:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAD0C433C8;
	Mon, 11 Dec 2023 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319764;
	bh=254I5tzdEY3fkwQTigYRpt3hBzirTI0xoStIELeWHts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KfwZc6TPy8Rog0azNS9FUzD4Bnsr79wh52V16rzlOJ5PqCOClnEDSXIFbk5vPMSir
	 QBWTy+jakJYJT2U5C7r81mTnc+XHJASTE6xFzOXSNpRQDAsbj3m2NYC+MBqF9tw9QC
	 95EVzetwjxqxT+oXBihRYyB9PmkZWJjFsZAujXZg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.6 225/244] x86/CPU/AMD: Check vendor in the AMD microcode callback
Date: Mon, 11 Dec 2023 19:21:58 +0100
Message-ID: <20231211182056.101338336@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov (AMD) <bp@alien8.de>

commit 9b8493dc43044376716d789d07699f17d538a7c4 upstream.

Commit in Fixes added an AMD-specific microcode callback. However, it
didn't check the CPU vendor the kernel runs on explicitly.

The only reason the Zenbleed check in it didn't run on other x86 vendors
hardware was pure coincidental luck:

  if (!cpu_has_amd_erratum(c, amd_zenbleed))
	  return;

gives true on other vendors because they don't have those families and
models.

However, with the removal of the cpu_has_amd_erratum() in

  05f5f73936fa ("x86/CPU/AMD: Drop now unused CPU erratum checking function")

that coincidental condition is gone, leading to the zenbleed check
getting executed on other vendors too.

Add the explicit vendor check for the whole callback as it should've
been done in the first place.

Fixes: 522b1d69219d ("x86/cpu/amd: Add a Zenbleed fix")
Cc: <stable@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231201184226.16749-1-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1315,6 +1315,9 @@ static void zenbleed_check_cpu(void *unu
 
 void amd_check_microcode(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return;
+
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
 



