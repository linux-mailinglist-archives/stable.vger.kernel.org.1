Return-Path: <stable+bounces-96074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E99E06E0
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3B41746E8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDEA204F9E;
	Mon,  2 Dec 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cUxv+Aq6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9D204F63
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151928; cv=none; b=lAF83xEVVfr8RQM/hTtKBb5YYyYbnEP9ogHHhjK3GpLg5NdjIXnsPDipdQqkEA5OrgLIiaQtioneZvL/KhCnHe0krzmHv5NuJ322oXa85tQ47zMnxggoaXvZ+ZK+tpjVdx9Ae3iwr1i4xhERIPuKvezCnhuWV1sMTiUXjH7SHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151928; c=relaxed/simple;
	bh=M9OMqFkoJQfFRLnGlw6XR5bfaBqeFiozxk83cnfM1p4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Dyo+mZgdqXcN8gcQd1IpFlGgauM4SSdyCtyxRg9QItx+RePUTpJ8vz2Lap90V0D1Pm9TflrCnSPTaWbCMvbu/CW2O2Bg1Nt+EOCyQHYz4UL81VChatyZy6iV6rLrcaq3XPWNrXSaKMBzFlzyfBne/VlQ7tWdxy4tK+OPHH040GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cUxv+Aq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB83C4CED1;
	Mon,  2 Dec 2024 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733151926;
	bh=M9OMqFkoJQfFRLnGlw6XR5bfaBqeFiozxk83cnfM1p4=;
	h=Subject:To:Cc:From:Date:From;
	b=cUxv+Aq6nxUMFnAoeUv/rMNQl/Foe4pxb2CxCEguVXqqSm22kDDV7h8MTo7c2VSza
	 7wet44WOvjsT/D36Jkhl+lXZrfb4elnNR2+H/7SFu1SJnyXA6y7PZCS4ga/cdvJWkj
	 3R9m68Zgk5YyCRPszT8ihiSH2Fut61moU20ikZzw=
Subject: FAILED: patch "[PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow" failed to apply to 4.19-stable tree
To: rananta@google.com,maz@kernel.org,oliver.upton@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:05:23 +0100
Message-ID: <2024120223-stunner-letter-9d09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 54bbee190d42166209185d89070c58a343bf514b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120223-stunner-letter-9d09@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 54bbee190d42166209185d89070c58a343bf514b Mon Sep 17 00:00:00 2001
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 19 Nov 2024 16:52:29 -0800
Subject: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow
 status

DDI0487K.a D13.3.1 describes the PMU overflow condition, which evaluates
to true if any counter's global enable (PMCR_EL0.E), overflow flag
(PMOVSSET_EL0[n]), and interrupt enable (PMINTENSET_EL1[n]) are all 1.
Of note, this does not require a counter to be enabled
(i.e. PMCNTENSET_EL0[n] = 1) to generate an overflow.

Align kvm_pmu_overflow_status() with the reality of the architecture
and stop using PMCNTENSET_EL0 as part of the overflow condition. The
bug was discovered while running an SBSA PMU test [*], which only sets
PMCR.E, PMOVSSET<0>, PMINTENSET<0>, and expects an overflow interrupt.

Cc: stable@vger.kernel.org
Fixes: 76d883c4e640 ("arm64: KVM: Add access handler for PMOVSSET and PMOVSCLR register")
Link: https://github.com/ARM-software/sbsa-acs/blob/master/test_pool/pmu/operating_system/test_pmu001.c
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
[ oliver: massaged changelog ]
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20241120005230.2335682-2-oliver.upton@linux.dev
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 8ad62284fa23..3855cc9d0ca5 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -381,7 +381,6 @@ static u64 kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
 
 	if ((kvm_vcpu_read_pmcr(vcpu) & ARMV8_PMU_PMCR_E)) {
 		reg = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
-		reg &= __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 		reg &= __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
 	}
 


