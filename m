Return-Path: <stable+bounces-74200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE837972E02
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6C71C24625
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB6C18A6B9;
	Tue, 10 Sep 2024 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZHTWI7/U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20531885A6;
	Tue, 10 Sep 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961107; cv=none; b=bFPuxesyBB8/ykXo4HzE7Sw6rkRfeqiv0aa792InUTk3S4CUDcG9h5K0gxPCEEZSeyOLNyaPGTH+TqWaRAzIJ4Vxo34/Ys2VpolkEA+J2FR5brn6Vo/wwLvbleaB1EqEaz+Twme7BhG6G0zobsxy1uQOwSWgGhDH2mU4UmB3VsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961107; c=relaxed/simple;
	bh=E0uldmncqtWgM9TyN+Kpa8/lEg3NTIbqlg2iFYxnR3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGwH67pZVTaeMyfkh8W+XEQ2OXV68XlLuj4I8dAIb4B5AK2wAEdxReMhWWhEIyZSPvtsTcXztwP3qmhYPiybtFCyly5m/yLS1c2uDLxbcN/BULU4+MKmAYBuS8i/rC4XN21lHg/agMf0zz/G/V6qYTjgIXat2YmfSrUx+A9Ce/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZHTWI7/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DDEC4CEC3;
	Tue, 10 Sep 2024 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961106;
	bh=E0uldmncqtWgM9TyN+Kpa8/lEg3NTIbqlg2iFYxnR3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHTWI7/UGhuMVHyaBYmQbkFr3pMMyRMdFqvRzDlR5VGiv2Lz2fpTqgitsF0DO9Dba
	 1zN03juS0iR0igsK79xvWfCIGp+CX8wiRyl4XPRxzeGnTNZ158dx16uEt1NvePtOXm
	 POMZSDL5puSH5tARaCS1WJL2QjaEOC3E+y0v+OMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 55/96] devres: Initialize an uninitialized struct member
Date: Tue, 10 Sep 2024 11:31:57 +0200
Message-ID: <20240910092543.943101298@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit 56a20ad349b5c51909cf8810f7c79b288864ad33 ]

Initialize an uninitialized struct member for driver API
devres_open_group().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/1719931914-19035-4-git-send-email-quic_zijuhu@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index a64f70a62e28..f9e5deb72db6 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -559,6 +559,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
-- 
2.43.0




