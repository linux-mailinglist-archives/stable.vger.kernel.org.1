Return-Path: <stable+bounces-20190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D1854CA2
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 16:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BFF1F24A58
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098645C604;
	Wed, 14 Feb 2024 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBrcUPYK"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35A43157
	for <Stable@vger.kernel.org>; Wed, 14 Feb 2024 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924399; cv=none; b=i1C/P3bp7ms5zBwqY7IsH+6e6pFcLl3HTsU1qKQ+spAyx/L9Ql2gvHgfwgapEhQuir1Ah37QExGtmxxpDhNLS3BeD/nyncdUtH5/2TOW46bRlu0m0jx4HMLetxX2TlcmrKnW5lhM9in2CpgXdJsk+GevM8VRHelDFYflZxXVKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924399; c=relaxed/simple;
	bh=Of5TOuhO9y89GtT/+7C8Y3OkzmPdiNF6WNpVZYDSYiY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=bX5dj5Ploh8fHrS3uTgux/0QXPm/hanymmIEFkEOxkSRzxGNgy5ok8Jm2unXTl7XtM1v+Ee0Rq+whJQnAoqPZSWWQ+9lV/Htvgt+Ym81JocS69jxZXCuZfQZOrLB5xtknpHewXHUYiaZCuc6SKawpcdODIEOhDX6g6DKE2PjNbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBrcUPYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFFEC433C7;
	Wed, 14 Feb 2024 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924399;
	bh=Of5TOuhO9y89GtT/+7C8Y3OkzmPdiNF6WNpVZYDSYiY=;
	h=Subject:To:From:Date:From;
	b=WBrcUPYKrehi0kbhNpWUN6tB+KU3SIFvuqeL5Pqr7Q8xiBXaSotAG17bvsuNKoKyh
	 38H6GefRtxQzGqtfV1CcGq2Nfw7EACgvBfbF2/0rSEhOV90/vGmYaABFkuxvz8WSfO
	 61Ou+++jQNeLvpV3rb3PZQCmj4FBv+m56FT7aJ7I=
Subject: patch "staging: iio: ad5933: fix type mismatch regression" added to char-misc-linus
To: david.schiller@jku.at,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Feb 2024 16:26:09 +0100
Message-ID: <2024021409-routine-relax-3398@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    staging: iio: ad5933: fix type mismatch regression

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 6db053cd949fcd6254cea9f2cd5d39f7bd64379c Mon Sep 17 00:00:00 2001
From: David Schiller <david.schiller@jku.at>
Date: Mon, 22 Jan 2024 14:49:17 +0100
Subject: staging: iio: ad5933: fix type mismatch regression

Commit 4c3577db3e4f ("Staging: iio: impedance-analyzer: Fix sparse
warning") fixed a compiler warning, but introduced a bug that resulted
in one of the two 16 bit IIO channels always being zero (when both are
enabled).

This is because int is 32 bits wide on most architectures and in the
case of a little-endian machine the two most significant bytes would
occupy the buffer for the second channel as 'val' is being passed as a
void pointer to 'iio_push_to_buffers()'.

Fix by defining 'val' as u16. Tested working on ARM64.

Fixes: 4c3577db3e4f ("Staging: iio: impedance-analyzer: Fix sparse warning")
Signed-off-by: David Schiller <david.schiller@jku.at>
Link: https://lore.kernel.org/r/20240122134916.2137957-1-david.schiller@jku.at
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index e748a5d04e97..9149d41fe65b 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -608,7 +608,7 @@ static void ad5933_work(struct work_struct *work)
 		struct ad5933_state, work.work);
 	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
 	__be16 buf[2];
-	int val[2];
+	u16 val[2];
 	unsigned char status;
 	int ret;
 
-- 
2.43.1



