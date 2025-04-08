Return-Path: <stable+bounces-130110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C61A8030C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE821753EE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5337267F4F;
	Tue,  8 Apr 2025 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BGyOggW+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C03E1AAA0F;
	Tue,  8 Apr 2025 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112843; cv=none; b=buRRXWIIC630JLO4tyRcGriRXAMXA2pgEEynJ+oRNc1jfhhQy0TKHHaihggX7nPga7KL/XjTvONr/+JtL49gRt2IFcs2VxjcVf0UiMVtKb241dxo1lNPPyr2zfmZ+NL0RuE8ZkG8Tf32twAmmhNgog5BpV3p6+dE6E6XKW0d1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112843; c=relaxed/simple;
	bh=94SdN/qyXkDlBMWiyS3VOSkXRHwhPbu7t/12kqrFKCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaHo5/ai4la6ZwEDIHYnfrqek9jaVNodcGAq93/zeLevukgPXMzfFSmiP5OSmMENt29ePr+GauTTEiF92QL8Aqaqm6D4ESyaXbXxk7WYF1EXXfkBARjnyHk+XR/R86IOof3ggexTm8xLfW+pDwNJYkP0PBpza4x+qdSlttY46M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BGyOggW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE76C4CEE5;
	Tue,  8 Apr 2025 11:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112843;
	bh=94SdN/qyXkDlBMWiyS3VOSkXRHwhPbu7t/12kqrFKCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGyOggW+OdZy7jQAbil1le1c9q+8I49MX/f2CNLlRlgYjvtknyA4BwN0uYhBSDqTN
	 miqVx8cjYWruBsxyBplOPQ+kLmUe87tiG/IEG+Lm6L2LQtby1l/fpXiTDH0FYJbRm+
	 jiWidM0mEPPeCxhxXNPh3f3i05J2/SoSqvF47vSw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geetha sowjanya <gakula@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 219/279] octeontx2-af: Free NIX_AF_INT_VEC_GEN irq
Date: Tue,  8 Apr 2025 12:50:02 +0200
Message-ID: <20250408104832.272132053@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geetha sowjanya <gakula@marvell.com>

[ Upstream commit 323d6db6dc7decb06f2545efb9496259ddacd4f4 ]

Due to the incorrect initial vector number in
rvu_nix_unregister_interrupts(), NIX_AF_INT_VEC_GEN is not
geeting free. Fix the vector number to include NIX_AF_INT_VEC_GEN
irq.

Fixes: 5ed66306eab6 ("octeontx2-af: Add devlink health reporters for NIX")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250327094054.2312-1-gakula@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 40fbda152533b..c5e3ef6b41a87 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -216,7 +216,7 @@ static void rvu_nix_unregister_interrupts(struct rvu *rvu)
 		rvu->irq_allocated[offs + NIX_AF_INT_VEC_RVU] = false;
 	}
 
-	for (i = NIX_AF_INT_VEC_AF_ERR; i < NIX_AF_INT_VEC_CNT; i++)
+	for (i = NIX_AF_INT_VEC_GEN; i < NIX_AF_INT_VEC_CNT; i++)
 		if (rvu->irq_allocated[offs + i]) {
 			free_irq(pci_irq_vector(rvu->pdev, offs + i), rvu_dl);
 			rvu->irq_allocated[offs + i] = false;
-- 
2.39.5




