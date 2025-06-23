Return-Path: <stable+bounces-157661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350E3AE5510
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB853B15E5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4B1222581;
	Mon, 23 Jun 2025 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xbogUmAQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8833597E;
	Mon, 23 Jun 2025 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716414; cv=none; b=sJ66fmqLIWFVkCdema5yC+h6Ozhsbf0QmwgmHKlFnUfTSAKghEuE7/q+cgbSNAZFiaVnfgR1lOCDOLJiJL7jDjGDeY6kUQGe+mIXYhCTdYewlIuQf3Rr95iwU3fF23F+r0zHhfXEW/tB8yRP8X0+pehZSyphVD6/8niReG78nkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716414; c=relaxed/simple;
	bh=LYxmP6oFDWH8eZPRJW9OgXs/ja/u+/7vYRKvZrj+d9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QffW+zaFn+j/UTNfya/NKLc+I5fqTXbwXQlNV2fz1sg/WSuqBm7dByUkqT+w3TZtnfM1TaJeccXOppAtd+nlIkPoSXaFRl/0kzjp4a2H9qBGq9XVfovQvw9Jv0NVeHXrtx78KarM54VK4/GZAvUVL5Shc7wR1F5WY/bg/NfrxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xbogUmAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B19C4CEEA;
	Mon, 23 Jun 2025 22:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716414;
	bh=LYxmP6oFDWH8eZPRJW9OgXs/ja/u+/7vYRKvZrj+d9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xbogUmAQJNJdDKe+TaMCVSjypLBEEpW3eCoHFqFliCOm4wG4Nif9983EtRMEOQvq1
	 cDyo79u9AwHQLSW02XQf/4InRsCUg/Bhgn4O6sd2b/OmUzhrBdBgD13c8EAZQR8Dp0
	 z1GFMHphD4mApg1/T2XPt9L8F1flRWgQAsqvXfB0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eddie James <eajames@linux.ibm.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.10 347/355] hwmon: (occ) Fix P10 VRM temp sensors
Date: Mon, 23 Jun 2025 15:09:08 +0200
Message-ID: <20250623130637.158959941@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eddie James <eajames@linux.ibm.com>

commit ffa2600044979aff4bd6238edb9af815a47d7c32 upstream.

The P10 (temp sensor version 0x10) doesn't do the same VRM status
reporting that was used on P9. It just reports the temperature, so
drop the check for VRM fru type in the sysfs show function, and don't
set the name to "alarm".

Fixes: db4919ec86 ("hwmon: (occ) Add new temperature sensor type")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Link: https://lore.kernel.org/r/20210929153604.14968-1-eajames@linux.ibm.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/occ/common.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -340,18 +340,11 @@ static ssize_t occ_show_temp_10(struct d
 		if (val == OCC_TEMP_SENSOR_FAULT)
 			return -EREMOTEIO;
 
-		/*
-		 * VRM doesn't return temperature, only alarm bit. This
-		 * attribute maps to tempX_alarm instead of tempX_input for
-		 * VRM
-		 */
-		if (temp->fru_type != OCC_FRU_TYPE_VRM) {
-			/* sensor not ready */
-			if (val == 0)
-				return -EAGAIN;
+		/* sensor not ready */
+		if (val == 0)
+			return -EAGAIN;
 
-			val *= 1000;
-		}
+		val *= 1000;
 		break;
 	case 2:
 		val = temp->fru_type;
@@ -888,7 +881,7 @@ static int occ_setup_sensor_attrs(struct
 				   0, i, "temp%d_label", s);
 		attr++;
 
-		if (sensors->temp.version > 1 &&
+		if (sensors->temp.version == 2 &&
 		    temp->fru_type == OCC_FRU_TYPE_VRM) {
 			occ_init_attribute(attr, 0444, show_temp, NULL,
 					   1, i, "temp%d_alarm", s);



