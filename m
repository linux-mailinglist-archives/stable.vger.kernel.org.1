Return-Path: <stable+bounces-37305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7904D89C44A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364B3280CF5
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52E9129A75;
	Mon,  8 Apr 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S543U6xX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8C5128370;
	Mon,  8 Apr 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583844; cv=none; b=XAMYqTMoyH1s2bB62pI2CaZfsu88ZX8C8UdkMdPpdbmK7gHPc02XcPjG7/rPOxPjY+NWACsutSGZRuMGa95pt69fQyXqUOrri6gLpEtVE2GxUdq5v3kl2U8zLw59ndNH26hZbySr1zxca7/NMCh2Rtbb+R8iBaJctqWPOMQS37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583844; c=relaxed/simple;
	bh=SDStYoPgA+FgODYjNPDRT43YBUnnCmjgB7BuIamYU3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbvhvQX6xUU7CdibsVTYzTzNno7os165X0ORSg1iOZ9iYEFHCZsY0sfO17aSLGPPUAxrdJjm1xOXjk8nwG37t1tnOn9ihoreb55LN9JJNtzsiFjbIRtUHbuChTLCPv2Tm3viibYy2sIRIwprkkV8J6cXOg5YdhcRr5f6VIMER1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S543U6xX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022F4C433F1;
	Mon,  8 Apr 2024 13:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583844;
	bh=SDStYoPgA+FgODYjNPDRT43YBUnnCmjgB7BuIamYU3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S543U6xX0+fwGZYI0COXypGmvb9vh1hRMxoWWXtUEwFbz/bAHY+33ZqmhEnC2wJLh
	 PzAzaVRLURN5Q/ano0dnynVxXf0V8P1+zxCv+96hjYKm0Da/o+QikGAhxZkA/Sm/DT
	 SOZ0bmZgSgEXqjaUK+Ih14dDeaLBxzZBm3LLQM2I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wolfgang Walter <linux@stwm.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 241/252] Revert "x86/mpparse: Register APIC address only once"
Date: Mon,  8 Apr 2024 14:59:00 +0200
Message-ID: <20240408125314.129555371@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit bebb5af001dc6cb4f505bb21c4d5e2efbdc112e2 which is
commit f2208aa12c27bfada3c15c550c03ca81d42dcac2 upstream.

It is reported to cause problems in the stable branches, so revert it.

Link: https://lore.kernel.org/r/899b7c1419a064a2b721b78eade06659@stwm.de
Reported-by: Wolfgang Walter <linux@stwm.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/mpparse.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -196,12 +196,12 @@ static int __init smp_read_mpc(struct mp
 	if (!smp_check_mpc(mpc, oem, str))
 		return 0;
 
-	if (early) {
-		/* Initialize the lapic mapping */
-		if (!acpi_lapic)
-			register_lapic_address(mpc->lapic);
+	/* Initialize the lapic mapping */
+	if (!acpi_lapic)
+		register_lapic_address(mpc->lapic);
+
+	if (early)
 		return 1;
-	}
 
 	/* Now process the configuration blocks. */
 	while (count < mpc->length) {



