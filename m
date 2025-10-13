Return-Path: <stable+bounces-185358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB9DBD4B58
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9A6B3430B0
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9276631281D;
	Mon, 13 Oct 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bR4tqbcW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12231280A;
	Mon, 13 Oct 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370066; cv=none; b=eOEs/w+NUh/0dlsGjSIcGr71ap2yx28QhO6Z/j9VQWth/PpVUQvs0ebqqrdu7+GkO9LgG24YqL0fswkTtRj7kPkn0LsT1iOrJLCrfD+/1VWDGfq971FLBtw9uBxWwIOweq6PZQPGN41u/h5rgoubvkLwYlaYbrDpf7Rn0iFMwPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370066; c=relaxed/simple;
	bh=tBFkt1HUD2JOW4E/1DypKGDi5DcxKxqF9CBOgQ0qBzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmPbw8LytraHppk9V83UrBq0lcW44+pLJdyjpLD5MsrXoUHpNHojrmPeHkol8c7x8CKLMx+V6cGCGtOgzNBNAHH8iifB1Lbp6mu/XzRiRb12z8xJDFRhLZc5twE053LtJ7zuISQnAbDNnKGIaM0vWej6mEHfqh0AnKi1HGVbgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bR4tqbcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7E9C4CEE7;
	Mon, 13 Oct 2025 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760370066;
	bh=tBFkt1HUD2JOW4E/1DypKGDi5DcxKxqF9CBOgQ0qBzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bR4tqbcW5JRt6Q8CYHlnJmFmF2J1iFjzdhpceMnKvj0LnWz1vB1dJQi2T5qfPYboA
	 6j4dMWt5hovCedyaPwG+aXMU/NyDmr/KgTRDYWxxSM9qXaeY2CwJU86abFlr7FNi4o
	 1KNHHddf5zbqxjV21YD4FP4MXp3siiU9XbxcsvKU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 449/563] net: enetc: Fix probing error message typo for the ENETCv4 PF driver
Date: Mon, 13 Oct 2025 16:45:10 +0200
Message-ID: <20251013144427.546898645@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Manoil <claudiu.manoil@nxp.com>

[ Upstream commit c35cf24a69b00b7f54f2f19838f2b82d54480b0f ]

Blamed commit wrongly indicates VF error in case of PF probing error.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250924082755.1984798-1-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b3dc1afeefd1d..a5c1f1cef3b0c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -1030,7 +1030,7 @@ static int enetc4_pf_probe(struct pci_dev *pdev,
 	err = enetc_get_driver_data(si);
 	if (err)
 		return dev_err_probe(dev, err,
-				     "Could not get VF driver data\n");
+				     "Could not get PF driver data\n");
 
 	err = enetc4_pf_struct_init(si);
 	if (err)
-- 
2.51.0




