Return-Path: <stable+bounces-143045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D3AAB133D
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 14:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD621BC7E66
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9CD290DAC;
	Fri,  9 May 2025 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyDsdNUD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19231274642;
	Fri,  9 May 2025 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746793457; cv=none; b=OzmioskrBcN8Kbcr2XWHHhQXuXXrlJ0Lv7CX6t8CvtwLXPWckd2t9PM01XW5avgChB+ZB44hWmKgd8ORn4J6obUmGiEmKwCvgaEM9jZfgmj/H4RPk75SGsbZGLhToi3oZiWbrveoC0FvhpHP+KXWbG22Dnaiy9+Dd+YeIp4MJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746793457; c=relaxed/simple;
	bh=VERcAVRj3d2dPrGdMrEq/G8EBTtz09HoiKnUvoWgwlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWR01hZSUpnLXlhN9fyxAhsCXSxl/zqWG7Yvm+fpfad9kjc7Iin/IbofltDiZtD20O/GXcKjwTS/WFZJhjV1/MOeHy/BloMCibXECzcH5Jz0LukiZVEDu/d1CX2OPABnQ1dAjGORBSQXmf7a7lQhimJsjVFl6zbhdfmyaJOJtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyDsdNUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED49C4CEEB;
	Fri,  9 May 2025 12:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746793455;
	bh=VERcAVRj3d2dPrGdMrEq/G8EBTtz09HoiKnUvoWgwlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyDsdNUD7TTToYNtJzvoKYLn44k+RTCEjPRgwE5KdZFjBS+stfWLs0n6ABHS3mu77
	 lX5/gia/V0eS3HaadO2ny0dbzlqfBo3Y4p4obwdCg88NxjY8kHYnmTQwHNa2KUa3+9
	 876M35z1BsK7PayAf7aKPo6AQzXzZw0vc/ml6YZDZwONEWdg6NhatZSZzgsAQwQPyA
	 ZgDToKkJf1cAJkF1vrRM9fT9rmBwtazKuktNB/4L4eeYNt6KWHMIlcQ/XLwn5c3ZKI
	 RjxKxaS0Pp5MqNp45DhpIch7PeXMOf+7dGRXjLxKtwpsAfkmXqMZu+UY6mL/5PScBO
	 8xsYPySb4perw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Peter Korsgaard <peter@korsgaard.com>,
	stable@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/2] nvmem: zynqmp_nvmem: unbreak driver after cleanup
Date: Fri,  9 May 2025 13:24:07 +0100
Message-ID: <20250509122407.11763-3-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509122407.11763-1-srini@kernel.org>
References: <20250509122407.11763-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Korsgaard <peter@korsgaard.com>

Commit 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
changed the driver to expect the device pointer to be passed as the
"context", but in nvmem the context parameter comes from nvmem_config.priv
which is never set - Leading to null pointer exceptions when the device is
accessed.

Fixes: 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
Reviewed-by: Michal Simek <michal.simek@amd.com>
Tested-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/zynqmp_nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 8682adaacd69..7da717d6c7fa 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -213,6 +213,7 @@ static int zynqmp_nvmem_probe(struct platform_device *pdev)
 	econfig.word_size = 1;
 	econfig.size = ZYNQMP_NVMEM_SIZE;
 	econfig.dev = dev;
+	econfig.priv = dev;
 	econfig.add_legacy_fixed_of_cells = true;
 	econfig.reg_read = zynqmp_nvmem_read;
 	econfig.reg_write = zynqmp_nvmem_write;
-- 
2.43.0


