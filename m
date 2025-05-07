Return-Path: <stable+bounces-142052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AFFAAE063
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011971659D7
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647AD2820AC;
	Wed,  7 May 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NpzxF9wi"
X-Original-To: stable@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E726B2BB
	for <stable@vger.kernel.org>; Wed,  7 May 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623538; cv=none; b=QnOMlBGWqBcpGdCKsIjCo3Xwi10tPf/XZBG7M+2OmvjztWcPNAzlzRHw/ajo1R6zw+T5NjlwD7bP0YUXTurkrwiGUve+u9uosvRYcKnernJlcjZq9TsZa/3DHTMCycJ5Gd2arJtIoQjly4chlT5LfHKsrC4MirWP86iTXskRu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623538; c=relaxed/simple;
	bh=b6CKEuJSKPXQTfIvll7OLUnoFVnwMZo9CAmnKvevM0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jI+RyWrDiEW7E+lkqBuuktmlCv6Q7XzQbpdwhTgewf03N34NuAvOPNHKU2Q6GyYex4k8/kznQNSDLu9edp9RBBeQDHnCSMnpPDrBggk1Gz0DzmGIPX9TgmRMUlE8bVoGqpCOtcIVZQTqzGddvGKsrDWR36JTgLntwYNLPfYuak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NpzxF9wi; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=XNKuWzOhMAkcw6O5WeUTZt27mSbEY5XCdReupCP8wKA=; b=Np
	zxF9wivC17dCfcsIhl9Ym2PMBkxv7UgkikvagURDuAwiZ1aSr9R9NBNSiGzIZNNvzrSDqwmBu+5q7
	HTFeTo/j7Ql19c2TlswTNR7wNX5r6EAnakQDljQpGBu0hxRPPaMx3rSM5zq0WGKzq9VpCEC0AtkOE
	Qv8Wla5r44H/UCKLzBBQfPsW49tbY+o5w5Uh+4V7EoRQjtP/H6F4XngU+yAD7JccRF9ISOjz0k7wi
	nPFDqusf4m8nEV8Hf81xvB+y7QwkwnWZoJkjurlH3LJ79e/FNol++DEOvZ/bMDVD/Tg08hqA5ygIj
	DYleT72yEbbsoVqrX2o0GlxsF8PSJNVw==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1uCeZJ-008eJu-Se; Wed, 07 May 2025 13:12:13 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y] of: module: add buffer overflow check in of_modalias()
Date: Wed,  7 May 2025 15:11:25 +0200
Message-ID: <20250507131123.538166-5-ukleinek@debian.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=ukleinek@debian.org; h=from:subject; bh=t+Gwxt5axtlXuVY7y3w18teyCaVWN5YJpejt81GIYpc=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGgbW/+hRJ/7SptItH2w1AuViyJ7qJguKoGRnVJLea93HHzae IkBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJoG1v/AAoJEI+A+1h9Ev5OiVgIALKs +4KEKgoonbpvHztuPRQeWy1PuuHi50YXe8hMt5yu2uxGIt6JrMvXiPgAriDDbybQBdrsMATcSpi TtRLO9jdsnmPQ2SVu8H+XF1lsrH9qKtx2sFMZf+sHKPYH1aQLulCC3LQ6QId17Ut95kmI89Lr7K v2Xb77aUSUoIDEhazbmstUEWniWQrV/bBJ7Oo/rcxDZbWlJyUBk126uKInjawkSFgZiKco6BoDD Z7BblpR3lQxbeT2Yn+W493FpRAWRTQGkaCSBiCE0jzvYkX9QDb0/HKtpgdrBEZN7wcEW86PmaGz uxyTaCq0C96dXsxM/g6y/JPe0DBVg0DVgzpFcqw=
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
index 19c42a9dcba9..f503bb10b10b 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -257,14 +257,15 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
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

base-commit: 16fdf2c7111bd6927f16c3e811f5086fecebbf00
-- 
2.47.2


