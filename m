Return-Path: <stable+bounces-133179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2215AA91EB9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB3A463D37
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCB824EA9A;
	Thu, 17 Apr 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBx1xvqv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C871F949
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897951; cv=none; b=PI+R7+4DSu/gXn1kIhNdtIzsmLNIKE5C2wTU3GhuU84LzVrEG/YgtwAAqPYDPVAol5QIKWgH3ukpc0g5vXoh0A17VHmr+YPiKuyc8BxktY94TUtDjdgDcWBB/JxMogKik+rs6a+2Qq/aNc9tAxjtvGPcxBdoaI04Aa65Q4Wg6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897951; c=relaxed/simple;
	bh=i7skUHrwW8Lf/ch38GIpwyjkAeC00OkcMD90rNHCMf4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XvcSO1b+EDtWdmZhIA5+DDyOR03Y8YRksE4gNJVcYBOO3TdK3xoau9oZUxBqDXR0OVinLacqjL3aJ1qqj5n32MuR177pmCTUL4XdErWuOMDyiO/uh+tmtRu3mL1UgbQv9xJwXnhLQntmh/rclu13HfglcD3IT0u2gpViuRum1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBx1xvqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7FDC4CEE4;
	Thu, 17 Apr 2025 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897950;
	bh=i7skUHrwW8Lf/ch38GIpwyjkAeC00OkcMD90rNHCMf4=;
	h=Subject:To:Cc:From:Date:From;
	b=mBx1xvqvhSjDqzCTHG5qbfzox4LbhBTOFvAmo/CGMZciXVvTTJlTpZmzN7+7vFzna
	 B9lAIwKn9Iy4v0N9cWNkt5rg4o68vC1OZZsSuiLnz3ruZUAwMsnDvohypV9Kul1Vn5
	 wft707XRV0d8cx4rx6nebFJABIPDOa4jOOLDCQhM=
Subject: FAILED: patch "[PATCH] misc: pci_endpoint_test: Fix 'irq_type' to convey the correct" failed to apply to 5.4-stable tree
To: hayashi.kunihiko@socionext.com,cassel@kernel.org,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:50:55 +0200
Message-ID: <2025041755-projector-liking-cff5@gregkh>
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
git cherry-pick -x baaef0a274cfb75f9b50eab3ef93205e604f662c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041755-projector-liking-cff5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From baaef0a274cfb75f9b50eab3ef93205e604f662c Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 25 Feb 2025 20:02:50 +0900
Subject: [PATCH] misc: pci_endpoint_test: Fix 'irq_type' to convey the correct
 type
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are two variables that indicate the interrupt type to be used
in the next test execution, "irq_type" as global and "test->irq_type".

The global is referenced from pci_endpoint_test_get_irq() to preserve
the current type for ioctl(PCITEST_GET_IRQTYPE).

The type set in this function isn't reflected in the global "irq_type",
so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.

As a result, the wrong type is displayed in old version of "pcitest"
as follows:

  - Result of running "pcitest -i 0"

      SET IRQ TYPE TO LEGACY:         OKAY

  - Result of running "pcitest -I"

      GET IRQ TYPE:           MSI

Whereas running the new version of "pcitest" in kselftest results in an
error as follows:

  #  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
  # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Expected 0 (0) == ret (1)
  # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Can't get Legacy IRQ type

Fix this issue by propagating the current type to the global "irq_type".

Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250225110252.28866-5-hayashi.kunihiko@socionext.com

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index acf3d8dab131..896392c428de 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -833,6 +833,7 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 		return ret;
 	}
 
+	irq_type = test->irq_type;
 	return 0;
 }
 


