Return-Path: <stable+bounces-172541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB76EB3267F
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 04:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA6156623A
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 02:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E871EB5FD;
	Sat, 23 Aug 2025 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRQ7pICp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776919E97B
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755917423; cv=none; b=arHc75CcDYA0vF6iTTWiHa6Ts8Xy2qubqLXlZG6g6xMOftqmN0H5pGPVptT2s97ew8vhQ5tCz7OKWJzwqB66IcFVViVQiaPaxpmp40B3WcaniT1IMSZpGatwGLRWC3hj3t6qVA6NuWFHHPf+6vQt0xgUHE3nSO5+TFYN+JUwJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755917423; c=relaxed/simple;
	bh=jthP1lWOCNaMupH3k1cRU/mEntigPHojC+A3yEQjSMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb7XFzZeYKLUquiolK5xID96lyJT9nCer1K/TBFajrzeJyY+ENghTbD1Lfl3vinLR4Mis19bMRrRQKGOE/QS3gATwVpUgstns8cV0fYPg+xpX6fuS6zZfmzZrOlse/oEyIMtIdMbGICwC2xP/zQoJ3toEuqk6aCdnpz+EO4/Tis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRQ7pICp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B692C4CEED;
	Sat, 23 Aug 2025 02:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755917422;
	bh=jthP1lWOCNaMupH3k1cRU/mEntigPHojC+A3yEQjSMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRQ7pICpoQLfKh5aBBBHgt+NQcLGtcnXhA0yeXQ0UXzGmOdH97ZVrQlVDcn206uKp
	 m/S3Ip/qZGBuqAmnfkm466RoDqsndnCDhzrpHJWxEYY1ayiCO0iDQ3yU/kNaEo8Mg8
	 abm7e5W7oXHkI6iQqZ7MTjdaXlOAu0T2uaBQ4EbmyNY/jfwCSEblJUSFk3kq6Ex0A/
	 C6lfCdOorTM9jEv8s+RXQ4lZTZMCt/lujPy4P4MOk8fwg5H8BDrH7x9wwv8loQ1L8b
	 5MFuGaNKmZbJNKnOUDTM2A9iI5qJ9VsZp5re60iaE4ctJxiO66nQO2trsVa2GxUxXJ
	 R0gcxENh82Ttw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] media: venus: don't de-reference NULL pointers at IRQ time
Date: Fri, 22 Aug 2025 22:50:19 -0400
Message-ID: <20250823025020.1694568-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082137-defiant-headstone-4d37@gregkh>
References: <2025082137-defiant-headstone-4d37@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 686ee9b6253f9b6d7f1151e73114698940cc0894 ]

Smatch is warning that:
	drivers/media/platform/qcom/venus/hfi_venus.c:1100 venus_isr() warn: variable dereferenced before check 'hdev' (see line 1097)

The logic basically does:
	hdev = to_hfi_priv(core);

with is translated to:
	hdev = core->priv;

If the IRQ code can receive a NULL pointer for hdev, there's
a bug there, as it will first try to de-reference the pointer,
and then check if it is null.

After looking at the code, it seems that this indeed can happen:
Basically, the venus IRQ thread is started with:
	devm_request_threaded_irq()
So, it will only be freed after the driver unbinds.

In order to prevent the IRQ code to work with freed data,
the logic at venus_hfi_destroy() sets core->priv to NULL,
which would make the IRQ code to ignore any pending IRQs.

There is, however a race condition, as core->priv is set
to NULL only after being freed. So, we need also to move the
core->priv = NULL to happen earlier.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 640803003cd9 ("media: venus: hfi: explicitly release IRQ during teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 91584d197af9..f4e444cd3d87 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1067,12 +1067,15 @@ static irqreturn_t venus_isr(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 	u32 status;
-	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
-	void __iomem *wrapper_base = hdev->core->wrapper_base;
+	void __iomem *cpu_cs_base;
+	void __iomem *wrapper_base;
 
 	if (!hdev)
 		return IRQ_NONE;
 
+	cpu_cs_base = hdev->core->cpu_cs_base;
+	wrapper_base = hdev->core->wrapper_base;
+
 	status = readl(wrapper_base + WRAPPER_INTR_STATUS);
 
 	if (status & WRAPPER_INTR_STATUS_A2H_MASK ||
@@ -1609,10 +1612,10 @@ void venus_hfi_destroy(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
 
+	core->priv = NULL;
 	venus_interface_queues_release(hdev);
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
-	core->priv = NULL;
 	core->ops = NULL;
 }
 
-- 
2.50.1


