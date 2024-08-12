Return-Path: <stable+bounces-66432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C709A94EA26
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8309E280F12
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9617416DEAB;
	Mon, 12 Aug 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r5DsXaRz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708716DEA7
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455844; cv=none; b=jYWTh/MLCn+n4o3GvWeRnsR7guKlwh9/9N/vHP8mvyNEA4Xq5dBW5Ca41IEwNExrdrq90hlcSQF5K1bA37WjxNDrjJmne+L0WA7/fb3o6sh6MzDUHEIz3QCxZKyLuwYz1sXc0q9K5dL5dZFcEc4/m/+QemHw6UOS0EkDM4mlFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455844; c=relaxed/simple;
	bh=E66xztRXCjy9IQqJL8n2h8i7lVYEo30Yxbl82s7RWok=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hi7e94swL8L+p+Xx/6aoYzizknn7gYDym52G3QaQD2ptgTmtanflKJLdKG1W8eVwkdZhNHY4C/3EdyPRKPX6fzS3XbDj72m1r0EC4dZyGHkzRIBr4h9BfbdPCBdvcRveBIr/jtqdjrkl7fajUTSH+0bed+wKCkD/So3YGy/tMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r5DsXaRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D50C4AF0F;
	Mon, 12 Aug 2024 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723455843;
	bh=E66xztRXCjy9IQqJL8n2h8i7lVYEo30Yxbl82s7RWok=;
	h=Subject:To:Cc:From:Date:From;
	b=r5DsXaRz+cQqHrt4apBGQLObQBukYJ6IMnwJvQgFVpzncBCp5UMwvm5V8gVd/tT5o
	 x+NP0AS5cNG/EKLs7rsZi6Rcc9lxb2Zv0D4A/7ioN6M3UdNQbJXYIwLCLu6bSkSPqm
	 sRH76Uu1r+ug1Iq/mAA7SAYCmbpdOgtxd3IQiWT0=
Subject: FAILED: patch "[PATCH] usb: gadget: u_audio: Check return codes from usb_ep_enable" failed to apply to 5.15-stable tree
To: crwulff@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 11:44:00 +0200
Message-ID: <2024081259-emporium-sequence-80c6@gregkh>
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
git cherry-pick -x 76a7bfc445b8e9893c091e24ccfd4f51dfdc0a70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081259-emporium-sequence-80c6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

76a7bfc445b8 ("usb: gadget: u_audio: Check return codes from usb_ep_enable and config_ep_by_speed.")
8722a949e62a ("usb: gadget: u_audio: Move dynamic srate from params to rtd")
c565ad07ef35 ("usb: gadget: u_audio: Support multiple sampling rates")
f2f69bf65df1 ("usb: gadget: u_audio: fix calculations for small bInterval")
6fec018a7e70 ("usb: gadget: u_audio.c: Adding Playback Pitch ctl for sync playback")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76a7bfc445b8e9893c091e24ccfd4f51dfdc0a70 Mon Sep 17 00:00:00 2001
From: Chris Wulff <crwulff@gmail.com>
Date: Sun, 21 Jul 2024 15:23:15 -0400
Subject: [PATCH] usb: gadget: u_audio: Check return codes from usb_ep_enable
 and config_ep_by_speed.

These functions can fail if descriptors are malformed, or missing,
for the selected USB speed.

Fixes: eb9fecb9e69b ("usb: gadget: f_uac2: split out audio core")
Fixes: 24f779dac8f3 ("usb: gadget: f_uac2/u_audio: add feedback endpoint support")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Wulff <crwulff@gmail.com>
Link: https://lore.kernel.org/r/20240721192314.3532697-2-crwulff@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 89af0feb7512..24299576972f 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -592,16 +592,25 @@ int u_audio_start_capture(struct g_audio *audio_dev)
 	struct usb_ep *ep, *ep_fback;
 	struct uac_rtd_params *prm;
 	struct uac_params *params = &audio_dev->params;
-	int req_len, i;
+	int req_len, i, ret;
 
 	prm = &uac->c_prm;
 	dev_dbg(dev, "start capture with rate %d\n", prm->srate);
 	ep = audio_dev->out_ep;
-	config_ep_by_speed(gadget, &audio_dev->func, ep);
+	ret = config_ep_by_speed(gadget, &audio_dev->func, ep);
+	if (ret < 0) {
+		dev_err(dev, "config_ep_by_speed for out_ep failed (%d)\n", ret);
+		return ret;
+	}
+
 	req_len = ep->maxpacket;
 
 	prm->ep_enabled = true;
-	usb_ep_enable(ep);
+	ret = usb_ep_enable(ep);
+	if (ret < 0) {
+		dev_err(dev, "usb_ep_enable failed for out_ep (%d)\n", ret);
+		return ret;
+	}
 
 	for (i = 0; i < params->req_number; i++) {
 		if (!prm->reqs[i]) {
@@ -629,9 +638,18 @@ int u_audio_start_capture(struct g_audio *audio_dev)
 		return 0;
 
 	/* Setup feedback endpoint */
-	config_ep_by_speed(gadget, &audio_dev->func, ep_fback);
+	ret = config_ep_by_speed(gadget, &audio_dev->func, ep_fback);
+	if (ret < 0) {
+		dev_err(dev, "config_ep_by_speed in_ep_fback failed (%d)\n", ret);
+		return ret; // TODO: Clean up out_ep
+	}
+
 	prm->fb_ep_enabled = true;
-	usb_ep_enable(ep_fback);
+	ret = usb_ep_enable(ep_fback);
+	if (ret < 0) {
+		dev_err(dev, "usb_ep_enable failed for in_ep_fback (%d)\n", ret);
+		return ret; // TODO: Clean up out_ep
+	}
 	req_len = ep_fback->maxpacket;
 
 	req_fback = usb_ep_alloc_request(ep_fback, GFP_ATOMIC);
@@ -687,13 +705,17 @@ int u_audio_start_playback(struct g_audio *audio_dev)
 	struct uac_params *params = &audio_dev->params;
 	unsigned int factor;
 	const struct usb_endpoint_descriptor *ep_desc;
-	int req_len, i;
+	int req_len, i, ret;
 	unsigned int p_pktsize;
 
 	prm = &uac->p_prm;
 	dev_dbg(dev, "start playback with rate %d\n", prm->srate);
 	ep = audio_dev->in_ep;
-	config_ep_by_speed(gadget, &audio_dev->func, ep);
+	ret = config_ep_by_speed(gadget, &audio_dev->func, ep);
+	if (ret < 0) {
+		dev_err(dev, "config_ep_by_speed for in_ep failed (%d)\n", ret);
+		return ret;
+	}
 
 	ep_desc = ep->desc;
 	/*
@@ -720,7 +742,11 @@ int u_audio_start_playback(struct g_audio *audio_dev)
 	uac->p_residue_mil = 0;
 
 	prm->ep_enabled = true;
-	usb_ep_enable(ep);
+	ret = usb_ep_enable(ep);
+	if (ret < 0) {
+		dev_err(dev, "usb_ep_enable failed for in_ep (%d)\n", ret);
+		return ret;
+	}
 
 	for (i = 0; i < params->req_number; i++) {
 		if (!prm->reqs[i]) {


