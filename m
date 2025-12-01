Return-Path: <stable+bounces-197925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C84A0C97F41
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 16:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E24A64E2B6F
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248111B87C0;
	Mon,  1 Dec 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWRgJfOz"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F23164DF
	for <Stable@vger.kernel.org>; Mon,  1 Dec 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601465; cv=none; b=PFDPnw6J3GJm+zGHjuzla6Ez6zZqi6PFgGh/tTOGvQ/9pxlQ+7HpBYY7vIT7CUJ7ii87RC9q514DkMreubbVahxVLReTkp7ds4MN9nZVH/2kjFsKxFtCJXQTP9mSdGRGk/OIC+A1fnT2LCJaAq783AH26vOKpAZ/aphSx3c7EiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601465; c=relaxed/simple;
	bh=Py2Vsq0rHLg+wWZDqHLORkx5vIkDxGhVIiRljdU8TjI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g/asAPdNsuKw+T3CbTGDPEHAaRIbMBLOfcjnw1/J6V7QK3c9tqUWeES5+imteAFB1IBu4rijrtwEqcDlmhcz84ufsIQBU4dEKhr+Rs9EcwB2c/p8QeH3xsidkTLyU4km19eSeBYnscBtDFDH8Noo+djydcEW9ZZlBYJlf29jU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWRgJfOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB16AC4CEF1;
	Mon,  1 Dec 2025 15:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764601465;
	bh=Py2Vsq0rHLg+wWZDqHLORkx5vIkDxGhVIiRljdU8TjI=;
	h=Subject:To:Cc:From:Date:From;
	b=MWRgJfOzFzZjtuDHSE7zQmCkXwWQdoKul1yiobYha6WmpXOdEwL2UeN/8FX56lpBX
	 XwDltMMvyVVVnLYmarcAeBOAjiAE0FvpFLJ8+W8iKSqoU0f4rdXiXI5Zy4fZYnCKuR
	 niemk5VOpYQOy0gzTEBVqjc3LhRlsF6PB+4aFDJs=
Subject: FAILED: patch "[PATCH] iio: adc: rtq6056: Correct the sign bit index" failed to apply to 6.1-stable tree
To: cy_huang@richtek.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andy_ya_hsu@wiwynn.com,dlechner@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 16:04:13 +0100
Message-ID: <2025120113-employed-paddle-1a20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9b45744bf09fc2a3287e05287141d6e123c125a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120113-employed-paddle-1a20@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b45744bf09fc2a3287e05287141d6e123c125a7 Mon Sep 17 00:00:00 2001
From: ChiYuan Huang <cy_huang@richtek.com>
Date: Thu, 18 Sep 2025 11:10:59 +0800
Subject: [PATCH] iio: adc: rtq6056: Correct the sign bit index

The vshunt/current reported register is a signed 16bit integer. The
sign bit index should be '15', not '16'.

Fixes: 4396f45d211b ("iio: adc: Add rtq6056 support")
Reported-by: Andy Hsu <andy_ya_hsu@wiwynn.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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


