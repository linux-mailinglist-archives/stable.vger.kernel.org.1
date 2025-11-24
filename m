Return-Path: <stable+bounces-196678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049DC7FFFD
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 11:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 307584E381B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A1B2F99BD;
	Mon, 24 Nov 2025 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WqC8SACW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5952F8BD0
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981560; cv=none; b=Vn+VFYmTMr1EaBZ7nGneJlR279iyFIKWHKDLz3BzeIgGnu0r0sx44vskcDUTR27piC//EiwSMebdwWR2uyS+VoHcUaGmHGLUY1cb7YvAfYXqRGAr/4ii5boR7dfjzQsH66v0nopCO/Bv9ykuDcXl9hgzyW2G2qaEoPEdNCsVpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981560; c=relaxed/simple;
	bh=Fj3/kwI+dfAyYGoRZouKX6TcOubGoYrAvN5keoHN1mI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZyPv5WKGi3mgYJLgMy1BlFDv/BqxC0/ugC8aE/KYpYJbbTAGJ4dVx9XJbiHmUItBIbPv8vWPd8qWZyZnnOwhGZZZk3MHBLqt7Y44EhSOL2/7ykj7oNUsD3lPtuFcbRxkGmgxqvGBfeKfQdCFCdsT3kGnFMefzjZaN1jZG3Qd0C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WqC8SACW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C64DC4CEF1;
	Mon, 24 Nov 2025 10:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763981559;
	bh=Fj3/kwI+dfAyYGoRZouKX6TcOubGoYrAvN5keoHN1mI=;
	h=Subject:To:Cc:From:Date:From;
	b=WqC8SACW5trj0R7aQ1/j1Xat77BvQvSvrB6CEGMw/JcgCSOVuosywClNAEZbnkLHN
	 DBLNbON6/hoFUZShKjBk2ugE5rPJM6TLrAHZ7UA9IO4PAD7q9WECSChwQeQ+y9yT6Y
	 5eD9SbSnX58+IJkEOwiMhkRJZ5NoW1Ipf4GTsSks=
Subject: FAILED: patch "[PATCH] KVM: arm64: Check the untrusted offset in FF-A memory share" failed to apply to 6.1-stable tree
To: sebastianene@google.com,maz@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 11:52:30 +0100
Message-ID: <2025112430-brunch-scone-7ffb@gregkh>
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
git cherry-pick -x 103e17aac09cdd358133f9e00998b75d6c1f1518
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112430-brunch-scone-7ffb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


