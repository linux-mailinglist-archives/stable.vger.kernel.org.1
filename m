Return-Path: <stable+bounces-73887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A142970753
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E391F1F21B57
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33E515C152;
	Sun,  8 Sep 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KWBU/oWy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E752F6F
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797796; cv=none; b=upwf4A7sGDGfcGTU76/Bq13IJX6wKgfQkraK4KLeKPqrvNsRCAKeAAS6FO7S5WCbCp3y4BFJpuWFkaKfTg5/QF07Sg6y+YTNKkLs5szH3TtB9Nh53eJ5W6SVtqGwfhm2ooJ+6/+dUIsVbsRhw1IrG3PBebeFetP/dSAY6mKqd84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797796; c=relaxed/simple;
	bh=M8GTgREqAVBewjOKJ5rU9BJCCN1hsV9BxDwOPVbEGAo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tbsT4RFcIN2JQqqrvu4snXo9hBy3wW289RKvSFL0WZQm/V5E07oBvv0TFxES6FHaaWFpxeQR5bIuMwz4IWQsJhrxd5sEHMgIrLy21aR6l9VHT45UCsa+KJvjbNS9C57Z/KmB+sZ2lBviDZb6s9VRuUy2xiUgBXA4uRsJdx5XXlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KWBU/oWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D555C4CEC3;
	Sun,  8 Sep 2024 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725797796;
	bh=M8GTgREqAVBewjOKJ5rU9BJCCN1hsV9BxDwOPVbEGAo=;
	h=Subject:To:Cc:From:Date:From;
	b=KWBU/oWydZcYRkHfvWOH4bYtqi5BIux931B6YdAlePKrGoqdpe0qpPYreyIhaqu0O
	 vrC5K/CwQgPQ6RP2x//UZg2rkh4/SXFusP+SBDfpDiIvqLt/0n5j9BarTsa7jm9y4z
	 NYYs1xI/maGoPVGepTUBAGcymbprXg7vgmtLCxiE=
Subject: FAILED: patch "[PATCH] x86/apic: Make x2apic_disable() work correctly" failed to apply to 5.10-stable tree
To: yuntao.wang@linux.dev,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:16:29 +0200
Message-ID: <2024090829-clench-kinfolk-03d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0ecc5be200c84e67114f3640064ba2bae3ba2f5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090829-clench-kinfolk-03d9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

0ecc5be200c8 ("x86/apic: Make x2apic_disable() work correctly")
720a22fd6c1c ("x86/apic: Don't access the APIC when disabling x2APIC")
5a88f354dcd8 ("x86/apic: Split register_apic_address()")
d10a904435fa ("x86/apic: Consolidate boot_cpu_physical_apicid initialization sites")
49062454a3eb ("x86/apic: Rename disable_apic")
bea629d57d00 ("x86/apic: Save the APIC virtual base address")
3adee777ad0d ("x86/smpboot: Remove initial_stack on 64-bit")
94a855111ed9 ("Merge tag 'x86_core_for_v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ecc5be200c84e67114f3640064ba2bae3ba2f5a Mon Sep 17 00:00:00 2001
From: Yuntao Wang <yuntao.wang@linux.dev>
Date: Tue, 13 Aug 2024 09:48:27 +0800
Subject: [PATCH] x86/apic: Make x2apic_disable() work correctly

x2apic_disable() clears x2apic_state and x2apic_mode unconditionally, even
when the state is X2APIC_ON_LOCKED, which prevents the kernel to disable
it thereby creating inconsistent state.

Due to the early state check for X2APIC_ON, the code path which warns about
a locked X2APIC cannot be reached.

Test for state < X2APIC_ON instead and move the clearing of the state and
mode variables to the place which actually disables X2APIC.

[ tglx: Massaged change log. Added Fixes tag. Moved clearing so it's at the
  	right place for back ports ]

Fixes: a57e456a7b28 ("x86/apic: Fix fallout from x2apic cleanup")
Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240813014827.895381-1-yuntao.wang@linux.dev

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 66fd4b2a37a3..373638691cd4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1775,12 +1775,9 @@ static __init void apic_set_fixmap(bool read_apic);
 
 static __init void x2apic_disable(void)
 {
-	u32 x2apic_id, state = x2apic_state;
+	u32 x2apic_id;
 
-	x2apic_mode = 0;
-	x2apic_state = X2APIC_DISABLED;
-
-	if (state != X2APIC_ON)
+	if (x2apic_state < X2APIC_ON)
 		return;
 
 	x2apic_id = read_apic_id();
@@ -1793,6 +1790,10 @@ static __init void x2apic_disable(void)
 	}
 
 	__x2apic_disable();
+
+	x2apic_mode = 0;
+	x2apic_state = X2APIC_DISABLED;
+
 	/*
 	 * Don't reread the APIC ID as it was already done from
 	 * check_x2apic() and the APIC driver still is a x2APIC variant,


