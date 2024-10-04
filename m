Return-Path: <stable+bounces-81021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3236D990DE8
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAE8288E9D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA3A1D9694;
	Fri,  4 Oct 2024 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L81UAZ+0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882B21645D;
	Fri,  4 Oct 2024 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066506; cv=none; b=YQE/dgCuCOlIzGkhMct5ocZ+LBWwViZYIC3NsCtjhS5gSMDaip8tF5sNNoUmm6EdL6o+ss5fHUPr17mdzXtNl1dMU4SmWt8wOmR8y3YFuARmOznAZDb5EBdC/6gaSOm8+R/R3lFMC+L7kqNL+KLygYFj8ncFIWfQfOvts6lfNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066506; c=relaxed/simple;
	bh=Em8xFEw9ZGQ62GUaT5jaqgfRaPhXK6rLuOte961+mYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uol1tiQNg8HVvphOKQYYMbQuJ3imAVEX85EytP3vBZ4NQBY34+mcRxnbvKD1L+HUcTidvzmvhtgtEJGoNmmd1HDXwq5csl7aXxulF2G/iBCuly2vuYfMfh5DBtv/aB/taTF5vZwifd1O1D8G6682yvmbTdRAqvI0VQrMOSC34vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L81UAZ+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEAEC4CECD;
	Fri,  4 Oct 2024 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066506;
	bh=Em8xFEw9ZGQ62GUaT5jaqgfRaPhXK6rLuOte961+mYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L81UAZ+0BzftJ1KjwetGZrkEksNui3tOE+YjybMIevgmtLmYZZbKB63XvQzLeK7aq
	 pE3DHV5VJFSt15Y4lPVoAfnWcqf68qin6vu/DB1znMVwNsOZw7eJtiGXbhqwDdfb/u
	 8A6qBp6VcKIroGx4UXSmDs4JRSzQtM80AcikSdBBfc8Lrn9K2eTNcdX7XUpUvJb6lM
	 ufTQSmRPLKaBGKEeVmkr7GA83+su6BrMhUCFpu+0mC8KEdZ1AgFF6CCC892DoKFLxF
	 aI+KMTqKvXDWkplw2JBQAMY8BKfNKQnR1JvKSeKiwG/kXz4KUyoX9DbzU7qpdk2Q47
	 XZv/hEwvuz7MA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 37/42] driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute
Date: Fri,  4 Oct 2024 14:26:48 -0400
Message-ID: <20241004182718.3673735-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index 7ca47e5b3c1f4..339a9edcde5f5 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -104,7 +104,8 @@ static ssize_t bus_attr_show(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for reading a bus attribute without show() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->show)
 		ret = bus_attr->show(subsys_priv->bus, buf);
@@ -116,7 +117,8 @@ static ssize_t bus_attr_store(struct kobject *kobj, struct attribute *attr,
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


