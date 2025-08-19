Return-Path: <stable+bounces-171765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59860B2C022
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 13:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF80C720F4A
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4AB322C87;
	Tue, 19 Aug 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0uurZQx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860E27876E;
	Tue, 19 Aug 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602468; cv=none; b=OUQhNLIJ7QaZDkUPPtQweCO92dbZxdsqkM7pYQpvZzLKHgcfRjcYxmVBHsWOSI83ZJXmyZretA10JIo7WK1wflh5XHSSZGH6LgIA06CdJcUuzyK95u6Z139LyuejLjbsSAgHQH5sXi1mKSQlnGPo5xSi1vTZW9PSpWlPVcHaxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602468; c=relaxed/simple;
	bh=zg3sIRBucPRKdjvD/EFZO1qKU1bTJV+UdCfQrDwIHNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bdIAoj6gFWKc9mYAqPhzI68g4ba0EYDNBRKI7t+lNMr3rjtOGWB88ucioqeKmOrPufeMp72QH78FNUDcYZX7CAKPYgIPHYBn/cVMz9nXRBlQR+R5yu8sA8oe6NY7hOPOSxWEOUeNkFDkDuikBiMMNSHraCmqgxiAyVW3I+qSG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0uurZQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31AEC4CEF1;
	Tue, 19 Aug 2025 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755602468;
	bh=zg3sIRBucPRKdjvD/EFZO1qKU1bTJV+UdCfQrDwIHNg=;
	h=From:To:Cc:Subject:Date:From;
	b=G0uurZQxc66TBpAYTCqLjxnDYExA+Lpv2EWDN3P01TSqUx2MA14Xk4u1G5mNf0g9z
	 K/41329Ux6Z9dnNTXrl0iidugros1p32PFOGNTKISqHLaR64+7i4O0rdARTqZCvdMz
	 P3YUONUZJGJlLmriXFXp2/580Ilkh7gZAqm+/4reFOCGmo4LwaM03wVyQAog2yheg3
	 5A4tEBuZMTjgkMOXJev/7/QKn/xPUhBa6yAdpqU6e9Iw2a3nRwhFZjxyM7PWyc04+D
	 nr4LKRCQ/HiD4u+MmiU4iv3ubUzazn/Me4GzXRwiUaQcCAwRnebNbTIuC517rIR5Yg
	 5NBkw8fhah49Q==
From: Michael Walle <mwalle@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvmem: layouts: fix automatic module loading
Date: Tue, 19 Aug 2025 13:21:03 +0200
Message-Id: <20250819112103.1084387-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support loading of a layout module automatically the MODALIAS
variable in the uevent is needed. Add it.

Fixes: fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
I'm still not sure if the sysfs modalias file is required or not. It
seems to work without it. I could't find any documentation about it.

v2:
 - add Cc: stable
---
 drivers/nvmem/layouts.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index 65d39e19f6ec..f381ce1e84bd 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -45,11 +45,24 @@ static void nvmem_layout_bus_remove(struct device *dev)
 	return drv->remove(layout);
 }
 
+static int nvmem_layout_bus_uevent(const struct device *dev,
+				   struct kobj_uevent_env *env)
+{
+	int ret;
+
+	ret = of_device_uevent_modalias(dev, env);
+	if (ret != ENODEV)
+		return ret;
+
+	return 0;
+}
+
 static const struct bus_type nvmem_layout_bus_type = {
 	.name		= "nvmem-layout",
 	.match		= nvmem_layout_bus_match,
 	.probe		= nvmem_layout_bus_probe,
 	.remove		= nvmem_layout_bus_remove,
+	.uevent		= nvmem_layout_bus_uevent,
 };
 
 int __nvmem_layout_driver_register(struct nvmem_layout_driver *drv,
-- 
2.39.5


