Return-Path: <stable+bounces-72814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6E7969A64
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8771C23448
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD58E1A3AA3;
	Tue,  3 Sep 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fzKqmyRC"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9A1A0BEC
	for <Stable@vger.kernel.org>; Tue,  3 Sep 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360113; cv=none; b=U3+nZJnzsE2dPZRO/zxXHCI1b2hou8NeKuPJol7aUbkvq7t+kEgA/OtSf3R0rOSEAs+qj0FjtPuFiXgOAU7sWIGUhCBsnoy7Jr2RlgIsYDmzLY36WZWVASi7pb46uIY0HxxVuWoym5xZsfwr0R8979dSoQErHXYV+DHsDA0JP58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360113; c=relaxed/simple;
	bh=hOZszzkCJkoMOMNtQN0yUkBtgbC8Kqmn0Din5TGec1U=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=iUEIIapkmhsMmih/tCkemOq8bEpR8CG+bWjnAGfyNMt7LzkM+lCIYUARXZk29/eZ9KFQkIUXnP1I1Jmd5wVpWrdwkGGd4jrFUp+xN1eGzr+N3E+QrhCC+g3ZySBx0YYNn5lTVxtCxuVroByGVSkB1IawbBx1u23CS1rAXKRXyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fzKqmyRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B28FC4CEC4;
	Tue,  3 Sep 2024 10:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360113;
	bh=hOZszzkCJkoMOMNtQN0yUkBtgbC8Kqmn0Din5TGec1U=;
	h=Subject:To:From:Date:From;
	b=fzKqmyRCC/Uh/LYxOb+4H2JBUMHpJ11fhzF5C/eUNOIIlEw0o+82XGN7ctQoxoLvQ
	 9ZQcWz0d/ib2joQP0mbbt3R2yuGixkvPeMlsgmWE0GhAmdBrhhWeB0C5uqi5sY+tA3
	 jlk61a1NsiX2AUDDkMmA5bi6xzQ+jo59GZmnxHwg=
Subject: patch "iio: adc: ad7124: fix chip ID mismatch" added to char-misc-linus
To: mitrutzceclan@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dumitru.ceclan@analog.com,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2024 12:18:03 +0200
Message-ID: <2024090303-chevron-hacking-b1aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7124: fix chip ID mismatch

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 96f9ab0d5933c1c00142dd052f259fce0bc3ced2 Mon Sep 17 00:00:00 2001
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
Date: Wed, 31 Jul 2024 15:37:22 +0300
Subject: iio: adc: ad7124: fix chip ID mismatch

The ad7124_soft_reset() function has the assumption that the chip will
assert the "power-on reset" bit in the STATUS register after a software
reset without any delay. The POR bit =0 is used to check if the chip
initialization is done.

A chip ID mismatch probe error appears intermittently when the probe
continues too soon and the ID register does not contain the expected
value.

Fix by adding a 200us delay after the software reset command is issued.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20240731-ad7124-fix-v1-1-46a76aa4b9be@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7124.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 3beed78496c5..c0b82f64c976 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -764,6 +764,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 	if (ret < 0)
 		return ret;
 
+	fsleep(200);
 	timeout = 100;
 	do {
 		ret = ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readval);
-- 
2.46.0



