Return-Path: <stable+bounces-50474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 250A290673F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35A21F2210D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55413D526;
	Thu, 13 Jun 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J17GTGLY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FtkKBH20"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329526AE4;
	Thu, 13 Jun 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268110; cv=none; b=eWT4WciF80nOALngo8cdMixlz/7obvXPOTRhemsE7FVObDTGEgzJIpST+e9yiGrXk0WpGg3122IaAk2EtPmN7LPEsbcFL+Ld02akSpmYRk0VgLh1UsO6FqJ/opjin5R79tFefBZMyS6jgUvbxfpmgurpjwj/4bF2HGdFIuXChpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268110; c=relaxed/simple;
	bh=1ZJ/uxN8Pb7qwYIgbsTKzzdLKnI4ejAlfOoGuc1Nl6A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HTB7lZqA1ocj8pS5BJar/swymLXVbb6o83Lp58KJO0eBW4H+NyTTMM6z545qYaEDH4n1hFIONfOoOQxSKujXD2KNi9xqpCTWDjLHS8FOZRiHI1MiDlXfJzVvw2UTRL9ugbRRvrjgySSKFb1DZqtBXtEUlAEj5xhEMVtaGaGVXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J17GTGLY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FtkKBH20; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Jun 2024 08:41:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718268106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05oMZ/uaU2LNUMzjQkqwNiFcFWF1pVwE3ycVjjdx3f0=;
	b=J17GTGLY0h9QF8mqNBHCSAKz2rR8jhbG2pfBLmpsVAKDpAToGLlTWklsUz9WM770F0j4NW
	etOt7GRO/JE2RAJ6IBPeVEe10JRK0kr1L2bAi33FIppsT4t60z4Mu/zCh0BSDuTLWZ9bpb
	ka822TwfHdyidqh4JKL78lkPYIhM9MdpjBKEE8UOwEU6rBEcaVqKcqFKTd0b9uf46xqqY3
	j1JceW7A2UwRAHZsHuLiWRyqYUl+qKiaUEZkKR86GUSSJGBuc/EHDEpmJTMfQNr1/qiKdr
	ZtUPrF+dVKJp/R87DK2IZZxtKvZ1Dg9oiDJe9KuN4GmImM7fg47YI7LR40N31A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718268106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05oMZ/uaU2LNUMzjQkqwNiFcFWF1pVwE3ycVjjdx3f0=;
	b=FtkKBH203/SnzCcJbfsbZo+LZ6t2VVS5XrYxcnApx/u1nMo2Ji+i2ei6nbv86ZlmhNMzg+
	3hwpZ0ecfvmc0qDw==
From: "tip-bot2 for Benjamin Segall" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Don't add the EFI stub to targets, again
Cc: Ben Segall <bsegall@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, v6.1+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <xm267ceukksz.fsf@bsegall.svl.corp.google.com>
References: <xm267ceukksz.fsf@bsegall.svl.corp.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171826810609.10875.7242823258662782011.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b2747f108b8034271fd5289bd8f3a7003e0775a3
Gitweb:        https://git.kernel.org/tip/b2747f108b8034271fd5289bd8f3a7003e0775a3
Author:        Benjamin Segall <bsegall@google.com>
AuthorDate:    Wed, 12 Jun 2024 12:44:44 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 13 Jun 2024 10:32:36 +02:00

x86/boot: Don't add the EFI stub to targets, again

This is a re-commit of

  da05b143a308 ("x86/boot: Don't add the EFI stub to targets")

after the tagged patch incorrectly reverted it.

vmlinux-objs-y is added to targets, with an assumption that they are all
relative to $(obj); adding a $(objtree)/drivers/...  path causes the
build to incorrectly create a useless
arch/x86/boot/compressed/drivers/...  directory tree.

Fix this just by using a different make variable for the EFI stub.

Fixes: cb8bda8ad443 ("x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S")
Signed-off-by: Ben Segall <bsegall@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org # v6.1+
Link: https://lore.kernel.org/r/xm267ceukksz.fsf@bsegall.svl.corp.google.com
---
 arch/x86/boot/compressed/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 243ee86..f205164 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -105,9 +105,9 @@ vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
-vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+vmlinux-libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
+$(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S

