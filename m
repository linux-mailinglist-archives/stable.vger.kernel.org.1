Return-Path: <stable+bounces-205166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C4BCF9992
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71264304F2F3
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF315289376;
	Tue,  6 Jan 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Inp9tvOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13B1DA55;
	Tue,  6 Jan 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719802; cv=none; b=An5MvyHqJnr9FHDlEYR1SK+CXgB8WgBLd18U0rDkulkCCGhiA87c81Kdp7qXxmL0ffVZ2CDee+q6DGYBd74zRttzIwwUZB2Wo0o/GsfD4oerpMsdqLL4WPJj9ekYwGi2b3hN4XqFiAFLs2k7m6i/sCCz3xwVEc+Kh9eMXs/Vnew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719802; c=relaxed/simple;
	bh=lP3x7Kv44HcLAjhdfFo1d5WKLyAAfY2XPbxSprKxkiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=st74ayYE52qVi7rx6V8uCdm6FL4O+WFauIx6tpoAAikQAfDbmEbULm+GR/RZnN920h5SvivB+JylgiUMsqfWOJWSh/WbQ+ifXPWcobpGr1QnQNTW9zSW8+wW+bKzii4Nhs2qcbZAkiV0CVj7xaUBZ+ci6ipZCYGalkgF7AwDOjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Inp9tvOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85DFC116C6;
	Tue,  6 Jan 2026 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767719802;
	bh=lP3x7Kv44HcLAjhdfFo1d5WKLyAAfY2XPbxSprKxkiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Inp9tvOxsUiJONA/jhdjyzT/YHfD2WCOXejTykTlFDmgrsyyDPg+4kUXcCTCra8c8
	 xxnbGnxwcmZ8TUIuH53+0RSr3Jx7XnSIGZOCOw3sTprZzy8QNFHtXfFQ/i0A3fooEE
	 1A8Wxu2cboeAUXf6YNwgyzIkCuHVgdLYDCHIEoNw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Fang <wei.fang@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 045/567] net: fec: ERR007885 Workaround for XDP TX path
Date: Tue,  6 Jan 2026 17:57:07 +0100
Message-ID: <20260106170453.008033407@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit e8e032cd24dda7cceaa27bc2eb627f82843f0466 ]

The ERR007885 will lead to a TDAR race condition for mutliQ when the
driver sets TDAR and the UDMA clears TDAR simultaneously or in a small
window (2-4 cycles). And it will cause the udma_tx and udma_tx_arbiter
state machines to hang. Therefore, the commit 53bb20d1faba ("net: fec:
add variable reg_desc_active to speed things up") and the commit
a179aad12bad ("net: fec: ERR007885 Workaround for conventional TX") have
added the workaround to fix the potential issue for the conventional TX
path. Similarly, the XDP TX path should also have the potential hang
issue, so add the workaround for XDP TX path.

Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Link: https://patch.msgid.link/20251128025915.2486943-1-wei.fang@nxp.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d1800868c2e01..9018a7d3864fd 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3934,7 +3934,12 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	writel(0, txq->bd.reg_desc_active);
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
 
 	return 0;
 }
-- 
2.51.0




