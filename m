Return-Path: <stable+bounces-180791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBE8B8DB22
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE7E17CCAB
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE2422F757;
	Sun, 21 Sep 2025 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GxZqmLIC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09E1A9F9E
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758458078; cv=none; b=EYkIi0LuTxwmgpfrsRimfUu1WosBcdRg0r8ookREr8BZGX0N7R1Ybjj9WcVhT+yR9+wigHdXlOktZatWNFbXha6XVBP3nvbAXBEmUhTipD8sIlAoeBWqKzJAe8MOScrd8anuYZ29KyXr10kzkn8MaJjJ8px82YoWmRJRrA4yHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758458078; c=relaxed/simple;
	bh=7YqkG9i0LuWPry7uAXhO7gqvm0hLbMnHI068zU0EPYk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mn6Z4MrV4Bwh+5VruD4CFOMvTrEzW74RsRqxMBGUbdFz1pNUt9Joc4puw73gMh5zC7GXOOOKD+Gt7Mn74pP2KKG7qYxtWb9sQc67q5bOXsO7Xye9+gSglVvXXNhmcf6KedyWW2TgX0tK5Uc8DFpG7sqU0mzbF2a3er0RSSd4cyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GxZqmLIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93109C4CEE7;
	Sun, 21 Sep 2025 12:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758458076;
	bh=7YqkG9i0LuWPry7uAXhO7gqvm0hLbMnHI068zU0EPYk=;
	h=Subject:To:Cc:From:Date:From;
	b=GxZqmLICMm0gRmRo0vtk3zOaaqdN6rcNID908gV7mn7dE0Ycz2mR8TEJONE0jcZ1V
	 Ves/AMgkSsCVS9j4lQXgrrdauxvaGqxPnioM+a2QarKWjznUHN9ZISc6nE8/gioFMc
	 XHgUsePzHrhASguuegmfUQrJMYPJvQEu17nxbdfE=
Subject: FAILED: patch "[PATCH] platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan" failed to apply to 6.12-stable tree
To: lkml@antheas.dev,ilpo.jarvinen@linux.intel.com,rahul@chandra.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:34:26 +0200
Message-ID: <2025092126-upstream-favorite-2f89@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 225d1ee0f5ba3218d1814d36564fdb5f37b50474
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092126-upstream-favorite-2f89@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


