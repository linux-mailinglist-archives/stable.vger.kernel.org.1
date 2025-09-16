Return-Path: <stable+bounces-179698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64763B590B2
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B7C3B4677
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53B92135B8;
	Tue, 16 Sep 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0DA/CMUc"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B22288EE
	for <Stable@vger.kernel.org>; Tue, 16 Sep 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011520; cv=none; b=CdQ7Ytmp8TnRXGk6cdzXDZ8Jk+LsDkmyMY/uZi/Ss9Hh4vzscB0YC80ip+yVtUzjwcArNgfqEdl8M0AWORfd0Y/9TRtD4DyT5GICcVgSVLZ3CZRWSbH+3atF5g2fShwevN0FZ2OuXZ8pHRY/PtbwR8qoOIv81Pd+vkaAy8dS31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011520; c=relaxed/simple;
	bh=ZGlA0zR95Sb8vYta0tA+Nd0pKK5Orf0V7/szjzAyFsE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=q56m/+mcduqrtDZht+Di8keug/pyvf83hdUQEvVukQpPHXTXBCqMOv5ofPQclDaPaAu61pOWJkuLtSMoDWyTK/GADcaguG55G1nFtsqQztrQkXz+agza5zmCS//Ee6f2bolCtcbBaTEgriOGbMhHYVLGLyDZQt115xCkiQQfSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0DA/CMUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC23C4CEEB;
	Tue, 16 Sep 2025 08:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011520;
	bh=ZGlA0zR95Sb8vYta0tA+Nd0pKK5Orf0V7/szjzAyFsE=;
	h=Subject:To:From:Date:From;
	b=0DA/CMUcXScogzi8HYZ8rF0XyDxsgVW73UtjPYrQsAlrhVTYb7eVGn0yngMQZM7Iz
	 lvDSB9UR0KS0rTWJt87sO3xsnu36Y5eGi6jZewhK6AGwkhOj51vuih8CYXZrBqlYPg
	 XeMgW7nDhzomF9Jy2vR4DGVK+7Yj7BO1BG10bBWg=
Subject: patch "iio: dac: ad5360: use int type to store negative error codes" added to char-misc-testing
To: rongqianfeng@vivo.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Sep 2025 10:31:33 +0200
Message-ID: <2025091632-footman-neurotic-89c4@gregkh>
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
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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



