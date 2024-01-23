Return-Path: <stable+bounces-14985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C3E8383F0
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F48B2B3B5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CBE629F7;
	Tue, 23 Jan 2024 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PCmQtkld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209AC629E1;
	Tue, 23 Jan 2024 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974971; cv=none; b=aCh219EeFSgCY27iekJYmjsTJMOsFbEieEfJ6H18PHaURdj9mAlk1iUEkLuyhq9s1aCZfFuzR4TpYVskFV3UtxojglbZYZr67J4rGJ/q8a8nV3Qd4bWzCp50ZNHOsEGSKSEkzfKyjnf3c2/TrNC5MXzuF+Vcg8Xd6S6sn3xFLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974971; c=relaxed/simple;
	bh=nIPOcWsZa79hAyEtrhQ7CYgWweLHAR+1TADf+wZMuyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmEgHGDIs4Qny4+kMpVGde/uYGc/RQ312mvjayiFXX7DVU/OcfMXkN6rv4pg1kpyrGpSzeZlKtaJ8bfjkj2MYYGD584uuSxhSf474TVGKJBrfHyoiKOQ+B2a003f3ooaPC/NsRE4YTgRmen68Y6HpJsWjJQWUxPuh2vyxmna9N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PCmQtkld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92394C433F1;
	Tue, 23 Jan 2024 01:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974970;
	bh=nIPOcWsZa79hAyEtrhQ7CYgWweLHAR+1TADf+wZMuyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCmQtkldiJhQFtjsWxrpxTgxqdfLR+W8C7zMISLKtugB9iURgO/eQzlvRQznIBChD
	 ssgcikJnfOQOGjPpK+jhzx7F4Hblb6guwc2N7clJTCFEHrRkdGBEkpKQ0qSqqRJe+t
	 cS7JlV4RVTZEwYR6JKP6lSiek2kfb+f2OQrlcDvA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Atul Dhudase <quic_adhudase@quicinc.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Douglas Anderson <dianders@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 174/583] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
Date: Mon, 22 Jan 2024 15:53:45 -0800
Message-ID: <20240122235817.351782138@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index c61848595da0..309c12f2d3bb 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -785,15 +785,15 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 		u32 disable_cap_alloc, retain_pc;
 
 		disable_cap_alloc = config->dis_cap_alloc << config->slice_id;
-		ret = regmap_write(drv_data->bcast_regmap,
-				LLCC_TRP_SCID_DIS_CAP_ALLOC, disable_cap_alloc);
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_SCID_DIS_CAP_ALLOC,
+					 BIT(config->slice_id), disable_cap_alloc);
 		if (ret)
 			return ret;
 
 		if (drv_data->version < LLCC_VERSION_4_1_0_0) {
 			retain_pc = config->retain_on_pc << config->slice_id;
-			ret = regmap_write(drv_data->bcast_regmap,
-					LLCC_TRP_PCB_ACT, retain_pc);
+			ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_PCB_ACT,
+						 BIT(config->slice_id), retain_pc);
 			if (ret)
 				return ret;
 		}
-- 
2.43.0




