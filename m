Return-Path: <stable+bounces-179702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788AAB590C6
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F931BC5729
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 08:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E5223E229;
	Tue, 16 Sep 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HUgSM69B"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65244136E3F
	for <Stable@vger.kernel.org>; Tue, 16 Sep 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011624; cv=none; b=ZtjVHjWy1vM0tlzP2+IR82c1loX0sP4SnopRcfsOpcPeCSWo3AgO96xxz+h3vSzM4zibnWhUrsHlbYOfUfav/23BTUWM9ciCP2aafkkMsYNCWfV5OpN6wQdHngiN/m4BPsiwD1+Dkv+R4R2NR1wNVq2n7njQaUYUPuGX3W/GmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011624; c=relaxed/simple;
	bh=5QJTeKNYj2NbHprLJGY4ZUmj5k9gT0cg5KghdY8elhQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ZLBGkyOKm8owDUmT9bHROLf9gFIdlQU9SgScLLQ/ngH7M7XwnSr1M5MBTKN8yecQzR50oUmwUIDzbG6CRHEoFBnAt9odMqmq8tm/w05RpVi2L/KA5pkxpYltknatD/FvThf4qv1L13zgBxgDMnUMrWJWtpVCg0jEII6QTgjBZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HUgSM69B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B576BC4CEEB;
	Tue, 16 Sep 2025 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011624;
	bh=5QJTeKNYj2NbHprLJGY4ZUmj5k9gT0cg5KghdY8elhQ=;
	h=Subject:To:From:Date:From;
	b=HUgSM69BLH740jkcUxijDr9TL+VltYrbllXCOh79v6aZBdL8MirNh+cb+aSphJs5y
	 fEgROLbLBUB/SQ5o2EFWiEslZ0Zxp4FpyA21WdqkSBDrt39rcvfBri/SA6lzhEcLCH
	 ZtmANvWwSYyqtnKwLbb6yXuKlEQtlxRXRqfFmTJ8=
Subject: patch "iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE" added to char-misc-next
To: michael.hennerich@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Sep 2025 10:33:01 +0200
Message-ID: <2025091601-theft-caress-2ac5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 1d8fdabe19267338f29b58f968499e5b55e6a3b6 Mon Sep 17 00:00:00 2001
From: Michael Hennerich <michael.hennerich@analog.com>
Date: Fri, 29 Aug 2025 12:25:43 +0100
Subject: iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The clk div bits (2 bits wide) do not start in bit 16 but in bit 15. Fix it
accordingly.

Fixes: e31166f0fd48 ("iio: frequency: New driver for Analog Devices ADF4350/ADF4351 Wideband Synthesizers")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250829-adf4350-fix-v2-2-0bf543ba797d@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/frequency/adf4350.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/frequency/adf4350.h b/include/linux/iio/frequency/adf4350.h
index de45cf2ee1e4..ce2086f97e3f 100644
--- a/include/linux/iio/frequency/adf4350.h
+++ b/include/linux/iio/frequency/adf4350.h
@@ -51,7 +51,7 @@
 
 /* REG3 Bit Definitions */
 #define ADF4350_REG3_12BIT_CLKDIV(x)		((x) << 3)
-#define ADF4350_REG3_12BIT_CLKDIV_MODE(x)	((x) << 16)
+#define ADF4350_REG3_12BIT_CLKDIV_MODE(x)	((x) << 15)
 #define ADF4350_REG3_12BIT_CSR_EN		(1 << 18)
 #define ADF4351_REG3_CHARGE_CANCELLATION_EN	(1 << 21)
 #define ADF4351_REG3_ANTI_BACKLASH_3ns_EN	(1 << 22)
-- 
2.51.0



