Return-Path: <stable+bounces-80917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5628F990CB6
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CB71F23C05
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672631FD2E2;
	Fri,  4 Oct 2024 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvlZbuJi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237BB1DD873;
	Fri,  4 Oct 2024 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066239; cv=none; b=lM7PPgqR6mWRFS7+bvIvxTITpo+as+UHVBr7+n1MIcnutBHpXubeUOcRNR01U0WmfVVNW6dcJ4Eu/1/JyGZnm1dnq6HH25O5S5hI456uPzHF3NCbjX9ciMFUaq562BMJj6vTLYtMyNoZktrysyq6mBqZgZfEHUvC4KOL/XVKaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066239; c=relaxed/simple;
	bh=ENCQHpLFJXmKy8E8IOnryfveTV3x/VVZfFg0XmJhric=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0xRbkxViFSFji6uJh0A4MMpPEBDpCJ96tbvas0D2/URkESCSI37t+Ro6fiIvMnjR9PJSNG6ouRfsLDzUsdVPR7NZMgzzO2VDxVSPaiVaA93tXI7x/U8NfyO3Z42hW4RVMvj5V6rrEavF4uQAdCiUHdA2RxSbkgpsTy+4AEb8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvlZbuJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E5EC4CECC;
	Fri,  4 Oct 2024 18:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066239;
	bh=ENCQHpLFJXmKy8E8IOnryfveTV3x/VVZfFg0XmJhric=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvlZbuJiGJw6gCJtBb7qscZWZA6sbH1fCVn/BxosesHuGHBpWY2S/+jgKDbN8EKcL
	 FwKJRhwv2W3/n0DljowHHaps3hpaKwXOICrhDw31UKzUFm4XBkI4pL3o08ZwymRriI
	 wgKT2WT+LMgge/SrrAyia8nd8+Mmo9BU4fvuLBekS3sTX6T7v8WFJBt61eRVRP48ci
	 FRc4KpVYZtR/EMX1YlSCpCv457KFWYgjPG7zcQbvIzkAch/lNT595aTImdsGitSJUX
	 Nl4h0jm08s1phcR86hFJuKPceIvN7HYX7CyrpUtT07Sp/1myG8RFqs8OMvgscv9ba5
	 KBh5nZLrcW0OA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 61/70] driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute
Date: Fri,  4 Oct 2024 14:20:59 -0400
Message-ID: <20241004182200.3670903-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit c0fd973c108cdc22a384854bc4b3e288a9717bb2 ]

Return -EIO instead of 0 for below erroneous bus attribute operations:
 - read a bus attribute without show().
 - write a bus attribute without store().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20240724-bus_fix-v2-1-5adbafc698fb@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 08362ecec0ecb..6a68734e7ebd1 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -152,7 +152,8 @@ static ssize_t bus_attr_show(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for reading a bus attribute without show() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->show)
 		ret = bus_attr->show(subsys_priv->bus, buf);
@@ -164,7 +165,8 @@ static ssize_t bus_attr_store(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for writing a bus attribute without store() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->store)
 		ret = bus_attr->store(subsys_priv->bus, buf, count);
-- 
2.43.0


