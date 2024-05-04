Return-Path: <stable+bounces-43065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BF48BBD50
	for <lists+stable@lfdr.de>; Sat,  4 May 2024 18:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98131C20CBB
	for <lists+stable@lfdr.de>; Sat,  4 May 2024 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850775A4C0;
	Sat,  4 May 2024 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NjXG4rIF"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464601E871
	for <Stable@vger.kernel.org>; Sat,  4 May 2024 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714841907; cv=none; b=hjST1XPYKPoEk8UePPlc+Iib/IPV0VxYWP0f1VqdPaW+A10PEOwdhw6YafnTuzFmLvCS6cSIpUkny7q1vbuB7CwkweT2EYsZ7I3xMjFQWFCKRzEH8uRBV0M6Q5KzGADku1YurSdi08URtcmmsG+zNT/VkZTaFoQQHmW46FKKUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714841907; c=relaxed/simple;
	bh=0OETpdqFmiZsZQfia5vzI6GtuXGKoZjaMhc3cpwlH74=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=gtxksfpvjAo4eCBuBDTmXCijDIsl8Dv/DBR0gWpwDImN080yZ82gF7Usovvf9r9lZNV9XdYieNbNu65vwkN1VJZFiu9JYFR/cuAD26hKlbbd1x8rdF/kZiRLjR4/sYOK4tKx4n9Jh8QOVTe3rQoAdnioF3vMh9PYoBn4aeJUfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NjXG4rIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65591C072AA;
	Sat,  4 May 2024 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714841907;
	bh=0OETpdqFmiZsZQfia5vzI6GtuXGKoZjaMhc3cpwlH74=;
	h=Subject:To:From:Date:From;
	b=NjXG4rIFynlGmLDH7IC+rOcqNL2Wr9mmgE+D5jYIoK+lCZHK18dAcnX/o4nw0nmPU
	 lwJMrYNpP1Si1S8X8aZ5otGX0yhaA/pgaznBcwWGtucyjK2YGO7++TsBlndMATgSR1
	 NJH6QYwMHPu/bO8Ns7FTcIvFoXEV119PhPiupbww=
Subject: patch "iio: temperature: mcp9600: Fix temperature reading for negative" added to char-misc-next
To: dima.fedrau@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andrew.hepp@ahepp.dev,marcelo.schmitt1@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Sat, 04 May 2024 18:56:38 +0200
Message-ID: <2024050438-disfigure-sled-2751@gregkh>
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
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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



