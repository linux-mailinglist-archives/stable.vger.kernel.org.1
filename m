Return-Path: <stable+bounces-197924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C98C97F3B
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 16:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAFD44E20F9
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474F231D380;
	Mon,  1 Dec 2025 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HRwxaMyg"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2331CA5F
	for <Stable@vger.kernel.org>; Mon,  1 Dec 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601458; cv=none; b=RDlZ7NNdtjZxVRjFhoMehnwB3S3Gedy9HGiuAMRANx3Pod5ByxXoU/v7weAeteNbeIzTvaM7+gcogSibKJlHBxVaLlEB9C/PHJFPcNVTslxdVmHMGTFUAr2lIhEdxKWEyaI6teLWHyFU1dwAhqq3pzRTEbDSsN+LHbTCVCsOF6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601458; c=relaxed/simple;
	bh=D7wAhLduIJ4AaXgp4xLATnk+y5GRbAmfp+awJwWNUrc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lCBMOW3wSw0dWNO99re0IKDdXvgzkMdpjEvY70OmJgv7iyjxDaewD+gIfuvlAuz0cbMTzQ33cWp3SumsF7Y4CeFks2+X6tKd0lsbK8fw2HvT9zjpQ7SkccRitQCJfE3FB83XoyZ48JVystIpPrZCBnCaPACbspz75cBJhNjRcLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HRwxaMyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20DAC4CEF1;
	Mon,  1 Dec 2025 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764601457;
	bh=D7wAhLduIJ4AaXgp4xLATnk+y5GRbAmfp+awJwWNUrc=;
	h=Subject:To:Cc:From:Date:From;
	b=HRwxaMygr5k61O576EkFwDJMzBDXgptRqaT+IfJn3/6hySDKW/E8MVV4+dPvmlpa8
	 THFDibINiES0dsTTcr2ySbquHlVv3TJ67InrDVlI40bBAUZ9LPTAoWqpI+XWWusvoO
	 qs2h77W89KNMCxU0Z8ox0Bt/FYlE35Hm2FwH1GHw=
Subject: FAILED: patch "[PATCH] iio: adc: rtq6056: Correct the sign bit index" failed to apply to 6.6-stable tree
To: cy_huang@richtek.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andy_ya_hsu@wiwynn.com,dlechner@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 16:04:13 +0100
Message-ID: <2025120113-voltage-chamber-e0d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9b45744bf09fc2a3287e05287141d6e123c125a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120113-voltage-chamber-e0d4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


