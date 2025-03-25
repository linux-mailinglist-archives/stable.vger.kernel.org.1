Return-Path: <stable+bounces-126194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF2A70006
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE13F1883C23
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA592676D9;
	Tue, 25 Mar 2025 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZyyXqSeh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01525A342;
	Tue, 25 Mar 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905774; cv=none; b=EGTs8sTYgvWmmvMF+PiefGimNUNs2pSzwCDvgkSFGehgdkEdftnCFBMhRJZ8j0RZEXvwc6li5tA9E9bMkD6Tl1MIpDSm8E9/rKimiMxDxcs8VBvOeKk0PosUvllSHMwF1Pwra/tVqrHkDpR8L7wZQzniZh4r37ZqpKJE260b4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905774; c=relaxed/simple;
	bh=MoQw0M63GIfd9mbOSZDqYxnwX+pLmlc5jOxs50FfWaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ80LhikQ1pHVY7nxuVkLe+7MKer0gS7HBmLLZKFoOI07UWeyhooUy74PoOTyzWnLONQHKp/4tFIuEhy2fw77qAkjQY5CkjucEfHyvZ5vd13I61bPDrGjc6BEqnQf+BFVhODtoTBfzhdUkEKvtpD053mmKoEN2zuxmfgNcxlK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZyyXqSeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C32C4CEE4;
	Tue, 25 Mar 2025 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905774;
	bh=MoQw0M63GIfd9mbOSZDqYxnwX+pLmlc5jOxs50FfWaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyyXqSehcOND3AuFdCPLtm9saf7aEcCvrZMUv7AwA6EYhy+nSpH1I4vLqsKJ9cwy8
	 AZv2Yfgj2nNH6etN0EKfCxKDNHpkB+9ucP8RgFEy9acuNjxl9Pxp5hxMLO2+MWk+Vn
	 ti7drUIwAFru0qdfy38ArwdgTug03dXRIih7iUaM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 156/198] RDMA/bnxt_re: Avoid clearing VLAN_ID mask in modify qp path
Date: Tue, 25 Mar 2025 08:21:58 -0400
Message-ID: <20250325122200.749236431@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

[ Upstream commit 81c0db302a674f8004ed805393d17fd76f552e83 ]

Driver is always clearing the mask that sets the VLAN ID/Service Level
in the adapter. Recent change for supporting multiple traffic class
exposed this issue.

Allow setting SL and VLAN_ID while QP is moved from INIT to RTR state.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Fixes: c64b16a37b6d ("RDMA/bnxt_re: Support different traffic class")
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://patch.msgid.link/1741670196-2919-1-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 23f9a48828dca..15a62d0d243ce 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1186,8 +1186,6 @@ static void __modify_flags_from_init_state(struct bnxt_qplib_qp *qp)
 			qp->path_mtu =
 				CMDQ_MODIFY_QP_PATH_MTU_MTU_2048;
 		}
-		qp->modify_flags &=
-			~CMDQ_MODIFY_QP_MODIFY_MASK_VLAN_ID;
 		/* Bono FW require the max_dest_rd_atomic to be >= 1 */
 		if (qp->max_dest_rd_atomic < 1)
 			qp->max_dest_rd_atomic = 1;
-- 
2.39.5




