Return-Path: <stable+bounces-181273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE1EB9301A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE0B447892
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC52F0C64;
	Mon, 22 Sep 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qYyhQu3p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C4E222590;
	Mon, 22 Sep 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570121; cv=none; b=ELC3FkZIAmeHTH6M+VPcDQZUPxYGCr0mXfIlrUTNmnobU1mW33pAWkcNnelfKpu70mkUY0Zb8pJ0YMGuGgi/7V0hS9I9Xh+PILN/aURHZd1dCfgaPM1gvto3XuZD/8n8fy4dNX6fB/XtTbsdDJ3fLPBKsA9G+PFHWe7lbAiMfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570121; c=relaxed/simple;
	bh=hbxtytD5PihpaHOcoLaG7aPHNjd0ZQC5wTEl005sLnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6Ecna4s46qDRBMz3uq8rqIoLyaMhgCkCAINNE/iVTsGFL38s27O/eVx3dn0cDUYSwb5AlSRodYB+QBQ7iON9fCXG39ipc7/T6okBRtq7o+hFsUiTmGwZv4J7TYDuKaFcx6+JhqATMAquCrDPFY3tUtIdtUeabdylWluOwafoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qYyhQu3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CE8C4CEF0;
	Mon, 22 Sep 2025 19:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570121;
	bh=hbxtytD5PihpaHOcoLaG7aPHNjd0ZQC5wTEl005sLnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYyhQu3p0y0MDAtPqQp5uVXdVCUwpqA0ypUcrUgIEJNPZf/hP/wqMTdYd1omyIT95
	 tzPpuVE7jbUHeUv1Ux/pc/SykBS/Bql9Yvn9scPB/AdC1/jcIKzfsaLq3jGDyVK1LB
	 1Oyd/LOUzECjgd8iCY7X6HmQ45akIhVXYTPJ+bqc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 013/149] um: virtio_uml: Fix use-after-free after put_device in probe
Date: Mon, 22 Sep 2025 21:28:33 +0200
Message-ID: <20250922192413.220415062@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 7ebf70cf181651fe3f2e44e95e7e5073d594c9c0 ]

When register_virtio_device() fails in virtio_uml_probe(),
the code sets vu_dev->registered = 1 even though
the device was not successfully registered.
This can lead to use-after-free or other issues.

Fixes: 04e5b1fb0183 ("um: virtio: Remove device on disconnect")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/virtio_uml.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index ad8d78fb1d9aa..de7867ae220d0 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1250,10 +1250,12 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&vu_dev->vdev.dev, true);
 
 	rc = register_virtio_device(&vu_dev->vdev);
-	if (rc)
+	if (rc) {
 		put_device(&vu_dev->vdev.dev);
+		return rc;
+	}
 	vu_dev->registered = 1;
-	return rc;
+	return 0;
 
 error_init:
 	os_close_file(vu_dev->sock);
-- 
2.51.0




