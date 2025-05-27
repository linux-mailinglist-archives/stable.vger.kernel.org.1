Return-Path: <stable+bounces-147799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211C8AC593A
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D73C4A4121
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F672566;
	Tue, 27 May 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gJIxe005"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79227FD64;
	Tue, 27 May 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368469; cv=none; b=rBe9JSlpkW4SGvPxVpgIo/GERZ0WHZ/7vn6yxWhAtQvn2s7WSCL4IDZL2rk/ImtcZB7/W2SdH56lNjMSFSq30tfwbisCgCkSoQeDFn11hceh66U8HmN3sVC9DoOJJ8HxsIupGrp5ANbj6i0LjWF8PnZ8QunIzZ1HIOEvM5C1P54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368469; c=relaxed/simple;
	bh=mOwCdJjLSUu0DXmyP98nugLGDu4bexTMUu9+grIpyUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2ScIlw+0lDEDr1UmQvzsgL4JGXiufyAHXWivmj5kGbdJZNeqxla3YY8+NsHirVaN4vGe00eEglB/LnDLgEl4MiI8ownA9eh7MmKLeotj4wZy//XXhya8PFNJO9VK4Gh4QuYuhLik8Pehr97djaHgV1PCvux8HGJ+N7ihJzGH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gJIxe005; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5A1C4CEE9;
	Tue, 27 May 2025 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368469;
	bh=mOwCdJjLSUu0DXmyP98nugLGDu4bexTMUu9+grIpyUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJIxe005SHLcxM+C5C9Qteq9lJ4TPR+lYbrmbcJ5U5ZEpK3dNRxrX6pVg/gsGPoVx
	 hKu4+O6n9VybEaDZiwbp+waZ+GYGhqCqdt+oF/TtNo1g4qRUCH/RNXSTytwbmYwndN
	 4PhxRznIKbH0cWQevxlYRrv0yjFbn/rqlIdLfpiA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suman Ghosh <sumang@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 717/783] octeontx2-pf: Avoid adding dcbnl_ops for LBK and SDP vf
Date: Tue, 27 May 2025 18:28:34 +0200
Message-ID: <20250527162542.312125255@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

From: Suman Ghosh <sumang@marvell.com>

[ Upstream commit 184fb40f731bd3353b0887731f7caba66609e9cd ]

Priority flow control is not supported for LBK and SDP vf. This patch
adds support to not add dcbnl_ops for LBK and SDP vf.

Fixes: 8e67558177f8 ("octeontx2-pf: PFC config support with DCBx")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250519072658.2960851-1-sumang@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 63ddd262d1229..1f53bd5e45604 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -729,9 +729,12 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 #ifdef CONFIG_DCB
-	err = otx2_dcbnl_set_ops(netdev);
-	if (err)
-		goto err_free_zc_bmap;
+	/* Priority flow control is not supported for LBK and SDP vf(s) */
+	if (!(is_otx2_lbkvf(vf->pdev) || is_otx2_sdp_rep(vf->pdev))) {
+		err = otx2_dcbnl_set_ops(netdev);
+		if (err)
+			goto err_free_zc_bmap;
+	}
 #endif
 	otx2_qos_init(vf, qos_txqs);
 
-- 
2.39.5




