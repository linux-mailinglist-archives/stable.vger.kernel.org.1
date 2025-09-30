Return-Path: <stable+bounces-182219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62684BAD60B
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD5116F91D
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830AB30649C;
	Tue, 30 Sep 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2l0HpVif"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD830594A;
	Tue, 30 Sep 2025 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244234; cv=none; b=TdXx3B7++GX72Ss7eJ+BIVZBils33jDkMpp5CfVVkLAiuNyA1995luYpgPsBpym+IhLvxss/P+66qhtdyDo6t2DROyHCcoX8nfUAD9q/OT3ZRapKz1jJBi8KYAZDTSlebzdrIljeqVPoAdqqbX1IPmuUhn1tmGo3w6p4IF+Y2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244234; c=relaxed/simple;
	bh=agdfvtNKSQPiZ+1VQaiSSEPjKZUUywTk/xV/mnF9AD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkXl4JkteJFKRK9WTuOBQUhQRR7+EL25VWWuOdaQHWzLbltEejJ9PQ7c4n1DGpwof36EXZGc/iyT9DNLnvVkzOG+AsMt/d2JHRF3G+cpWUIGtl0rcDz7Kfith0bHlLvGhsa2N6hS8JdZYgG6Y3ACAx/cRRKyHryc0L2bsOXTq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2l0HpVif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA1FC4CEF0;
	Tue, 30 Sep 2025 14:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244233;
	bh=agdfvtNKSQPiZ+1VQaiSSEPjKZUUywTk/xV/mnF9AD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2l0HpVifRiziJM5fhpLlLtSC4ScvAH6nJiYdAWrhQTkoHAq4aNYwzVyhJBM84+yYB
	 4LlyCN3v7EQDcRSH+m8DbQx7iBFDwYpnTHD1n4axzMkWxDYFjT8196ghB0wIO0rtYo
	 JWSdGA5fdvL53HmxYaS0VEMw+mieiDcHEyoaRAxk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 050/122] um: virtio_uml: Fix use-after-free after put_device in probe
Date: Tue, 30 Sep 2025 16:46:21 +0200
Message-ID: <20250930143825.052095962@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143822.939301999@linuxfoundation.org>
References: <20250930143822.939301999@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index d5d768188b3ba..0178d33e59469 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1129,10 +1129,12 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, vu_dev);
 
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




