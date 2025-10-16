Return-Path: <stable+bounces-186021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ECDBE3622
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A083454699C
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8F831AF1E;
	Thu, 16 Oct 2025 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WK6K/nCD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706C32E36F2
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617980; cv=none; b=fL1O7jiwKFHX2a45YwBh2F5xtuFjsDGitBWS4S+YT6ONT7He9Y0+pkw52y6yS3N4HEAZj/ER4iQNu2cEc5qUHMWOSc3/uM7WhPRg+kscaibNtoDVlM1r9oqHlyUkEinrRk4gw7TdhH8pmFcOR7T8UVm8zXi1YdEah9CzQxF57dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617980; c=relaxed/simple;
	bh=uxO0CiwA2WbByamXHbLQKDSSyJwupkregm7hZkixATc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GXdVH1jTLZsguCdFdkpixFG235Be1K55GAKcNS0mbOS26eYSuTy59EPRQZGneeXMxgs4QUVIad/k9ZASaAbYX4rSfca25LHovf54KupwqX2ASy/rrudEamMPTwlnfHdXOOxA5bvLRzy7jrWAnms/mmctMPy+rOUJTs33g1rxtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WK6K/nCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98717C4CEF1;
	Thu, 16 Oct 2025 12:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760617980;
	bh=uxO0CiwA2WbByamXHbLQKDSSyJwupkregm7hZkixATc=;
	h=Subject:To:Cc:From:Date:From;
	b=WK6K/nCDse30H57d0yCoJxEKylDQgoHb1a3VHsoH+OyAHaVG1Lm2xGclaLUWPpywn
	 1+E2b5EEv8Fkc1Ex2piYa/+Z6Ggao0QO8woVKAZvfhN8jj8eEc5EK2+UdGBlTP9Y2Y
	 AONGH2kM8Al8WfEBmfnFEnT11uQLSFPvjofIl/OE=
Subject: FAILED: patch "[PATCH] cdx: Fix device node reference leak in cdx_msi_domain_init" failed to apply to 6.12-stable tree
To: linmq006@gmail.com,gregkh@linuxfoundation.org,nipun.gupta@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:32:57 +0200
Message-ID: <2025101657-coaster-squall-0e3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 76254bc489d39dae9a3427f0984fe64213d20548
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101657-coaster-squall-0e3f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76254bc489d39dae9a3427f0984fe64213d20548 Mon Sep 17 00:00:00 2001
From: Miaoqian Lin <linmq006@gmail.com>
Date: Tue, 2 Sep 2025 16:49:33 +0800
Subject: [PATCH] cdx: Fix device node reference leak in cdx_msi_domain_init

Add missing of_node_put() call to release
the device node reference obtained via of_parse_phandle().

Fixes: 0e439ba38e61 ("cdx: add MSI support for CDX bus")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Acked-by: Nipun Gupta <nipun.gupta@amd.com>
Link: https://lore.kernel.org/r/20250902084933.2418264-1-linmq006@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index 3388a5d1462c..91b95422b263 100644
--- a/drivers/cdx/cdx_msi.c
+++ b/drivers/cdx/cdx_msi.c
@@ -174,6 +174,7 @@ struct irq_domain *cdx_msi_domain_init(struct device *dev)
 	}
 
 	parent = irq_find_matching_fwnode(of_fwnode_handle(parent_node), DOMAIN_BUS_NEXUS);
+	of_node_put(parent_node);
 	if (!parent || !msi_get_domain_info(parent)) {
 		dev_err(dev, "unable to locate ITS domain\n");
 		return NULL;


