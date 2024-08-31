Return-Path: <stable+bounces-71686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE5796702D
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 09:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C255B2816EE
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 07:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA0616F27E;
	Sat, 31 Aug 2024 07:41:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A56616A94F
	for <stable@vger.kernel.org>; Sat, 31 Aug 2024 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725090078; cv=none; b=s4845hqv+OjKzlOD9cmbIhRQibOggTEW5t4620qgCkNXOYuyJLDT9DVm3C6T7Et2NyGUvD13Un8GfPDbYxZNI6DP4alzdUOHJk3QTblLXM9Aka8gTWtO7pfww6biAXwA3KDzMltvgMaV0sNEw2G0c19wSEqrXAZANOlTfhrTg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725090078; c=relaxed/simple;
	bh=ZI8K8njkaYV9oGXzZBBlt9FZB+ON64jMRFDOGGP+rsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:To:Cc:Message-Id; b=T4ntIX36JwtrSBdOFbC/MgU9HJxQQgwOQxtTAC0v8Lu2AESCdRFBLvjnv5yV0jdHrOoDtg1pDW6KAS/c6F697HU/h4KmjL+Z3sHbADkWTihsJUwG3fjJRkZTBgjPvTZM/P8QD9LQ3SY8jkBUvNCcKUJNhgEIjBhm56zV8MMuS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1skIjT-0006f7-0B;
	Sat, 31 Aug 2024 07:41:15 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Sat, 31 Aug 2024 07:40:43 +0000
Subject: [git:media_stage/master] media: i2c: ar0521: Use cansleep version of gpiod_set_value()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linuxtv-commits@linuxtv.org
Cc: Krzysztof Hałasa <khalasa@piap.pl>, Alexander Shiyan <eagle.alexander923@gmail.com>, stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1skIjT-0006f7-0B@linuxtv.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: i2c: ar0521: Use cansleep version of gpiod_set_value()
Author:  Alexander Shiyan <eagle.alexander923@gmail.com>
Date:    Thu Aug 29 08:48:49 2024 +0300

If we use GPIO reset from I2C port expander, we must use *_cansleep()
variant of GPIO functions.
This was not done in ar0521_power_on()/ar0521_power_off() functions.
Let's fix that.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 11 at drivers/gpio/gpiolib.c:3496 gpiod_set_value+0x74/0x7c
Modules linked in:
CPU: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.10.0 #53
Hardware name: Diasom DS-RK3568-SOM-EVB (DT)
Workqueue: events_unbound deferred_probe_work_func
pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : gpiod_set_value+0x74/0x7c
lr : ar0521_power_on+0xcc/0x290
sp : ffffff8001d7ab70
x29: ffffff8001d7ab70 x28: ffffff80027dcc90 x27: ffffff8003c82000
x26: ffffff8003ca9250 x25: ffffffc080a39c60 x24: ffffff8003ca9088
x23: ffffff8002402720 x22: ffffff8003ca9080 x21: ffffff8003ca9088
x20: 0000000000000000 x19: ffffff8001eb2a00 x18: ffffff80efeeac80
x17: 756d2d6332692f30 x16: 0000000000000000 x15: 0000000000000000
x14: ffffff8001d91d40 x13: 0000000000000016 x12: ffffffc080e98930
x11: ffffff8001eb2880 x10: 0000000000000890 x9 : ffffff8001d7a9f0
x8 : ffffff8001d92570 x7 : ffffff80efeeac80 x6 : 000000003fc6e780
x5 : ffffff8001d91c80 x4 : 0000000000000002 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000001
Call trace:
 gpiod_set_value+0x74/0x7c
 ar0521_power_on+0xcc/0x290
...

Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
Fixes: 852b50aeed15 ("media: On Semi AR0521 sensor driver")
Cc: stable@vger.kernel.org
Acked-by: Krzysztof Hałasa <khalasa@piap.pl>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/i2c/ar0521.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

---

diff --git a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
index 56a724b4d47e..fc27238dd4d3 100644
--- a/drivers/media/i2c/ar0521.c
+++ b/drivers/media/i2c/ar0521.c
@@ -842,7 +842,8 @@ static void __ar0521_power_off(struct device *dev)
 	int i;
 
 	if (sensor->reset_gpio)
-		gpiod_set_value(sensor->reset_gpio, 1); /* assert RESET signal */
+		/* assert RESET signal */
+		gpiod_set_value_cansleep(sensor->reset_gpio, 1);
 
 	for (i = ARRAY_SIZE(ar0521_supply_names) - 1; i >= 0; i--) {
 		if (sensor->supplies[i])
@@ -886,7 +887,7 @@ static int ar0521_power_on(struct device *dev)
 
 	if (sensor->reset_gpio)
 		/* deassert RESET signal */
-		gpiod_set_value(sensor->reset_gpio, 0);
+		gpiod_set_value_cansleep(sensor->reset_gpio, 0);
 	usleep_range(4500, 5000); /* min 45000 clocks */
 
 	for (cnt = 0; cnt < ARRAY_SIZE(initial_regs); cnt++) {

