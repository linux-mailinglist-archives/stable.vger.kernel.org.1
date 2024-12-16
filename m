Return-Path: <stable+bounces-104372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CF89F3491
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79FB1887D0F
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33D4136349;
	Mon, 16 Dec 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C9N8pVsC"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229C17C64
	for <Stable@vger.kernel.org>; Mon, 16 Dec 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363177; cv=none; b=Izpx6F4jN36e4irTxXpZp4lI7vDVGri0mDySWGrfrcPisXCV3DWLoeFLmi5WjBNZhLQE4N+O7fkC3sFI95zO5tpYZN7hsdYFjKTLxWqtoRWYYvaXoyJwU6JB1pF4UvrowZWhj/mYSCb/kZlazsFxzhtaZOr/a3jMuUduV+GfHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363177; c=relaxed/simple;
	bh=7lSjTnUABwTj0y/lbKboeAU9IoiISEu23zRvHja0ZOw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=k8x8v/gBcOdaHBTdJSYcjZVOGYBdq03N8+BrfzNRK3Z9j7YXt9FvMXwcJifBmfWeObkJBN+0QZt8pEJcwexpPfK7UBzkM6Zyxk6U17AYRbMUtcV4l1MF5FNms9aXdAHb/rI6T8085US51KFjM+bAU8RllHuW6+asSjJ8s/yY2tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C9N8pVsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD6BC4CED0;
	Mon, 16 Dec 2024 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734363177;
	bh=7lSjTnUABwTj0y/lbKboeAU9IoiISEu23zRvHja0ZOw=;
	h=Subject:To:From:Date:From;
	b=C9N8pVsC3x+vy0pnULSkG7nanKe1jNXihs4jC52sakBENE/djunnL0bNCUyL/UyPl
	 yj1Mdv1AAoB54i8jXOQF7zmrluUr6cLf3jaaBTose7doSXK4aUHLKrFDJf/arGFfoH
	 J9OQzvtnyYn4X9DmkYHlfvt9w5j/iJyw8OqAoJbc=
Subject: patch "iio: adc: at91: call input_free_device() on allocated iio_dev" added to char-misc-linus
To: joe@pf.is.s.u-tokyo.ac.jp,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Dec 2024 16:31:44 +0100
Message-ID: <2024121643-corroding-contrite-83b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: at91: call input_free_device() on allocated iio_dev

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From de6a73bad1743e9e81ea5a24c178c67429ff510b Mon Sep 17 00:00:00 2001
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Date: Sat, 7 Dec 2024 13:30:45 +0900
Subject: iio: adc: at91: call input_free_device() on allocated iio_dev

Current implementation of at91_ts_register() calls input_free_deivce()
on st->ts_input, however, the err label can be reached before the
allocated iio_dev is stored to st->ts_input. Thus call
input_free_device() on input instead of st->ts_input.

Fixes: 84882b060301 ("iio: adc: at91_adc: Add support for touchscreens without TSMR")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Link: https://patch.msgid.link/20241207043045.1255409-1-joe@pf.is.s.u-tokyo.ac.jp
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/at91_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index a3f0a2321666..5927756b749a 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -979,7 +979,7 @@ static int at91_ts_register(struct iio_dev *idev,
 	return ret;
 
 err:
-	input_free_device(st->ts_input);
+	input_free_device(input);
 	return ret;
 }
 
-- 
2.47.1



