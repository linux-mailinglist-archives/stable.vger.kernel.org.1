Return-Path: <stable+bounces-81104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E93990EFC
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3510C282703
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6617622E2BC;
	Fri,  4 Oct 2024 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAcFoaz2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B622E2B3;
	Fri,  4 Oct 2024 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066700; cv=none; b=ZCuh7gEAeOTmyRyMtyLvMDC3wVVAosKvT9zHAPS8ldTPL7ornCnHQLb5t/swK8/OspN8ZXCTjjpqi8nenkAX2313C0U3xzwNCW1Jpod6qRGxT75fOl+mBX7rJl93JpjSj8ZZckZMsq8NPktq2TOudCbO3scaVLJG1hbaWP3m54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066700; c=relaxed/simple;
	bh=yYHq7xNveiDsE3Gbt9wmgizCiBRBWqnRzYhdreKXSOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtdT24jHexvlZ5uLtVXN2ETWFOBqclbDXD1Lh7y1B+LdhXqLzr54omNfyLyPajkjffQV4SuUsDgYxIVMsWkNm+NkCLigKL6/aktGeA/R+O3wAvZ8gcELe0wZ6zaMYCIhdho18EHC4qwluHk/OubdbopMgh50W09SzX2yI8lq3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAcFoaz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E053C4CECC;
	Fri,  4 Oct 2024 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066700;
	bh=yYHq7xNveiDsE3Gbt9wmgizCiBRBWqnRzYhdreKXSOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAcFoaz2p5Q9EVZ6ssymx/6MHWOn82E6qgm+41fF3/pxvUEgs6VPcdhO/IMvpHzCo
	 Y4prMIuH5kXb138kVOor9BFbnC6saRWiMUrXMEOscR8MNwpx4mHeHPyD+4JQvyEiYo
	 Jm5J/9328Dp34IcD5WJaROXuudIRyglNMb+5GW1K5h7SpO+vsXQMghIHUlx7ZP4MnQ
	 csXsz4OX6ahfaEEVlRo827a/cxqrfBNi2rYfKOGp7L38efnpSpgC2weFSN1pI5j4yG
	 0l4hXLcOE8Hp6q3V+JTr3Z3M66Vn6LKyzWvXZA0Flf6rZBdv8DU6H7TTSete0zsUOt
	 8I2wQJxWCcJeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 20/21] driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute
Date: Fri,  4 Oct 2024 14:30:55 -0400
Message-ID: <20241004183105.3675901-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183105.3675901-1-sashal@kernel.org>
References: <20241004183105.3675901-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index 7d7d28f498edd..f970a40a2f7ad 100644
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


