Return-Path: <stable+bounces-130897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B37A8066D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8847AFC9D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65D26B2CD;
	Tue,  8 Apr 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HiKMuaeX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6C269802;
	Tue,  8 Apr 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114950; cv=none; b=Q5yy7iGO+I+Qeu8fxxiiLPUnuNr+g6+Uwn1KwkHgw1GNLxJ8XAWhiCKyoDBTNaRvtTV/Xg6rmNgFMEVZSQDtZhvdeGMwTF2+rQmauowygAA8/VV8X4qTAQpPQXH5JCFYyKwIvcBbEz/RENUAy5nUPPBijlrR16ajbR5EbMWSqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114950; c=relaxed/simple;
	bh=OzVxyE8VOGZTM9yx9rOpXpb1NdymBT9ZFuw3DUp+SD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9F1InXNRJGFqp622c4q0gyss1OtKssR5RJ5gxeYJUmnVzneIGIO5UpMmkmL0gtcZDvGTRFh09seTyYBWWFgMuc9pDBEP9aNNMFvYCnliJ8s7EsDzc6GBkRlcfGjLnXJICSTz+/qmtQ4f/GCSgxrp9NkOkWbuQSNyTxRWw9tg48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HiKMuaeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5780C4CEE5;
	Tue,  8 Apr 2025 12:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114950;
	bh=OzVxyE8VOGZTM9yx9rOpXpb1NdymBT9ZFuw3DUp+SD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HiKMuaeXVDhYqzjqDiIXXEWEyAyuEPq2w/JiOF/KO4vVSfbFJ6jJoOmo6wGfshbfz
	 njMj4OkpxSGOQCLan68xYziMknPEZPO+YQC0u7LVHxKoX7EaqTnPHnywCxPjMaRi0Z
	 63e+BYr/RTDwbdhDeP+CGBWrRdbhNZNPFQWu3u54=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geetha sowjanya <gakula@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 292/499] octeontx2-af: Fix mbox INTR handler when num VFs > 64
Date: Tue,  8 Apr 2025 12:48:24 +0200
Message-ID: <20250408104858.497365371@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

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




