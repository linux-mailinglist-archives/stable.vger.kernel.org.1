Return-Path: <stable+bounces-133142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AB1A91E6E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186D87ADF35
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3924EA8E;
	Thu, 17 Apr 2025 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r/SDcrgV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9024E4D2
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897516; cv=none; b=VzhNdW7+qcNAAQRbjx6830skqgCB0S2wPQVIYfgw2Mw/w4twGBWG8dkmZsCptNlhkABxrH2oRpiVxOrAW/AC6QXBt5ifBLLNXQR5h5pJWmrxtIavSClQOKrdVoPzv2R6HJGNX7Nqx/PJceeB78S8p+IN6pIqDmdq5S9bbjMskVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897516; c=relaxed/simple;
	bh=HDSljw7brrElgVob+11DwSdI4sbK6dDyLrRpQmZOKmg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kuqkkDXYn39MdmC9w23zP9OvCshHj90dcKxhDt/b4TsCf3kv8CQsV5GdLcMdPBhkDViRmxNGIsnTAhqbZD+efhbguAgb4/J6Cxckhzul5EXMc40ucPnOzaGRs2YUFa/dAniPXKZtFCVRdV5w9lXe6rqtH3+ZE9FkZXyokaXFZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r/SDcrgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87F4C4CEEA;
	Thu, 17 Apr 2025 13:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897516;
	bh=HDSljw7brrElgVob+11DwSdI4sbK6dDyLrRpQmZOKmg=;
	h=Subject:To:Cc:From:Date:From;
	b=r/SDcrgVzsVDj8m2JpBayTjge8FNyGVNAvwL+R7Yh3ECQ45bXN8JH9IRjf27Sav7o
	 fzCuZle+JGEfboAo7PKRq+GVo4Ru+gXxNGf6dHgaym013u+djI7+Viyndha1zsvftA
	 S29gKpg8IKaYhKAxCwUBXuYURAaiAinVKGHFwsgk=
Subject: FAILED: patch "[PATCH] misc: pci_endpoint_test: Fix displaying 'irq_type' after" failed to apply to 5.4-stable tree
To: hayashi.kunihiko@socionext.com,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:40:59 +0200
Message-ID: <2025041759-uncover-siesta-9298@gregkh>
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
git cherry-pick -x 919d14603dab6a9cf03ebbeb2cfa556df48737c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041759-uncover-siesta-9298@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 919d14603dab6a9cf03ebbeb2cfa556df48737c8 Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 25 Feb 2025 20:02:49 +0900
Subject: [PATCH] misc: pci_endpoint_test: Fix displaying 'irq_type' after
 'request_irq' error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are two variables that indicate the interrupt type to be used
in the next test execution, global "irq_type" and "test->irq_type".

The former is referenced from pci_endpoint_test_get_irq() to preserve
the current type for ioctl(PCITEST_GET_IRQTYPE).

In the pci_endpoint_test_request_irq(), since this global variable
is referenced when an error occurs, the unintended error message is
displayed.

For example, after running "pcitest -i 2", the following message
shows "MSI 3" even if the current IRQ type becomes "MSI-X":

  pci-endpoint-test 0000:01:00.0: Failed to request IRQ 30 for MSI 3
  SET IRQ TYPE TO MSI-X:          NOT OKAY

Fix this issue by using "test->irq_type" instead of global "irq_type".

Cc: stable@vger.kernel.org
Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/20250225110252.28866-4-hayashi.kunihiko@socionext.com
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 9e56d200d2f0..acf3d8dab131 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -242,7 +242,7 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	return 0;
 
 fail:
-	switch (irq_type) {
+	switch (test->irq_type) {
 	case IRQ_TYPE_INTX:
 		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
 			pci_irq_vector(pdev, i));


