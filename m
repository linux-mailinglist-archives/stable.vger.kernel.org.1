Return-Path: <stable+bounces-14684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57C838221
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAD81F23B35
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD1558AB7;
	Tue, 23 Jan 2024 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcvSNUlR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC66C63BF;
	Tue, 23 Jan 2024 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974070; cv=none; b=D62xc8UH/xyv+TBxUHGYzoWonzqMZOpnZxGztnXFgEjtwWALvLBLU7YrEFhXHGE1sL+M9xIFqzineoC6slg+fvR6LggkRM/091b5GhEnNUTtjmG+HxgdsffvDmvzcBgeU/kp3jm5o3/jZNx4I05LDnYgVXEVV3KftUbnGkZfrZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974070; c=relaxed/simple;
	bh=QHxo855qmypYgjKF6ryMgijqptHfZJCN8QILIO0bF98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/pf4s2xiMkkGyv+bdGBCPmNZ9ROFYmUY0DXpVffdgJGtsZArL+SzSSd3U0+FlavwlPyqxB3kKpG8xxHzhh/8uPgHzu0s1tQI6PFDWDxSgRBFbMJU4KSmK6ZA6Yj/ZWcR2r2/AF2KCZrirhHoEffMxr1fj7j49ywTMDSbk06xQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hcvSNUlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0DAC433A6;
	Tue, 23 Jan 2024 01:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974070;
	bh=QHxo855qmypYgjKF6ryMgijqptHfZJCN8QILIO0bF98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcvSNUlRbfGiIQjwJG/fXqZng4wXn7TUfIkz6ktJj6JY2p8dJVbsj/YuBL2SwADWp
	 W66gliOUoatcC8BuiGx8qBxtx+/FBZoH1fnU52j7Anj4bPiCWpVG9gB+VyfJjU8gHu
	 CWQhKBFsV86e0IGFj9dEjnE6pq7DwMIveemiaRfU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Atul Dhudase <quic_adhudase@quicinc.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Douglas Anderson <dianders@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 151/374] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
Date: Mon, 22 Jan 2024 15:56:47 -0800
Message-ID: <20240122235749.875556569@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

From: Atul Dhudase <quic_adhudase@quicinc.com>

[ Upstream commit eed6e57e9f3e2beac37563eb6a0129549daa330e ]

Commit c14e64b46944 ("soc: qcom: llcc: Support chipsets that can
 write to llcc") add the support for chipset where capacity based
allocation and retention through power collapse can be programmed
based on content of SCT table mentioned in the llcc driver where
the target like sdm845 where the entire programming related to it
is controlled in firmware. However, the commit introduces a bug
where capacity/retention register get overwritten each time it
gets programmed for each slice and that results in misconfiguration
of the register based on SCT table and that is not expected
behaviour instead it should be read modify write to retain the
configuration of other slices.

This issue is totally caught from code review and programming test
and not through any power/perf numbers so, it is not known what
impact this could make if we don't have this change however,
this feature are for these targets and they should have been
programmed accordingly as per their configuration mentioned in
SCT table like others bits information.

This change brings one difference where it keeps capacity/retention
bits of the slices that are not mentioned in SCT table in unknown
state where as earlier it was initialized to zero.

Fixes: c14e64b46944 ("soc: qcom: llcc: Support chipsets that can write to llcc")
Signed-off-by: Atul Dhudase <quic_adhudase@quicinc.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/1701876771-10695-1-git-send-email-quic_mojha@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/llcc-qcom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index fabc5ce828af..59e359e9062b 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -450,14 +450,14 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 		u32 disable_cap_alloc, retain_pc;
 
 		disable_cap_alloc = config->dis_cap_alloc << config->slice_id;
-		ret = regmap_write(drv_data->bcast_regmap,
-				LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_alloc);
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_SCID_DIS_CAP_ALLOC,
+					 BIT(config->slice_id), disable_cap_alloc);
 		if (ret)
 			return ret;
 
 		retain_pc = config->retain_on_pc << config->slice_id;
-		ret = regmap_write(drv_data->bcast_regmap,
-				LLCC_TRP_PCB_ACT, retain_pc);
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_PCB_ACT,
+					 BIT(config->slice_id), retain_pc);
 		if (ret)
 			return ret;
 	}
-- 
2.43.0




