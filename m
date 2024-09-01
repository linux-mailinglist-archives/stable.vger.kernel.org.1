Return-Path: <stable+bounces-71705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF939675BB
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 11:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AECE1F20F0C
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026F513C66A;
	Sun,  1 Sep 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NRhRwAvS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5634143880
	for <stable@vger.kernel.org>; Sun,  1 Sep 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725182633; cv=none; b=nFt59WnO12HobDR088VBFfZ8C5cid2KA+9+HWJV/dYddAsuCI4hu5Z4Oe3kO2zXcdOVCNFesn9rf++MS8rcSNtUKSquSNVfLmZ4Fr5UIZ+4XQJsUZnSde+vNJmwO0tacm9oT1Aquz1WUrQaWUFvO/3h7MX6ch9WbJWv3+Hygsdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725182633; c=relaxed/simple;
	bh=PowvoBQP5oor83G/kzUEb5O54g0VMSMx6eXyZpGj47s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S3ftqgHA90BeautF+htL/kvZMneeb8nH79vu9LAB64g6/4IwATxjT8zSl9bGX7iRFeC9bflk//UxWZq6uwBdXFtGL0pGrTyjN4S+st9a2RDLJ6E9MmqV9mBiv08RLKaeYCvuFD9hfuwGNzBF+FCWptdoZWxx0KYOlJItu7lcQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NRhRwAvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD2BC4CEC3;
	Sun,  1 Sep 2024 09:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725182633;
	bh=PowvoBQP5oor83G/kzUEb5O54g0VMSMx6eXyZpGj47s=;
	h=Subject:To:Cc:From:Date:From;
	b=NRhRwAvSWHdT3203BWStWI0PJqK1SXCaIGArjB1yUNmbc7q8DPKKN2jL+bN3cmt3o
	 1yqOWrJhJg2oXF95foSSvuMjo382AxJsAA86FRuSN2pvLDkkLf6dnwcsVAiaLVFL9H
	 nJVL1a+DwdEGRsmWpGI7k68BAn5GJPIQqs3c4DfM=
Subject: FAILED: patch "[PATCH] usb: dwc3: st: add missing depopulate in probe error path" failed to apply to 4.19-stable tree
To: krzysztof.kozlowski@linaro.org,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,patrice.chotard@foss.st.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 01 Sep 2024 11:23:43 +0200
Message-ID: <2024090143-yiddish-twisted-954d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x cd4897bfd14f6a5388b21ba45a066541a0425199
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090143-yiddish-twisted-954d@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

cd4897bfd14f ("usb: dwc3: st: add missing depopulate in probe error path")
e36721b90144 ("usb: dwc3: st: Add of_node_put() before return in probe function")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd4897bfd14f6a5388b21ba45a066541a0425199 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 11:39:57 +0200
Subject: [PATCH] usb: dwc3: st: add missing depopulate in probe error path

Depopulate device in probe error paths to fix leak of children
resources.

Fixes: f83fca0707c6 ("usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20240814093957.37940-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index a9cb04043f08..c8c7cd0c1796 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -266,7 +266,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	if (!child_pdev) {
 		dev_err(dev, "failed to find dwc3 core device\n");
 		ret = -ENODEV;
-		goto err_node_put;
+		goto depopulate;
 	}
 
 	dwc3_data->dr_mode = usb_get_dr_mode(&child_pdev->dev);
@@ -282,6 +282,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	ret = st_dwc3_drd_init(dwc3_data);
 	if (ret) {
 		dev_err(dev, "drd initialisation failed\n");
+		of_platform_depopulate(dev);
 		goto undo_softreset;
 	}
 
@@ -291,6 +292,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dwc3_data);
 	return 0;
 
+depopulate:
+	of_platform_depopulate(dev);
 err_node_put:
 	of_node_put(child);
 undo_softreset:


