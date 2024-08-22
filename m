Return-Path: <stable+bounces-69916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5840C95C196
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 01:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03ACB233F4
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 23:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD08187325;
	Thu, 22 Aug 2024 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="o49hBV7l"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A215183CAF
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724370403; cv=none; b=mCdbYFsousbjifSEmpf7X3b72THCErvbbASg1sUz5mYxsLISNyH3fH4cjRf1dO8lD4Qx3J33GAvoIG2J55B/7GXBB7pezI/bH8ZdQCvEGn6orO3+moVEuAyixgg9b2lMAiDN06bfj7dtbd//2TAIdhz8K/FS73xEKj8U+DyXG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724370403; c=relaxed/simple;
	bh=cG9ZLV0/ImkhShNucrTnC7LBMBWp+w7HiUAs1jjf1ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=damEfTOKyBGBUIO0t+WarGF909aP8Y/K2X9h2ZYEN55SyOVQqVkbFEdyzEz+eS2vDUpFyq5xcrv7jVE2j9HqzPGXhKNe1zmUNq/ApVWVcTyGiYzup8hpUVuZn5tcgZSGl75N01avVBFAFWs3PQOYOVkoAzYXl4qx02iZUxQlzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=o49hBV7l; arc=none smtp.client-ip=17.58.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724370401;
	bh=slWs4FBpXwI3j4WDK+TAcRPwxZc3iFHDp5brKK18Qic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=o49hBV7lVhjwm3z61Zw3hVXTfAOZ7+mbbPUrCPmngVnmy4TvVbpBOJs3f7GmM/c7c
	 UfO6i9NCL89sNoBpbgIGRsi+cqAVxhwIJjNx5gzYcJtHZDr0GqgUFAQNdCWxWuYXlP
	 2zl6BOjNUKT1b/w+zR8GYFfDgQfIzFNovjNRui2eGJHK397YbP7OA7rcuuUXtdQRCR
	 gcErX0UwgrzEoVk03u3CwZheXQNpdLczJVoRV3in5PisqHaF2pMwpgkjyJ+24zSu8v
	 kwwbT5QjnmVrcWCjpGAm4+aU/zx2v15IyGhWsC3LdCbipX9fS2pQ8Bj9Q/U+uSdloS
	 opivHr105jQrA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id 2645D800AD;
	Thu, 22 Aug 2024 23:46:37 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 23 Aug 2024 07:46:09 +0800
Subject: [PATCH] driver core: Fix an uninitialized variable is used by
 __device_attach()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMDNx2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNj3bTMiviMxLLU+MTiyrxkXeNEQ2NTM0OLFEvDJCWgpoKiVKAKsIH
 RsbW1AHtIKdZgAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: oRO0UkB3Kho1Q_bQfaBCXrto_ovUeOon
X-Proofpoint-GUID: oRO0UkB3Kho1Q_bQfaBCXrto_ovUeOon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_16,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 spamscore=0 phishscore=0
 mlxlogscore=733 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408220179
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

An uninitialized variable @data.have_async may be used as analyzed
by the following inline comments:

static int __device_attach(struct device *dev, bool allow_async)
{
	// if @allow_async is true.

	...
	struct device_attach_data data = {
		.dev = dev,
		.check_async = allow_async,
		.want_async = false,
	};
	// @data.have_async is not initialized.

	...
	ret = bus_for_each_drv(dev->bus, NULL, &data,
			__device_attach_driver);
	// @data.have_async must not be set by __device_attach_driver() if
 	// @dev->bus does not have driver which allows probe asynchronously

	if (!ret && allow_async && data.have_async) {
	// Above @data.have_async is not uninitialized but used.
		...
	}
	...
}

It may be unnecessary to trigger the second pass probing asynchronous
drivers for the device @dev.

Fixed by initializing @data.have_async to false.

Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/dd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9b745ba54de1..b0c44b0846aa 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1021,6 +1021,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			.dev = dev,
 			.check_async = allow_async,
 			.want_async = false,
+			.have_async = false,
 		};
 
 		if (dev->parent)

---
base-commit: 87ee9981d1f86ee9b1623a46c7f9e4ac24461fe4
change-id: 20240823-fix_have_async-3a135618d91b

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


