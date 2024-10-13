Return-Path: <stable+bounces-83625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD1E99B9FA
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5CF1F21654
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706B4146A63;
	Sun, 13 Oct 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cyWZlazZ"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302BC1DFFC
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833166; cv=none; b=tWIvxvR6mtL98k880ul5/WVOX9Sd/SwYRV6x7s/748korneb9ngGUuDEMUrfzxXlrBpFfM4rljny4OkrE8VcZCmV41vZp1wzTxsaWOAWWEbovxZ3wBoNWFbztEYtg3lrzE7ccXuPuC+06eoN7gq/mC5n82stT0BCq0rLcckfp9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833166; c=relaxed/simple;
	bh=nTYTswiIdo3PHaMBrrQOPooWQ37pgT9hFcLIBef+Y1I=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=SXaZRG0zCbrUNI0Jg37zYSXekR47U8iApoy5ZqekR+zXp/8MuMgcRZZOmE0p5vgiJb5ia5YIPbbNaLE/xE6DNZYrwerPAKncTyEQN8xf3BCXgS6qhazreRrw/FiB69MvDVr4CdVwk2GwAYM3jXp2X0tQqHhPy7Aj/kWc7p1vhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cyWZlazZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E734C4CEC5;
	Sun, 13 Oct 2024 15:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833165;
	bh=nTYTswiIdo3PHaMBrrQOPooWQ37pgT9hFcLIBef+Y1I=;
	h=Subject:To:From:Date:From;
	b=cyWZlazZxUKkZPwmeQh4jKmHtPpBJYVL6Xv7fTiTWbunodFufdpxlPqgV1XWGOcj5
	 G3YUXPaQj/DzsT9/VAm5qQFhA2BJYbW6VN+kQSZ3rgc/GZb1MNENI7lzTwIcT4EiUe
	 ZK6cnc5+ewKsPHlTi6icufNGJKoYgw4ggRYq627w=
Subject: patch "iio: light: opt3001: add missing full-scale range value" added to char-misc-linus
To: emil.gedenryd@axis.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:25:54 +0200
Message-ID: <2024101354-papaya-circling-bd18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: opt3001: add missing full-scale range value

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 530688e39c644543b71bdd9cb45fdfb458a28eaa Mon Sep 17 00:00:00 2001
From: Emil Gedenryd <emil.gedenryd@axis.com>
Date: Fri, 13 Sep 2024 11:57:02 +0200
Subject: iio: light: opt3001: add missing full-scale range value

The opt3001 driver uses predetermined full-scale range values to
determine what exponent to use for event trigger threshold values.
The problem is that one of the values specified in the datasheet is
missing from the implementation. This causes larger values to be
scaled down to an incorrect exponent, effectively reducing the
maximum settable threshold value by a factor of 2.

Add missing full-scale range array value.

Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
Cc: <Stable@vger.kernel.org>
Link: https://patch.msgid.link/20240913-add_opt3002-v2-1-69e04f840360@axis.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/opt3001.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 887c4b776a86..176e54bb48c3 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -138,6 +138,10 @@ static const struct opt3001_scale opt3001_scales[] = {
 		.val = 20966,
 		.val2 = 400000,
 	},
+	{
+		.val = 41932,
+		.val2 = 800000,
+	},
 	{
 		.val = 83865,
 		.val2 = 600000,
-- 
2.47.0



