Return-Path: <stable+bounces-62753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8030E940F4E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04079B26C1F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20D01991DB;
	Tue, 30 Jul 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PaK1NqXW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B311990CE
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335212; cv=none; b=lSKqr0Yyv+z42g4A372LMkAfdOV74b4SHFdbFCckp91dWJ08dVWEVxK0bYMztNPZlx0Hn25PR8DvQlf2o4N9TG8M0dGmLHPJsSY2J+asVBVYWQ0o1/cZrF5RNuN/XCXs0uxMFxQizv37DWhESpJv8MvAUobCbAzDTUA0j36V6T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335212; c=relaxed/simple;
	bh=f4adDyGUNO8odQ0mZmwwlt+dcu2JWIDWsYgIT+5cYAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S1hd290qq3mEAhCry0ySjqbnVrrQr9fIHWHI4fI4O5Nezt+Qn5ikMrEdaG5u0TALJM3cdmd9DKH5u1JTIE8PEK9sbzz2VgXQuM4aDudB4fg7yY4P2/Rg+TPDArB1Iu9s5SQ3CjOhaVJUViQmqG7T22dxSNinQaCnCYvTyGVzKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PaK1NqXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5175C4AF0F;
	Tue, 30 Jul 2024 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722335212;
	bh=f4adDyGUNO8odQ0mZmwwlt+dcu2JWIDWsYgIT+5cYAg=;
	h=Subject:To:Cc:From:Date:From;
	b=PaK1NqXWp2hKXufystLX1jNeClIC5c5zAuX5I1PuAPMpNtgNehAjxtw04cHvSFj6Y
	 Z65m9syVruLMFtAfR55L4NyYjjSDNdpF/dvYROIKXL0y3HifpVoWMhK0l2wsktmlbz
	 3K8iVy5ugJ3QWmrE2tUGW2z53uUKiw+8xP3HXAog=
Subject: FAILED: patch "[PATCH] remoteproc: imx_rproc: Fix refcount mistake in" failed to apply to 5.15-stable tree
To: amishin@t-argos.ru,mathieu.poirier@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:26:49 +0200
Message-ID: <2024073049-brutishly-astride-ce55@gregkh>
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
git cherry-pick -x dce68a49be26abf52712e0ee452a45fa01ab4624
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073049-brutishly-astride-ce55@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

dce68a49be26 ("remoteproc: imx_rproc: Fix refcount mistake in imx_rproc_addr_init")
61afafe8b938 ("remoteproc: imx_rproc: Fix refcount leak in imx_rproc_addr_init")
afe670e23af9 ("remoteproc: imx_rproc: Fix ignoring mapping vdev regions")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dce68a49be26abf52712e0ee452a45fa01ab4624 Mon Sep 17 00:00:00 2001
From: Aleksandr Mishin <amishin@t-argos.ru>
Date: Wed, 12 Jun 2024 16:17:14 +0300
Subject: [PATCH] remoteproc: imx_rproc: Fix refcount mistake in
 imx_rproc_addr_init

In imx_rproc_addr_init() strcmp() is performed over the node after the
of_node_put() is performed over it.
Fix this error by moving of_node_put() calls.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5e4c1243071d ("remoteproc: imx_rproc: support remote cores booted before Linux Kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Link: https://lore.kernel.org/r/20240612131714.12907-1-amishin@t-argos.ru
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 39eacd90af14..144c8e9a642e 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -734,25 +734,29 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 			continue;
 		}
 		err = of_address_to_resource(node, 0, &res);
-		of_node_put(node);
 		if (err) {
 			dev_err(dev, "unable to resolve memory region\n");
+			of_node_put(node);
 			return err;
 		}
 
-		if (b >= IMX_RPROC_MEM_MAX)
+		if (b >= IMX_RPROC_MEM_MAX) {
+			of_node_put(node);
 			break;
+		}
 
 		/* Not use resource version, because we might share region */
 		priv->mem[b].cpu_addr = devm_ioremap_wc(&pdev->dev, res.start, resource_size(&res));
 		if (!priv->mem[b].cpu_addr) {
 			dev_err(dev, "failed to remap %pr\n", &res);
+			of_node_put(node);
 			return -ENOMEM;
 		}
 		priv->mem[b].sys_addr = res.start;
 		priv->mem[b].size = resource_size(&res);
 		if (!strcmp(node->name, "rsc-table"))
 			priv->rsc_table = priv->mem[b].cpu_addr;
+		of_node_put(node);
 		b++;
 	}
 


