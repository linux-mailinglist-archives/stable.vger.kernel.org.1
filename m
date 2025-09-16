Return-Path: <stable+bounces-179695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74942B590BB
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80F6189844A
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 08:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6D1F4198;
	Tue, 16 Sep 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQ99520p"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072D136E3F
	for <Stable@vger.kernel.org>; Tue, 16 Sep 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011510; cv=none; b=rMbg9SwA17i81frBBAhPsiMueMURWywZjqDNK3aokWmcud34L06jgoOhWgpjr5Wo2qMGTJyEaR61cz/bJR0gDI1enHJea1/WxQvlhDkeJUOSYxG9V6sg/khSM14efIoA6NbEtmlkMRI6OzYApXsW+bKolP2HBAdZfwUSlLi6iEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011510; c=relaxed/simple;
	bh=z8kzWaPYZETBvl1kOCXd93A10UqpT0jXiZz/WDnXnjI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=tSAfxeHPbxWfiqDuvduZuK1xySCjdeivQcq/gWaxCNklDzCLbXMQMjC2sf+ZqcaVzdPT/qd+LAh6GhTUy78V4iliHoQEpg6Y0Sb5iCwmtuLth/tXlKnvYI9zwNDYi5dFE0OlznMetHqP4Xp9Mm1gAcXHnb9UNJ+158gFpm6BBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQ99520p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AF0C4CEEB;
	Tue, 16 Sep 2025 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011510;
	bh=z8kzWaPYZETBvl1kOCXd93A10UqpT0jXiZz/WDnXnjI=;
	h=Subject:To:From:Date:From;
	b=RQ99520pAG/f1tO8vpBBAOhyqu8idhr+x2+j5ea4fnQsg5tyDPK1pKdeVDNxi6TNH
	 mxfy8EiOzq9a1/6ZcFvkzXbyiNWOOOJkGYQ0d6JMZK/yA6HYIMH4KoMLmIYnblc8UC
	 GNahbpjDZNornxWdQLyhxFtBMp+BNI9vJny+NPIk=
Subject: patch "iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE" added to char-misc-testing
To: michael.hennerich@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Sep 2025 10:31:32 +0200
Message-ID: <2025091632-persuaded-chatty-2090@gregkh>
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
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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



