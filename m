Return-Path: <stable+bounces-129723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B280A800E3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10DDD1890EFC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB46269CE4;
	Tue,  8 Apr 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZY2Ab2hd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA0269B0D;
	Tue,  8 Apr 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111807; cv=none; b=UxAwetfKFh4tngBJBDXPofA1ZtK/zEpO6p5Y5c5X7c3DFQMuWe8xoylyvIK9W5+NJu1X0prDaYPKSpTe42oP57hqyzOTk1avtGqdRIGRpC1f97WQaAOGI4cjsk0uwrj+fz9eGpdmpy0iZvUWx5d3i+FgAl1Cet/oLW7cgyW9nk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111807; c=relaxed/simple;
	bh=67gN6CwQTifmq8dNIpuqCcQF+YDlDO9daiQQzdkmFPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FS7U8lJhoWF/sYqjodxRrANJPJB9oUImZguhmaFmKp7lzkvI90dR3jgMUUJo0z2B2avR7t/sfoooEi8PCfHl07koAoe5xApzw8h0hWMWY+Z9gM9NJ1iCVzzf2Yx3+HWJWTRRnJgN5nhoZoEsZl7sBHx3UXUkSOXdg32rCNQleQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZY2Ab2hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF29DC4CEE7;
	Tue,  8 Apr 2025 11:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111807;
	bh=67gN6CwQTifmq8dNIpuqCcQF+YDlDO9daiQQzdkmFPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZY2Ab2hd5uL7CAS6ry7TnaU5mFl7MU3cvNfOmZ/73RB4K0fimPInls8AU7QRDj4iP
	 WTsClq62SM3njzm9CqiDlbRDjrdYyecEQsewjOVxWfhw2ES65+DwSQyzeNzLTjz6UT
	 5Q95U/6nwevIryyyNcDK8oy5Lzu89vD2cWr2ayOY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geetha sowjanya <gakula@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 568/731] octeontx2-af: Fix mbox INTR handler when num VFs > 64
Date: Tue,  8 Apr 2025 12:47:45 +0200
Message-ID: <20250408104927.486052484@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

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




