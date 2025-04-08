Return-Path: <stable+bounces-130651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9C4A805C5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B3D1B8238D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8826A1C9;
	Tue,  8 Apr 2025 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YE+OEHE6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B826A1BE;
	Tue,  8 Apr 2025 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114282; cv=none; b=Mkm27tWa8kkaxMyxeueaTxxMGwRzQD7r/CAvdD0i/qSpiL4MaKYhz9yeLVRNrMR7KHzvZqj+D5KAdmuniXeREEiGP9LzYDpB6IuJrDRUulRZxS3DwBnqpLcES0LG7VrzyMrIHwZn6OAB1tzprCGxAjFWCCCPr2bMPmFRMn0A5ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114282; c=relaxed/simple;
	bh=WIgT6AHgLtt3+ESujSaEC2Wega0WHv5bCvwZG+BGxJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbWuY7ff+BfGO8CZtu+Gz9WAYZwi0gx91IsqqFKOgpnWEUblzMADQwEjqhdoCOoJagA+j/N7vky2j3E1JgYsqE+IcMn7EmhMn4nCGYgnAS+wvGkiCjss4zHN4zm17Qwq0QqefAvzEx0i09fRhN8TTOXUXI0nP25SqV46suEj/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YE+OEHE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085B5C4CEE5;
	Tue,  8 Apr 2025 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114282;
	bh=WIgT6AHgLtt3+ESujSaEC2Wega0WHv5bCvwZG+BGxJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YE+OEHE64sgpJbUDFdmAvRNOZ4e46E5ZCFdjxC8J+QeVJyEZ3iv7cX1xIlBPK83xX
	 vns/V+0klv89lB3aAgyAutR0d28aBiWhljljZFNJ9hpDEZSLW0de2JaFVvwONk5IRA
	 SOANhASE80cMXU7cEOEHbb/jOmVA5jbZmUP81xY0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Armin Wolf <W_Armin@gmx.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 050/499] platform/x86: dell-ddv: Fix temperature calculation
Date: Tue,  8 Apr 2025 12:44:22 +0200
Message-ID: <20250408104852.487896931@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 7a248294a3145bc65eb0d8980a0a8edbb1b92db4 ]

On the Dell Inspiron 3505 the battery temperature is always
0.1 degrees larger than the temperature show inside the OEM
application.

Emulate this behaviour to avoid showing strange looking values
like 29.1 degrees.

Fixes: 0331b1b0ba653 ("platform/x86: dell-ddv: Fix temperature scaling")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20250305053009.378609-2-W_Armin@gmx.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-wmi-ddv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
index e75cd6e1efe6a..ab5f7d3ab8249 100644
--- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -665,8 +665,10 @@ static ssize_t temp_show(struct device *dev, struct device_attribute *attr, char
 	if (ret < 0)
 		return ret;
 
-	/* Use 2731 instead of 2731.5 to avoid unnecessary rounding */
-	return sysfs_emit(buf, "%d\n", value - 2731);
+	/* Use 2732 instead of 2731.5 to avoid unnecessary rounding and to emulate
+	 * the behaviour of the OEM application which seems to round down the result.
+	 */
+	return sysfs_emit(buf, "%d\n", value - 2732);
 }
 
 static ssize_t eppid_show(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.39.5




