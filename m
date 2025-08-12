Return-Path: <stable+bounces-167967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A1B232C3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8665836FB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94382ED17F;
	Tue, 12 Aug 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="piTZadEp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679332EAB97;
	Tue, 12 Aug 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022595; cv=none; b=jPWxCyojBjgipdbQ+3Yshcx9BpZ32Ktj9VuVWpdfKyY4kHzD7nGXuwBbm+ShBvtFyOWu2VzBZqB6IvflHyOQAfDGEDTDm0vXIhn8SocGspWf0BWdQVBPQtI/k+kxc1n35QwYaz1lC9aOGNSiVjpZ5UtaS5PimhjK1CpLhtHZcfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022595; c=relaxed/simple;
	bh=wM6sNXM7upJTr0/UqQWKvfZhRSMnaaV5cz9sfb8mkh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh00NsfsvPKr8eqrtKWb4upbE0szpOTNvTtZSbsRzGCtAPk69XUVrfryBroXxHW64fa42+hZ76nQfM+S+165XoLbi2dRN41G+hlmatvFkzB8GqPJDV5nkGJSpTfRaV0Be/1qjHRQ7O2Nw2qNUTjP8WrhuVJ/WQ6hrEUOB84HVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=piTZadEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDB7C4CEF0;
	Tue, 12 Aug 2025 18:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022595;
	bh=wM6sNXM7upJTr0/UqQWKvfZhRSMnaaV5cz9sfb8mkh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=piTZadEpbjVedYtD9B1uqoy/pyzncJm+BdbPDmwR2sI2BtJGE4qTwip6TbGfl2bLx
	 A0Bd/onZ/FNYFrR4HCE/bqfmTA6mgz7go/FlPzsEHsZTIdU0uPI3M8es2aRfJq8S6r
	 tDzjNm8MT3J0SF5RE87KHCz8naFE6v4TPF+x9M7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 201/369] scsi: elx: efct: Fix dma_unmap_sg() nents value
Date: Tue, 12 Aug 2025 19:28:18 +0200
Message-ID: <20250812173022.331178082@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit 3a988d0b65d7d1713ce7596eae288a293f3b938e ]

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: 692e5d73a811 ("scsi: elx: efct: LIO backend interface routines")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Link: https://lore.kernel.org/r/20250627114117.188480-2-fourier.thomas@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/elx/efct/efct_lio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/elx/efct/efct_lio.c b/drivers/scsi/elx/efct/efct_lio.c
index 9ac69356b13e..bd3d489e56ae 100644
--- a/drivers/scsi/elx/efct/efct_lio.c
+++ b/drivers/scsi/elx/efct/efct_lio.c
@@ -382,7 +382,7 @@ efct_lio_sg_unmap(struct efct_io *io)
 		return;
 
 	dma_unmap_sg(&io->efct->pci->dev, cmd->t_data_sg,
-		     ocp->seg_map_cnt, cmd->data_direction);
+		     cmd->t_data_nents, cmd->data_direction);
 	ocp->seg_map_cnt = 0;
 }
 
-- 
2.39.5




