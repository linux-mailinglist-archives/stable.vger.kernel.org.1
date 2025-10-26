Return-Path: <stable+bounces-189772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346FC0A9DE
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E4BF4EDA23
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AFE247DEA;
	Sun, 26 Oct 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t+mprSWB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644723EA9A
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488512; cv=none; b=MPA6rkP2ts9IpmuWZhZc44K8IjVrpmgBoYPR/dHGiCE/Bdd0glyTPXUOW7Lc42siwATJwC+A3wSTFAJZF55dj9lv5kReG4fRy2uZ9bZmWH64atVSux091HYt4eltBpnXcHuGlwvaZ1ikuM48yQhDRPx7EEEt0gvCcXueyMd43mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488512; c=relaxed/simple;
	bh=n21dWDoWOH7VshoG+EnIg4pBhRiOdM9b0WJElcx8S04=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uFGQU0i2+bpKSSTjNDRUmln3pgNQiNwqFegsBCtZvzw41GvSEN6l1aQdq/morN+QVM0rttjWZYS2iU6WnFffPB76kYWKIM8T818ljrk/LgUDvBSMTat64NBjnO9hX3sJ6DgDzFxZ8n0zx0X+aLXfzjNYEuefpetA2h+Ditou3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t+mprSWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D121DC4CEE7;
	Sun, 26 Oct 2025 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488512;
	bh=n21dWDoWOH7VshoG+EnIg4pBhRiOdM9b0WJElcx8S04=;
	h=Subject:To:Cc:From:Date:From;
	b=t+mprSWBasY9KHltaj9Se5hLEzImkBG+++G3t44KMxxg+HC29+MANhfFmg2nsFyFL
	 Dadtf4HtmAn6R+THZNYF5Q8qY8RXz0PeMDcLfmJvzHCCRhNX8LKJpollGRUrBrzNj+
	 so17m1uvzIFK7Jvhknb5uXYn3SDAITGa+4eDnDew=
Subject: FAILED: patch "[PATCH] arch_topology: Fix incorrect error check in" failed to apply to 5.15-stable tree
To: kaushlendra.kumar@intel.com,gregkh@linuxfoundation.org,stable@kernel.org,sudeep.holla@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:21:41 +0100
Message-ID: <2025102641-hydrant-wake-e29d@gregkh>
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
git cherry-pick -x 2eead19334516c8e9927c11b448fbe512b1f18a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102641-hydrant-wake-e29d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2eead19334516c8e9927c11b448fbe512b1f18a1 Mon Sep 17 00:00:00 2001
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Date: Tue, 23 Sep 2025 23:13:08 +0530
Subject: [PATCH] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()

Fix incorrect use of PTR_ERR_OR_ZERO() in topology_parse_cpu_capacity()
which causes the code to proceed with NULL clock pointers. The current
logic uses !PTR_ERR_OR_ZERO(cpu_clk) which evaluates to true for both
valid pointers and NULL, leading to potential NULL pointer dereference
in clk_get_rate().

Per include/linux/err.h documentation, PTR_ERR_OR_ZERO(ptr) returns:
"The error code within @ptr if it is an error pointer; 0 otherwise."

This means PTR_ERR_OR_ZERO() returns 0 for both valid pointers AND NULL
pointers. Therefore !PTR_ERR_OR_ZERO(cpu_clk) evaluates to true (proceed)
when cpu_clk is either valid or NULL, causing clk_get_rate(NULL) to be
called when of_clk_get() returns NULL.

Replace with !IS_ERR_OR_NULL(cpu_clk) which only proceeds for valid
pointers, preventing potential NULL pointer dereference in clk_get_rate().

Cc: stable <stable@kernel.org>
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: b8fe128dad8f ("arch_topology: Adjust initial CPU capacities with current freq")
Link: https://patch.msgid.link/20250923174308.1771906-1-kaushlendra.kumar@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1037169abb45..e1eff05bea4a 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -292,7 +292,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 		 * frequency (by keeping the initial capacity_freq_ref value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
+		if (!IS_ERR_OR_NULL(cpu_clk)) {
 			per_cpu(capacity_freq_ref, cpu) =
 				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
 			clk_put(cpu_clk);


