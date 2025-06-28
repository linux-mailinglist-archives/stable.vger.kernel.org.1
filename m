Return-Path: <stable+bounces-158818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2803FAEC6AC
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 13:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EDE4A07D8
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A61220F41;
	Sat, 28 Jun 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ISfRGq7x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pl8IWT3Z"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D1217701;
	Sat, 28 Jun 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751110415; cv=none; b=JuH2PI5isJDzK3jmOsSQjNXAZ3nq8nQZDY2BDHfSJIp2W+PDm/+cH718acR774M311fG+LbTPuV34xiQKlY6GpjbJeAuZkYZYHHUapEDSHcKYfBznwiYN8wF+LRt/L39q3tZEut1DerYNo+sL7bG8iBHZaNa6HLRJ9QVuCyyvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751110415; c=relaxed/simple;
	bh=OLmIt0NdaTQQio1j6R4DTmPwFYt4BbZfA51Lhm3hYz8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s4dznl4aImDbGaptUKAgFcPthH6cvF6SFj5i01TZrVcIgxEk/QarZ9z781Y9FxFx+woZ+XEnWl9bOFiV9wNCV0sOTCaIE2ejUcPUW3wvjNb/Zh+qx6+oVewq9LtIGCJKFB/vcCVKLvLdaY4MQ03BfgtHRa/9RxiI+7uHXFSs0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ISfRGq7x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pl8IWT3Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Jun 2025 11:33:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751110406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLLvKV6PC2ezlAmjaYU+E1HyuVMnXblpdQqr7/rdJ4o=;
	b=ISfRGq7xNB333K/uTqoQcAoAnNji/G7fUj53N6SOHSrHEWEXrxQe+Lj+o//QJWYBJs4yJn
	iChQB1eBtkN9RniRMpeuVq1dJYpM2o1KtywnuR4M7Q427wFcSA21Cj+poKOxNHokBUpQUo
	bdoCPshBZfgzn6YQ71zEYnn3t7D+62IwOvBGL0p92nhokBJHeNx8bz+hHR+kZf3sJKuCRh
	CN5a4bEY2KncKirLKX7cCmdRKSqcRgMHjiLIU1uGDQ6iqpnzrutd1LljyI5RfkQ++9BU3B
	jyQwsySubmMgy64gFqrkXYLPMCyDgMc7oUrsJpexiGGPX5/BxLGv/D+l0GEgEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751110406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLLvKV6PC2ezlAmjaYU+E1HyuVMnXblpdQqr7/rdJ4o=;
	b=pl8IWT3ZqjANLNcmX4lNZo0YezJ+/oSv5CAIYd/HRrXq+SUHGQOBVF1v3wIIN+l9ZwBEws
	QJTpmhHkVLApLVDA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/urgent] x86/mce/amd: Fix threshold limit reset
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250624-wip-mca-updates-v4-4-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-4-236dd74f645f@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175111040497.406.16411404951495816487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/urgent branch of tip:

Commit-ID:     5f6e3b720694ad771911f637a51930f511427ce1
Gitweb:        https://git.kernel.org/tip/5f6e3b720694ad771911f637a51930f511427ce1
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 24 Jun 2025 14:15:59 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 27 Jun 2025 13:16:23 +02:00

x86/mce/amd: Fix threshold limit reset

The MCA threshold limit must be reset after servicing the interrupt.

Currently, the restart function doesn't have an explicit check for this.  It
makes some assumptions based on the current limit and what's in the registers.
These assumptions don't always hold, so the limit won't be reset in some
cases.

Make the reset condition explicit. Either an interrupt/overflow has occurred
or the bank is being initialized.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250624-wip-mca-updates-v4-4-236dd74f645f@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6820ebc..5c4eb28 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -350,7 +350,6 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 struct thresh_restart {
 	struct threshold_block	*b;
-	int			reset;
 	int			set_lvt_off;
 	int			lvt_off;
 	u16			old_limit;
@@ -432,13 +431,13 @@ static void threshold_restart_bank(void *_tr)
 
 	rdmsr(tr->b->address, lo, hi);
 
-	if (tr->b->threshold_limit < (hi & THRESHOLD_MAX))
-		tr->reset = 1;	/* limit cannot be lower than err count */
-
-	if (tr->reset) {		/* reset err count and overflow bit */
-		hi =
-		    (hi & ~(MASK_ERR_COUNT_HI | MASK_OVERFLOW_HI)) |
-		    (THRESHOLD_MAX - tr->b->threshold_limit);
+	/*
+	 * Reset error count and overflow bit.
+	 * This is done during init or after handling an interrupt.
+	 */
+	if (hi & MASK_OVERFLOW_HI || tr->set_lvt_off) {
+		hi &= ~(MASK_ERR_COUNT_HI | MASK_OVERFLOW_HI);
+		hi |= THRESHOLD_MAX - tr->b->threshold_limit;
 	} else if (tr->old_limit) {	/* change limit w/o reset */
 		int new_count = (hi & THRESHOLD_MAX) +
 		    (tr->old_limit - tr->b->threshold_limit);

