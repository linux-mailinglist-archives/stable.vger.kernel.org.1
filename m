Return-Path: <stable+bounces-15382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54932838504
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A28B230AA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C17A717;
	Tue, 23 Jan 2024 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="05GKGveu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6EB77F2F;
	Tue, 23 Jan 2024 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975550; cv=none; b=gQRmGpNECCC4ZUPuU+6IbQ7AQi5NuKSn5bnig4V0WfqvEOChi7XVnBe+tOIWv1IiyBHPe7CJljS+hqLGSUGE2sVi5kkppq/EPKEGqdrokBeeIzFJL0zSc1qfTrZ8kraaBxbwE4f4teY9NDDlzBmXx5j46ZrwdBQblisFs/B8b4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975550; c=relaxed/simple;
	bh=e+g0t/ecXvpNp1wtslf7PyYOvhwRqeS9zLQFEpdr+S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seQFd75J9cMWnerygXW636hTKOqtQK5r1U2tujjcuPIEQpJY8OL7uBfqpbpHaEoOnmPF+qF86Vj612AQEZd8CWJrNITrX/lJDXaz9yekK+JLuynHLLdYI3Npeg2KYE+U6WHDeYDJmY6zQwDOT2LGyelCim6V5NQMIYYwiNmFScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=05GKGveu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F48C433F1;
	Tue, 23 Jan 2024 02:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975549;
	bh=e+g0t/ecXvpNp1wtslf7PyYOvhwRqeS9zLQFEpdr+S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=05GKGveutuObhUcK0cQ6NR4khOrt39+HyyLnYEVW3RVH41e8WXFvFNQWiQqWqE47X
	 oR71otM5b8EtdS4Ue9e8TM/2JtXZCBEz+hKnTxsat7KoHC+GPBeRVRBOxFw7V4apgj
	 xGNqzA6CSECD6rKaxqvebgVvBtf5PaE6PH4Maavc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 501/583] vdpa: Fix an error handling path in eni_vdpa_probe()
Date: Mon, 22 Jan 2024 15:59:12 -0800
Message-ID: <20240122235827.370194618@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit c1b9f2c66eed3261db76cccd8a22a9affae8dcbf ]

After a successful vp_legacy_probe() call, vp_legacy_remove() should be
called in the error handling path, as already done in the remove function.

Add the missing call.

Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-Id: <a7b0ef1eabd081f1c7c894e9b11de01678e85dee.1666293559.git.christophe.jaillet@wanadoo.fr>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index 5a09a09cca70..cce3d1837104 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -497,7 +497,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!eni_vdpa->vring) {
 		ret = -ENOMEM;
 		ENI_ERR(pdev, "failed to allocate virtqueues\n");
-		goto err;
+		goto err_remove_vp_legacy;
 	}
 
 	for (i = 0; i < eni_vdpa->queues; i++) {
@@ -509,11 +509,13 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queues);
 	if (ret) {
 		ENI_ERR(pdev, "failed to register to vdpa bus\n");
-		goto err;
+		goto err_remove_vp_legacy;
 	}
 
 	return 0;
 
+err_remove_vp_legacy:
+	vp_legacy_remove(&eni_vdpa->ldev);
 err:
 	put_device(&eni_vdpa->vdpa.dev);
 	return ret;
-- 
2.43.0




