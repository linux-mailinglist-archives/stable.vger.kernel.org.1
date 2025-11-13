Return-Path: <stable+bounces-194743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EF6C5A55E
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6C1E4EF1C7
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC62E4274;
	Thu, 13 Nov 2025 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="McG9fafR"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4E2E1F02
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073292; cv=none; b=enguyOYyPOL1MBY1dgJcylrYcKYMNZTt8Tb8eHFBsVF7ziCr+eaDml1flYXiqR8j4eGmzTdBWZyrVympb5k/7/ajGaBXQcaQH+jSZCUVEom6Go4EZ0Y0bYHOetUbGrjvR0N7kfU3d/eDtLBSENOWqr3tzcocqmYcf6atep5Lbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073292; c=relaxed/simple;
	bh=b18WXejFmlBtD6/iIc0c2IxZsfS2gQcJ8roIqxvRR7I=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=cNm+J+msvObZWeK9WlOB93Ejk27GJcokD1CHs7i0pvqANU8OZVAMH5PdDg+1QHT+FWyCkbNSPS9fs9r3A6VngqnvKR79FYW2TbPA8fA3I4vmfp2JvVQw6HAqHEDn9n8VvfAf6K0W0wWhhyr/D2OiXtvJnq3ekW/f0xXoJ8b7ueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=McG9fafR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D0BC4CEF7;
	Thu, 13 Nov 2025 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073291;
	bh=b18WXejFmlBtD6/iIc0c2IxZsfS2gQcJ8roIqxvRR7I=;
	h=Subject:To:From:Date:From;
	b=McG9fafR+JQE2LRZnUxC9mqa7R5lzI48G/p/w785McR4c4JkiG0go6qJrqToBZJFO
	 w4EZy0zUQEWHfncla1BPUkV/yY3pDb4eO/vf3qSEFSVWbUfp/L3m//GNY7upKiFC+B
	 IM7jbatUxdsJvHHOUvhIgW7Kw4m+jP5mHLP5gR0A=
Subject: patch "iio: adc: rtq6056: Correct the sign bit index" added to char-misc-linus
To: cy_huang@richtek.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andy_ya_hsu@wiwynn.com,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:49 -0500
Message-ID: <2025111349-unpopular-opponent-4d72@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: rtq6056: Correct the sign bit index

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 9b45744bf09fc2a3287e05287141d6e123c125a7 Mon Sep 17 00:00:00 2001
From: ChiYuan Huang <cy_huang@richtek.com>
Date: Thu, 18 Sep 2025 11:10:59 +0800
Subject: iio: adc: rtq6056: Correct the sign bit index

The vshunt/current reported register is a signed 16bit integer. The
sign bit index should be '15', not '16'.

Fixes: 4396f45d211b ("iio: adc: Add rtq6056 support")
Reported-by: Andy Hsu <andy_ya_hsu@wiwynn.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rtq6056.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index ad9738228b7f..2bf3a09ac6b0 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -300,7 +300,7 @@ static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
 		return IIO_VAL_INT;
 	case RTQ6056_REG_SHUNTVOLT:
 	case RTQ6056_REG_CURRENT:
-		*val = sign_extend32(regval, 16);
+		*val = sign_extend32(regval, 15);
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
-- 
2.51.2



