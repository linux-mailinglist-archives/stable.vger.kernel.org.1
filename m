Return-Path: <stable+bounces-160463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F04AFC636
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 10:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AE01AA27C6
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 08:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF475203706;
	Tue,  8 Jul 2025 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WogXzH2r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B22221D87
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964808; cv=none; b=qIKg0FHoH720OO+R06sAcyq1bgWPzGRBWu1DYuCPfTXzj7xQg/J3Or6pwBg2To9PbE+wH+oIGtT0O1KunaYRZ8koWdnOSN4CHJMZdce6ExlLBSvZGLBFhNne6KGWvPfkugkSSMc/9ObiSWZaShc0nUPG3NhlBQ4gIkXRR1kETGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964808; c=relaxed/simple;
	bh=ry2qmXvLEQBcY/EX1JJ+pELp2W4v4RZ+mTda2L5EqFY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OtAzWzvyxRQu3NXp3MneEeAsj1qpIQ2Ho+wwlcBID9T/pHHCag0DAA3g7O5o09R88wPZEPTiQ2l3uKEQ/ZaVnoygMuJVNoL14rlwUpgoeJJFdwSG+RK1o8moZVJU/4tnKeSu8SjDVQLsCSLYKH48ZxHfmXy22iFN15rzLaAnxAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WogXzH2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F0C4CEED;
	Tue,  8 Jul 2025 08:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751964808;
	bh=ry2qmXvLEQBcY/EX1JJ+pELp2W4v4RZ+mTda2L5EqFY=;
	h=Subject:To:Cc:From:Date:From;
	b=WogXzH2rJmSM+qP2PL8Oj9tXY8QRmgc/ASKf6Q3nSRCJfwGWE5j0mAnSIJUt/wlxh
	 kfdRlHRakiKndkQ/vTKOZDxGnOibb/MtSHlinbV9kxOOhV8Mw3NCp1a3mLGYs3vVU6
	 /mIMAew1Swe8so+Jb2H5sbsYI7/TNNAn80AuNEUc=
Subject: FAILED: patch "[PATCH] xhci: Disable stream for xHC controller with" failed to apply to 5.4-stable tree
To: xiehongyu1@kylinos.cn,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Jul 2025 10:53:14 +0200
Message-ID: <2025070814-pebbly-diffused-9cd9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x cd65ee81240e8bc3c3119b46db7f60c80864b90b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070814-pebbly-diffused-9cd9@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd65ee81240e8bc3c3119b46db7f60c80864b90b Mon Sep 17 00:00:00 2001
From: Hongyu Xie <xiehongyu1@kylinos.cn>
Date: Fri, 27 Jun 2025 17:41:20 +0300
Subject: [PATCH] xhci: Disable stream for xHC controller with
 XHCI_BROKEN_STREAMS

Disable stream for platform xHC controller with broken stream.

Fixes: 14aec589327a6 ("storage: accept some UAS devices if streams are unavailable")
Cc: stable <stable@kernel.org>
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250627144127.3889714-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 6dab142e7278..c79d5ed48a08 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -328,7 +328,8 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 	}
 
 	usb3_hcd = xhci_get_usb3_hcd(xhci);
-	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4)
+	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
+	    !(xhci->quirks & XHCI_BROKEN_STREAMS))
 		usb3_hcd->can_do_streams = 1;
 
 	if (xhci->shared_hcd) {


