Return-Path: <stable+bounces-189771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 084C0C0A99C
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA0B9349C3D
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29B3219A79;
	Sun, 26 Oct 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E755Coj+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72396224B0D
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488504; cv=none; b=HGiULux8XlHlpCEPrkjw9GnrWs8/ZcIyFj7C4mlXenMTrksII+0lDpm4pARPpOo68vqy6509X590w9ovoTMMRKJd6TcaMITgkbT5Ox04l1XmdJQ72WgcUeEP9T47R3X2sLSZnWmqAoV5C/qlrDNahrgxN13ZHeu4RCKCe/oZRZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488504; c=relaxed/simple;
	bh=3tLA9fKDNOOL7tFZBNbPDujPKxTZITXFbi+vZttEduM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nv+TMhw7/yy+4bVB2VX5GD5gVk8hJOSr5iRPJX/DYIqtFOe/LLHVJmeQNzeVmC9QYRarhhPST8kInl0u36igH/1u5w1oSL+bN7qSwx3yBgLf8fLyvWcye6tHCWHPzqc+wfcZGuFHWnl0f8ZwLepvHkj52B87aW90qCFUye8bkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E755Coj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C02FC4CEE7;
	Sun, 26 Oct 2025 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488504;
	bh=3tLA9fKDNOOL7tFZBNbPDujPKxTZITXFbi+vZttEduM=;
	h=Subject:To:Cc:From:Date:From;
	b=E755Coj+5NTJjY+fLLOM+L/5FquCelVmsaYqGBdFzuR6hT9Urtj6vU4+sK/P592i2
	 9NF+xZTMwR5fl/Q5cQo4YI5a1WzOpyw/ZjfQimVzjsgq7jN79pDD/l7KAX4W+/e0I1
	 lpwejKETqpiClzT8lCbgYfqFA3/WWF/hX3Z+/pyQ=
Subject: FAILED: patch "[PATCH] arch_topology: Fix incorrect error check in" failed to apply to 6.1-stable tree
To: kaushlendra.kumar@intel.com,gregkh@linuxfoundation.org,stable@kernel.org,sudeep.holla@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:21:41 +0100
Message-ID: <2025102641-derail-shine-9dd5@gregkh>
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
git cherry-pick -x 2eead19334516c8e9927c11b448fbe512b1f18a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102641-derail-shine-9dd5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


