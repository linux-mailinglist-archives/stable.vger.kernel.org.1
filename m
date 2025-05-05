Return-Path: <stable+bounces-141048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C797DAAAD91
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0DA16FA92
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4D130A804;
	Mon,  5 May 2025 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMOoeNLb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0DB37EA88;
	Mon,  5 May 2025 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487318; cv=none; b=ZkRYI1jSZk6Cv3mbJQL62BwS1NqurwPMGjOb+T41v0wrYTKD8JuI0HyK67lHXKzle8O/1MELuK1f3mXdGr5X8iGd8TMYtnqJDpQpJDg6kGuHRQnsvE7HBzc2HBCZqO1IRw+UJdAlPgs5LKqCQFxioeW9r2EsATFGGT0lgMsXc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487318; c=relaxed/simple;
	bh=zEWgyvgE0K3/6juLqJn8ugmpW06gemNbsD2fMXiHnzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b47tNzJW03PRVRHjwU7Y4V1AjhSbLAADgBWXytwq5MuG4Azpjz6D5blfDiexqJkVYDyE5PkPJ6ZPtasvrlAU/u4KJxN4KvkCrsG1FsspbFcW2/S3CzQx+YO1i/Pb6NFlSmgmID4g9WkPZN0zUElRO4ccclAY+/EEtdgr6Rwo1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMOoeNLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD18C4CEEE;
	Mon,  5 May 2025 23:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487317;
	bh=zEWgyvgE0K3/6juLqJn8ugmpW06gemNbsD2fMXiHnzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMOoeNLbKASS6peXeD6ID1XEvrEj4xxPeTo/uzuIaYQuz4/oWgOOm9rPuqaqHlrJ/
	 3dDqHWmwNi0+/0MDBpkmIfpfD6UuS5rgkZ2e45wZwb8ujoo8/uCw4b11aPUi/xbqX7
	 JPFzafWaU/paXNZsHWr7hIWhpKPjFGVVtk9p0+gDTkIuNiFYdR1mplKxWjwNzVzOBQ
	 LSIRJuTaFzVtt6Zay/cdwKe97GSIFEFeLIy4/O1vIg614VBhbirmZh1GkzuCHSmY6d
	 35NHpbynTOCg5Hpg34pYKjwz4TTDoD3pbwrmkSsrNQsLyvQ90p+ojWCTlpLreCRP2g
	 UMkm8KBBy7hzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 02/79] mailbox: use error ret code of of_parse_phandle_with_args()
Date: Mon,  5 May 2025 19:20:34 -0400
Message-Id: <20250505232151.2698893-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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


