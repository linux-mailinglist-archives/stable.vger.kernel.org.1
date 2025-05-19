Return-Path: <stable+bounces-144802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC51EABBDFF
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6351917D993
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F726AA93;
	Mon, 19 May 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="amcePTlC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780020C00E
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658219; cv=none; b=Xeb6kqlXhyQI8WdgZcmwCCtwzby/+kptwbYRFp3L5BhTTku6ksiny7ey6MKWfphO0wdneS1i7qD2a6yqycM15daNItVHm80wJZKROoOmIeZbTOJZyvHmSdHOXVfoLZxGdg5cbcKjg+eFLXe4NrSzpoUjuxyS8GX8Cp5lKiCVnSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658219; c=relaxed/simple;
	bh=bTgSVQD3V5cFBKRrkgWXHJ5K/Ntl0fRzhsPkp+IDSgY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aOnlSiGgOcc4HKX1ZGi99zF4KzmhTnfrBCcSTMHLA/ruTgHBL40HiWA/wfJ9L4sNhEQu6mj8M8bbpdANm1Xwco4GkXvNroND9Hug8ojH8Deb/5kFjAWRnn9rgvzRbcn2MC34B/uwFE2iGg6bftYkvnsq4t6qgYKq7BfIA/OVPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=amcePTlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FEEC4CEE4;
	Mon, 19 May 2025 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747658219;
	bh=bTgSVQD3V5cFBKRrkgWXHJ5K/Ntl0fRzhsPkp+IDSgY=;
	h=Subject:To:Cc:From:Date:From;
	b=amcePTlCBLycaGWOO1Ef80w/+sOmsnx3MbwbUm7lUW4tBLcsCLCkcMVLTr6cjA5jP
	 hIMFL8Jz4Q8qDoygkp4zqQteeHuCjvalQMKO2JYEvO3mmjJuu9DfmdC2XR1kS1K3Hj
	 TK64SsozBeSisLjE6ag8QUEFPX8ObXMwANaOajFo=
Subject: FAILED: patch "[PATCH] i2c: designware: Fix an error handling path in" failed to apply to 6.12-stable tree
To: christophe.jaillet@wanadoo.fr,andi.shyti@kernel.org,jarkko.nikula@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:36:56 +0200
Message-ID: <2025051956-squealer-murky-a238@gregkh>
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
git cherry-pick -x 1cfe51ef07ca3286581d612debfb0430eeccbb65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051956-squealer-murky-a238@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cfe51ef07ca3286581d612debfb0430eeccbb65 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Tue, 13 May 2025 19:56:41 +0200
Subject: [PATCH] i2c: designware: Fix an error handling path in
 i2c_dw_pci_probe()

If navi_amd_register_client() fails, the previous i2c_dw_probe() call
should be undone by a corresponding i2c_del_adapter() call, as already done
in the remove function.

Fixes: 17631e8ca2d3 ("i2c: designware: Add driver support for AMD NAVI GPU")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <stable@vger.kernel.org> # v5.13+
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/fcd9651835a32979df8802b2db9504c523a8ebbb.1747158983.git.christophe.jaillet@wanadoo.fr

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 8e0267c7cc29..f21f9877c040 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -278,9 +278,11 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 
 	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU) {
 		dev->slave = i2c_new_ccgx_ucsi(&dev->adapter, dev->irq, &dgpu_node);
-		if (IS_ERR(dev->slave))
+		if (IS_ERR(dev->slave)) {
+			i2c_del_adapter(&dev->adapter);
 			return dev_err_probe(device, PTR_ERR(dev->slave),
 					     "register UCSI failed\n");
+		}
 	}
 
 	pm_runtime_set_autosuspend_delay(device, 1000);


