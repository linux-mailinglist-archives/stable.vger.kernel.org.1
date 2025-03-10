Return-Path: <stable+bounces-121696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0BDA59150
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55845188B74D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1355C226CE6;
	Mon, 10 Mar 2025 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLmrjqxJ"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C1D18C011;
	Mon, 10 Mar 2025 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603036; cv=none; b=ouYeYkFstNDjmbco2EdBpiSTwD7hgXS6RoPq+Z+7VOWnZh01ylspN/r6LfZ/AwFfY3qdOJQpWqorcN1i/pRJstImdE/7hJ8Pm4lM6LN7XbCtBMaob3i4vJ2Zh/Ym6NPANKAthpknEPiBxabgyxcErVaIgfjv5uDdNmSS0GSbZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603036; c=relaxed/simple;
	bh=y00EQZIJvf+cwpaf3/dijE7HqWuVqTtk69AAJ7FkSiM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qog44SoStOlbrp5hz0GBBf4KwPJR37EyqiizrxYqXw0YNntrP8MHxYlgkpNFjgM8M+6C14G+gDED9IWQ7DSox6bpal+wmZlHWg8FpFzYjJEWPRqBUVp7DFeVc6Nzi+J70Gpa1YmGEUQx79Ml7R4D5clHZsAP7W9bEXcpKJZbqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLmrjqxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF79C4CEE5;
	Mon, 10 Mar 2025 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741603036;
	bh=y00EQZIJvf+cwpaf3/dijE7HqWuVqTtk69AAJ7FkSiM=;
	h=Subject:To:Cc:From:Date:From;
	b=bLmrjqxJ8sH3AcS/x76n0eTm7aUjkQtHHZD+RNtUtZ9SRPtS45SvmssQ0WHT9mzMk
	 X+OYa6rWEl7yEsMuB6RxLOjAhhZ9T8ivKCcY++Bqnv5KKtPJx9vqLim1krTT/q0DLo
	 UTabxbGUT2fKy7HqF9Pd0l5fPb98EovYbsh2k56k=
Subject: Patch "iio: dac: ad3552r: clear reset status flag" has been added to the 6.13-stable tree
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,adureghello@baylibre.com,gregkh@linuxfoundation.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Mar 2025 11:33:58 +0100
Message-ID: <2025031057-eldest-oversold-0328@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    iio: dac: ad3552r: clear reset status flag

to the 6.13-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iio-dac-ad3552r-clear-reset-status-flag.patch
and it can be found in the queue-6.13 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From e17b9f20da7d2bc1f48878ab2230523b2512d965 Mon Sep 17 00:00:00 2001
From: Angelo Dureghello <adureghello@baylibre.com>
Date: Sat, 25 Jan 2025 17:24:32 +0100
Subject: iio: dac: ad3552r: clear reset status flag

From: Angelo Dureghello <adureghello@baylibre.com>

commit e17b9f20da7d2bc1f48878ab2230523b2512d965 upstream.

Clear reset status flag, to keep error status register clean after reset
(ad3552r manual, rev B table 38).

Reset error flag was left to 1, so debugging registers, the "Error
Status Register" was dirty (0x01). It is important to clear this bit, so
if there is any reset event over normal working mode, it is possible to
detect it.

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Link: https://patch.msgid.link/20250125-wip-bl-ad3552r-clear-reset-v2-1-aa3a27f3ff8c@baylibre.com
Cc: <Stable@vger..kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/ad3552r.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -410,6 +410,12 @@ static int ad3552r_reset(struct ad3552r_
 		return ret;
 	}
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = ad3552r_write_reg(dac, AD3552R_REG_ADDR_ERR_STATUS,
+				AD3552R_MASK_RESET_STATUS);
+	if (ret)
+		return ret;
+
 	return ad3552r_update_reg_field(dac,
 					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
 					AD3552R_MASK_ADDR_ASCENSION,


Patches currently in stable-queue which might be from adureghello@baylibre.com are

queue-6.13/iio-dac-ad3552r-clear-reset-status-flag.patch

