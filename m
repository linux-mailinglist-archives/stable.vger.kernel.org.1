Return-Path: <stable+bounces-57149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74F925AFA
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA23D1F2129D
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A303181318;
	Wed,  3 Jul 2024 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pqr8S/AL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969E17E8EE;
	Wed,  3 Jul 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003997; cv=none; b=sQOCeYHuGe51VYrdb+TnU9cQ/xYQ+IMN8s3y0o7ZzLNwR0NBJ6u1UTSz0gVkTyeOOIyapD/46iY8FVvJ1N74kqTGxTS3EzYuUidBhbxOjaxZqCZuj/UJV9oVPsp0+V8q6w03pDrlJArHu+oYfgK/P/JG1B521C9uNzEqtZpeNWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003997; c=relaxed/simple;
	bh=pAp+/O7PaI2omsuc56hr8IpuQagb8XJeZH3Je3gFtrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0cRJK/wXXTg/wT7R0IJdC3Wue/bUcCceX3TpD4SOima0qiGH9kpmFpEHAktUQ605SGqrweF624Rzxr3D7OEfR9EuWWX4kBR98TRQ9Bv4AGIsrmIp6ZOYalj6HYD0hr9tkRmLdyxWgoC9UiWJ4jOTCvIsfpTDAaHo3erN/4u4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pqr8S/AL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC18C2BD10;
	Wed,  3 Jul 2024 10:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003996;
	bh=pAp+/O7PaI2omsuc56hr8IpuQagb8XJeZH3Je3gFtrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pqr8S/ALtY0dOZ9noKi0HgZ4uhRymAZQV1kiUmlR2obhIEmR2CO8hcwp4Tx0dIE1m
	 BTFuRqoclEsZGszC8W1yHiZs+NsjShDchW70DRIpFZWco+rv+7iXZAe/DLu3oPwWwV
	 PQ+Rb25kmAdVkvc2cjqfG/lJ4jWW/+Mdz1ur/HkA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jean Delvare <jdelvare@suse.de>,
	Juergen Fitschen <me@jue.yt>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 088/189] i2c: at91: Fix the functionality flags of the slave-only interface
Date: Wed,  3 Jul 2024 12:39:09 +0200
Message-ID: <20240703102844.822953172@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jean Delvare <jdelvare@suse.de>

[ Upstream commit d6d5645e5fc1233a7ba950de4a72981c394a2557 ]

When an I2C adapter acts only as a slave, it should not claim to
support I2C master capabilities.

Fixes: 9d3ca54b550c ("i2c: at91: added slave mode support")
Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Juergen Fitschen <me@jue.yt>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-at91-slave.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-slave.c b/drivers/i2c/busses/i2c-at91-slave.c
index d6eeea5166c04..131a67d9d4a68 100644
--- a/drivers/i2c/busses/i2c-at91-slave.c
+++ b/drivers/i2c/busses/i2c-at91-slave.c
@@ -106,8 +106,7 @@ static int at91_unreg_slave(struct i2c_client *slave)
 
 static u32 at91_twi_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_SLAVE | I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
-		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
+	return I2C_FUNC_SLAVE;
 }
 
 static const struct i2c_algorithm at91_twi_algorithm_slave = {
-- 
2.43.0




