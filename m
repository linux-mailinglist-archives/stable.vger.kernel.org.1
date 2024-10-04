Return-Path: <stable+bounces-80847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E96990BC9
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE61C281C9A
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDBA1E9DD0;
	Fri,  4 Oct 2024 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUYXcrqH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD691E9DC7;
	Fri,  4 Oct 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066037; cv=none; b=Oy4mUik62my9mhuBMX8Cr+akyxtoKEbzhwNtzuKQgVHaaena0TRigU1vVU3LAJ7sRvbDVdymXWNo0+8AQpkQb/c2hh4/s87aWfUQeiwFXQUCaU5BE8JER2T8HRu6J+LNGJdpKAeUHsvEPhQz/6OMbQv7dNnJh6Qs1mmy/XDUG84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066037; c=relaxed/simple;
	bh=ENCQHpLFJXmKy8E8IOnryfveTV3x/VVZfFg0XmJhric=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuTXKBgrCPcup0pRfRb+41VOvssuGaChpjiiz1UUberm3U9PaXYpPtwfbA7TOtrQpcmfnM+/ZCW7xznZmPBylIC9UjLtIWuPP5P/dub6vkFOqSU4RXCPhUnZhOSEFF/BYnxLVINRTxLKk3oQZ8yfXwTPVsM06QmAyBY4eXxJ5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUYXcrqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27DEC4CECE;
	Fri,  4 Oct 2024 18:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066036;
	bh=ENCQHpLFJXmKy8E8IOnryfveTV3x/VVZfFg0XmJhric=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUYXcrqHCSYjKIkDVDH1icZcDJ5k1ynOhJDSKzD3agyz5hRtHVi0YyA7uRRafJKjo
	 qBdX6W2LwSVLXufB2cslZcXuKvKWt5WSKNna2wIaNcEmwuOA0jvlvia2Z5aCXyjUJx
	 ruWyocPUMYXeUSykIkmLypoJogY9RTVWj0YqOFUjknx6aI/w5i3utsdKDeqOHZQ7+U
	 IBtysF85BENpoZanDlJljviWm7Ffvy2W0BsZYVNZGbnqn7s0tyVLvJ1bjoQ5hEVQBn
	 2X5bKDkiFCMOV4FxJo96NAY1zr5s90Ve3NzaoSJ1vN6rlbmskGzZxfyx1nufAqJefK
	 1EkVhI8IwmdMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.11 67/76] driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute
Date: Fri,  4 Oct 2024 14:17:24 -0400
Message-ID: <20241004181828.3669209-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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


