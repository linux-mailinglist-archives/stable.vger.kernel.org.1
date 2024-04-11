Return-Path: <stable+bounces-38772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019C38A1053
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DF01C21848
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6298414A61E;
	Thu, 11 Apr 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kyC4smKH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B01465BF;
	Thu, 11 Apr 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831545; cv=none; b=hPY89IrYa86UrpJznsnF+wPk1W6n0Tm6f9v/vHNhJz102Rkw6zjPP1YgNuac7YB8dSuL+9chAmTzBC24RDU39qAe6I21DDzS4lrbxhtnx2vPjRZV7qbLgRw0a9GjzPv/6RSIiG8/pHrMHiI5OyWl1MfN/YdwDZ3HNjhyFwXi5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831545; c=relaxed/simple;
	bh=MRGSThjcJDtsieRm64Q6wi4NRAKCYpoOBUjam+ky1Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxvubHT9/0Usr1FH/Gl1ELjbjo01pbc2P0rHWPlG6NJysoMMlZSAi+RNmczPzY21vRVYc+1ggO/K6vwvWV1Oncim0tQovSToCh6sKye0v/8ziqLIDNaG9svVpf/TFOW9yW8yYNFOAF+P4VBLPFpl6PtUgtJuHXiG+xR/82d5deU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kyC4smKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED9CC433F1;
	Thu, 11 Apr 2024 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831544;
	bh=MRGSThjcJDtsieRm64Q6wi4NRAKCYpoOBUjam+ky1Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kyC4smKHV7SEplfEkhhDsMpGMQ80X4VdIUIvuLxfQ+171n7Wz5q8EWDSoCEhBiko6
	 Yz6xJFbNdQ+ktC7jZs9GHLfx8oHjZDvPl7cnbvM2JgXsUTJVLup+8/M8cAWHHCV+U3
	 hxXlf+fDs4qxGrB2+d0l1K66jujbzOv84Fsq4QQg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabor Juhos <j4g8y7@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 044/294] clk: qcom: mmcc-msm8974: fix terminating of frequency table arrays
Date: Thu, 11 Apr 2024 11:53:27 +0200
Message-ID: <20240411095436.964993291@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit e2c02a85bf53ae86d79b5fccf0a75ac0b78e0c96 ]

The frequency table arrays are supposed to be terminated with an
empty element. Add such entry to the end of the arrays where it
is missing in order to avoid possible out-of-bound access when
the table is traversed by functions like qcom_find_freq() or
qcom_find_freq_floor().

Only compile tested.

Fixes: d8b212014e69 ("clk: qcom: Add support for MSM8974's multimedia clock controller (MMCC)")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240229-freq-table-terminator-v1-7-074334f0905c@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/mmcc-msm8974.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index 015426262d080..dfc377463a7af 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -283,6 +283,7 @@ static struct freq_tbl ftbl_mmss_axi_clk[] = {
 	F(291750000, P_MMPLL1, 4, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
 	F(466800000, P_MMPLL1, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 mmss_axi_clk_src = {
@@ -307,6 +308,7 @@ static struct freq_tbl ftbl_ocmemnoc_clk[] = {
 	F(150000000, P_GPLL0, 4, 0, 0),
 	F(291750000, P_MMPLL1, 4, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ocmemnoc_clk_src = {
-- 
2.43.0




