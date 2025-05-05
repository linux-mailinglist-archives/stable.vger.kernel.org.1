Return-Path: <stable+bounces-141337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30816AAB29F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2ACE1882E3D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918B937A28B;
	Tue,  6 May 2025 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epuufFxc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59536BA57;
	Mon,  5 May 2025 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485820; cv=none; b=CT1uGeXwpvDA5BSrFW9VG05ZyRMSHCu6BNEHwpBm91eSQncHC1l8Ais34NHu6ZJnysasYq3OkYgxqRknKJjPSm7+R2NDtCslDdrFRdx5lnn2f/SMm38zp+tf+aaEgwhF6UUgSewTKPtfSElzKx5OnpL+n3TqLjiwopvO/pktY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485820; c=relaxed/simple;
	bh=Eu+imOLVi3odg/wSjq9w2olldKw2pM4nidzA1sAy6hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckMi5Df+FlFfXqNK7Cu3EJnQEleuslQ8ws8UZe/xUDYO+76BqAW/JWyhyOn2NP7BisAb8T3LRhLayy+EUOEhi5PRXW/KmU9WxMfl+p3dVuwOUZ2PmmrFlesB4VLIXKdDsoNpY/i7yQnE3/zZyCMLD8kFOOEGcjbRcbybXK/daIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epuufFxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A166DC4CEE4;
	Mon,  5 May 2025 22:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485820;
	bh=Eu+imOLVi3odg/wSjq9w2olldKw2pM4nidzA1sAy6hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epuufFxck13wAQOUkO5mRcvbad7xT8c+LfAUvsSrQAbVW+6n/xSGfeXDlX8xLR4uy
	 oIS4pwiu8Oxls34U7FeUZRCrgOe2rzFppudkwg6i1fhfeTtIP0csDk34HVMZb1GD1D
	 uG+l0Q1OygU7Mbp1miyCpVRKYICioP+STt3EbiG2kjBf/u+1yMwyImit3igntNAmGk
	 Rh0GAAJaBqGzJleerYYFT9ysLl4fbGJj4dQYVMPul28DinIq4KTHVmFzCdVSO+XCr3
	 qJ1UN1mfnfTZFOudcl2ElmVI9ilEmteVSWSDngTPslI6pGZgTUu2Us+RY2D/0VmpA7
	 SM3xKa2sud0Uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 015/294] mailbox: use error ret code of of_parse_phandle_with_args()
Date: Mon,  5 May 2025 18:51:55 -0400
Message-Id: <20250505225634.2688578-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index ebff3baf30451..f13d705f7861a 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -415,11 +415,12 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 
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


