Return-Path: <stable+bounces-199200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086BCA152B
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E6D530198A0
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0E7314A91;
	Wed,  3 Dec 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RhwOH3dO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8A3101A2;
	Wed,  3 Dec 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779019; cv=none; b=QoTPf933gijE/0hgL5dkCgjGGLZyEbTXBjdmYeyfPQ5h9ZOpESb5jM/IrNJ7y9x+3vEM8IrM/99I3F9lKYTdrFKSLOcHv7FqDP8aYbqF6fqH/Eksfsba43D4XSdZ1pqzNEKvClTMsz8Ko1PoUFm8EOC2MBPonPV3VdDeTHBQQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779019; c=relaxed/simple;
	bh=Fsbo+YOEbw+HhTFVZVonTgh9SwPwjkFEUYci+8imqp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYTLFLGGTYWUml8EaBse9xBA3zQEq8ZJCmrA/oUC80hw0KoV4vQGI3zXT6H5O07Gif7DmdlMW7JfbCpIfKMh6Og1Q84kJDzY7HqCwhcb3zts9DdP5/Pf+yBE+0hQfwhsVquyVX+KfnHRehbFfHU7+ypbGHiAb2DxNGbZCsDxnCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RhwOH3dO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234AFC2BC9E;
	Wed,  3 Dec 2025 16:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764779018;
	bh=Fsbo+YOEbw+HhTFVZVonTgh9SwPwjkFEUYci+8imqp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhwOH3dOkX0NvxuXJ/c2MUcddpbCgfI0TqXaB1ZyYxIHeEUPdCG4vB/69maqR6oII
	 enNHiwpuGGBy+skhct15W5enf2GBU+RFZocPBu2Am1WYDB4TGIiWAXCYtKNOSXK/AQ
	 WnGfUoi7JoexrZfUZCYtNXArT9tb84m709GB9zU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/568] mfd: stmpe-i2c: Add missing MODULE_LICENSE
Date: Wed,  3 Dec 2025 16:22:12 +0100
Message-ID: <20251203152445.490150385@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 00ea54f058cd4cb082302fe598cfe148e0aadf94 ]

This driver is licensed GPL-2.0-only, so add the corresponding module flag.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://lore.kernel.org/r/20250725071153.338912-3-alexander.stein@ew.tq-group.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmpe-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index 4d55494a97c4b..8c36b7d122856 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -139,3 +139,4 @@ module_exit(stmpe_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("STMPE MFD I2C Interface Driver");
 MODULE_AUTHOR("Rabin Vincent <rabin.vincent@stericsson.com>");
+MODULE_LICENSE("GPL");
-- 
2.51.0




