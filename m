Return-Path: <stable+bounces-171883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A92B2D77D
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 11:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B8A7AB26B
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FADE296BA8;
	Wed, 20 Aug 2025 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NtH+lJMz"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16632550CA
	for <Stable@vger.kernel.org>; Wed, 20 Aug 2025 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680771; cv=none; b=YnyAyKNxILfw3Ia1JNZDOKK3ZewcQELBcZB62ZLGJtgA1tcPBFmqxeeTbfJ8hsjyyq/ebtxFoH68oV6MU602gVlqKxNoVcZJ8sjBN5WABU3CRkw1mCVCac0N/UlMypSUe8u6uWfljsa6nabfwVnjJnqlKrnDy7KQyPy6BzVT8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680771; c=relaxed/simple;
	bh=A03orkuBhM73ApRnlew5K6kVE66+pOpr57aitOSGg20=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ZKnfXZZfKSv3e3SVudmZrnYGxyLUezd0iIOCy6vjGw39EIRW/EhH8RUm4hpHJCjUx1tZURYr5gOXlV1snoJ12GCQZk/xJz1KReTbT0pnP+Yv2WTLqs7yuovamKfUwhuVdMidVoi3RJB55kMq6G8XkQ6Zl5fHaK8hF4xT0mSHwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NtH+lJMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4CDC4CEEB;
	Wed, 20 Aug 2025 09:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755680770;
	bh=A03orkuBhM73ApRnlew5K6kVE66+pOpr57aitOSGg20=;
	h=Subject:To:From:Date:From;
	b=NtH+lJMztuEqm6Zby2jqC+VzTjSFug4c2IGEHIm4/LJEFHUkrbiJ/RQWwGNMyk+JI
	 lBeST/J/7VlIxuGasdDVWeQnJrHKISLrgLQawgGNJWOwfFu/cuLqyKzpvOwwdkV6bN
	 Ytu6oXUkHMzeswGwZDCLYbhOa+rnfaOrOXnhAxLk=
Subject: patch "iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()" added to char-misc-linus
To: salah.triki@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 Aug 2025 11:05:37 +0200
Message-ID: <2025082037-brownnose-bullpen-2f50@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 43c0f6456f801181a80b73d95def0e0fd134e1cc Mon Sep 17 00:00:00 2001
From: Salah Triki <salah.triki@gmail.com>
Date: Mon, 18 Aug 2025 10:27:30 +0100
Subject: iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()

`devm_gpiod_get_optional()` may return non-NULL error pointer on failure.
Check its return value using `IS_ERR()` and propagate the error if
necessary.

Fixes: df6e71256c84 ("iio: pressure: bmp280: Explicitly mark GPIO optional")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250818092740.545379-2-salah.triki@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/bmp280-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 74505c9ec1a0..6cdc8ed53520 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3213,11 +3213,12 @@ int bmp280_common_probe(struct device *dev,
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
+
 	/* Deassert the signal */
-	if (gpiod) {
-		dev_info(dev, "release reset\n");
-		gpiod_set_value(gpiod, 0);
-	}
+	dev_info(dev, "release reset\n");
+	gpiod_set_value(gpiod, 0);
 
 	data->regmap = regmap;
 
-- 
2.50.1



