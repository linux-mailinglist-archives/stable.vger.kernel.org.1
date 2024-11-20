Return-Path: <stable+bounces-94199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711B09D3B85
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B54B29337
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF261B6CEE;
	Wed, 20 Nov 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ql7Sd11e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED51A2C25;
	Wed, 20 Nov 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107550; cv=none; b=SaDj+2v7lLnZ/lW3hrR7fkQCrre5/DMQEXXgr4RSqMIPrfTurwvgtU7UlaurNdNPnvS74sEPmqI742zG+0QQgrwPQfMEgd7QDb0Hlia77daDo9YhpJ5l30xuWMfujeSTx/P69CGEl62HbZeBU/MJDZ5PgXQJQrw8FVOsscsvFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107550; c=relaxed/simple;
	bh=eVZtl6Rg/KxnmLCOzRXc5G6hy3xh0SJp9NC/AOUIo3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxSNKQ+MWOdzDNgE9v3FLBUSN/rKTpQGbY5WABo51iei/icUoH8J884YvtQX6F465LHvbvd0FricsiHsNStrnuvvtOVWW0GSM4rdHS2yKl3yQJCn8uJlY9OWrHbal2VQwKE8MyGq+6wduRW2sx2XzKGvP4wU9hL+puyc5sR6nA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ql7Sd11e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92979C4CECD;
	Wed, 20 Nov 2024 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107549;
	bh=eVZtl6Rg/KxnmLCOzRXc5G6hy3xh0SJp9NC/AOUIo3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ql7Sd11eLME4GkOwKfxTBnC944Mj+9s8RcyKL+/ExthDGC8pyv+O1pGdv2hnl4u2F
	 GiA2vtgUDw6hjYwAaJ1dKlXoulfJF+ukQboezh1p2E/W20CEUR53xHJ+tgfuhomLLY
	 CsKDG9ckmnL2+R6LM5zZ3dIE+eHSVQOyJrut2cnI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Lyude Paul <lyude@redhat.com>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH 6.11 089/107] nouveau: fw: sync dma after setup is called.
Date: Wed, 20 Nov 2024 13:57:04 +0100
Message-ID: <20241120125631.717664160@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>
References: <20241120125629.681745345@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Airlie <airlied@redhat.com>

commit 21ec425eaf2cb7c0371f7683f81ad7d9679b6eb5 upstream.

When this code moved to non-coherent allocator the sync was put too
early for some firmwares which called the setup function, move the
sync down after the setup function.

Reported-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Tested-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Fixes: 9b340aeb26d5 ("nouveau/firmware: use dma non-coherent allocator")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241114004603.3095485-1-airlied@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
@@ -89,11 +89,6 @@ nvkm_falcon_fw_boot(struct nvkm_falcon_f
 		nvkm_falcon_fw_dtor_sigs(fw);
 	}
 
-	/* after last write to the img, sync dma mappings */
-	dma_sync_single_for_device(fw->fw.device->dev,
-				   fw->fw.phys,
-				   sg_dma_len(&fw->fw.mem.sgl),
-				   DMA_TO_DEVICE);
 
 	FLCNFW_DBG(fw, "resetting");
 	fw->func->reset(fw);
@@ -105,6 +100,12 @@ nvkm_falcon_fw_boot(struct nvkm_falcon_f
 			goto done;
 	}
 
+	/* after last write to the img, sync dma mappings */
+	dma_sync_single_for_device(fw->fw.device->dev,
+				   fw->fw.phys,
+				   sg_dma_len(&fw->fw.mem.sgl),
+				   DMA_TO_DEVICE);
+
 	ret = fw->func->load(fw);
 	if (ret)
 		goto done;



