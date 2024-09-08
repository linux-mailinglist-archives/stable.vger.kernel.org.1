Return-Path: <stable+bounces-73885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0D970751
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919C71C20C14
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02BC15ADBC;
	Sun,  8 Sep 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j7qsnYDg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16E152F6F
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797790; cv=none; b=cAf3n3zdxAvfQdCZU4jLPrafl9Bp12RAXJUyU+WusxejgjhnnCwnGyApkGnuLp7JkUb2NYIDmrXKfU5NT3i3ak7mJJJK/oF0CRyBbQDX1lAVZR9WirPWtw9QkfiuAjeEMRlNnnDFHPpoSprr5bLIId/o1HtfkDNIzwhxhEscyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797790; c=relaxed/simple;
	bh=EOt5NqvP0KKnndJpr/k3IHnfPb+iBm79WRm6iS39GIo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wi2BX78zhJ0sdgApu6NqoccpEZOxkzyFH8Xrh9bEk8xWd9WVXITAaPINilv8jZKOskkgjEb84NDUv82uaYILi9mlYdtFBYx2Ji45zC4p9AXgYAuH17+I1+6Vi/qihy6V/aa/isBEHQTXgSjCel/BThsli3WXPqtsBzg4UqUf0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j7qsnYDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2244DC4CEC8;
	Sun,  8 Sep 2024 12:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725797790;
	bh=EOt5NqvP0KKnndJpr/k3IHnfPb+iBm79WRm6iS39GIo=;
	h=Subject:To:Cc:From:Date:From;
	b=j7qsnYDgbKehLlV/qA6FphxuR6OUc3oQ2jfkSPPFyw0sgBX5L6W8e48eNfbPZVAxC
	 PJfiaVYsNGnTMVZTERT/8qMP1ZxEH8UC0Tha5F/jZ1LmdIADqWxufFGUrFV0w9Dxkt
	 Yxvyuhy6/SGm8rmzyfVM7fCuQHAzbLmdjsEMtejw=
Subject: FAILED: patch "[PATCH] x86/apic: Make x2apic_disable() work correctly" failed to apply to 6.1-stable tree
To: yuntao.wang@linux.dev,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:16:27 +0200
Message-ID: <2024090827-recount-humbly-e075@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0ecc5be200c84e67114f3640064ba2bae3ba2f5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090827-recount-humbly-e075@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


