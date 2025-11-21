Return-Path: <stable+bounces-195650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E2C7954D
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD4BC34B225
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBA327147D;
	Fri, 21 Nov 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L2b0/Ym8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0142F3632;
	Fri, 21 Nov 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731276; cv=none; b=D41wze82y00ovMXSQPAtUzFqSaYrSrzhXdSkNg8elxndHOJV1MgkkmD5DhNK6+3PR22gQlfUJe7NLK19E10565tscbQX1scB+h0S+zv6I/HF3roFynELB6N9OSrnjUBnvHAWOCeuJxzvqInu4JSsVBVAQExsFrmSoOb2EGAG6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731276; c=relaxed/simple;
	bh=1UdYgKCQlVUj35rJVQb/OvPhOUZ7fgpC6InL4HcWakI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkxY2F1s9k/6w0It8Ki75pWfhavhGArIYNmaRhxRln2BkWRMBJOO82dEX5Lf/09xlJDzB2U2Uzk7uDVo1y+Wgi0691LfTimzm/2FaLNEWfdCxe49uWiMfL+GletPPvudRD5gyY6+TW8ATZ3XXLwf1AasALDKyNDV32jcz9Z5ZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L2b0/Ym8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5945FC4CEF1;
	Fri, 21 Nov 2025 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763731275;
	bh=1UdYgKCQlVUj35rJVQb/OvPhOUZ7fgpC6InL4HcWakI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2b0/Ym8Kd7M4KYEnFXkPGx5PVDqB1iyDtot8rwEWytGNXefgcvWI3ibSD1qAfrq/
	 bwed/5RzTLT/+cRvlkIMbyVHjIWagP5nQBan1FdUPqrMc/ZboGtRVY8IJzWG80ptmI
	 zf60Exs+XqDpf5xG6eGLWO+hr8nQ/7ndnBsyoChc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.17 150/247] LoongArch: KVM: Add delay until timer interrupt injected
Date: Fri, 21 Nov 2025 14:11:37 +0100
Message-ID: <20251121130200.109913318@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130154.587656062@linuxfoundation.org>
References: <20251121130154.587656062@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bibo Mao <maobibo@loongson.cn>

commit d3c9515e4f9d10ccb113adb4809db5cc31e7ef65 upstream.

When timer is fired in oneshot mode, CSR.TVAL will stop with value -1
rather than 0. However when the register CSR.TVAL is restored, it will
continue to count down rather than stop there.

Now the method is to write 0 to CSR.TVAL, wait to count down for 1 cycle
at least, which is 10ns with a timer freq 100MHz, and then retore timer
interrupt status. Here add 2 cycles delay to assure that timer interrupt
is injected.

With this patch, timer selftest case passes to run always.

Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kvm/timer.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <asm/delay.h>
 #include <asm/kvm_csr.h>
 #include <asm/kvm_vcpu.h>
 
@@ -95,6 +96,7 @@ void kvm_restore_timer(struct kvm_vcpu *
 		 * and set CSR TVAL with -1
 		 */
 		write_gcsr_timertick(0);
+		__delay(2); /* Wait cycles until timer interrupt injected */
 
 		/*
 		 * Writing CSR_TINTCLR_TI to LOONGARCH_CSR_TINTCLR will clear



