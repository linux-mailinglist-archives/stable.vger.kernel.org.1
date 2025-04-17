Return-Path: <stable+bounces-133146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB2BA91E78
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A0A461E1A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A813524E4CB;
	Thu, 17 Apr 2025 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AjmcsC98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825624E01C
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897529; cv=none; b=QVJT1NErCFf7FnqIpZWF38Aw9pS9N+MutWylvpTaKrS0raAhEoQzBzxkR6Z9D3rNcLhJePzr8RqJFkTFjcAXo+CmLtf7BqhwEp67jmKXxmrsZ2rESNnxw4wqJ7A5J7uZefUvFcZ74luqCLM4dBCla0WuaSvcCWRYHGszfOZkzuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897529; c=relaxed/simple;
	bh=YK2wv4OSU5iDNV8q+Xjm1Gifl0snNrtpFTs1MXCzds8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ScFJaNWx9067Z6BOKFTDmEv6SRa3fZY5zsFfuy6T6xT+mi1qFwKtNLLwuP0DoY9CoVKRCM0Q3cAuFE9y5ouffluB+v2GDTIz4MKsYqy9KkzeIidIrP9HHyCP1WglqJtD7yBkCawCrP95tiWaevOtPKIMBLpTBFjGM+dK5aGvFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AjmcsC98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8813AC4CEEA;
	Thu, 17 Apr 2025 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897528;
	bh=YK2wv4OSU5iDNV8q+Xjm1Gifl0snNrtpFTs1MXCzds8=;
	h=Subject:To:Cc:From:Date:From;
	b=AjmcsC98LkbwQkUOOBXI2zEuxRp8IZBxflntshOUBjkHYX3umlbERChEaMCiJXhyu
	 RhInTN7WhkulJrUfkmiuwCYSNqV/8SW0RF32amNccotUhAnkgnt9cVCy4lCZlNipsZ
	 AWOTubNfKbAwazZmllows1sm6Du/nxRNtdQ1Pre8=
Subject: FAILED: patch "[PATCH] of: resolver: Fix device node refcount leakage in" failed to apply to 6.6-stable tree
To: quic_zijuhu@quicinc.com,robh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:42:58 +0200
Message-ID: <2025041758-unloving-barcode-722b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a46a0805635d07de50c2ac71588345323c13b2f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041758-unloving-barcode-722b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a46a0805635d07de50c2ac71588345323c13b2f9 Mon Sep 17 00:00:00 2001
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Mon, 24 Feb 2025 17:01:55 -0600
Subject: [PATCH] of: resolver: Fix device node refcount leakage in
 of_resolve_phandles()

In of_resolve_phandles(), refcount of device node @local_fixups will be
increased if the for_each_child_of_node() exits early, but nowhere to
decrease the refcount, so cause refcount leakage for the node.

Fix by using __free() on @local_fixups.

Fixes: da56d04c806a ("of/resolver: Switch to new local fixups format.")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20250209-of_irq_fix-v2-9-93e3a2659aa7@quicinc.com
[robh: Use __free() instead]
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index c871e35d4921..2caad365a665 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -249,8 +249,9 @@ static int adjust_local_phandle_references(const struct device_node *local_fixup
  */
 int of_resolve_phandles(struct device_node *overlay)
 {
-	struct device_node *child, *local_fixups, *refnode;
+	struct device_node *child, *refnode;
 	struct device_node *overlay_fixups;
+	struct device_node __free(device_node) *local_fixups = NULL;
 	struct property *prop;
 	const char *refpath;
 	phandle phandle, phandle_delta;


