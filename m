Return-Path: <stable+bounces-52584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2012890B8F5
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF408281D3A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB55199EBA;
	Mon, 17 Jun 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="omVgpXcf"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E5199EAA
	for <Stable@vger.kernel.org>; Mon, 17 Jun 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647365; cv=none; b=ebmV7JHvGf9qPgc7W2kSP2wrF7b+q4WYq/v0yiAzeoy6Up8wP0QSSwKzn7JD1Ek7e6kxUJ3xgpdAuBzt4LjUJvDjyTp6yYsrm7IgoviZXgDCKbYsYa15YImQ2LTYoeN/26mBybLAO7Vavp5la4wOpQGXDRsZVWaoLEEJQJqhE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647365; c=relaxed/simple;
	bh=jUFmDg5B2IbWHzBWgB3JwpicLK2rf0016LtG1KKeEm4=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=PjErz43CURwzlXLngRq74PHM4LUNpdPs7SBXuvTSPNIbbjyAjgmrFEu0Xxi/ONbG2AVn5F5OmklkzkP/MkllnKGJqGwMNHmXWyVj6z+Nf5Lo2XJ04yExXHtSg+vk0DcSF3hTnOsLdJ++Cw8/TxNCvZ+NqcgRihSRWNSwhkhTAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=omVgpXcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0582C2BD10;
	Mon, 17 Jun 2024 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718647365;
	bh=jUFmDg5B2IbWHzBWgB3JwpicLK2rf0016LtG1KKeEm4=;
	h=Subject:To:From:Date:From;
	b=omVgpXcfHjCHNXi43LU9CnZDB30Cm5rmqwpOBJJwcdN+HmkvwRs+Br7iWxv2ivRwf
	 6P1c48bg2gB/M35XAP4FKFdHjgw380JFpQ2KkmRzgfr80wPbx6TT8kK1v/ehvY4OAf
	 K2y08YcX1tO7DW1J0eSt9aHGG5xmiglZuZJS6Kc8=
Subject: patch "iio: adc: ad7266: Fix variable checking bug" added to char-misc-linus
To: hagisf@usp.br,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 20:02:39 +0200
Message-ID: <2024061739-corporal-renderer-9589@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7266: Fix variable checking bug

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a2b86132955268b2a1703082fbc2d4832fc001b8 Mon Sep 17 00:00:00 2001
From: Fernando Yang <hagisf@usp.br>
Date: Mon, 3 Jun 2024 15:07:54 -0300
Subject: iio: adc: ad7266: Fix variable checking bug

The ret variable was not checked after iio_device_release_direct_mode(),
which could possibly cause errors

Fixes: c70df20e3159 ("iio: adc: ad7266: claim direct mode during sensor read")
Signed-off-by: Fernando Yang <hagisf@usp.br>
Link: https://lore.kernel.org/r/20240603180757.8560-1-hagisf@usp.br
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7266.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 353a97f9c086..13ea8a1073d2 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -157,6 +157,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 		ret = ad7266_read_single(st, val, chan->address);
 		iio_device_release_direct_mode(indio_dev);
 
+		if (ret < 0)
+			return ret;
 		*val = (*val >> 2) & 0xfff;
 		if (chan->scan_type.sign == 's')
 			*val = sign_extend32(*val,
-- 
2.45.2



