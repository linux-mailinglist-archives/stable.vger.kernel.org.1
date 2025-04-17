Return-Path: <stable+bounces-133149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1485AA91E83
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9501C8A12D4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175D21A45E;
	Thu, 17 Apr 2025 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JPmF47uE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E519AA63
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897538; cv=none; b=dRYzplxukdNp+XHk+d1EhqjLOVvpazp+AtjoWss1ICXxJOMm1NRMFo2aHRyF5UEIXu0MLj30Mie/bglUVCKWPJ/AFUDnymIO9QndZ84FFqeWbuBiVEdBr2e78CDzp/h6AMvRlTyhyoCaaXriilQ7UzPyfv6grasbnHRkZzeCbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897538; c=relaxed/simple;
	bh=PqgZa2FAqf+W1M7JYLlLlWE5ogvkyp0yzUGQ8IHVEiw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fsyrep5SdFtdmbOUs4hnLpy1LPdnLz8ij0hQRgdzLrVxb9ahXCJGVPOMVRMxYQpSrxxwc7wP+7rg09ANSdeS9yEDAYAJ1CDkExoUWSkoyXWBZT/YSeOyEDqb656RFkj+G0ekS/8L9IvHAe5LELoMG9ocHtK1bfYEwAEfIRW4rOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JPmF47uE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A60C4CEEA;
	Thu, 17 Apr 2025 13:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897538;
	bh=PqgZa2FAqf+W1M7JYLlLlWE5ogvkyp0yzUGQ8IHVEiw=;
	h=Subject:To:Cc:From:Date:From;
	b=JPmF47uEDftGPerKFYXYXRp5/rxeo8Eti4C1Qc5PstPK3XgjsEisJv8ElPiJZcWG/
	 ww4R1Uw3KvEMnqvAaPfqUvF1E2Bar3uErjiP9WnsGy9+VQWteoITP8ZHMwkm6s57yu
	 x2ZLxBJa8yV4sxV1eSKPUjwnnC8ikE0yD/8QoSOU=
Subject: FAILED: patch "[PATCH] of: resolver: Fix device node refcount leakage in" failed to apply to 6.1-stable tree
To: quic_zijuhu@quicinc.com,robh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:42:59 +0200
Message-ID: <2025041758-shy-trekker-318e@gregkh>
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
git cherry-pick -x a46a0805635d07de50c2ac71588345323c13b2f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041758-shy-trekker-318e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


