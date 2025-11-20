Return-Path: <stable+bounces-195336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0CAC75453
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4D3132BAE8
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBB3624DF;
	Thu, 20 Nov 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jJLevNUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58768363C44
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655238; cv=none; b=Bi/VP8qZZspKFTF+k0wq0Y2L9ab7fsXa5tEVeYPQOJ0RarEiZpQ79AGBEhuS7cxTka0jkPyZSS0qmr3UO/pmSDEA3zFq+AzzrVsw3D/rXZXe17d8BSgIAZiYQF4KqRq3rx1svlVhTjCYL7W01SP9jGMI15iyX0KAw9+cG00mPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655238; c=relaxed/simple;
	bh=UNDvfcRL2FPBONhYjku8mfWlJrky30DL7UJSvRUocWk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KM5eMOa+7Tbf6j14KIxhYPKLGeXvJrguu7RTd+zZ/a0DRvpDOjbrxWNi7HXdr54KKwtKtSeyXm7PXAc3WELUm16wmTuMsBwt6uWiNqet59EMsnaDHdPcr8VorqqIeoBptzxV6+2qipkUfpsdigjrDg+wGybEDufD76mFMpHN8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jJLevNUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935C4C116D0;
	Thu, 20 Nov 2025 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655238;
	bh=UNDvfcRL2FPBONhYjku8mfWlJrky30DL7UJSvRUocWk=;
	h=Subject:To:Cc:From:Date:From;
	b=jJLevNUtk3vt3AXYo31lRKRqJB6W+3uUBkUMwG98BPQnwNt3U0msmtbF3SuqPErD0
	 POQFR58ZkyWfoUnsnAQAsqsI46Mq1o2f1CRiqvVqt88wPeqO+0uO7qe7PKW35o/uzU
	 kd0JFycJFFYLqFBv59CfUemGxwHTzNH+hOR+G/E8=
Subject: FAILED: patch "[PATCH] mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT to" failed to apply to 5.15-stable tree
To: shawn.lin@rock-chips.com,alchark@gmail.com,sigmaris@gmail.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:13:55 +0100
Message-ID: <2025112055-suspense-expiring-db69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a28352cf2d2f8380e7aca8cb61682396dca7a991
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112055-suspense-expiring-db69@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a28352cf2d2f8380e7aca8cb61682396dca7a991 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Mon, 20 Oct 2025 09:49:41 +0800
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT to
 0x4

strbin signal delay under 0x8 configuration is not stable after massive
test. The recommandation of it should be 0x4.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Alexey Charkov <alchark@gmail.com>
Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>
Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform support")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index eebd45389956..5b61401a7f3d 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -94,7 +94,7 @@
 #define DLL_TXCLK_TAPNUM_DEFAULT	0x10
 #define DLL_TXCLK_TAPNUM_90_DEGREES	0xA
 #define DLL_TXCLK_TAPNUM_FROM_SW	BIT(24)
-#define DLL_STRBIN_TAPNUM_DEFAULT	0x8
+#define DLL_STRBIN_TAPNUM_DEFAULT	0x4
 #define DLL_STRBIN_TAPNUM_FROM_SW	BIT(24)
 #define DLL_STRBIN_DELAY_NUM_SEL	BIT(26)
 #define DLL_STRBIN_DELAY_NUM_OFFSET	16


