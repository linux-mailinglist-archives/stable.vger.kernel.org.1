Return-Path: <stable+bounces-81120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F55E990F33
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F28B28578
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E56B23147C;
	Fri,  4 Oct 2024 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsNN8wrM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18858231473;
	Fri,  4 Oct 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066734; cv=none; b=KelGg5+y/nJUZy57ZHLqwg3bWtubfigSPydHv1Y0wjU7iV+v5/NADefFCZivB6LyYjj/H660dYou79C/1elSKunCivrPTeQ30y/u7Ch06cF+gdyqzXSOTcsB4EQveob+HpO0ER00PgkdiBGegqsSlJLh+gBla2y4giqtssh3eRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066734; c=relaxed/simple;
	bh=wSMyeTnnNRe7Chle8+gRu8DV1r6hE/+3YV/oU/0q4I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBSQUO8LHA/ZTBfrQnf1C35MfPHNfdXEVH3a5weV4NIcAKWsBubt6scimF/NBUCyD5/4DCbt8urDhUiLVzkIIxqF4+9QlfLeL/OQMChBtq1Gd/UacS9Usj4D21LFNXjYt6N7eSENoVcOzYZpWdsu90bVHxmocu+/gcJEqmdYWZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsNN8wrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232F2C4CEC6;
	Fri,  4 Oct 2024 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066733;
	bh=wSMyeTnnNRe7Chle8+gRu8DV1r6hE/+3YV/oU/0q4I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsNN8wrMNDkiTFg1M9fWu8BHx8me5vqUY+ozRUg2qvMRsYfewrt/MD/9jymchwnrZ
	 xKNoFLM/35QwYaLAFVwhrX5KAzTpSnYlIPmwJHHsAjUE2BJquV8G291eU1HyjTBVnO
	 apjAhYM4wcPI4in4AwzbSoaZr+zOZsaITJSoXS83RKPRJ1NU+v7VzQbwSq5vf0p8TJ
	 DYDxV421WpzdPBqxyH84LyJ6VVbQJhF7n14NiGq+dvAtjO4HYrzQ760lPmerSsD+Lj
	 n9Q1utUNsmH8hPL8Sbx19R2VlpNFSJSL8BqbdnN9+TjRFZs8ttl6/UOe6lkxI3pDzP
	 aKARW/vYaA8/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 15/16] driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute
Date: Fri,  4 Oct 2024 14:31:42 -0400
Message-ID: <20241004183150.3676355-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183150.3676355-1-sashal@kernel.org>
References: <20241004183150.3676355-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index e06a57936cc96..aad13af4175b8 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -103,7 +103,8 @@ static ssize_t bus_attr_show(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for reading a bus attribute without show() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->show)
 		ret = bus_attr->show(subsys_priv->bus, buf);
@@ -115,7 +116,8 @@ static ssize_t bus_attr_store(struct kobject *kobj, struct attribute *attr,
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


