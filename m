Return-Path: <stable+bounces-155054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663C1AE1748
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F8A3BBEEA
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E427FB1C;
	Fri, 20 Jun 2025 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KG/oD7Tw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B068632B
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410820; cv=none; b=ujMkPjOs5niRcNP7ZikEZns1LWi+/v04Qp9L5UoCy8NS4xhcRQAHFiLLMzp4mN7CrQqScI6mwIlP7uaofyIQHH8fFhWMTkCCSl9Y2xEwqag23XFWtsCL9LLDalGBRHHNpVbuI8LvzsaOZXeFCgAnLusF9JBDCcIA4AMSVrlewdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410820; c=relaxed/simple;
	bh=q+lXzN/bLPs+8LVVsJRDYSVtlz5wNVwpd+koVfVU84A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FIRlaCnxhpPAHSE/N1q3T4gIO4J4XqAI0Edt1CvmcIrhKpf+wD2uits8MZmfxl4Xt4WXgnoe6KSLIpfF7kodCMqp1MsUxvG8NiED8q/jz16WeTclDrOYoXz8cAIFjlerBs5EI5RWDlc8yq6a89ha1JvzJbpG5Ksg3MmeWf9fqFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KG/oD7Tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6665CC4CEE3;
	Fri, 20 Jun 2025 09:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410819;
	bh=q+lXzN/bLPs+8LVVsJRDYSVtlz5wNVwpd+koVfVU84A=;
	h=Subject:To:Cc:From:Date:From;
	b=KG/oD7Tw7SYYcXG2lkGe0vsDhBN4joxQcCl5Jd+NByhYxcREkDu1QI+Y+CbRFs7ST
	 oGTsBTBDF+yjbKqJD8mzSAcXGHw5HSdxdKPN5h+A9+EucyZUnMFzuQuS2/8PRiIwLn
	 3x+zte+gChWRDETYYoyHW0yoE7s1xOHYJvTjMmMM=
Subject: FAILED: patch "[PATCH] PCI: apple: Set only available ports up" failed to apply to 6.6-stable tree
To: j@jannau.net,alyssa@rosenzweig.io,manivannan.sadhasivam@linaro.org,maz@kernel.org,robh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:13:28 +0200
Message-ID: <2025062028-paddling-tribunal-1ecc@gregkh>
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
git cherry-pick -x 751bec089c4eed486578994abd2c5395f08d0302
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062028-paddling-tribunal-1ecc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 751bec089c4eed486578994abd2c5395f08d0302 Mon Sep 17 00:00:00 2001
From: Janne Grunau <j@jannau.net>
Date: Tue, 1 Apr 2025 10:17:01 +0100
Subject: [PATCH] PCI: apple: Set only available ports up

Iterating over disabled ports results in of_irq_parse_raw() parsing
the wrong "interrupt-map" entries, as it takes the status of the node
into account.

This became apparent after disabling unused PCIe ports in the Apple
Silicon device trees instead of deleting them.

Switching from for_each_child_of_node_scoped() to
for_each_available_child_of_node_scoped() solves this issue.

Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Fixes: a0189fdfb73d ("arm64: dts: apple: t8103: Disable unused PCIe ports")
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Janne Grunau <j@jannau.net>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/asahi/20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net/
Link: https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
Link: https://patch.msgid.link/20250401091713.2765724-2-maz@kernel.org

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 18e11b9a7f46..996cef8a2e17 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -754,7 +754,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
-	for_each_child_of_node_scoped(dev->of_node, of_port) {
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
 			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);


