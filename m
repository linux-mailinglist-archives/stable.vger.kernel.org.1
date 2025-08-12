Return-Path: <stable+bounces-167178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB6DB22CF6
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAF71883DAB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B351423D7CB;
	Tue, 12 Aug 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1TAk/PbO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FAC305E03
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014999; cv=none; b=l/UUlv4pWKlHflrWRcUF/Q5z1eLuH0Lj16+or88jk32qTGiHk/tImB8wOxkRmSV+/S71eok+F6NYkSQ1vf6MQpjmsPAcc7rlVpAOwtZoUDGl8jgKLH9sMQCvZspTHB2YdVOr3Mcz5hFIpwvYlJYlr+Mxn3PsdiOGpXkFAkVVN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014999; c=relaxed/simple;
	bh=YSw9rUwWeTg1nhWgeUtlcqSfa/rZhApokXeHcqmTt0U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lO5DmJzYuROSnxCHsrCBW1EpMs5uuyMKPBrqzjnUNHNkArmFUxnu3z3CO2oFCFFIZK8napK7FCSsF4GaYgA1SYQJsvdQ19tbsbILpDI4xH2NTPLuUous7fGVO/nOHtle9lOuUF6tpfy7cE+PBKSF9NBkmnafBXe52v3mx6NJ9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1TAk/PbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D87C4CEF0;
	Tue, 12 Aug 2025 16:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755014999;
	bh=YSw9rUwWeTg1nhWgeUtlcqSfa/rZhApokXeHcqmTt0U=;
	h=Subject:To:Cc:From:Date:From;
	b=1TAk/PbOZRep01nFVhWrQ2lO18SrMQyWD3Ax+7iaWT26q/FxrugYygfTgLiEpOBan
	 5bTta1P/ItV6mQ6iQJFV68/GIaTC/L74u+E9vbvMwwnZewQj6qDzGLG8vpOfKBleW2
	 NY905IS1oGUQFIjVGjME+YVlTnO5RbTQc0AVawqI=
Subject: FAILED: patch "[PATCH] ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()" failed to apply to 5.10-stable tree
To: g@b4.vu,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:09:44 +0200
Message-ID: <2025081244-epileptic-value-7d4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8a15ca0ca51399b652b1bbb23b590b220cf03d62
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081244-epileptic-value-7d4e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a15ca0ca51399b652b1bbb23b590b220cf03d62 Mon Sep 17 00:00:00 2001
From: "Geoffrey D. Bennett" <g@b4.vu>
Date: Mon, 28 Jul 2025 19:00:35 +0930
Subject: [PATCH] ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()

During communication with Focusrite Scarlett Gen 2/3/4 USB audio
interfaces, -EPROTO is sometimes returned from scarlett2_usb_tx(),
snd_usb_ctl_msg() which can cause initialisation and control
operations to fail intermittently.

This patch adds up to 5 retries in scarlett2_usb(), with a delay
starting at 5ms and doubling each time. This follows the same approach
as the fix for usb_set_interface() in endpoint.c (commit f406005e162b
("ALSA: usb-audio: Add retry on -EPROTO from usb_set_interface()")),
which resolved similar -EPROTO issues during device initialisation,
and is the same approach as in fcp.c:fcp_usb().

Fixes: 9e4d5c1be21f ("ALSA: usb-audio: Scarlett Gen 2 mixer interface")
Closes: https://github.com/geoffreybennett/linux-fcp/issues/41
Cc: stable@vger.kernel.org
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://patch.msgid.link/aIdDO6ld50WQwNim@m.b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 49eeb1444dce..15bbdafc4894 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -2351,6 +2351,8 @@ static int scarlett2_usb(
 	struct scarlett2_usb_packet *req, *resp = NULL;
 	size_t req_buf_size = struct_size(req, data, req_size);
 	size_t resp_buf_size = struct_size(resp, data, resp_size);
+	int retries = 0;
+	const int max_retries = 5;
 	int err;
 
 	req = kmalloc(req_buf_size, GFP_KERNEL);
@@ -2374,10 +2376,15 @@ static int scarlett2_usb(
 	if (req_size)
 		memcpy(req->data, req_data, req_size);
 
+retry:
 	err = scarlett2_usb_tx(dev, private->bInterfaceNumber,
 			       req, req_buf_size);
 
 	if (err != req_buf_size) {
+		if (err == -EPROTO && ++retries <= max_retries) {
+			msleep(5 * (1 << (retries - 1)));
+			goto retry;
+		}
 		usb_audio_err(
 			mixer->chip,
 			"%s USB request result cmd %x was %d\n",


