Return-Path: <stable+bounces-106211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D817D9FD5C6
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8402D3A110E
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BEF35978;
	Fri, 27 Dec 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6T4R7lc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450127721
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735315243; cv=none; b=V6FeizcTAh4MQWHskGPdgNrA9Adu3EOtD9zfV+gT9qnblqnX7+ir/hPHZY+xcBSL4CINko4wLZaqXFWDs9cGKcL7y764a6nv0fDgwcYeHPFOS4OyR9AmsLPA3jg/yvuTdq35AKxA8vqmLUA2uz+5Lnf6SYCN8lVvCbTmndjm0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735315243; c=relaxed/simple;
	bh=HOWs+ZahWp5BsVDxqaJ6XWjZY3qImgdF6sQJqEyCMGY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=McXqe7COUHiV/zzrqkIbTbf8OVkkbOn2KbqS9/iWhxvA3vZPkussyvgg6UBi4urRoAWM3zrM4P3r6WJI7jJpwAG3yMLliNILS+Cufiq2I0YhpI+TT5rvJT2vKXYjRIJczW9u7Oq3makyo52qagGjse6EYwhRqLnShkTFGI5jlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6T4R7lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C18AC4CED0;
	Fri, 27 Dec 2024 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735315243;
	bh=HOWs+ZahWp5BsVDxqaJ6XWjZY3qImgdF6sQJqEyCMGY=;
	h=Subject:To:Cc:From:Date:From;
	b=N6T4R7lcKDnfyEBapOtT97efkeTDBifKJWBdXAQxektg+tHl7sdGRYxc0Sj1kgw++
	 C/6uB29jjlO3zKg9iys63mxr2j0LQjrSDnQHlOguue+DXnST/qGENrqqUc9h6qZOhp
	 NnWabywlpUk+ClnBQvL9UoKkqVJZzPDtkbGqRTBQ=
Subject: FAILED: patch "[PATCH] phy: usb: Toggle the PHY power during init" failed to apply to 5.15-stable tree
To: justin.chen@broadcom.com,florian.fainelli@broadcom.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 27 Dec 2024 17:00:31 +0100
Message-ID: <2024122731-scotch-canning-0796@gregkh>
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
git cherry-pick -x 0a92ea87bdd6f77ca4e17fe19649882cf5209edd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122731-scotch-canning-0796@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a92ea87bdd6f77ca4e17fe19649882cf5209edd Mon Sep 17 00:00:00 2001
From: Justin Chen <justin.chen@broadcom.com>
Date: Thu, 24 Oct 2024 14:35:40 -0700
Subject: [PATCH] phy: usb: Toggle the PHY power during init

When bringing up the PHY, it might be in a bad state if left powered.
One case is we lose the PLL lock if the PLL is gated while the PHY
is powered. Toggle the PHY power so we can start from a known state.

Fixes: 4e5b9c9a73b3 ("phy: usb: Add support for new Synopsys USB controller on the 7216")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20241024213540.1059412-1-justin.chen@broadcom.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
index 950b7ae1d1a8..dc452610934a 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
@@ -325,6 +325,12 @@ static void usb_init_common_7216(struct brcm_usb_init_params *params)
 	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 
 	USB_CTRL_UNSET(ctrl, USB_PM, XHC_S2_CLK_SWITCH_EN);
+
+	/*
+	 * The PHY might be in a bad state if it is already powered
+	 * up. Toggle the power just in case.
+	 */
+	USB_CTRL_SET(ctrl, USB_PM, USB_PWRDN);
 	USB_CTRL_UNSET(ctrl, USB_PM, USB_PWRDN);
 
 	/* 1 millisecond - for USB clocks to settle down */


