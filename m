Return-Path: <stable+bounces-60251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2F1932E13
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07880B237B5
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B579619E7FF;
	Tue, 16 Jul 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c4Q/9hjL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315317A930;
	Tue, 16 Jul 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146337; cv=none; b=IoZbWGV6t+TVt0s8kOzi421mSsvfjTwbTwgBzINMjuMl032zt2N8v0QDbqANunhAbqHpT65XAzpk95Uy0vIJcXnolmKSIWek8VqQlYSGRjf8VZvODcjIHo05fEX3ikdv557KBL6fEWx2KCK3h4gxcszEoI4WbwNQIWibuzMvqRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146337; c=relaxed/simple;
	bh=vQ7R1NyP9LG5KWGUdEEsZRuSZL+sJm6E1ca9N9GGehk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1mTM6ZegpH2ysdDYvV1QzNjBRFn9cY1/wR8M56qSHVe0MN59N0k0cQdZ6olNLRXsmDAzhZsVLvBQTZJ7KQzBARSosXxyk9YGacgHuRyFLaJYZxocR7VsVaeXEibZ91OwoMkPwdfbA3cDwesW2Ys83b6dIhHpzy7RRzOJvGEKoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c4Q/9hjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF33DC116B1;
	Tue, 16 Jul 2024 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721146337;
	bh=vQ7R1NyP9LG5KWGUdEEsZRuSZL+sJm6E1ca9N9GGehk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4Q/9hjLzNxk+sSv7dUd77iZpFciDrr3/ytCuXQGdO9negu5v3Xp+QNwtHahIBQJj
	 Un+qudIqQrDcNJMwABIeJJhKvyb+WXsBESmq/tWC9mDYpKVAYPiyH4W2uU/++Nypim
	 Y8ROuoXygGbHvUJwzD1qjKvMOweqxEWG8kU0D7eM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 134/144] i2c: mark HostNotify target address as used
Date: Tue, 16 Jul 2024 17:33:23 +0200
Message-ID: <20240716152757.665908830@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
References: <20240716152752.524497140@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit bd9f5348089b65612e5ca976e2ae22f005340331 ]

I2C core handles the local target for receiving HostNotify alerts. There
is no separate driver bound to that address. That means userspace can
access it if desired, leading to further complications if controllers
are not capable of reading their own local target. Bind the local target
to the dummy driver so it will be marked as "handled by the kernel" if
the HostNotify feature is used. That protects aginst userspace access
and prevents other drivers binding to it.

Fixes: 2a71593da34d ("i2c: smbus: add core function handling SMBus host-notify")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 505eebbc98a09..dccd94ee138e2 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1041,6 +1041,7 @@ EXPORT_SYMBOL(i2c_find_device_by_fwnode);
 
 static const struct i2c_device_id dummy_id[] = {
 	{ "dummy", 0 },
+	{ "smbus_host_notify", 0 },
 	{ },
 };
 
-- 
2.43.0




