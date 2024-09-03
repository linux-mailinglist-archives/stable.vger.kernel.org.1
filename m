Return-Path: <stable+bounces-72816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B8C969A70
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6310D1F24139
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207961C769E;
	Tue,  3 Sep 2024 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SP9BaXk+"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EED1C768C
	for <Stable@vger.kernel.org>; Tue,  3 Sep 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360125; cv=none; b=CKTQOFK3Ays2QDzkG5GosIiJSfyZQ4Ok9X6JRigF53yAZMPQVjhsov5GFAPItZWNHY6BLGXt7MyqSwPlcNAaHiv58I0aumKruEaVhqTU9vW8NJlk49u0hA1KLMhLdetyIoDxcZYRMECDQnFsKlDXHjnnZRmRZgySZEI01nKUyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360125; c=relaxed/simple;
	bh=KD1SAqRfauBuOY54rsohR0F8975dwZclVJHfoA5DADg=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=cXd6ZzKqKByWF84YmNFbDaXc9DVWSVQ42sqppn7snh2DIQKLyAoVlDZcCmTQUMxRvBjav+LFs1fAFcldTO1slSq/YtWfLdqebxaKCgOtLjrWy6sJVWMt+tOPYaM1QPirdXvHKYH8E1QP/RdXE9UdkWNKMWDqEeXrblxF4VC/nkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SP9BaXk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450E5C4CEC5;
	Tue,  3 Sep 2024 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360125;
	bh=KD1SAqRfauBuOY54rsohR0F8975dwZclVJHfoA5DADg=;
	h=Subject:To:From:Date:From;
	b=SP9BaXk+cO3rsuEkYpF7pNtJBaty/gZODsZnOG/eKosSb9JwCU6G9o7gODcGsHbZL
	 qExdsYo7Az9Uwv/HCIiNsSppJcC0fiPG7c8Xrv3BDPTNQGKSKo5Cw9rd0pNfC7+WJw
	 gDJgip53e/4GliW46przuzwEe/rsS/GFUYhoa8eA=
Subject: patch "iio: fix scale application in iio_convert_raw_to_processed_unlocked" added to char-misc-linus
To: matteomartelli3@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2024 12:18:05 +0200
Message-ID: <2024090304-slam-bling-55e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: fix scale application in iio_convert_raw_to_processed_unlocked

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 8a3dcc970dc57b358c8db2702447bf0af4e0d83a Mon Sep 17 00:00:00 2001
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Tue, 30 Jul 2024 10:11:53 +0200
Subject: iio: fix scale application in iio_convert_raw_to_processed_unlocked

When the scale_type is IIO_VAL_INT_PLUS_MICRO or IIO_VAL_INT_PLUS_NANO
the scale passed as argument is only applied to the fractional part of
the value. Fix it by also multiplying the integer part by the scale
provided.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
Link: https://patch.msgid.link/20240730-iio-fix-scale-v1-1-6246638c8daa@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/inkern.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 9f484c94bc6e..151099be2863 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -647,17 +647,17 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000LL);
 		break;
 	case IIO_VAL_INT_PLUS_NANO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000000LL);
 		break;
-- 
2.46.0



