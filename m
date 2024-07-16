Return-Path: <stable+bounces-60244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25638932E09
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CD51F218E0
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A419B3C4;
	Tue, 16 Jul 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xHHsn4H8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412B1DDCE;
	Tue, 16 Jul 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146320; cv=none; b=kdumYK/s6razghgbbHdhTuKrZuooCPW56gZfTjZOn42RyYhhN813OYxdMmmLCrlrjqttNICQVQUpEMH6yV1LUyNyMEvlhebr7q+AXVGPkZU1QYMsjtFqE/rjr3T2iguD9kZ9+N4zKn9ZXmmtrKtZnKvftYCI5Vx7LcPciXEfRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146320; c=relaxed/simple;
	bh=PAx6CqM32ctUDP7szCCi+PznyT+pb1RQVj+VcyK++WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpysJ3IVkDtU/ZV/gLzGFtVJeVlozTXHDE9HrrEkkMvudT1GEmAO9zBrQuZMwSMNOpMcN53D40S3LrGs3CQQgErVLDTIvIMxrguKFDK0qz4n9MdVaBKDijSBGrHIwavNrPNXIwkLZecRi7KXjQT6/K0wArdIpqDYJbqpOfgc43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xHHsn4H8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E07C116B1;
	Tue, 16 Jul 2024 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721146319;
	bh=PAx6CqM32ctUDP7szCCi+PznyT+pb1RQVj+VcyK++WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xHHsn4H8PrAqGi6JT0uxq96M9vnAqQZSmMrvEI9UncPMySR4oKqE0gyeSwRsB6M1g
	 QYse0uhfdUd97GKTj0WktH5yuNj7QNNlIvv0PFzzIDzfnMnsOAhxf/s7JJi8IieHVE
	 oN8rrPY6saktBrGFw9izURifFS+hRuu5JdUI9uH4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 097/144] octeontx2-af: replace cpt slot with lf id on reg write
Date: Tue, 16 Jul 2024 17:32:46 +0200
Message-ID: <20240716152756.266594808@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
References: <20240716152752.524497140@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

[ Upstream commit bc35e28af7890085dcbe5cc32373647dfb4d9af9 ]

Replace slot id with global CPT lf id on reg read/write as
CPTPF/VF driver would send slot number instead of global
lf id in the reg offset. And also update the mailbox response
with the global lf's register offset.

Fixes: ae454086e3c2 ("octeontx2-af: add mailbox interface for CPT")
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index 4895faa667b50..767c975ef7f38 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -260,7 +260,8 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 					struct cpt_rd_wr_reg_msg *req,
 					struct cpt_rd_wr_reg_msg *rsp)
 {
-	int blkaddr;
+	u64 offset = req->reg_offset;
+	int blkaddr, lf;
 
 	blkaddr = validate_and_get_cpt_blkaddr(req->blkaddr);
 	if (blkaddr < 0)
@@ -271,17 +272,25 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 	    !is_cpt_vf(rvu, req->hdr.pcifunc))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
-	rsp->reg_offset = req->reg_offset;
-	rsp->ret_val = req->ret_val;
-	rsp->is_write = req->is_write;
-
 	if (!is_valid_offset(rvu, req))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
+	/* Translate local LF used by VFs to global CPT LF */
+	lf = rvu_get_lf(rvu, &rvu->hw->block[blkaddr], req->hdr.pcifunc,
+			(offset & 0xFFF) >> 3);
+
+	/* Translate local LF's offset to global CPT LF's offset */
+	offset &= 0xFF000;
+	offset += lf << 3;
+
+	rsp->reg_offset = offset;
+	rsp->ret_val = req->ret_val;
+	rsp->is_write = req->is_write;
+
 	if (req->is_write)
-		rvu_write64(rvu, blkaddr, req->reg_offset, req->val);
+		rvu_write64(rvu, blkaddr, offset, req->val);
 	else
-		rsp->val = rvu_read64(rvu, blkaddr, req->reg_offset);
+		rsp->val = rvu_read64(rvu, blkaddr, offset);
 
 	return 0;
 }
-- 
2.43.0




