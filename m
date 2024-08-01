Return-Path: <stable+bounces-65195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E133A943F9D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17DE280E38
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CA68F5C;
	Thu,  1 Aug 2024 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLqiCuJO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3515853D;
	Thu,  1 Aug 2024 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472816; cv=none; b=EfS0g0mGTIeBIWxQrZr+1lmmYOHukS4vp4GQe3TirSbZHC9ojQ+LvgpwIIBTgMCCc2gkEfJcNFnDLoJ9nzTl2/LEz0Ny32DBicezy4xQzEaiX5xw0hUaD4AbIRM8pr5PedRuxil73iNUwZuE5ML5Z1x7zauz6R0RFmmFY/747JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472816; c=relaxed/simple;
	bh=0SQiW/QsOIHnN8k7ZgzCKjwSTCpLv9uEgLI/56K/59o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuGS4IAg3x4ZDsCJTocUz9eGWS6TpiS60izPnQzoNJBnaoqFeNr5Af9J060lsGTtmhcqWk0N/msMhgOTFsgmHUFNDg7SKIvxNvts++bqUW0JJbFwMHxSPvMmcbl6Yu13OjzdpWgO+8QMO7obDkR68g/z215XesN81ZmrIRh1Jng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLqiCuJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB5CC4AF10;
	Thu,  1 Aug 2024 00:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472816;
	bh=0SQiW/QsOIHnN8k7ZgzCKjwSTCpLv9uEgLI/56K/59o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLqiCuJOnSm6FT0ct81exoH+5PAtWv8itDOj1PhXyv4vUA3mz85rC9sfYu9XxEcW1
	 I6ohtcsU7as+aEfq42TVnkCYbv/FD9eXB3URQPctNUylR3Ir7YodMPWznm/XZXvMnE
	 1w0twYFd7NbZRod5SxLug1VUEAFnLObY/Rg5TlevZFHoQugGsjhWQvPEE54TUzqMGK
	 QhqQtq16JA1LmqYzHimPEzrX9RymV0pUQBEOoo2DwwO7TEoBRluSeOQH8yYYIR0t7K
	 W3vLejkAZyMGJtxKnhVu7no5XJuYqs4AyIof2IpbeynCcC9Ak+KeRSHkyTIWFlbI41
	 xqR1yxJAi6Osg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 20/22] hwmon: (w83627ehf) Fix underflows seen when writing limit attributes
Date: Wed, 31 Jul 2024 20:38:49 -0400
Message-ID: <20240801003918.3939431-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 5c1de37969b7bc0abcb20b86e91e70caebbd4f89 ]

DIV_ROUND_CLOSEST() after kstrtol() results in an underflow if a large
negative number such as -9223372036854775808 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/w83627ehf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index eb171d15ac489..e4e5bb9115584 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1506,7 +1506,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->target_temp[nr] = val;
@@ -1532,7 +1532,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	/* Limit the temp to 0C - 15C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 15);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 15000), 1000);
 
 	mutex_lock(&data->update_lock);
 	if (sio_data->kind == nct6775 || sio_data->kind == nct6776) {
-- 
2.43.0


