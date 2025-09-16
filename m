Return-Path: <stable+bounces-179693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E8B590CE
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0F87B4A3D
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1328A1F1;
	Tue, 16 Sep 2025 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OiaVoTV2"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87D1B532F
	for <Stable@vger.kernel.org>; Tue, 16 Sep 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011503; cv=none; b=bDnciEMQmppHcbMj5WDanUGdxT3UfIUuYmnRg6THBHXALLRQGFRfuzVNkKyPB4lamay2RW8ezoWBEIclJf2hNbDTExzO9zS+AdwEp6UkJntj0OUFjS3WzWHC6QCCv+ZoyN4Wr8EEKmQJXvJRECsnJO7MwUQFMQIEW6uP5tGMoVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011503; c=relaxed/simple;
	bh=pz+vYt3UOYcIOyDlzEOpqtiyAd8ywNT2LMg9nuAT60Q=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=tZwWrxREhlwvJ2E76aPp4jqA5PdD5p2ciTkXrq+rDjJHpxkJMGac8m0oRHlnowpmWskzGNM4+XS0Org32aLyPngrh4+5WW8Q26QCV2xQvAWjH9RKrnTbwZehWLNJRmPBmM7bsWbgZ6SCmuBn/DFANUgY1bG2KKzA9rAbwk/WCX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OiaVoTV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F359C4CEEB;
	Tue, 16 Sep 2025 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011502;
	bh=pz+vYt3UOYcIOyDlzEOpqtiyAd8ywNT2LMg9nuAT60Q=;
	h=Subject:To:From:Date:From;
	b=OiaVoTV2qflrAp9NmisJahPLknGjdmgBLtnUAc5OJDonXzrrDh/idp/1st9ovdF5I
	 s+q3sdcMr0VO3NFfqjZ07B0L1Hc3lKGhEZmfgeHvGxwioNhPIlx+ym+kjcyFrzafmi
	 /ASY3+EoWw1rYjXuWrMwzF0GAht3eLKl2ddH6Tns=
Subject: patch "iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK" added to char-misc-testing
To: sean.anderson@linux.dev,Jonathan.Cameron@huawei.com,Salih.Erim@amd.com,Stable@vger.kernel.org,conall.ogriofa@amd.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Sep 2025 10:31:32 +0200
Message-ID: <2025091632-headroom-sizing-024b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 1315cc2dbd5034f566e20ddce4d675cb9e6d4ddd Mon Sep 17 00:00:00 2001
From: Sean Anderson <sean.anderson@linux.dev>
Date: Mon, 14 Jul 2025 20:30:58 -0400
Subject: iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK

AMS_ALARM_THR_DIRECT_MASK should be bit 0, not bit 1. This would cause
hysteresis to be enabled with a lower threshold of -28C. The temperature
alarm would never deassert even if the temperature dropped below the
upper threshold.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: O'Griofa, Conall <conall.ogriofa@amd.com>
Tested-by: Erim, Salih <Salih.Erim@amd.com>
Acked-by: Erim, Salih <Salih.Erim@amd.com>
Link: https://patch.msgid.link/20250715003058.2035656-1-sean.anderson@linux.dev
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/xilinx-ams.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 180d4140993d..124470c92529 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -118,7 +118,7 @@
 #define AMS_ALARM_THRESHOLD_OFF_10	0x10
 #define AMS_ALARM_THRESHOLD_OFF_20	0x20
 
-#define AMS_ALARM_THR_DIRECT_MASK	BIT(1)
+#define AMS_ALARM_THR_DIRECT_MASK	BIT(0)
 #define AMS_ALARM_THR_MIN		0x0000
 #define AMS_ALARM_THR_MAX		(BIT(16) - 1)
 
-- 
2.51.0



