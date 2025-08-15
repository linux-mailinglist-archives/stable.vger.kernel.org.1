Return-Path: <stable+bounces-169737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8A3B282FF
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8B11D03599
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D581D6188;
	Fri, 15 Aug 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zt3RJolX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299D14F125
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271920; cv=none; b=k18e/JybBB/+uw3pydeA09Xjsu4CRmxiiVfJ/r9j49XXlkL/h/M7dtO31PuiP/EVYQYkXho6ZcGLDo/QGPydBp+ZibrRcJTyG0LzIZX8w/O0vHQ7PHYt+BbJWCTEtyAOpfGW6lqHhLkrCD8NG5jp4Xe2WWz1tsaK/ZvmfF04k68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271920; c=relaxed/simple;
	bh=EoppllOCYVi2w8oSNCNNSEXH5ke4m1sy7Rpem9XPmiA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rWXgNOEE4Vq9kU3e0aAlfDyvVd3jlv7C716T74fO+LAh+Sw1yiKUC7wYSBJxK2SIn2plxQyfwzF4G3aXAWqTXNrRrSeVyEm8uOkwvWtT6TpN4ZWqm+/pAdluoCkK1BmuPYf5NW6TQyVcPfFiS8XaWanuHrtblq3CHD3QPu7wxKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zt3RJolX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8160C4CEEB;
	Fri, 15 Aug 2025 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755271920;
	bh=EoppllOCYVi2w8oSNCNNSEXH5ke4m1sy7Rpem9XPmiA=;
	h=Subject:To:Cc:From:Date:From;
	b=Zt3RJolX+IzBlrj4rAotH2kHag2Zgr34MKOLm0F4uEYYwhuE9gaPNn0DFkbJhPbh2
	 PYYedlqokzmaNj5Q8FVQmYyX+KJh+6K8WZd2ea5v3BBokrke026lc3wXZ9gWgPgD1U
	 tp37cyQ5sia/qjdhYI2VkXu0UzOPMVqDW/S+J6Lk=
Subject: FAILED: patch "[PATCH] net: enetc: fix device and OF node leak at probe" failed to apply to 6.1-stable tree
To: johan@kernel.org,horms@kernel.org,kuba@kernel.org,vladimir.oltean@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 17:31:56 +0200
Message-ID: <2025081556-icon-nursing-ee42@gregkh>
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
git cherry-pick -x 70458f8a6b44daf3ad39f0d9b6d1097c8a7780ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081556-icon-nursing-ee42@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 70458f8a6b44daf3ad39f0d9b6d1097c8a7780ed Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 25 Jul 2025 19:12:10 +0200
Subject: [PATCH] net: enetc: fix device and OF node leak at probe

Make sure to drop the references to the IERB OF node and platform device
taken by of_parse_phandle() and of_find_device_by_node() during probe.

Fixes: e7d48e5fbf30 ("net: enetc: add a mini driver for the Integrated Endpoint Register Block")
Cc: stable@vger.kernel.org	# 5.13
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250725171213.880-3-johan@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index f63a29e2e031..de0fb272c847 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -829,19 +829,29 @@ static int enetc_pf_register_with_ierb(struct pci_dev *pdev)
 {
 	struct platform_device *ierb_pdev;
 	struct device_node *ierb_node;
+	int ret;
 
 	ierb_node = of_find_compatible_node(NULL, NULL,
 					    "fsl,ls1028a-enetc-ierb");
-	if (!ierb_node || !of_device_is_available(ierb_node))
+	if (!ierb_node)
 		return -ENODEV;
 
+	if (!of_device_is_available(ierb_node)) {
+		of_node_put(ierb_node);
+		return -ENODEV;
+	}
+
 	ierb_pdev = of_find_device_by_node(ierb_node);
 	of_node_put(ierb_node);
 
 	if (!ierb_pdev)
 		return -EPROBE_DEFER;
 
-	return enetc_ierb_register_pf(ierb_pdev, pdev);
+	ret = enetc_ierb_register_pf(ierb_pdev, pdev);
+
+	put_device(&ierb_pdev->dev);
+
+	return ret;
 }
 
 static const struct enetc_si_ops enetc_psi_ops = {


