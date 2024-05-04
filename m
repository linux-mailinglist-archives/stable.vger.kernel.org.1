Return-Path: <stable+bounces-43053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A335D8BB9E0
	for <lists+stable@lfdr.de>; Sat,  4 May 2024 09:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E65283582
	for <lists+stable@lfdr.de>; Sat,  4 May 2024 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66383748A;
	Sat,  4 May 2024 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I/M6HtYb"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6279C4
	for <Stable@vger.kernel.org>; Sat,  4 May 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714809120; cv=none; b=VWc++EVI3LneYFnzZEmuyKV7qwW5ShGr/9YUJ6aJvKlhfWEJblSnRN04N4Obf+D+KKLBiLzw0unHeq5q6vH5TYrcMLw0D5d6qJVWIhoqgNaJcLPD6/Nx/Bdn/GMbRmQc8BrP5vrUt8MLgQBPkFnASrkpnlyGN6GTZ1U3QTDlTNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714809120; c=relaxed/simple;
	bh=lB6BkNHbqmnzGkZd9RKBb/tft/zCCjjPV0SzuY0K8u0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=M/2tVpufkUpzzXXxzsR7vqkibyRZwONgM5sRwA3wPxDnBJ+5BPvr1pJiMb24i8RK72r0ZXsytHrXeAi1Q3/t3e7lXSVeSm/R6h1Pk2hSUxsnp5m2zs9LrvZZMzj1upd+Y10fvafhyupasjDqv7Yo0GFcaAKK/IXoQzup5B5i9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I/M6HtYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29951C072AA;
	Sat,  4 May 2024 07:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714809119;
	bh=lB6BkNHbqmnzGkZd9RKBb/tft/zCCjjPV0SzuY0K8u0=;
	h=Subject:To:From:Date:From;
	b=I/M6HtYbq2bYyKU8qZAH9mS9eI9feq7P1dkhlm74h2nftVAzpOuF31K0DzjGfheQa
	 CGjU8pbS9k1lp2kIVHbITS6DjoSrLyZmwa8BY5eUpLr5LIlVDjKOXbksI272hx0RAD
	 jEwwsWsjbDpSGMIY+ThIlI3QIasQIJdK6pOjImqY=
Subject: patch "iio: temperature: mcp9600: Fix temperature reading for negative" added to char-misc-testing
To: dima.fedrau@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andrew.hepp@ahepp.dev,marcelo.schmitt1@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Sat, 04 May 2024 09:50:16 +0200
Message-ID: <2024050415-badass-mute-6d3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: temperature: mcp9600: Fix temperature reading for negative

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 827dca3129708a8465bde90c86c2e3c38e62dd4f Mon Sep 17 00:00:00 2001
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Wed, 24 Apr 2024 20:59:10 +0200
Subject: iio: temperature: mcp9600: Fix temperature reading for negative
 values

Temperature is stored as 16bit value in two's complement format. Current
implementation ignores the sign bit. Make it aware of the sign bit by
using sign_extend32.

Fixes: 3f6b9598b6df ("iio: temperature: Add MCP9600 thermocouple EMF converter")
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Tested-by: Andrew Hepp <andrew.hepp@ahepp.dev>
Link: https://lore.kernel.org/r/20240424185913.1177127-1-dima.fedrau@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/mcp9600.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 46845804292b..7a3eef5d5e75 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -52,7 +52,8 @@ static int mcp9600_read(struct mcp9600_data *data,
 
 	if (ret < 0)
 		return ret;
-	*val = ret;
+
+	*val = sign_extend32(ret, 15);
 
 	return 0;
 }
-- 
2.45.0



