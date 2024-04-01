Return-Path: <stable+bounces-34663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD6C894049
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21379B2179E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5146B9F;
	Mon,  1 Apr 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xcm2Rrr/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D0482DF;
	Mon,  1 Apr 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988878; cv=none; b=vD/ND15CaifCPA6puXEST3GPph+Xq7gflpzGNRk1q5UraF5qAbPvjMZYLJM/fs7ejo/yxMaJ4czJmQl294BlTHeDbhX2goXWMiTdmgdf5yzsnYoILfSpKcH8o0QsUFrGIHokx+gj5avf5NK6+R6Zwy7mfQAKGwNzI8cbxF863CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988878; c=relaxed/simple;
	bh=z//7JzATQkF3pA/sM4NxkU1/ZI7rjdz9rg/qmdWz71k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWh005dnrPzvvVW7r38CyPJgEkWMuA/TOLqqgM4j8Jo2XG9hM1K3KSGoCh1NRU+HssyTI6zFLkpZ3ffi165jDQD2PYtwlPCQ4m8jotZ2zNhwNE4zPPYGYf+XECjiJH1E1IRyPzppwD+WppHusbuRk0EtyIQGb1pvkFEIgv1VQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xcm2Rrr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353ABC433C7;
	Mon,  1 Apr 2024 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988878;
	bh=z//7JzATQkF3pA/sM4NxkU1/ZI7rjdz9rg/qmdWz71k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xcm2Rrr/bkA8mGHClaPYjLcl5ALRLm3E/Ghlcrl3jLLet77YQx4bnmTBN/8noq1qk
	 vxRF2eaeimcljlUKVtgrfWL91hFIBnZl5/w+nXuL3vYD6G0/whVEas1l4miClaGFkb
	 mbL4Ppd/hlMPLZnEidIfSjSyI3A+duKZksi7DMmA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 315/432] x86/mpparse: Register APIC address only once
Date: Mon,  1 Apr 2024 17:45:02 +0200
Message-ID: <20240401152602.581065187@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit f2208aa12c27bfada3c15c550c03ca81d42dcac2 ]

The APIC address is registered twice. First during the early detection and
afterwards when actually scanning the table for APIC IDs. The APIC and
topology core warn about the second attempt.

Restrict it to the early detection call.

Fixes: 81287ad65da5 ("x86/apic: Sanitize APIC address setup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240322185305.297774848@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/mpparse.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index b223922248e9f..15c700d358700 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -196,12 +196,12 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 	if (!smp_check_mpc(mpc, oem, str))
 		return 0;
 
-	/* Initialize the lapic mapping */
-	if (!acpi_lapic)
-		register_lapic_address(mpc->lapic);
-
-	if (early)
+	if (early) {
+		/* Initialize the lapic mapping */
+		if (!acpi_lapic)
+			register_lapic_address(mpc->lapic);
 		return 1;
+	}
 
 	/* Now process the configuration blocks. */
 	while (count < mpc->length) {
-- 
2.43.0




