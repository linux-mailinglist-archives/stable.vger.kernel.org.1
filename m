Return-Path: <stable+bounces-141587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08EFAAB758
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A7A4A5FB6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A842F1CF1;
	Tue,  6 May 2025 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG7AAcCn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F172F22E9;
	Mon,  5 May 2025 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486810; cv=none; b=AAeL1n32JINQwzzm7ypX1MSpREK5W++RlyjpM4ylUkvV9K5y4R3kEmx1PHLYd11aDAWy78L7HyOVuGsnn/8PBWFQvOqKXG11KD2TImh8GFGiP8NBXAMVErJWl/NKnpsvZlnXEG7Lfk4xF8IctuG8onQSqRAf/13W7csBn5Wae9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486810; c=relaxed/simple;
	bh=zEWgyvgE0K3/6juLqJn8ugmpW06gemNbsD2fMXiHnzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSeOCeyuOc6IExcXm+uNkGCXTGzxGyiqV0+u5qQF7VoWYTzjpUAq9cDFGN6D2E7Uxwr0ZBLS2MUSINDEM29onHGNZbXsd4WNejBa8UYdUvDv8WHZb4F5F45QxRNr0zKEAEpxAJN7rh2kNFHxoTDAxXazrSpnHWlwNP7LfzYBnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG7AAcCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8F0C4CEED;
	Mon,  5 May 2025 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486809;
	bh=zEWgyvgE0K3/6juLqJn8ugmpW06gemNbsD2fMXiHnzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mG7AAcCnTKV10J51E4GRHSz7/XXXyX+ObT9E3gKS6vMf8skw2v4M7+MAcP3mO1yKV
	 Y90cMNJz6Wmb4SODMTLCYK5ZT+XpX19DCxb6vev/m4ZQA4Tn7OGGOYoBlIMnyvTCRy
	 4LZ8pJpuUHlfCbtqZHc5aO88sunZgfjTNOKVE+RoJFDSWCwnS+cI+Hn5sQh1sSI3Mp
	 EOOcq5ubXCDNvj6a2TR135XlITLntuWSjB+WKL3UTvflLUrt38bUh85aOSY7lgxwBk
	 n42KzIu1RGc0vBfj43UAmXNrl91oO2d9mxnmFns5ZaGmyBl5NoG02yx42SH3FizgDp
	 X5vtMO/15SehA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 004/153] mailbox: use error ret code of of_parse_phandle_with_args()
Date: Mon,  5 May 2025 19:10:51 -0400
Message-Id: <20250505231320.2695319-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

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


