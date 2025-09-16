Return-Path: <stable+bounces-179703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7EB590C7
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDA11BC56B0
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 08:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AFE1FBC92;
	Tue, 16 Sep 2025 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="idJNvsLI"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAFD23313E
	for <Stable@vger.kernel.org>; Tue, 16 Sep 2025 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011627; cv=none; b=IJIwzou1GgzPtWvJPD9tJ+xGU+z7o4AHD30Fay7TqlNadYhAjliDt1laGIHYsGnpp9f27YxPNONkEcPbQiKLvpkloF3Kj3UGCDDsuOSqOBuymC6Yl7emiVeV5n5c/RbnJNd7cdysc7LGEPsw9LhbogqlomPNVWijLey4nSJhbxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011627; c=relaxed/simple;
	bh=lju69sSnw4X97oj1YWZ6suOYtEadz6FGo4vXS3JxHMk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=NAjrfKhFLg2sBXb11PruLiC9S+IZSmVTkbuYCcSyVJaUP1luKde2NCCE1bNSRmthTCDyVb3Up7XaWvYHK8NtzBnAKV/0FES9bLOaIsKQKyOlORwr/IJJmTF18XsouMDZCOtmxTnUoBJ4BfczLkxRC+1GsOpSefJBBFnz108XUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=idJNvsLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D945C4CEEB;
	Tue, 16 Sep 2025 08:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011627;
	bh=lju69sSnw4X97oj1YWZ6suOYtEadz6FGo4vXS3JxHMk=;
	h=Subject:To:From:Date:From;
	b=idJNvsLI4HZfMBwUxeMlxIOY6sdl9TJd1EcRmw3Qfm7QE+cdvsV9CEUU4JbV+rtPn
	 5sdNW8xSiQAwNGehg9GN10qBzOlxEcieJiPPlj3LHjyGulb65hQYWvmW7vcDo8srwT
	 mB/v2f2+hA+5w8CApcn+rJb1VC7UapEwmNSONf4Q=
Subject: patch "iio: dac: ad5360: use int type to store negative error codes" added to char-misc-next
To: rongqianfeng@vivo.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Sep 2025 10:33:01 +0200
Message-ID: <2025091601-thyself-commute-6cc1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad5360: use int type to store negative error codes

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From f9381ece76de999a2065d5b4fdd87fa17883978c Mon Sep 17 00:00:00 2001
From: Qianfeng Rong <rongqianfeng@vivo.com>
Date: Mon, 1 Sep 2025 21:57:25 +0800
Subject: iio: dac: ad5360: use int type to store negative error codes

Change the 'ret' variable in ad5360_update_ctrl() from unsigned int to
int, as it needs to store either negative error codes or zero returned
by ad5360_write_unlocked().

Fixes: a3e2940c24d3 ("staging:iio:dac: Add AD5360 driver")
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Link: https://patch.msgid.link/20250901135726.17601-2-rongqianfeng@vivo.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad5360.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index a57b0a093112..8271849b1c83 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -262,7 +262,7 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	unsigned int clr)
 {
 	struct ad5360_state *st = iio_priv(indio_dev);
-	unsigned int ret;
+	int ret;
 
 	mutex_lock(&st->lock);
 
-- 
2.51.0



