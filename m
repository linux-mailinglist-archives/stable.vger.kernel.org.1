Return-Path: <stable+bounces-4303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7DC8046EB
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC251C20DB5
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248B79F2;
	Tue,  5 Dec 2023 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="idRyJ0xl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AA6FB1;
	Tue,  5 Dec 2023 03:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC06C433C8;
	Tue,  5 Dec 2023 03:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747179;
	bh=dyUMmz/M8qtWfQ0zQYBpej61bAsoR+SxzNmdQgnYufY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idRyJ0xlA2WJvdId6CFcLjKTcvxPPoGFA33Sivf0SKMSUZ+SA9SKiifqNBr4zEf2f
	 0y0u16bxTrQwz5dRIJhbe4brKJE+k2Gk8ZJTBWNKHWNEyhV5pt9Ur51irKlrBpb5fU
	 mabSXKSoG8UE+AhDuaO/Gsvmnm/39kL1f41EkNcE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Elena Salomatkina <elena.salomatkina.cmc@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 065/107] octeontx2-af: Fix possible buffer overflow
Date: Tue,  5 Dec 2023 12:16:40 +0900
Message-ID: <20231205031535.498012569@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Elena Salomatkina <elena.salomatkina.cmc@gmail.com>

[ Upstream commit ad31c629ca3c87f6d557488c1f9faaebfbcd203c ]

A loop in rvu_mbox_handler_nix_bandprof_free() contains
a break if (idx == MAX_BANDPROF_PER_PFFUNC),
but if idx may reach MAX_BANDPROF_PER_PFFUNC
buffer '(*req->prof_idx)[layer]' overflow happens before that check.

The patch moves the break to the
beginning of the loop.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e8e095b3b370 ("octeontx2-af: cn10k: Bandwidth profiles config support").
Signed-off-by: Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Link: https://lore.kernel.org/r/20231124210802.109763-1-elena.salomatkina.cmc@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 1f3a8cf42765e..7310047136986 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5236,6 +5236,8 @@ int rvu_mbox_handler_nix_bandprof_free(struct rvu *rvu,
 
 		ipolicer = &nix_hw->ipolicer[layer];
 		for (idx = 0; idx < req->prof_count[layer]; idx++) {
+			if (idx == MAX_BANDPROF_PER_PFFUNC)
+				break;
 			prof_idx = req->prof_idx[layer][idx];
 			if (prof_idx >= ipolicer->band_prof.max ||
 			    ipolicer->pfvf_map[prof_idx] != pcifunc)
@@ -5249,8 +5251,6 @@ int rvu_mbox_handler_nix_bandprof_free(struct rvu *rvu,
 			ipolicer->pfvf_map[prof_idx] = 0x00;
 			ipolicer->match_id[prof_idx] = 0;
 			rvu_free_rsrc(&ipolicer->band_prof, prof_idx);
-			if (idx == MAX_BANDPROF_PER_PFFUNC)
-				break;
 		}
 	}
 	mutex_unlock(&rvu->rsrc_lock);
-- 
2.42.0




