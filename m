Return-Path: <stable+bounces-134577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DF6A93703
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DEE8A4385
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B32749D3;
	Fri, 18 Apr 2025 12:25:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DF92741B6
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979134; cv=none; b=kx1P1XGaLhjyBe0i4RYeBU4n+ayOxqmA7caXfrtbg0praVZSvlYq0OgTJQm6mB5AuDAZJhZudE+RZkP/p2Bg2STRKqB7U7WNAccaQnR7AO9sREzeurUune+wiWwXGFmp/Z93xjmDc6+2qneYcVTaGL4FuHjUJeqhu6Np3X15l4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979134; c=relaxed/simple;
	bh=w+8uMlMpQRUDzIllBp/+9aJUibDlbLY4i2jqK8po71Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYKcMisvxWsjQjOjy5BJ+Q+/TEylT0unHHNJFw8ScE6UrL1iSs/cPPJ9vSvW88cUByjoBA1pyeJepzQNE+UPQT85VH6LVqUBkDgErO0fy8XwCVjnm/6tbgJrwkc1lCVtvNCBn4zegVDMZjJciYrilVx73LTudHm8kmu+PtE3/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Apr 2025 21:25:33 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id E7CB12091483;
	Fri, 18 Apr 2025 21:25:32 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Fri, 18 Apr 2025 21:25:32 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan3.css.socionext.com (Postfix) with ESMTP id 77742701;
	Fri, 18 Apr 2025 21:25:32 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: stable@vger.kernel.org
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH 5.4.y] misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
Date: Fri, 18 Apr 2025 21:25:31 +0900
Message-Id: <20250418122531.2031985-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025041759-uncover-siesta-9298@gregkh>
References: <2025041759-uncover-siesta-9298@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
(cherry picked from commit 919d14603dab6a9cf03ebbeb2cfa556df48737c8)
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a031ead38888..4a105b50661d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -230,7 +230,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	return true;
 
 fail:
-	switch (irq_type) {
+	switch (test->irq_type) {
 	case IRQ_TYPE_LEGACY:
 		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
 			pci_irq_vector(pdev, i));
-- 
2.25.1


