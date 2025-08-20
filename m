Return-Path: <stable+bounces-171884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F4B2D782
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 11:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734FF4E47F5
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C827056D;
	Wed, 20 Aug 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FYCkUyqH"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F722D8785
	for <Stable@vger.kernel.org>; Wed, 20 Aug 2025 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680773; cv=none; b=jMDz2JjFQ1FWOCK/G4AjWlJaiLS8aEMoBSSo1M8LkgdZDA53/c1FgIUu+CClXL7OmlxlDS6X66bL58tvnnatzot6UjDjf1qgkdwVc2/CwS+8uX976E//4p9Blxohik9VdfJJLa61y2932f5k6PbsQReIK7VQeSAs10mDrFxcrK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680773; c=relaxed/simple;
	bh=4pn6Cep8WI4zv2CvArn2mpCLDlM3Q/KVdRA/tYcHkck=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=OGAAD1Ysknd1XDgsUUmLAxbs07lVrcYucqVKZbMG7wGqaQL+vbpfPMsfJ/g4Fz+2ISlex/LugJ2nNCj3M0RdHAmQvDD40T2V6ZeHWa+Z5P/dPFBd1NlZpOZ15Cf2VsaEYbeLppDSK8x3gjdfZaKIE9AbhUJijDeNhx0HJD0hp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FYCkUyqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31A9C4CEEB;
	Wed, 20 Aug 2025 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755680773;
	bh=4pn6Cep8WI4zv2CvArn2mpCLDlM3Q/KVdRA/tYcHkck=;
	h=Subject:To:From:Date:From;
	b=FYCkUyqHoFFymW18fBN9DOhOtJCLjyvb7xgG7NslfZfBbgfpxkZ3y1rbuNf5bhLGp
	 ckLElfhFaZ5G5BMbwN3TOgodwgAn1LQPvpqUFc26TKXu2K7ja6oP6KfLOrn4zoQHyZ
	 iWHm7bmv+4Re9Jn/hUaqOEgg8BOtS1gbdpcLiD6c=
Subject: patch "iio: light: as73211: Ensure buffer holes are zeroed" added to char-misc-linus
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andy@kernel.org,mazziesaccount@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 Aug 2025 11:05:37 +0200
Message-ID: <2025082036-situation-vowel-e871@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: as73211: Ensure buffer holes are zeroed

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 433b99e922943efdfd62b9a8e3ad1604838181f2 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Sat, 2 Aug 2025 17:44:21 +0100
Subject: iio: light: as73211: Ensure buffer holes are zeroed

Given that the buffer is copied to a kfifo that ultimately user space
can read, ensure we zero it.

Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://patch.msgid.link/20250802164436.515988-2-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/as73211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 68f60dc3c79d..32719f584c47 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -639,7 +639,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 	struct {
 		__le16 chan[4];
 		aligned_s64 ts;
-	} scan;
+	} scan = { };
 	int data_result, ret;
 
 	mutex_lock(&data->mutex);
-- 
2.50.1



