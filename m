Return-Path: <stable+bounces-131559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66088A80B8A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30394500D38
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973EC276049;
	Tue,  8 Apr 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mv9/ah7m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5056326AAAB;
	Tue,  8 Apr 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116723; cv=none; b=YuXw4GJ5wliR41mI3SCsFnQyK3bAXdX2IY7BrmMpd8H+aQiwEov8bP1KPYAb3cLXXW2U+VZFx+bsJSi/6VgsAIs58yAHDT8GMHDCmBgd18Iam75zbgwMWjdPLk9aWYj9ZvaJINcDY3e6uxR700JvVkhPuV3DgIML/Wz0XNlfO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116723; c=relaxed/simple;
	bh=Zf7g02Bevr2bxaXgmdEKuYIj8oIgLPmTGzvJ3lf51p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lR/V/QV6D70Od5S/bPdoGAeLQt4FhF1Yb+Pgyi6R+oyt0NBWq4Yvx1rxI0fvaivLNL6GWDz2WvkXjeouilHTwobUv2l3yToTfBliJ0uKp2J+KYYJwbes26LrkxfnJRmwjtHcArPC6rCW72gbztkRtkhx4DLzCU7Avf9DmxymZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mv9/ah7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C17C4CEE5;
	Tue,  8 Apr 2025 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116723;
	bh=Zf7g02Bevr2bxaXgmdEKuYIj8oIgLPmTGzvJ3lf51p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mv9/ah7mYiHPVB2t3g/lymgl2QhHNiQ7ra/p3OIKTXvnEaqFzN6Z4n3vf7AuWcuKB
	 9WcTJr4Dh2bEoGS59oL8XejwqoLzE65jS3bm4eLUQkulUs9DVaRbRGZsj69fCfebSM
	 m+S40hPn3slcdaN9k8bngQhMzPXrZN53eZLyQRD0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geetha sowjanya <gakula@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 245/423] octeontx2-af: Fix mbox INTR handler when num VFs > 64
Date: Tue,  8 Apr 2025 12:49:31 +0200
Message-ID: <20250408104851.438375761@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

From: Geetha sowjanya <gakula@marvell.com>

[ Upstream commit 0fdba88a211508984eb5df62008c29688692b134 ]

When number of RVU VFs > 64, the vfs value passed to "rvu_queue_work"
function is incorrect. Due to which mbox workqueue entries for
VFs 0 to 63 never gets added to workqueue.

Fixes: 9bdc47a6e328 ("octeontx2-af: Mbox communication support btw AF and it's VFs")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250327091441.1284-1-gakula@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index cd0d7b7774f1a..6575c422635b7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2634,7 +2634,7 @@ static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
 		rvupf_write64(rvu, RVU_PF_VFPF_MBOX_INTX(1), intr);
 
 		rvu_queue_work(&rvu->afvf_wq_info, 64, vfs, intr);
-		vfs -= 64;
+		vfs = 64;
 	}
 
 	intr = rvupf_read64(rvu, RVU_PF_VFPF_MBOX_INTX(0));
-- 
2.39.5




