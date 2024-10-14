Return-Path: <stable+bounces-83751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C55699C442
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A442859D3
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897C7156F5E;
	Mon, 14 Oct 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC4QX28a"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E9156886;
	Mon, 14 Oct 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896218; cv=none; b=cJYLkz1junxp2S2xboJx1JCS3UqNUWUYQksv14zp54uFDZjDzx71NPPVtnwCP6ZGl+J01O6+FpONmQeEn9sINdv9Nu4wDkfQ1diCNWVAscRHSxAgqRZ6quoCDMsTTKde0a8ewOhEhYQIt3gr8kWCmi+xZCUtemsKxDIkkOPdA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896218; c=relaxed/simple;
	bh=cgQO1UwCPIWBof6xKNlDEdY6kW2vr7t1iwZgCtqmWls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GSyc71/TRRmVeqhiUT/q3LTzSTPLauQTilwmGZq84I4BfO832JW0b1rOWE9Iv6rlQ2NpYXs0eMGdHWroRKk6OUKPLmCE6BR40JvDhmRHSUvA1xa4BYhMAofgbGBjbJ4pfdNu+ptOj6ZrDzbk2WQMMK5avzl/xwgQJCpWSH/NyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC4QX28a; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c97cc83832so936268a12.0;
        Mon, 14 Oct 2024 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728896215; x=1729501015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZtKiNo2Id4aizdmJ3+JWafU0x2IXYEJ4ykrMWfdUD4=;
        b=VC4QX28ahK5JDVM7d6zKx8TUQnCikKVY6CSjOUBmbFs2kR4mBFCBVUufTD5PvgldJm
         OM04/qvW+Hs1v+QgFXSu6Usvr79CDVczcgFZvEGf75MVJPQ3oVVrJhbv3o1jBZbllnUK
         o1HKBzToRmw8RSL/I6NkQSz/fu/F+SqWYYnBGMkkKMOCCx0EVywEq8sng9z21xSzWE2P
         gP83KfvfgKmF1Ey0hE10EVfAXg8OD4x7wQpFB1r82TwGw7Eeg1+JxjC3/UNM6shitSWC
         3bbo3mvISj2DbRiNrMA7hbQ/YYVQJkSsI63P+iXWCskfUS7+9cRQCJywWtClIsOgMD3I
         rPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896215; x=1729501015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZtKiNo2Id4aizdmJ3+JWafU0x2IXYEJ4ykrMWfdUD4=;
        b=niJNRfwfP2WukCCx4RFbBy2LX0SHsTzHqtyif5SHJqUDHXciUya6QLMQ57EadzbVET
         FzkSNTd0UFbqCL6yZ/yv7KM4L1eUsrVlDrh9Ir/H20//BXJjvMkeT9ozj0I6j44B07aS
         lBVvP/PrgFyryrmmDw/tujD48HVy9WBoBfjcNo6wYD5lM/y7Ogyz9UMiOjZy3G2gn8TS
         KXV9sDDw5/yG/CZw9XnBqe2MfILmtN1fptitOAW+ouMaIK7fCj3yT8Y5fLWiA+kS5Tq/
         t3A5u+7D+huVkIlTQGbFBB9MaDAAKTEldbdr+NVBVWMhaAa5nGR9Mpzmp0l0aRxqxSPJ
         fspg==
X-Forwarded-Encrypted: i=1; AJvYcCVojqSnaf8su8KY0j2UT9Qhf1F+rW8cfaETb86d6qZuzmt4iBRcuRHZzzmNHAx8e87IuBjqbe36@vger.kernel.org, AJvYcCWsS3ZLKELpl6ZhJq8mdnR85tZj5wbxq2JxJvS2OKNeqdD//ZIB3ZvC5rXpkN6bBAKn2zx6qeBOGwCv6Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ79j0WMREyiIepP5vdiyLxQpvwxHlGF2swy4TRI+PzjT8D3ds
	4gIcRXFDBjxI2fCwlBMSww/MyAuAjF8046EaiwV4hcLece19HBJj81PwONOc
X-Google-Smtp-Source: AGHT+IE4Tebx2zedc1mf+9ffSBCm5CEIg+axVw0KgnFRYtSFdJGxxHajwNWdgYanJ3YncO+DPc1FjA==
X-Received: by 2002:a05:6402:42d1:b0:5c4:14fe:971e with SMTP id 4fb4d7f45d1cf-5c948d58e4bmr8108654a12.23.1728896214496;
        Mon, 14 Oct 2024 01:56:54 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d2296sm4635091a12.15.2024.10.14.01.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:56:54 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 14 Oct 2024 10:56:37 +0200
Subject: [PATCH v2 2/2] staging: vchiq_arm: Fix missing refcount decrement
 in error path for fw_node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-vchiq_arm-of_node_put-v2-2-cafe0a4c2666@gmail.com>
References: <20241014-vchiq_arm-of_node_put-v2-0-cafe0a4c2666@gmail.com>
In-Reply-To: <20241014-vchiq_arm-of_node_put-v2-0-cafe0a4c2666@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Stefan Wahren <wahrenst@gmx.net>, Umang Jain <umang.jain@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728896207; l=1950;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=cgQO1UwCPIWBof6xKNlDEdY6kW2vr7t1iwZgCtqmWls=;
 b=z8dlOAj/8FIYM9IbUkY70cYe7S9l19ri5R7gxEkCqRIXIL34pJkUIGwLA8NJtm6fID+dxXhB9
 l+cV2UsHREeCPEOwnnztwEcLzm2lYoVDIPK3cOQXJLAOnaP4gIN5z+0
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

An error path was introduced without including the required call to
of_node_put() to decrement the node's refcount and avoid leaking memory.
If the call to kzalloc() for 'mgmt' fails, the probe returns without
decrementing the refcount.

Use the automatic cleanup facility to fix the bug and protect the code
against new error paths where the call to of_node_put() might be missing
again.

Cc: stable@vger.kernel.org
Fixes: 1c9e16b73166 ("staging: vc04_services: vchiq_arm: Split driver static and runtime data")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 81b2887d1ae0..bf2024929d07 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1332,7 +1332,6 @@ MODULE_DEVICE_TABLE(of, vchiq_of_match);
 
 static int vchiq_probe(struct platform_device *pdev)
 {
-	struct device_node *fw_node;
 	const struct vchiq_platform_info *info;
 	struct vchiq_drv_mgmt *mgmt;
 	int ret;
@@ -1341,8 +1340,8 @@ static int vchiq_probe(struct platform_device *pdev)
 	if (!info)
 		return -EINVAL;
 
-	fw_node = of_find_compatible_node(NULL, NULL,
-					  "raspberrypi,bcm2835-firmware");
+	struct device_node *fw_node __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
 	if (!fw_node) {
 		dev_err(&pdev->dev, "Missing firmware node\n");
 		return -ENOENT;
@@ -1353,7 +1352,6 @@ static int vchiq_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mgmt->fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
-	of_node_put(fw_node);
 	if (!mgmt->fw)
 		return -EPROBE_DEFER;
 

-- 
2.43.0


