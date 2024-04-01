Return-Path: <stable+bounces-34850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329D894129
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CC71C2123C
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB647A6B;
	Mon,  1 Apr 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eag0201l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AED433DA;
	Mon,  1 Apr 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989507; cv=none; b=Vsgk7DEpB4gYTAxDJ5luw4qzRdU8wN3ByP85tyWBa4+hfV7eWvVU4fLXKtP2XI8YLtRIZgpMAIc2vIbMgslC7FIOR5lG9Wazkr68NMm3UH/qveVLntad6WbXPBRcaiKSdPVYKb0ThIBiG2Bekzp6HhKJeFkzcAR3VOSD24a6RyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989507; c=relaxed/simple;
	bh=1uT0IQ/mxopYwwewrobTrGEs7j5iSaUVEPVsfEflT6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcGFaaS5Ks2HKUkqShGzc5WGef6lX/mHIcdfbVi+Ua/NeAlFQg38WdERH7b76bKSh8QGbp/Ft0ZFwPgM7gBdDhvDWRMLcQj8NuBWU89J+fzOodapMoh/KWvpM4X4GwiKBhhG5Pz2viUbeAjVT32zZIc30HGZplsle5fUlskrB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eag0201l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5541AC433C7;
	Mon,  1 Apr 2024 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989507;
	bh=1uT0IQ/mxopYwwewrobTrGEs7j5iSaUVEPVsfEflT6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eag0201lfLtwmHPisQh+0w6VBesgF4ayMXMrIYmdphB3jJ330NIcsdn36zUy+xB82
	 Q6ZuX9aW0pXqcYNIUYy2UerOTC6CmyRfxi2YanmxMHESQsEz021zBqFFT84Yqxcq8F
	 Qupuxqk7k6uYlOGj5s+K9G1kbiMrXCbwZDUhVsdI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabor Juhos <j4g8y7@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 070/396] clk: qcom: mmcc-apq8084: fix terminating of frequency table arrays
Date: Mon,  1 Apr 2024 17:41:59 +0200
Message-ID: <20240401152550.008682497@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit a903cfd38d8dee7e754fb89fd1bebed99e28003d ]

The frequency table arrays are supposed to be terminated with an
empty element. Add such entry to the end of the arrays where it
is missing in order to avoid possible out-of-bound access when
the table is traversed by functions like qcom_find_freq() or
qcom_find_freq_floor().

Only compile tested.

Fixes: 2b46cd23a5a2 ("clk: qcom: Add APQ8084 Multimedia Clock Controller (MMCC) support")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240229-freq-table-terminator-v1-6-074334f0905c@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/mmcc-apq8084.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/mmcc-apq8084.c b/drivers/clk/qcom/mmcc-apq8084.c
index 02fc21208dd14..c89700ab93f9c 100644
--- a/drivers/clk/qcom/mmcc-apq8084.c
+++ b/drivers/clk/qcom/mmcc-apq8084.c
@@ -348,6 +348,7 @@ static struct freq_tbl ftbl_mmss_axi_clk[] = {
 	F(333430000, P_MMPLL1, 3.5, 0, 0),
 	F(400000000, P_MMPLL0, 2, 0, 0),
 	F(466800000, P_MMPLL1, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 mmss_axi_clk_src = {
@@ -372,6 +373,7 @@ static struct freq_tbl ftbl_ocmemnoc_clk[] = {
 	F(150000000, P_GPLL0, 4, 0, 0),
 	F(228570000, P_MMPLL0, 3.5, 0, 0),
 	F(320000000, P_MMPLL0, 2.5, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 ocmemnoc_clk_src = {
-- 
2.43.0




