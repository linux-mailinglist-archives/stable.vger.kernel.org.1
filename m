Return-Path: <stable+bounces-103737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F999EF98E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA317D40A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2C2288EF;
	Thu, 12 Dec 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zz1lxiFJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256C42253FD;
	Thu, 12 Dec 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025456; cv=none; b=lNRLDcU3DKqFUvoujnJvYo/Eqa0YH8ji/jbxAb8Bpra2L/KQnqziM+bh7ZNWbwWlonElZAgy7vfhnI3SoaL2knkUQEFE60lODw8o0BzV3KGpe81u6+QswKi7dur18VHGe+53H2deNWbP0AV/U9lUgJRI8DFyajkQ7Tt2lquulDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025456; c=relaxed/simple;
	bh=BUbDxmIS+3+LVDNt4gXFdc162Im7Vb/lYJE8YBnUZLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=En2hHRfReplPgZeKQviIbBwsbnyDG5X18C8o/UoYx2P9yh5YXZbBoNcRzOhQF3yca9P8kFbkfii6WxHBpOFxa+STAR8BwPn2zJI8K2e2MUfbAuYElnDnMUvm49mzLwmOxiMY/jzEx98vGOtPAUSfr2UTPrrwhEtN31rajlmN1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zz1lxiFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98224C4CECE;
	Thu, 12 Dec 2024 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025456;
	bh=BUbDxmIS+3+LVDNt4gXFdc162Im7Vb/lYJE8YBnUZLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zz1lxiFJS/1T2TT99lAGKqjI0uTgeHC66Kpee9RAyhndcYJo4MPsODY5kzvvGliJx
	 PTw0JLD6Ynz5laq0HRv5L6d3gGqpOAjPsDiRMttQDZCjGlCtLe2G0DTFoqYOsznUW2
	 I7LlkF9ifyLOoY78Q6I+ZLQFa24Qb1IxH0KMR698=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5.4 144/321] soc: qcom: socinfo: fix revision check in qcom_socinfo_probe()
Date: Thu, 12 Dec 2024 16:01:02 +0100
Message-ID: <20241212144235.668512506@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>

commit 128fdbf36cddc2a901c4889ba1c89fa9f2643f2c upstream.

In success case, the revision holds a non-null pointer. The current
logic incorrectly returns an error for a non-null pointer, whereas
it should return an error for a null pointer.

The socinfo driver for IPQ9574 and IPQ5332 is currently broken,
resulting in the following error message
qcom-socinfo qcom-socinfo: probe with driver qcom-socinfo failed with
error -12

Add a null check for the revision to ensure it returns an error only in
failure case (null pointer).

Fixes: e694d2b5c58b ("soc: qcom: Add check devm_kasprintf() returned value")
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20241016144852.2888679-1-quic_mmanikan@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/socinfo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -433,7 +433,7 @@ static int qcom_socinfo_probe(struct pla
 	qs->attr.revision = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u.%u",
 					   SOCINFO_MAJOR(le32_to_cpu(info->ver)),
 					   SOCINFO_MINOR(le32_to_cpu(info->ver)));
-	if (!qs->attr.soc_id || qs->attr.revision)
+	if (!qs->attr.soc_id || !qs->attr.revision)
 		return -ENOMEM;
 
 	if (offsetof(struct socinfo, serial_num) <= item_size) {



