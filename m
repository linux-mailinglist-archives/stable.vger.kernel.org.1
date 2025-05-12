Return-Path: <stable+bounces-143225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81BAB34A5
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8015017D16D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13C925A341;
	Mon, 12 May 2025 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zyOMRgqw"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245B29D0B
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044991; cv=none; b=o0uEs2RBCPk70WvGppzowlTutmPFuLuj+6OdNSadfnHKtUF51xlohzcIWw8SlpE2BfkGrDY//ujrCnE3RD8ZDUfsbnCIN/2PesVYcItd3iKR1LA3CcWPsW3H2hbBtVJyJiG4892/d5yZy2f1lCrP5Q+1skVBgsK8thzmFdCf2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044991; c=relaxed/simple;
	bh=gtQE/iZovn55FqB3j4s/khK8PLYk+ZfQFLcQZ5PzjU8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X2bmopjs4UXo22xYSIiSB7vLgLcWSdGehWW3yuR7LHZV0/YTJZcGTkYLEIQX299wPXS5rzcSH1FbwXlfeQpNbwxljnFVCDTYFdtKbCixVWpZlbjGtABu2Up7sLgR0VYMt+eOY3cxxH7f8vgzwh31rKk76ySQz3aJoSQk1bfU6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zyOMRgqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC80EC4CEE7;
	Mon, 12 May 2025 10:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044991;
	bh=gtQE/iZovn55FqB3j4s/khK8PLYk+ZfQFLcQZ5PzjU8=;
	h=Subject:To:Cc:From:Date:From;
	b=zyOMRgqwHIcbuEBAxesukKSQ+fWeqpBmUVoPf7v8RhtDGzA/mDtE7OYiN0mV3f3FT
	 p/mXikuiBQWSJtjLsb9Gml0JtQMgPMG3DXPymjLSchMqB/pwI8CkFYvlndsxC7XVDq
	 mwld34976qVmDXYhhsXozOQRDW7Cyz8vpp7VvpKo=
Subject: FAILED: patch "[PATCH] iio: adc: ad7266: Fix potential timestamp alignment issue." failed to apply to 5.4-stable tree
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:16:16 +0200
Message-ID: <2025051216-wreath-barrier-759f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 52d349884738c346961e153f195f4c7fe186fcf4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051216-wreath-barrier-759f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52d349884738c346961e153f195f4c7fe186fcf4 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Sun, 13 Apr 2025 11:34:24 +0100
Subject: [PATCH] iio: adc: ad7266: Fix potential timestamp alignment issue.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On architectures where an s64 is only 32-bit aligned insufficient padding
would be left between the earlier elements and the timestamp. Use
aligned_s64 to enforce the correct placement and ensure the storage is
large enough.

Fixes: 54e018da3141 ("iio:ad7266: Mark transfer buffer as __be16") # aligned_s64 is much newer.
Reported-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250413103443.2420727-2-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 18559757f908..7fef2727f89e 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -45,7 +45,7 @@ struct ad7266_state {
 	 */
 	struct {
 		__be16 sample[2];
-		s64 timestamp;
+		aligned_s64 timestamp;
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 


