Return-Path: <stable+bounces-134587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 992C4A9375A
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 14:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E438E23A5
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 12:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7031427511E;
	Fri, 18 Apr 2025 12:45:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB7F27510B
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744980318; cv=none; b=NNdTehuIcBJngSTN7gJTjBFjpSgc6zvV2/bokiHjarO+vee8nmt028ZY58vtAqzAAvthR2CoiFAXcIGHe6wbDrfMQ6RN3DDyuEhpVwMFew6c0YJKgbZfV1gXY3cTuINBPKPFM+R5vlQBN+qe6YlMg8XQ8ZofKzEhoUBfSK8Bddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744980318; c=relaxed/simple;
	bh=TPlJu4Gne4eWbjm1BCD987nlrDa9TsE12bX8poPoGZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpIoJ9xKZYi3NqcdQBk+D5jVFIIixTmmCQTJG9qJtIhBf6ClDDVtuhBCEoxNtDOY8RDBfvTzikL1XQFqKFaObld9qVAwAoBRiDdtHOYjRKfaRKvDRQ5URHlQbmj2gvyGc21E1wr4UU2Qg/15Z1AskdSRtRyRvCsPq8aCPlMp4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 Apr 2025 21:45:15 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id CE7FA206A2EB;
	Fri, 18 Apr 2025 21:45:15 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Fri, 18 Apr 2025 21:45:15 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan3.css.socionext.com (Postfix) with ESMTP id A238F701;
	Fri, 18 Apr 2025 21:45:15 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: stable@vger.kernel.org
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5.10.y] misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
Date: Fri, 18 Apr 2025 21:45:08 +0900
Message-Id: <20250418124508.2046260-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025041755-booting-squiggly-42bc@gregkh>
References: <2025041755-booting-squiggly-42bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
(cherry picked from commit baaef0a274cfb75f9b50eab3ef93205e604f662c)
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index fb8066d8d2e4..7ea1ac3fc65f 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -718,6 +718,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	if (!pci_endpoint_test_request_irq(test))
 		goto err;
 
+	irq_type = test->irq_type;
 	return true;
 
 err:
-- 
2.25.1


