Return-Path: <stable+bounces-160535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7527AFD095
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329F448283D
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C562B2E091E;
	Tue,  8 Jul 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R8c29Vwx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C42E543D;
	Tue,  8 Jul 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991854; cv=none; b=l9fd0e1XkAPrd6ImQz/MnHIOYa65cdpV7Sc8WxXNOFP5o0tU5lZ1rpfrOJ0oGPUIIpHTaQy6GffGeYxd9mSgbqY4XEP5pHAwrASrv4HrMRRmmVH4LydPQlalgm8DASufZ/LHBHHULZfHPZInfmvih8rRBWJ9ZDYg9DMp37++yhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991854; c=relaxed/simple;
	bh=S9aByOSOY92AJlpxzbwGllzyNY92HL9l9En3wG/2ifg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3gZANiZ9AknXBzINw2R7oeCfxAsceKxRwH2JyViajPqHPwm+cmOIDsQ1A00ofmtNIZCGx2wyejBI91r4jomn1FioIL5yg6CAGh7Sxwr5x5gcJQC/qey5gKdYBFy0D7sx7K+8r9vaDBSo57jzILs7bYKhrLFqcXrIoYS8RRoy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R8c29Vwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86BEC4CEF0;
	Tue,  8 Jul 2025 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751991854;
	bh=S9aByOSOY92AJlpxzbwGllzyNY92HL9l9En3wG/2ifg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8c29VwxM2XguBxRRtbOheUZuZc+T2SMaPOV62XQrbddfO3aY8cyn4JxKtoLhsbXz
	 SezMGgqbE8upmRkTRik/gxcuR0QgYl9uVvCfkecRVcQC/1YJ2lDwvyxY3y8Xi/jOQY
	 05ZcJoE9bbPSYYF2Xlsr2DsaE7kLPusZUdHkAqCU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Elena Popa <elena.popa@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.6 002/132] rtc: pcf2127: fix SPI command byte for PCF2131
Date: Tue,  8 Jul 2025 18:21:53 +0200
Message-ID: <20250708162230.836575145@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Elena Popa <elena.popa@nxp.com>

commit fa78e9b606a472495ef5b6b3d8b45c37f7727f9d upstream.

PCF2131 was not responding to read/write operations using SPI. PCF2131
has a different command byte definition, compared to PCF2127/29. Added
the new command byte definition when PCF2131 is detected.

Fixes: afc505bf9039 ("rtc: pcf2127: add support for PCF2131 RTC")
Cc: stable@vger.kernel.org
Signed-off-by: Elena Popa <elena.popa@nxp.com>
Acked-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20250530104001.957977-1-elena.popa@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-pcf2127.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -1383,6 +1383,11 @@ static int pcf2127_i2c_probe(struct i2c_
 		variant = &pcf21xx_cfg[type];
 	}
 
+	if (variant->type == PCF2131) {
+		config.read_flag_mask = 0x0;
+		config.write_flag_mask = 0x0;
+	}
+
 	config.max_register = variant->max_register,
 
 	regmap = devm_regmap_init(&client->dev, &pcf2127_i2c_regmap,



