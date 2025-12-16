Return-Path: <stable+bounces-201168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0332ACC1F97
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F11EC30133C8
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780EC2D7388;
	Tue, 16 Dec 2025 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lywat0j2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CB27A12B
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881156; cv=none; b=ZXcZX7LOjD68AcvnbLYfrezzl1yVhehfAicFyWkSJCpMlwC796bVzD9Exkzg7wyo+GAH7Y+zIyvD0+xgDbsDdceTJ2SXCzG2LmWq+LT2PdvPhyic1zRBGYVI6S454LPMELmEf2hsAG624IhpXOI7uG2EMAs6rk+IrcW0Ac3JfCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881156; c=relaxed/simple;
	bh=xvmcJ2dQSJ6vUdAFZd7s+wtwIEmk+/EeaMOKgbNz198=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CY61Qxuf2cNBBPudY7UR41rH0oN/9LjkD02mtEvwii01tqObUhOVrYwoEwkZ83NZpDs9f31kFTxJmfBorTffTW2x3Q7E0Pjb+xkzUBJjNL3MGcy1FlNG0XbuhnIRsZ/1mLE4480QdpuY97synZT50nxNhAJznQmh0aG7W5E7A/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lywat0j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B62C4CEF1;
	Tue, 16 Dec 2025 10:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765881155;
	bh=xvmcJ2dQSJ6vUdAFZd7s+wtwIEmk+/EeaMOKgbNz198=;
	h=Subject:To:Cc:From:Date:From;
	b=Lywat0j2hLqdNj+ixSp1N2MYeYfnbgr+B28FBYLF+0GLJlx0LtP974Mj6XW5SztiU
	 vuP5QzVXl7OOCBhXf6m7z0v3uaCEIpUqXwLYu3/wor7a4kFCn8gQ+ciVlRyC6drCjy
	 BzK0kHutNwL70P5+T0esnJblBWOSwzwyG/RwvobY=
Subject: FAILED: patch "[PATCH] ALSA: wavefront: Fix integer overflow in sample size" failed to apply to 5.15-stable tree
To: moonafterrain@outlook.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Dec 2025 11:32:18 +0100
Message-ID: <2025121618-refuse-macaw-9005@gregkh>
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
git cherry-pick -x 0c4a13ba88594fd4a27292853e736c6b4349823d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025121618-refuse-macaw-9005@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c4a13ba88594fd4a27292853e736c6b4349823d Mon Sep 17 00:00:00 2001
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 6 Nov 2025 10:49:46 +0800
Subject: [PATCH] ALSA: wavefront: Fix integer overflow in sample size
 validation

The wavefront_send_sample() function has an integer overflow issue
when validating sample size. The header->size field is u32 but gets
cast to int for comparison with dev->freemem

Fix by using unsigned comparison to avoid integer overflow.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://patch.msgid.link/SYBPR01MB7881B47789D1B060CE8BF4C3AFC2A@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index cd5c177943aa..0d78533e1cfd 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -950,9 +950,9 @@ wavefront_send_sample (snd_wavefront_t *dev,
 	if (header->size) {
 		dev->freemem = wavefront_freemem (dev);
 
-		if (dev->freemem < (int)header->size) {
+		if (dev->freemem < 0 || dev->freemem < header->size) {
 			dev_err(dev->card->dev,
-				"insufficient memory to load %d byte sample.\n",
+				"insufficient memory to load %u byte sample.\n",
 				header->size);
 			return -ENOMEM;
 		}


