Return-Path: <stable+bounces-136369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44245A99278
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87ABB7A5829
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE297289351;
	Wed, 23 Apr 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="smO4jTkH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FF20D4F8;
	Wed, 23 Apr 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422365; cv=none; b=pZmkqBAQJjS6scrwq8955tXLcKTOH9+Lc6tFcwk9Itqb1niJaSSKrbM+cIR0oFOEh3jemcDBjwlywjJUIopooy718ihbA0NqBkvP16RKfWfxZhRhuk2p71A+sBoe998eBulzsBJo4muBDedGka5uyz+mSrvalBv1kpP6qW1veXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422365; c=relaxed/simple;
	bh=2w5SuprNVyiDlv9snIrnjWc3KDPFaBIfq2NsD/S+zEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmL++z2q4XtB/M8IcgLo/I7pnSQodTb2aizvgyY+AEZf0lKNk8MEcj+5zVLimb6dPGEhN83POJlUbXRkC+2vElQ3YwguJ6Qv6KE78N1TfjbNARj9fYhyUBrOZ6VsMQ2nngWSCyMzF7unsOo+NEPaYug+4GCcEf56braXREYE+5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=smO4jTkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08B0C4CEE2;
	Wed, 23 Apr 2025 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422365;
	bh=2w5SuprNVyiDlv9snIrnjWc3KDPFaBIfq2NsD/S+zEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smO4jTkHkt3dxRFB/Yn1u3V0i4ZCEnMIm2IIlQUOzupR/c/yoPs7VCxg8wKNDuCTZ
	 W6vZcntuJqp1nt68nc8+qWHEtR4jXUkoGDHfhhma6Lquw0kxpE4tnubbSxuiUe5Vt0
	 wPRvqAO/61OuShzBfAnQ21GDMo46NO5er8qk0POU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6.1 263/291] misc: pci_endpoint_test: Fix irq_type to convey the correct type
Date: Wed, 23 Apr 2025 16:44:12 +0200
Message-ID: <20250423142635.172659225@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

commit baaef0a274cfb75f9b50eab3ef93205e604f662c upstream.

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
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/pci_endpoint_test.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -717,6 +717,7 @@ static bool pci_endpoint_test_set_irq(st
 	if (!pci_endpoint_test_request_irq(test))
 		goto err;
 
+	irq_type = test->irq_type;
 	return true;
 
 err:



