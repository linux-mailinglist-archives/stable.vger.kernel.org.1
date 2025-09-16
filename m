Return-Path: <stable+bounces-179697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD50B590B5
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94396323488
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 08:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D31B532F;
	Tue, 16 Sep 2025 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qshY8kNw"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A1257832
	for <Stable@vger.kernel.org>; Tue, 16 Sep 2025 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011516; cv=none; b=MOLKBuie20dkwIIpeXlkPjZK05Glf6JbBYBh/i1wyeGRNn6SphneVOSuVke/MYVUfh6pijzsyVogGuax6mpSTzNuCQEUrvBGbi4kRbSbMrcO4cV2fnmT/lHMu57RtRhxxialI1IY/5SSt0zOj2uF4G81/JzcQ6OH5veXx9rh6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011516; c=relaxed/simple;
	bh=K4PtAlOrCdEWiCPexoO9lTKZRMHFV0kxllbQQq/67LU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=EpRhWEkGWas0lgRbBZs2/kS2HMZKiU96otPR4ywq5GW33m02We5dIgJHJLpuwzzdEBYCbsJJ4PB6MDOLrThqDODMPXHfqjNDa1ZjpgvF3myH+/Kk/zHsFRKeimzsTCXM+DtQm4x2OrxCJkQu9vNTqfL3YS2aNBsp311yvYaHBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qshY8kNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1DBC4CEF9;
	Tue, 16 Sep 2025 08:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011516;
	bh=K4PtAlOrCdEWiCPexoO9lTKZRMHFV0kxllbQQq/67LU=;
	h=Subject:To:From:Date:From;
	b=qshY8kNwQFQdDOftjYqMbn6LhNis6dmSvUiGCgDrjz7KUFVi2pTUsU6a6zENUVK2V
	 IzfSmzp+FUm6amWnloLhIXKpDGzDUbwGurg1Te5UXcZvRg6IFMw0kbWu/i0pb1OU6p
	 LIaawE3eS73TnsR5Tnfx2DKPpef5Ls/d3+cv9Nx4=
Subject: patch "iio: dac: ad5421: use int type to store negative error codes" added to char-misc-testing
To: rongqianfeng@vivo.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Sep 2025 10:31:33 +0200
Message-ID: <2025091633-prepay-turkey-232f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad5421: use int type to store negative error codes

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 3379c900320954d768ed9903691fb2520926bbe3 Mon Sep 17 00:00:00 2001
From: Qianfeng Rong <rongqianfeng@vivo.com>
Date: Mon, 1 Sep 2025 21:57:26 +0800
Subject: iio: dac: ad5421: use int type to store negative error codes

Change the 'ret' variable in ad5421_update_ctrl() from unsigned int to
int, as it needs to store either negative error codes or zero returned
by ad5421_write_unlocked().

Fixes: 5691b23489db ("staging:iio:dac: Add AD5421 driver")
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Link: https://patch.msgid.link/20250901135726.17601-3-rongqianfeng@vivo.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad5421.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 1462ee640b16..d9d7031c4432 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -186,7 +186,7 @@ static int ad5421_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
 	unsigned int clr)
 {
 	struct ad5421_state *st = iio_priv(indio_dev);
-	unsigned int ret;
+	int ret;
 
 	mutex_lock(&st->lock);
 
-- 
2.51.0



