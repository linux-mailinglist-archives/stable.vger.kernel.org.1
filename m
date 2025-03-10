Return-Path: <stable+bounces-121698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73A6A59213
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C193B0AF7
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB64227E8A;
	Mon, 10 Mar 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yEhtgwsL"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B42253ED;
	Mon, 10 Mar 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604110; cv=none; b=XwHHufUj81E9FrzBE8bnyioXIQxO7Pabd+ThrV+cA4g3e/ORZZu8+sEbJS9pSePk/1JM656q1donFYK3/XemoRe97npm1LmcxoMYIK5whtLsYsFKFUxSLcPvI3Yjoe1loQbQTx5F37ZZ+AAqTT7DbQ9sEFl6VCIAcE7uj4uH33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604110; c=relaxed/simple;
	bh=DwjiqbOPcvwFpHcaDUPFkm/lGfZE5Kj5xWUfEKCkTxY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ltJmy/oBmM7Dy7antGtoMSjNt4UpvxmIz13OUSHyTKbj4TrIhM2wGgI5Cc2mfWdBInBnsXoV8hFz6Xzk6TyQhzP7llIfjltFqYob7ZvXwGprTxDnCHfcpUOdGv9Hn6Yj97NlpA4IKqFOoFktgwYHYia5ga8UgeIEOH08NXBS+VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yEhtgwsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BFFC4CEE5;
	Mon, 10 Mar 2025 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741604109;
	bh=DwjiqbOPcvwFpHcaDUPFkm/lGfZE5Kj5xWUfEKCkTxY=;
	h=Subject:To:Cc:From:Date:From;
	b=yEhtgwsL5+x1sHrTQd/pruI1Xf/ZmNUSfedErtTBgBA/HDHOMWFQUD1dPikoQLzP3
	 9Bfu9WzjD0cEPDqQa7bZW6iF2Bq6PHsp0QMev/vesjv6ttTLjRdD0d7/pawoBUCmBS
	 bFi/xHDk8BplQTLbYGaUmxH1Lbidn2qIXiSGDQw0=
Subject: Patch "iio: dac: ad3552r: clear reset status flag" has been added to the 6.12-stable tree
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,adureghello@baylibre.com,gregkh@linuxfoundation.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Mar 2025 11:53:49 +0100
Message-ID: <2025031049-afflicted-mangy-4da9@gregkh>
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

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iio-dac-ad3552r-clear-reset-status-flag.patch
and it can be found in the queue-6.12 subdirectory.

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
@@ -714,6 +714,12 @@ static int ad3552r_reset(struct ad3552r_
 		return ret;
 	}
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = ad3552r_write_reg(dac, AD3552R_REG_ADDR_ERR_STATUS,
+				AD3552R_MASK_RESET_STATUS);
+	if (ret)
+		return ret;
+
 	return ad3552r_update_reg_field(dac,
 					addr_mask_map[AD3552R_ADDR_ASCENSION][0],
 					addr_mask_map[AD3552R_ADDR_ASCENSION][1],


Patches currently in stable-queue which might be from adureghello@baylibre.com are

queue-6.12/iio-dac-ad3552r-clear-reset-status-flag.patch

