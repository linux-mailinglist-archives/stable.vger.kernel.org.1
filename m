Return-Path: <stable+bounces-167176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636A4B22CF3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B8068041C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA31305E03;
	Tue, 12 Aug 2025 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BSSEN3tw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE2156CA
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014987; cv=none; b=d66EoQf5HRAy3IG/DInxB3dRZk4JirkfeoTUEfPo/tWLVAmmvseg+l8lOvcGUOGId7Qc4E3FCPPYJGOuioASb1I0SagLLy66j5OndbLlej82KGrwEEbcZWIQjjftHS1996zoyfWpgngO/szR89E4OfvZpd2eXRxKLpqKxOnfR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014987; c=relaxed/simple;
	bh=6aqXaYAhdQS9CatHuNVf9TVrJI9O9aZFa8JagT4SELQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DTM1yo4Tq3UEolOwmLnnGclvpXDhbCuwfRY5/atHXPeS57rWw8GV60nYt8Aoy8CRKNvQ624KApKWCsPiKu6vcZ5S9blAN8gzOiNif8dDToyB1/lkShuYCE0m+QhwGas6rTdtlAsO8bSvPbhdpk8cswyIOQ76opeFED7pTtt6+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BSSEN3tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDBAC4CEF0;
	Tue, 12 Aug 2025 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755014987;
	bh=6aqXaYAhdQS9CatHuNVf9TVrJI9O9aZFa8JagT4SELQ=;
	h=Subject:To:Cc:From:Date:From;
	b=BSSEN3tweFpBzyVztkD5ojEJivbwLAwjWydGwIcVMfuib0fY4AVEBVVDSOHGHY/IY
	 8VVh89t7XKH6uuDo7axa/kxHc8TNGmqV8K+AXpPjefbS1IdMlsHLi/n36XCKfBhhR4
	 1iHEzabzuE2oHLXKywUP3DSAeFsezEFNr0efClBY=
Subject: FAILED: patch "[PATCH] ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()" failed to apply to 5.15-stable tree
To: g@b4.vu,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:09:43 +0200
Message-ID: <2025081243-disaster-wrinkly-bdc6@gregkh>
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
git cherry-pick -x 8a15ca0ca51399b652b1bbb23b590b220cf03d62
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081243-disaster-wrinkly-bdc6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


