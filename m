Return-Path: <stable+bounces-105607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBD89FAE06
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85B1162D6E
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC87019F12A;
	Mon, 23 Dec 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wm3o6N/F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71C166307
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734955104; cv=none; b=Wa04Ue1FMAX2joqferK8u6pV/cJLYAdt/CoSUcqRqY+BoLKEKZRHt70rCqB+V9veEqriFEDpbt4Lzovaeq8+vUe9Ev9rlbL3DjMGPWle4/GgXZSql2MhPSKARilXmFeSbD8OYao9f/mHj5JQ+cC+eJ/UhBg3zGDpwmJDUIXjQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734955104; c=relaxed/simple;
	bh=fMd9i+2GLwEBHmMROlifMBgXpRxiSt8FIglFDWGiJe4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E6P/JGloQkmLjXkROCYifSBfzOGTVg284kP1K7EFBtSrsGbFt6fylls3QIcukZKGsQJRJfOTL2BNawtHVQJRWZD5CexqBci28fEvk4KFQGs0RRzKPGYJDhUGkJPLJVC4eErEm13KLma9p2DRNCUJSVplefmvp1UezLtI2DwIT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wm3o6N/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA814C4CED3;
	Mon, 23 Dec 2024 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734955104;
	bh=fMd9i+2GLwEBHmMROlifMBgXpRxiSt8FIglFDWGiJe4=;
	h=Subject:To:Cc:From:Date:From;
	b=Wm3o6N/FmxchE9b3ZimqYAxOpl5Jo6FuIDqKqCFc6Kw8HTmq5fNRuojgofQgvDqoh
	 X1B5kImwxASd7fjX++j+QiWDjNDZyvSKA5TeO2xv/JI9OEe5CBIDfKlCIOrqDr+pUj
	 O1JTTzqyetqJ9obKQ/nIV8O8MAyqiCVwTrA++At8=
Subject: FAILED: patch "[PATCH] of: property: fw_devlink: Do not use interrupt-parent" failed to apply to 6.6-stable tree
To: samuel.holland@sifive.com,maz@kernel.org,robh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 12:58:21 +0100
Message-ID: <2024122321-plug-barrel-3b60@gregkh>
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
git cherry-pick -x bc7acc0bd0f94c26bc0defc902311794a3d0fae9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122321-plug-barrel-3b60@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc7acc0bd0f94c26bc0defc902311794a3d0fae9 Mon Sep 17 00:00:00 2001
From: Samuel Holland <samuel.holland@sifive.com>
Date: Wed, 20 Nov 2024 15:31:16 -0800
Subject: [PATCH] of: property: fw_devlink: Do not use interrupt-parent
 directly

commit 7f00be96f125 ("of: property: Add device link support for
interrupt-parent, dmas and -gpio(s)") started adding device links for
the interrupt-parent property. commit 4104ca776ba3 ("of: property: Add
fw_devlink support for interrupts") and commit f265f06af194 ("of:
property: Fix fw_devlink handling of interrupts/interrupts-extended")
later added full support for parsing the interrupts and
interrupts-extended properties, which includes looking up the node of
the parent domain. This made the handler for the interrupt-parent
property redundant.

In fact, creating device links based solely on interrupt-parent is
problematic, because it can create spurious cycles. A node may have
this property without itself being an interrupt controller or consumer.
For example, this property is often present in the root node or a /soc
bus node to set the default interrupt parent for child nodes. However,
it is incorrect for the bus to depend on the interrupt controller, as
some of the bus's children may not be interrupt consumers at all or may
have a different interrupt parent.

Resolving these spurious dependency cycles can cause an incorrect probe
order for interrupt controller drivers. This was observed on a RISC-V
system with both an APLIC and IMSIC under /soc, where interrupt-parent
in /soc points to the APLIC, and the APLIC msi-parent points to the
IMSIC. fw_devlink found three dependency cycles and attempted to probe
the APLIC before the IMSIC. After applying this patch, there were no
dependency cycles and the probe order was correct.

Acked-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 4104ca776ba3 ("of: property: Add fw_devlink support for interrupts")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Link: https://lore.kernel.org/r/20241120233124.3649382-1-samuel.holland@sifive.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 519bf9229e61..cfc8aea002e4 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1286,7 +1286,6 @@ DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
 DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
 DEFINE_SIMPLE_PROP(io_backends, "io-backends", "#io-backend-cells")
-DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
 DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
 DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
@@ -1432,7 +1431,6 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_mboxes, },
 	{ .parse_prop = parse_io_channels, },
 	{ .parse_prop = parse_io_backends, },
-	{ .parse_prop = parse_interrupt_parent, },
 	{ .parse_prop = parse_dmas, .optional = true, },
 	{ .parse_prop = parse_power_domains, },
 	{ .parse_prop = parse_hwlocks, },


