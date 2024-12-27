Return-Path: <stable+bounces-106209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B339FD5C4
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 17:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DB73A3A02
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69241F3D33;
	Fri, 27 Dec 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LzVyFch8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87D1F754E
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735315203; cv=none; b=QPGAF7ZT+sFnoLDUsAi0pMXoH7i8/rV+fPhL+WcGyPKEj8WzZ+Ll91UmmwaBkgvYsKWI5/e0gfUq4p/RSie6+G5AamC0zAU6MxxpmRcVQZtAa2ciIRdq2BkEhzzn7TLUbhuycGGuGGv9+S3tPf+nseHQyEUa8/HOVm3/+zdq8dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735315203; c=relaxed/simple;
	bh=ganNciXAgWlD9a4cGfjV/dwJZwaTIwyALocMbMMNzWw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VVK0g/W0WERNr09qgdLeRvrp2w3L4i9SijmQk6KD0jGBm7Yo/obvvAZR2H31IgOYr93GcghuQZ3xfQg5x/zio/RIIQGMRFPIvT2Ti5yIQtWVrzderFipWbvxJaL/ZY77cWGNBYkD+ae8ydvp6fERas5BSerkrd+WZG/SKHInNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LzVyFch8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77673C4CED0;
	Fri, 27 Dec 2024 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735315203;
	bh=ganNciXAgWlD9a4cGfjV/dwJZwaTIwyALocMbMMNzWw=;
	h=Subject:To:Cc:From:Date:From;
	b=LzVyFch8HdRFKe2b7IUiwv2HGUX1LfKuDA5I75alJP3ecuLt3JjZnEaPR+ZLLciWb
	 WEDrYy/0+HxzyPDsZ0r2Gfr7nVplimFt+veM4QA4NIBDwCA73ypmdZ43ikX5Uj6we3
	 m0oL9SspgpFd6ol6wTMrR7kZGhwj1NyweQVSg9EM=
Subject: FAILED: patch "[PATCH] phy: core: Fix that API devm_of_phy_provider_unregister()" failed to apply to 5.4-stable tree
To: quic_zijuhu@quicinc.com,johan+linaro@kernel.org,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 27 Dec 2024 16:59:59 +0100
Message-ID: <2024122759-prune-pavement-a482@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x c0b82ab95b4f1fbc3e3aeab9d829d012669524b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122759-prune-pavement-a482@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0b82ab95b4f1fbc3e3aeab9d829d012669524b6 Mon Sep 17 00:00:00 2001
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Fri, 13 Dec 2024 20:36:42 +0800
Subject: [PATCH] phy: core: Fix that API devm_of_phy_provider_unregister()
 fails to unregister the phy provider

For devm_of_phy_provider_unregister(), its comment says it needs to invoke
of_phy_provider_unregister() to unregister the phy provider, but it will
not actually invoke the function since devres_destroy() does not call
devm_phy_provider_release(), and the missing of_phy_provider_unregister()
call will cause:

- The phy provider fails to be unregistered.
- Leak both memory and the OF node refcount.

Fortunately, the faulty API has not been used by current kernel tree.
Fix by using devres_release() instead of devres_destroy() within the API.

Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/stable/20241213-phy_core_fix-v6-2-40ae28f5015a%40quicinc.com
Link: https://lore.kernel.org/r/20241213-phy_core_fix-v6-2-40ae28f5015a@quicinc.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index f190d7126613..de07e1616b34 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1259,12 +1259,12 @@ EXPORT_SYMBOL_GPL(of_phy_provider_unregister);
  * of_phy_provider_unregister to unregister the phy provider.
  */
 void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider)
+				     struct phy_provider *phy_provider)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_phy_provider_release, devm_phy_match,
-		phy_provider);
+	r = devres_release(dev, devm_phy_provider_release, devm_phy_match,
+			   phy_provider);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY provider device resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_provider_unregister);


