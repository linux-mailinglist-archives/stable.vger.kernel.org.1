Return-Path: <stable+bounces-142053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0471AAE075
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EFDB2098F
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA21289803;
	Wed,  7 May 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="b+7Uf2CJ"
X-Original-To: stable@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77659287503
	for <stable@vger.kernel.org>; Wed,  7 May 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623541; cv=none; b=HO+1MJ1YNJ/Yt9LVbRpbqQklv4XPRJ8fZXNwcPSYA7B3GmsMIBp6vTilkl+vaSEvty0uRTnOMjHXRDbxYgRcvZ2OHqB2BcnQ2RmvicKSWrcS6Ez39BakykIZIfxZtAeKC0HsAogelrltUp5htiMjin15ME23fA3C/ePo6bOJhOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623541; c=relaxed/simple;
	bh=izIXhEeyn9qpsRChKXpSGrYaS5fDpperMF0cqmZl9hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YXuD6WSo/UCYKmCB9zI8Qw1V9eISZtohhz96+k0RwaFdium6nYr2TzVGYmWby0Tc8MJC5w8L3dTMHqfuuiLTIRa2NbgCACwXouJriS/iRixhFZSpKu3WwcJjlOdu+smDpmF6/1oMbIEv4G5+bi6n82ge7i/gM11sPBt9SxTimoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=b+7Uf2CJ; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=sPtOYV/zsfQ2Ss+JMSEEFz+BdoQXmS7002XG59Lv4aI=; b=b+
	7Uf2CJlgpJ/qCOcLTpgrowvLFFgOkTlkvunINR6RMdCWDzF6mTensg+P4Vip5zpii8aUobtVhx7po
	hvat4ZNiYXwvjBrWaa4mPx+S8EB2zuaykNOvHPfZpFhlBIF7CEbIMPsHPXbigNiMO3/zgDM5oP/yR
	pjCgcxqTwPiVVijEJKUdzKAsLq8p8bpFiYmhkDhYP60jhgOLLEKObYmvnggXSnIGZJwmooJB8ytyf
	KIQwJT0TGg/U9aQDkUGJdLGbSYqHGEuvgi5hvF2kNc2DVi5C7RxckPQbKi+oUHE7bCCqfeY4PAoiA
	GzT46IMXmh7R5/vBzuWnpbalGctLKlSw==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1uCeZN-008eK7-CL; Wed, 07 May 2025 13:12:17 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4.y] of: module: add buffer overflow check in of_modalias()
Date: Wed,  7 May 2025 15:11:26 +0200
Message-ID: <20250507131123.538166-6-ukleinek@debian.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=ukleinek@debian.org; h=from:subject; bh=w+v8cUDJ+t6e+YTHq9b6k30P5uYFRyoundV6kph1ho0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoG1wC7AjfFmnEgxR3eajVQJbz1wotXGdy+xgr2 H+I4KQM9l6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaBtcAgAKCRCPgPtYfRL+ Tp7aB/9F+QVrOvNfaazayhttbvFR9w8+tP3CLAHRTqIBfZYeBOvMCybVZej8Z/U0tuzryoRTX+L J9efrvZzSqDCs42OxZjxpBOT1SYf15ndQY1hi4508kd98i7zL4OJ21IhSiZA+hg49k+ZjghqjQ8 kgxxofunGpUohdaMYZflOaEBMtIdihgMP/HsOxh4Oujof1DHtkg7do3XSYigR1OHsN0KXCyTXAJ pCTweF2qTrfwsn11p3QzibxSe9PnIs7b/ZpVL1+ZhqIQ3T0F8i5VJnhil84X4t4FU/WHc0Amc11 rkdvR3Sa+sD6GSOOHNPqK3e0hkL/lF7T3HlxeEHl2Dvsy4qH
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Sergey Shtylyov <s.shtylyov@omp.ru>

commit cf7385cb26ac4f0ee6c7385960525ad534323252 upstream.

In of_modalias(), if the buffer happens to be too small even for the 1st
snprintf() call, the len parameter will become negative and str parameter
(if not NULL initially) will point beyond the buffer's end. Add the buffer
overflow check after the 1st snprintf() call and fix such check after the
strlen() call (accounting for the terminating NUL char).

Fixes: bc575064d688 ("of/device: use of_property_for_each_string to parse compatible strings")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/bbfc6be0-c687-62b6-d015-5141b93f313e@omp.ru
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/of/device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 7fb870097a84..ee3467730dac 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -213,14 +213,15 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
 	csize = snprintf(str, len, "of:N%pOFn%c%s", dev->of_node, 'T',
 			 of_node_get_device_type(dev->of_node));
 	tsize = csize;
+	if (csize >= len)
+		csize = len > 0 ? len - 1 : 0;
 	len -= csize;
-	if (str)
-		str += csize;
+	str += csize;
 
 	of_property_for_each_string(dev->of_node, "compatible", p, compat) {
 		csize = strlen(compat) + 1;
 		tsize += csize;
-		if (csize > len)
+		if (csize >= len)
 			continue;
 
 		csize = snprintf(str, len, "C%s", compat);

base-commit: 2c8115e4757809ffd537ed9108da115026d3581f
-- 
2.47.2


