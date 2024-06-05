Return-Path: <stable+bounces-48205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8168FCDAA
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFF11F2923E
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C101ABE5C;
	Wed,  5 Jun 2024 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZnL6RGT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804171ABE51;
	Wed,  5 Jun 2024 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589136; cv=none; b=ehnev7h/FAHoFYopC10Hp03WPXvaFrsgzJYqgXnxzOY42TUObqcBvFZmeGD/y9tThAdOlKspMdqhfKcMb9z+NX1P23tOzXbCzIM2JrhJDYhAh7csoWpkZvfSmqb6aWsuLiaZpPHgscnoBcFfHcWXe6w3kKd+y6M5s5WmAhRTlQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589136; c=relaxed/simple;
	bh=dRcy6OS1IofzbD1NjQE76rjD0zXix+SxVmT62c0IwPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDjwm94UyJR6SRMq+X4/ud6+3nZ4yx5lxfnA4a7ORXTvuUyMf4t170qnUdjk+Q1O8mMAN7YeFyhhHduzP+tKniazOgEn08TnR+3PTyKTGbF9Xgv7nMKpepawrvmb60qn/dvjDZS/JpJ+kRvy2b1JSFFfJi6qQXu+pgnNidmwA6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZnL6RGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7540C4AF09;
	Wed,  5 Jun 2024 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589136;
	bh=dRcy6OS1IofzbD1NjQE76rjD0zXix+SxVmT62c0IwPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZnL6RGTHnjXjS58b7LixhFx62X8+UC31o9jlo4hCUEZZNCUzKCCvKcImLhY/cXPw
	 mc8tWdJPy/2dVd2xlohTzY6J2xqbpa6awoi/138ewmX8mV1bE5jn014f3QD6Ht3Bxg
	 NXfZTHuSUUGVNxnIC9Hyw8lObSGiXO37yL/WAOYiCFt4RXe9KPpirdDEkyuOLGk+It
	 AbnCajnmfX0ys4+jmWvRLO24AsEB33IDw4ZL/epqb6r3Vyp0GvujsaciKDcpKZDZZI
	 2PRNANAwpNgSRiVKzTXqbgUCsdIBdJKJ+ixDztLxPRozDJvlyZKrzmQRFrE5Q0bu0P
	 1cO9fzLTU58yg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jim Wylder <jwylder@google.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 5.15 05/12] regmap-i2c: Subtract reg size from max_write
Date: Wed,  5 Jun 2024 08:05:15 -0400
Message-ID: <20240605120528.2967750-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120528.2967750-1-sashal@kernel.org>
References: <20240605120528.2967750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit

From: Jim Wylder <jwylder@google.com>

[ Upstream commit 611b7eb19d0a305d4de00280e4a71a1b15c507fc ]

Currently, when an adapter defines a max_write_len quirk,
the data will be chunked into data sizes equal to the
max_write_len quirk value.  But the payload will be increased by
the size of the register address before transmission.  The
resulting value always ends up larger than the limit set
by the quirk.

Avoid this error by setting regmap's max_write to the quirk's
max_write_len minus the number of bytes for the register and
padding.  This allows the chunking to work correctly for this
limited case without impacting other use-cases.

Signed-off-by: Jim Wylder <jwylder@google.com>
Link: https://msgid.link/r/20240523211437.2839942-1-jwylder@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap-i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 3ec611dc0c09f..a905e955bbfc7 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -350,7 +350,8 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
 
 		if (quirks->max_write_len &&
 		    (bus->max_raw_write == 0 || bus->max_raw_write > quirks->max_write_len))
-			max_write = quirks->max_write_len;
+			max_write = quirks->max_write_len -
+				(config->reg_bits + config->pad_bits) / BITS_PER_BYTE;
 
 		if (max_read || max_write) {
 			ret_bus = kmemdup(bus, sizeof(*bus), GFP_KERNEL);
-- 
2.43.0


