Return-Path: <stable+bounces-133148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0EDA91E81
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DA78A1253
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DB92628D;
	Thu, 17 Apr 2025 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iWEpDbtX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D8024E4D2
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897535; cv=none; b=sYPAno6XeBGbSYomIvx25XIaFzadqS28ShnWVI+8h0HWSL7LEE5rKupFLpMGYRdYPGIA7bw9B0XFbbGp+idfVwaHC1Q6WgAz8AfzojCqH6UGY1PIJnQXYrlQDfcwmsowlBlidMyRpgmPZQCgcFxdxpwwI1+ZgxEGtPKWrBd0qGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897535; c=relaxed/simple;
	bh=9w7H+Rqjgr7YK5YeoUYCu3LlgikgpY7NHEAW8s5FeA4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XdJ38TdrIk549RsTYU0Hz/zTpv+Lt45PmDvdoNR7nQZLcWf60NjjdUFbjS1epRZr3ysWgmKrqyeLq0bWI4Dx1+Dv4qSca3aBBoJxQHS2ldj+IsIVPup6PujVFBnsPaArE2wj9W72fRMJ8ZY54FigwH5GoKOy60Yselaw4lfKGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iWEpDbtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5A5C4CEEB;
	Thu, 17 Apr 2025 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897535;
	bh=9w7H+Rqjgr7YK5YeoUYCu3LlgikgpY7NHEAW8s5FeA4=;
	h=Subject:To:Cc:From:Date:From;
	b=iWEpDbtX7/Z0GZ0/gjnULPftDUIe71UJqyXyO0E/Ygln7BG/J301GQ5Gr7+54uGTS
	 f+hNtVODhM/mQyXMvHanS2GXkMGPjT6KD5Tejuw9f/09hcLlhs3NN9uRd6vYBhq7w/
	 06hA0wzqIWAMZg3HyX7kjUtMI3jMEB3OYuaSYzlE=
Subject: FAILED: patch "[PATCH] of: resolver: Fix device node refcount leakage in" failed to apply to 5.15-stable tree
To: quic_zijuhu@quicinc.com,robh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:42:59 +0200
Message-ID: <2025041759-mournful-evaporate-f5c1@gregkh>
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
git cherry-pick -x a46a0805635d07de50c2ac71588345323c13b2f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041759-mournful-evaporate-f5c1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


