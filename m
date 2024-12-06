Return-Path: <stable+bounces-99043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68A9E6DFE
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE80283549
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C5201012;
	Fri,  6 Dec 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ABR6e55"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7A20100D
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487687; cv=none; b=nxFgHpiwabqOL5qBE5sl3zc4e0D7ObUmXEBxAi6b/CLM8f6B7m39Dt5IsUyJcfpV8jCN7ZhGQoqwzu1VEb/uIqsLXDCion3njMAu9GmxeDZ3ysuOZJBHZsF7xSuF7nrSiHP5VwZMrTtQuoEMhBe9TtRK5oU7Xu0iJU2PIizNaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487687; c=relaxed/simple;
	bh=VdBeCp/r/lPUgWlTA/XfJPVzLjF8aS+agDGZHqXPsko=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CCye1/Wxp3p1TNsJimEc8s4462bKX8mj/x0+EsIh6cw69i+10AZYKkl+jgmpUzuKHyRmfryfy8W1RSZUqqiLMqkIk87a29PXZIMQz7aVxNlMixpbNydLHp7h23sx8GVQ+w1hNt9Hsv6MOJ2PfKme6yEJqQQeSBV3g+50MCFA8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ABR6e55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EC6C4CED1;
	Fri,  6 Dec 2024 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733487687;
	bh=VdBeCp/r/lPUgWlTA/XfJPVzLjF8aS+agDGZHqXPsko=;
	h=Subject:To:Cc:From:Date:From;
	b=2ABR6e559+2ZbwxiE/VXeZCipjyIeiXwFVD3LDtda7H7LDElp1tcizWZn+r6kw5lV
	 ZmUKJjmOq0yoSUrj3K3aDZOcAvUKCDNSyKqiR120Wmh58uhgZse0/vThg/ulWq7db8
	 L1aANDl64jAa1sL7y7CG+LnS+xMY3xS2rX7gZYsE=
Subject: FAILED: patch "[PATCH] PCI: keystone: Set mode as Root Complex for" failed to apply to 5.4-stable tree
To: kishon@ti.com,kwilczynski@kernel.org,s-vadapalli@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:21:16 +0100
Message-ID: <2024120616-pucker-unlisted-7c65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 5a938ed9481b0c06cb97aec45e722a80568256fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120616-pucker-unlisted-7c65@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a938ed9481b0c06cb97aec45e722a80568256fd Mon Sep 17 00:00:00 2001
From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Fri, 24 May 2024 16:27:13 +0530
Subject: [PATCH] PCI: keystone: Set mode as Root Complex for
 "ti,keystone-pcie" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x
Platforms") introduced configuring "enum dw_pcie_device_mode" as part of
device data ("struct ks_pcie_of_data"). However it failed to set the
mode for "ti,keystone-pcie" compatible.

Since the mode defaults to "DW_PCIE_UNKNOWN_TYPE", the following error
message is displayed for the v3.65a controller:

  "INVALID device type 0"

Despite the driver probing successfully, the controller may not be
functional in the Root Complex mode of operation.

So, set the mode as Root Complex for "ti,keystone-pcie" compatible to
fix this.

Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Link: https://lore.kernel.org/r/20240524105714.191642-2-s-vadapalli@ti.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
[kwilczynski: commit log, added tag for stable releases]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 2219b1a866fa..b99bc4071fe9 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1093,6 +1093,7 @@ static int ks_pcie_am654_set_mode(struct device *dev,
 
 static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
 	.host_ops = &ks_pcie_host_ops,
+	.mode = DW_PCIE_RC_TYPE,
 	.version = DW_PCIE_VER_365A,
 };
 


