Return-Path: <stable+bounces-6269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E17C80D9B2
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29967281B74
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EED551C46;
	Mon, 11 Dec 2023 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fNndfrzA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5AF321B8;
	Mon, 11 Dec 2023 18:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6898C433C7;
	Mon, 11 Dec 2023 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320970;
	bh=eOxnU175kEaa4DPMGrdJSEoMPpmZIkoiGGbpPvr77qE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNndfrzA5BO7m8A3/baQgYW9trX3IYgSE4OiUjS7UmZCYJMLeDXdbXrT72Jt87r6l
	 w+UalyvRfIhVIkoguoawWWWzAEN6xHxRtVftdgxtGPVIcj8fg9RoGdgdzGLqTljkS0
	 u9Ii286aDijmLWsYXMidJ40vNT9/6mVp9eBEdU2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jonas Malaco <jonas@protocubo.io>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 061/141] hwmon: (nzxt-kraken2) Fix error handling path in kraken2_probe()
Date: Mon, 11 Dec 2023 19:22:00 +0100
Message-ID: <20231211182029.194481918@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 35fe2ad259a3bfca15ab78c8ffb5278cb6149c89 ]

There is no point in calling hid_hw_stop() if hid_hw_start() has failed.
There is no point in calling hid_hw_close() if hid_hw_open() has failed.

Update the error handling path accordingly.

Fixes: 82e3430dfa8c ("hwmon: add driver for NZXT Kraken X42/X52/X62/X72")
Reported-by: Aleksa Savic <savicaleksa83@gmail.com>
Closes: https://lore.kernel.org/all/121470f0-6c1f-418a-844c-7ec2e8a54b8e@gmail.com/
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Jonas Malaco <jonas@protocubo.io>
Link: https://lore.kernel.org/r/a768e69851a07a1f4e29f270f4e2559063f07343.1701617030.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nzxt-kraken2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nzxt-kraken2.c b/drivers/hwmon/nzxt-kraken2.c
index 89f7ea4f42d47..badbcaf01f90b 100644
--- a/drivers/hwmon/nzxt-kraken2.c
+++ b/drivers/hwmon/nzxt-kraken2.c
@@ -161,13 +161,13 @@ static int kraken2_probe(struct hid_device *hdev,
 	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 	if (ret) {
 		hid_err(hdev, "hid hw start failed with %d\n", ret);
-		goto fail_and_stop;
+		return ret;
 	}
 
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev, "hid hw open failed with %d\n", ret);
-		goto fail_and_close;
+		goto fail_and_stop;
 	}
 
 	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "kraken2",
-- 
2.42.0




