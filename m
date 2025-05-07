Return-Path: <stable+bounces-142058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E251AAE0AA
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E210A467523
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EAF205E3B;
	Wed,  7 May 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DiLa31Sn"
X-Original-To: stable@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76E25DB1A
	for <stable@vger.kernel.org>; Wed,  7 May 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624340; cv=none; b=cTMswMzU0Q7NhnTPwn1+c9dgbVoBDKI/yxMxCczMQXXh0lC8feHMg9c4vahwvy0ulnFhUus2J8oNqc4XyLoj9ijKBeJPY7tcaEyVd7Ix0akpFnanGxf41PjzPoWjOLcBqxhagANKcYTZvrkfUlnLpuji3m/FLNMvpzAY28lK0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624340; c=relaxed/simple;
	bh=n4QtldqqpLlFI1Ss+X2x8D7uSg/XZ+yObh3NYYR+CrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sUs+mSVfl5aZ7y/g1H0zGyYDTng3I9YF/wzCCMpuZGiKUQL9Rz/FHaJQZhLAZ6v1HOzSMgXaAd1BMvYVary1lqaC955uS6s86OOYg2ghqJHpn8uSEYU9feC7LADz3WTD5mFeEjOKngQHkVnswwXOdmt1AOvF37VDRYBuvFC7Pck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DiLa31Sn; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=jcGf10D2efT+XD+0y/JSBweiknb2/SkN3k9kolk5nNs=; b=Di
	La31SnoxRq2cJ0yjKhnpw/khJYKzU28a2WRkTGfLnb8r+sh+2KSkz8cCApTL46rj/lSmQbHLZKIWR
	FGJKBe4eBKuwJjVS5CsxFl/wcy6rkjQRigu7TsRtg5U9oTIMWWhFCZNCX5janGAOrcC0e5oJMH7YV
	ZU664kEEWBJ8lN/j2Je23aLl8baoH+hHB+fcFm/CX8zDrmDzKM+qk9eJTqVncPT7Aj6DH4pm84ROj
	wz6iL/5KtKYb3GbzFyAZhKNTVE9w/VoARVAPT/d3dQ1bLHEaAjaTjX6FSCdNJ7lRwU+C9+h4MAtrJ
	2LeC8ln6UWeDJn9628q83xe5figsvGVw==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1uCeYv-008eIx-LI; Wed, 07 May 2025 13:11:49 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] of: module: add buffer overflow check in of_modalias()
Date: Wed,  7 May 2025 15:11:24 +0200
Message-ID: <20250507131123.538166-4-ukleinek@debian.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=ukleinek@debian.org; h=from:subject; bh=ggehUJJ1kBVZQHsYRq2OxsY6DL+vq56IItWccby2Cks=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGgbW/vIerROrlFqfLuAJicyc3TdLDR4HUuGhRkEUp6XmVa2j okBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJoG1v7AAoJEI+A+1h9Ev5OlfEH/jSw Ht2uOX54ukzp3KIn3cHn0JxvoZAqoHI3U1TEU8nbEl3meBom31HpBoE4xEfxhDkdGaEh4MGiKFD IxfTk+bpj8afHUJ7gx1EVzT8WazcKyhRB94g6kzCbAWfaSU7KWfMnv5L9zLyMZesJoHWZ4jgwlQ Rzhh2nfmXCumy0MXqCNvtaKid+pcbxkgkQk0D/n3qFcbRcEhmTMaq3AdG9tRLxNq7C/MK1tgzfx LMjQ/QUMCPqwgKabhvvOOheULHA/lRM55j0rCNsHdaEV+4M7n4qzj8KRfm+6oLlakBG1PKiMPsu 5LkROK/meO6MS8V4UK9Uml6I7jLYftBgq0o6Y1E=
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
index 3a547793135c..93f08f18f6b3 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -231,14 +231,15 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
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

base-commit: 024a4a45fdf87218e3c0925475b05a27bcea103f
-- 
2.47.2


