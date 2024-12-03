Return-Path: <stable+bounces-97043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC39E25C5
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC79BA6465
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1671F7554;
	Tue,  3 Dec 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HCIcCLy2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F341F472A;
	Tue,  3 Dec 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239355; cv=none; b=Gp9tiD3UzNccTikzeNxoqD9IgQyLSvR1qSNDOm0T91cxxWfbHlfZbQxTTDkd+3cvOmRGR7IU76zTWXMyAiASZiQzgwntFKIZSskMYlcAp4JyFMd2Z6FvAsKCQZT2x+O7c03zw/V8xWdJ3QnczC9p/Lr6KTvAMeqfZlbVEh/lLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239355; c=relaxed/simple;
	bh=suxx8mTWR7U9nEhsuHLdBsRC6RJQLGDS5dsK8GfSnRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhWgMioEmFTrPw+huHbtjX/+RH/RfTw77xhs4j71cQ0WZsz61PG+UJztxU17HRt5yZtIfO1w0Pv9aV809U0sZAqIKYQ5sKaON+t2VzB+BcVarnd7qwwoNNqKatJpd5XtqCzBKsoJ68XV9bTRRoV1PPF0gbPOKHxRm3hr7fFozgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HCIcCLy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B86C4CECF;
	Tue,  3 Dec 2024 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239355;
	bh=suxx8mTWR7U9nEhsuHLdBsRC6RJQLGDS5dsK8GfSnRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCIcCLy2CorOCkWfBTjJyVXXqTjNVOfLRMDx1R605jouNS8K2gzlkED9Do7YDOYPa
	 9zZQuzRz50XEbbHiIaegAaLabYLrs/eLic5nG+PN4aqLJuvgdIS3dqCsCrbZWAYUgq
	 HzBEhh6zVzagWK5Gr+G1ialevP6j3I+t2YVuU6Ko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Shravya KN <shravya.k-n@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 586/817] bnxt_en: Set backplane link modes correctly for ethtool
Date: Tue,  3 Dec 2024 15:42:38 +0100
Message-ID: <20241203144018.796594446@linuxfoundation.org>
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

From: Shravya KN <shravya.k-n@broadcom.com>

[ Upstream commit 5007991670941c132fb3bc0484c009cf4bcea30f ]

Use the return value from bnxt_get_media() to determine the port and
link modes.  bnxt_get_media() returns the proper BNXT_MEDIA_KR when
the PHY is backplane.  This will correct the ethtool settings for
backplane devices.

Fixes: 5d4e1bf60664 ("bnxt_en: extend media types to supported and autoneg modes")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index ac06f4a4cf97c..0f9441de2f2d7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2837,19 +2837,24 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	}
 
 	base->port = PORT_NONE;
-	if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP) {
+	if (media == BNXT_MEDIA_TP) {
 		base->port = PORT_TP;
 		linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
 				 lk_ksettings->link_modes.supported);
 		linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
 				 lk_ksettings->link_modes.advertising);
+	} else if (media == BNXT_MEDIA_KR) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Backplane_BIT,
+				 lk_ksettings->link_modes.supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Backplane_BIT,
+				 lk_ksettings->link_modes.advertising);
 	} else {
 		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
 				 lk_ksettings->link_modes.supported);
 		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
 				 lk_ksettings->link_modes.advertising);
 
-		if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC)
+		if (media == BNXT_MEDIA_CR)
 			base->port = PORT_DA;
 		else
 			base->port = PORT_FIBRE;
-- 
2.43.0




