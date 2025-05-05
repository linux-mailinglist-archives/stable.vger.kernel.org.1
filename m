Return-Path: <stable+bounces-140819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD9CAAAF38
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FC97B0B46
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7283B3BB1;
	Mon,  5 May 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pkqt+POw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EE1288C29;
	Mon,  5 May 2025 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486407; cv=none; b=f7pfcto84QFJQs5C42trLhRgIx9qzciM1XFb/irzi+XZFy8VYZFDKKarlakJdWZ4T2atQmPbB1N8PhGbcV+2smupZpf9TdQkPpkBa6mW2YoNW0GRagLZq5Yl+zxcL6zZfzNRA34RKC/UvxOe4DKOdUdBzB3M8CA0LrqpzUYSME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486407; c=relaxed/simple;
	bh=zEWgyvgE0K3/6juLqJn8ugmpW06gemNbsD2fMXiHnzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqY9mkY/kvrhF0wqyMjAs+o5g1DIsLm7TxnXpOpuyuGLEIEOEZjzT1HZXGdo9RD0Cn4bVs9krvWO8MBm80M2gZP01ets18kNvbZ2Vux3xHjlBok6lqJZxwYLnfnc9QJL3A/04y1QIdjlvfkH5Rxli0UkLgO2y9rrK8Bmq/Jc3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pkqt+POw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45597C4CEF1;
	Mon,  5 May 2025 23:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486405;
	bh=zEWgyvgE0K3/6juLqJn8ugmpW06gemNbsD2fMXiHnzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pkqt+POw8OFS+cUjFhbDIWLBsudRtxjNfd3hFdcL6EpUToCEv1Wykvu6Ayi5dsI04
	 PxFDXmdRPkwGn+XABxoav8nVgks9jVRsMo0LTc4WXth8KpoWEXP+WaP7ogqTDwFfoC
	 MHqE8SXDOTpLLizXTsiu6qK6X0R8MaXIkYflWLttg4cdBzN+3woicjIm7pP/O46hgF
	 4fPRYdyp5xayOcLsES83Xy2ew3Yv7dFy1gv/89ozBycHdXBkBU8h/2SMMOSVsmwlXh
	 7HpSX4NKXM01bqPk3O+TK/RYIArWWAIj7FzQWf9UI1HiBgOsM9Rktu35YOf2xgvPcO
	 tTM3q8mn6X1zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 012/212] mailbox: use error ret code of of_parse_phandle_with_args()
Date: Mon,  5 May 2025 19:03:04 -0400
Message-Id: <20250505230624.2692522-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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


