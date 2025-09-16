Return-Path: <stable+bounces-179704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54515B590C3
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BE017D657
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66190284689;
	Tue, 16 Sep 2025 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7Ql8rkg"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F01281368
	for <Stable@vger.kernel.org>; Tue, 16 Sep 2025 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011631; cv=none; b=iRzrqzNuJxQo6ad/QImaML/CfXKB2wTGZ772TcnZy6kqU2TuTqxCTKB1+jT3JCKD7ljDjxCRtY+OFCoPi7OhYkP7h7U1JE4Wo7VsWsm2UCMiEFAWsc07VtCDpkEFclent58Lr2K8NSpd5KJZI5S6Lg9ahbJkjkU9FounEZCl9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011631; c=relaxed/simple;
	bh=QIXKVxCbVzAvJGxLiNQDDku7J0B+xXP3VoR5p4kSKxM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=NI7JltZClOIMHyiKMDYjhPJrNUL2EyQ+7SR0HnkbUH4hJZFV96fQmNylZS01R2dDz3jHiRKddj+gxHa9AoQRfB9nMZiFzhWS9PbwLpr3yF9uTs9jfCk5IZflc0YV/bOKV3MqJM7tNDG46a9EzOxmnU5kbeLczR6PW95Fi1Tgnek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7Ql8rkg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94376C4CEEB;
	Tue, 16 Sep 2025 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011631;
	bh=QIXKVxCbVzAvJGxLiNQDDku7J0B+xXP3VoR5p4kSKxM=;
	h=Subject:To:From:Date:From;
	b=f7Ql8rkgxk4IGaKIM25ehvJlq/Sm5lBL4C61XopgSD/gF5Y74dgqGReum2gaekYeP
	 DAVJNvxVmwMCE+twmlM1wW7p1UlFTpO/NvSjrvPWyNFN2ddbtWwJi6BnkVsoJmZTwU
	 w8q8cR4dsA/rxfkS6K9b5Exe855jEVBE6kJM7cO4=
Subject: patch "iio: dac: ad5421: use int type to store negative error codes" added to char-misc-next
To: rongqianfeng@vivo.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Sep 2025 10:33:01 +0200
Message-ID: <2025091601-splashing-enjoying-bab4@gregkh>
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
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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



