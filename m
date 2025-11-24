Return-Path: <stable+bounces-196677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2208C80003
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 11:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002ED3A7960
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A192F9DA0;
	Mon, 24 Nov 2025 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hjl6fLqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A212F9987
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981557; cv=none; b=NiMIlytwsEE+nvnJI/M3Wm8772vPLOeFAhP5QYlRNISw3KHTmx2SmPMiaZ45hR0MjVrfzoXQ9VugPNIIkG6RoTZ5R5bOx4WwM72lYrYk69Taxpp8VAjKTRCO6bT3fX8yYJ52PUO3bCCADGRpzy3ww4fQv6q6yYVbCZUs+EovI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981557; c=relaxed/simple;
	bh=tp2C106NrLs2VzDSNAluEX2a++BShXYNY+HUst24+U0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FvWRMBwJQMnpNgEAJ7Z1rnEvz/FUTtqzYuOw/JeqgT0YZ3cdvE5auOL3fHSPgKtwRT1rVFOG4EYFJ59Zm0XTuq/cn72DTJfnCC8IXebIO821O6Neqfl9FRFF2hpK0Ng+eLOT34SyrESfG6jyZaOUvX7ULyyRt+cNGiuUhnaU6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hjl6fLqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85855C4CEF1;
	Mon, 24 Nov 2025 10:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763981556;
	bh=tp2C106NrLs2VzDSNAluEX2a++BShXYNY+HUst24+U0=;
	h=Subject:To:Cc:From:Date:From;
	b=Hjl6fLqKUzUia+PV+Rr6OxWiUj1FDQEt9QEVZh0iU2SsllC1jcpTlC03mqh2tlhu1
	 vJ6XxhAPZkBGj01rgAchg2yAVWeoHlrcFAox3+xIlu1pe6rUIXQhymm8yQpq6KAozG
	 wQE/+08bGczDTdtixghGBXxhH4wtbMzmptaMvsvs=
Subject: FAILED: patch "[PATCH] KVM: arm64: Check the untrusted offset in FF-A memory share" failed to apply to 5.15-stable tree
To: sebastianene@google.com,maz@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 11:52:30 +0100
Message-ID: <2025112430-imperial-yearling-e395@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 103e17aac09cdd358133f9e00998b75d6c1f1518
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112430-imperial-yearling-e395@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 103e17aac09cdd358133f9e00998b75d6c1f1518 Mon Sep 17 00:00:00 2001
From: Sebastian Ene <sebastianene@google.com>
Date: Fri, 17 Oct 2025 07:57:10 +0000
Subject: [PATCH] KVM: arm64: Check the untrusted offset in FF-A memory share

Verify the offset to prevent OOB access in the hypervisor
FF-A buffer in case an untrusted large enough value
[U32_MAX - sizeof(struct ffa_composite_mem_region) + 1, U32_MAX]
is set from the host kernel.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251017075710.2605118-1-sebastianene@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 4e16f9b96f63..58b7d0c477d7 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -479,7 +479,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
 	struct ffa_mem_region *buf;
-	u32 offset, nr_ranges;
+	u32 offset, nr_ranges, checked_offset;
 	int ret = 0;
 
 	if (addr_mbz || npages_mbz || fraglen > len ||
@@ -516,7 +516,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 		goto out_unlock;
 	}
 
-	if (fraglen < offset + sizeof(struct ffa_composite_mem_region)) {
+	if (check_add_overflow(offset, sizeof(struct ffa_composite_mem_region), &checked_offset)) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out_unlock;
+	}
+
+	if (fraglen < checked_offset) {
 		ret = FFA_RET_INVALID_PARAMETERS;
 		goto out_unlock;
 	}


