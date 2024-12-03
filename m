Return-Path: <stable+bounces-96748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B53F9E23CB
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D20B88086
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AD01F7071;
	Tue,  3 Dec 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wrLeyNab"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B41F7587;
	Tue,  3 Dec 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238479; cv=none; b=snLUsaLoAT8+0QBVSRUgCJcREE6rdxdXfrm+iiwoemnjfMoy6WUg/GnS3efgMp42tkvHcv42+gHBno9N95v8AYhOT9qN+qtDu20ISSfMyuLu+iD4RfCgn2q5v6TlsLX5WW0isuF/muEtei0IyUvdreTH9jUT5uCzemSrExc/XTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238479; c=relaxed/simple;
	bh=LpLmmlFVNd5gvlbeiNBNLteU/fBUE5ixHKwE/e3T3fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSiTX/Wy2TdeGqsOuueFkL4BOXkXJN5X/YOfRrpWMC7z6EOtf/30bTS0uAqO9ZVtw7RSyMJtxvpnLERSEbRUV3lMbwDNh1OWM4aDG71k7tZtErzFR3ic95wswuQTdCkHXvsAtKniM6KJvKgklX0eO0396mrdQ/mwoN3FA+NGWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wrLeyNab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495ABC4CECF;
	Tue,  3 Dec 2024 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238479;
	bh=LpLmmlFVNd5gvlbeiNBNLteU/fBUE5ixHKwE/e3T3fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wrLeyNabfcFnW6CmQeiZWNYM9/wRxcS+hXZs6nEPsNfbZBi1kRNB0IvMzmuaxoDm8
	 S4V/RI7iTTqNquq5suVPRtqMJXKMtnmXU17Jj2nEjcFBhapMBAvyBsR/nuOhY+KQrF
	 uBvfapN8k43ytas6PQgDK2FCgAHtHZEib6695/LY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dipendra Khadka <kdipendra88@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 291/817] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c
Date: Tue,  3 Dec 2024 15:37:43 +0100
Message-ID: <20241203144007.170115393@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

From: Dipendra Khadka <kdipendra88@gmail.com>

[ Upstream commit 69297b0d3369488af259e3a7cf53d69157938ea1 ]

Add error pointer check after calling otx2_mbox_get_rsp().

Fixes: 8e67558177f8 ("octeontx2-pf: PFC config support with DCBx")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index aa01110f04a33..294fba58b6709 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -315,6 +315,11 @@ int otx2_config_priority_flow_ctrl(struct otx2_nic *pfvf)
 	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
 		rsp = (struct cgx_pfc_rsp *)
 		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp)) {
+			err = PTR_ERR(rsp);
+			goto unlock;
+		}
+
 		if (req->rx_pause != rsp->rx_pause || req->tx_pause != rsp->tx_pause) {
 			dev_warn(pfvf->dev,
 				 "Failed to config PFC\n");
-- 
2.43.0




