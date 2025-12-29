Return-Path: <stable+bounces-204106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99020CE78AF
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C059300DB94
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C76C334C0A;
	Mon, 29 Dec 2025 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UJj5Hg1S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD07331A45;
	Mon, 29 Dec 2025 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026067; cv=none; b=c6kSkF2So3a57l0jV+y7p564Tp2iMhsCEftbHk82dUSkDfhkuyNfvuSu153KFqCC1UhPyb1/QfjUzG0btYOeVDg5MB/ivSKgzX8tks/KYnsFbJkp2jlBAcNmtrm+/L8DKF6Vjn7pD87ZGpQQ/wEiJ7YcZgpv/UKRvWGztcKRhgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026067; c=relaxed/simple;
	bh=PnfH1ZWCXfxD6MxOFS+HAs3hfJvmY1zLeuN9Up9qYHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKOxoiJtrpEIOVgcsBS80opnt8oZvrGiKvez622KCRIozjmeZFZ1I9JdvxLe1ZAizhhN6EHRpjMOt434neDajW+kVUjg5tmizLLu9hC3YR8Vyph+zVPMo2d6848JT41a6WHOke8nkHA1Dedu+Q2mNtSNdoN4WAJJxdjdOHX4dbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UJj5Hg1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B69C4CEF7;
	Mon, 29 Dec 2025 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767026066;
	bh=PnfH1ZWCXfxD6MxOFS+HAs3hfJvmY1zLeuN9Up9qYHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJj5Hg1SXtvjSxZD7WhnzEbnOygkj/aY+MDdxiGVxQBVr9h9Uym6w2tPTHJUrEg8s
	 WvCBpd2v5K1z4rPm2ZQ8Gs53xzrFbpVN4kSLfiz4Iy3vEhNePa4NKbKzcy32BEVVM0
	 aN+GN9miJRHJitLcaC16xCRyfoBdjDn1Xj6doypc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.18 420/430] hwmon: (max6697) fix regmap leak on probe failure
Date: Mon, 29 Dec 2025 17:13:42 +0100
Message-ID: <20251229160739.767643530@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 02f0ad8e8de8cf5344f8f0fa26d9529b8339da47 upstream.

The i2c regmap allocated during probe is never freed.

Switch to using the device managed allocator so that the regmap is
released on probe failures (e.g. probe deferral) and on driver unbind.

Fixes: 3a2a8cc3fe24 ("hwmon: (max6697) Convert to use regmap")
Cc: stable@vger.kernel.org	# 6.12
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20251127134351.1585-1-johan@kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/max6697.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -548,7 +548,7 @@ static int max6697_probe(struct i2c_clie
 	struct regmap *regmap;
 	int err;
 
-	regmap = regmap_init_i2c(client, &max6697_regmap_config);
+	regmap = devm_regmap_init_i2c(client, &max6697_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 



