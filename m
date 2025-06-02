Return-Path: <stable+bounces-150060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC82ACB5CA
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7676B9E4321
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0422D4F2;
	Mon,  2 Jun 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bn0g4aS7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962822D4DC;
	Mon,  2 Jun 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875907; cv=none; b=Zql+EeXzDkO1BOvpugS28gW7zKn7Qi2+dYddK+LQaa/SgvjuL50PBPafoA6qdkOYs5gfTSR8UqF5wZmPBrUAu6zAPbah4jayJAvGrNdePTwlNkeYa+tMTkjN/eped433oqeSQAqUheJMRd1taOAw3VR+O7xa0i9ehnt+kHLgIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875907; c=relaxed/simple;
	bh=rhz4r/5nkX12wTng6NxwxrLKNSd04mSsYThJO223ex4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNHyAnVTdah369i2N5U5P7/ASFKR2eVX/FlwPg4Ds9pmfyvzsRwR9wKqEfHQ+jNVm0Nx+VgxDK1iUXgGdHpAjh/aK6UTfIuCgBGE0d6ov6rdiuo2T+XfDXiD9IMla5zmwr573N4eIoxIg7U8c5R+fnDwPhufR4Obl5EKZDJGVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bn0g4aS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9AFC4CEEB;
	Mon,  2 Jun 2025 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875906;
	bh=rhz4r/5nkX12wTng6NxwxrLKNSd04mSsYThJO223ex4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bn0g4aS7n+/M/CNjbtwih0DOE3f/Pn/LiqjVypSLrMATINa2z9sS8vSlWVSiFzw4Q
	 d/JfAlBzSb7Df5HT6O4MEc3bTAuNkgEb9Yy1xL0o189ua09vhayz2R+XsPw9OCga3G
	 9PNi/oaaxatpRXOmkkewcRrkN/HrGWkkkElhyLS4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 011/207] mailbox: use error ret code of of_parse_phandle_with_args()
Date: Mon,  2 Jun 2025 15:46:23 +0200
Message-ID: <20250602134259.217705738@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tudor Ambarus <tudor.ambarus@linaro.org>

[ Upstream commit 24fdd5074b205cfb0ef4cd0751a2d03031455929 ]

In case of error, of_parse_phandle_with_args() returns -EINVAL when the
passed index is negative, or -ENOENT when the index is for an empty
phandle. The mailbox core overwrote the error return code with a less
precise -ENODEV. Use the error returned code from
of_parse_phandle_with_args().

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 4229b9b5da98f..6f54501dc7762 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -350,11 +350,12 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 
 	mutex_lock(&con_mutex);
 
-	if (of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", index, &spec)) {
+	ret = of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells",
+					 index, &spec);
+	if (ret) {
 		dev_dbg(dev, "%s: can't parse \"mboxes\" property\n", __func__);
 		mutex_unlock(&con_mutex);
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(ret);
 	}
 
 	chan = ERR_PTR(-EPROBE_DEFER);
-- 
2.39.5




