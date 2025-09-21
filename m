Return-Path: <stable+bounces-180790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD8B8DB1F
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E053189D777
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC0525393E;
	Sun, 21 Sep 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UIYgUhIa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FAE1A9F9E
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758458068; cv=none; b=rBer7rMVlDZbTY7O/kkFOO6ydyb8VI00GnwDMZx4d7pf738RrJt1h/ul1A3GPsPa04ywkLDV0raI4ChN4wVeuSqiOFr8f0aC/Jz3m3GKGW4ofW/8WZUuFmHBrlPNO+co+QnrVvI+76+xcsiLryCDc5Oo75xsig/1MRCbc7B1ejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758458068; c=relaxed/simple;
	bh=+25xnoZtEsG1Yamny17QMYeW15rDuoh+wJ+oLPcUBD4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EW3GQATs6+3wxxvhB3uzbKIe2E52jEuHUjWtTnLOJyu3QUgpNQGxnOngCI6YAR7lhqZou29lMLrbZ5If8SQndM+mXO9I/p34E4u2S5xSMbWK2FajsPQOt0TiPgv2Ze31OQYyJ5eMZnnPL3H+xGF/HJ2qiEFN67AMsyUjnXzQQmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UIYgUhIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1764CC4CEE7;
	Sun, 21 Sep 2025 12:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758458068;
	bh=+25xnoZtEsG1Yamny17QMYeW15rDuoh+wJ+oLPcUBD4=;
	h=Subject:To:Cc:From:Date:From;
	b=UIYgUhIa4jAW8DjHdDi8BNoBMGiHPjQAuCSwfd7MRcm8yLNk+yZ2LhYcjs69fJmcH
	 TDwxMpVtp3iUtK2MpSt/bKCW4IkoEacRW0LBbVcJ9twR8Ft/g4XBwmv7I/DlzQD4Z+
	 RU+bfcB6f/oEygIh95vRYb75FR8fiXnubMLn9mdA=
Subject: FAILED: patch "[PATCH] platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan" failed to apply to 6.16-stable tree
To: lkml@antheas.dev,ilpo.jarvinen@linux.intel.com,rahul@chandra.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:34:26 +0200
Message-ID: <2025092125-thigh-immerse-6abd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 225d1ee0f5ba3218d1814d36564fdb5f37b50474
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092125-thigh-immerse-6abd@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 225d1ee0f5ba3218d1814d36564fdb5f37b50474 Mon Sep 17 00:00:00 2001
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 16 Sep 2025 09:28:18 +0200
Subject: [PATCH] platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan
 quirk
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It turns out that the dual screen models use 0x5E for attaching and
detaching the keyboard instead of 0x5F. So, re-add the codes by
reverting commit cf3940ac737d ("platform/x86: asus-wmi: Remove extra
keys from ignore_key_wlan quirk"). For our future reference, add a
comment next to 0x5E indicating that it is used for that purpose.

Fixes: cf3940ac737d ("platform/x86: asus-wmi: Remove extra keys from ignore_key_wlan quirk")
Reported-by: Rahul Chandra <rahul@chandra.net>
Closes: https://lore.kernel.org/all/10020-68c90c80-d-4ac6c580@106290038/
Cc: stable@kernel.org
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Link: https://patch.msgid.link/20250916072818.196462-1-lkml@antheas.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 3a488cf9ca06..6a62bc5b02fd 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -673,6 +673,8 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
 		break;
+	case 0x5D: /* Wireless console Toggle */
+	case 0x5E: /* Wireless console Enable / Keyboard Attach, Detach */
 	case 0x5F: /* Wireless console Disable / Special Key */
 		if (quirks->key_wlan_event)
 			*code = quirks->key_wlan_event;


