Return-Path: <stable+bounces-201169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CACC1FB8
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3F9B3051EBF
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A380A27A12B;
	Tue, 16 Dec 2025 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yw86vvgW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C24238171
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881159; cv=none; b=AXuCwe0AupfcTPPjf6iVd8RD/alOYiHNYk8/MpCRW2DOkJdC8TE94FvA+4Ux1D7OuG3nQQ1HfRP3YCAdRJN6nkpYcS5SuPG1Je4zfBzsraalNH/OSbwfabIcqztcbGKvxdukImstrCkkeeW5N5UaeZxhA8ik1ufoipbUbdLwuy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881159; c=relaxed/simple;
	bh=LaWshiSWwsSA3fMsmSdDNkmgMXAg+VVFOHaRlYNprbQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZM/tXflZC6RTIINnETS9drVm5zBL+qxkfXU+Sk12MtXlNUH8pB8B/621FKuEbljmmOehtuoUwrCp/Yno1JMRhyggZkGq6gtVlE/ZUZxjHdGTUtyIZt2Muu52/Ms51IGh0KyBpD7W9F3vY+RRE9/Si7D10cv3i0WB0PEXaIVoHDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yw86vvgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE319C4CEF1;
	Tue, 16 Dec 2025 10:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765881159;
	bh=LaWshiSWwsSA3fMsmSdDNkmgMXAg+VVFOHaRlYNprbQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Yw86vvgWRGvfSSpm0pxtsVBAEWNNBn0x1gL1pAJq78sGojOZZYGtf1iwQoy2UFflG
	 KQqa7jGKh2zESmQQkoF+Njja+fm7zXvyQ1XJlo5YcJdFDRBawftzIyA6fNtdvXSEnC
	 dHmGMiEmy69eB3Ve0XuiZuYmjo+dlltUglWE093o=
Subject: FAILED: patch "[PATCH] ALSA: wavefront: Fix integer overflow in sample size" failed to apply to 6.1-stable tree
To: moonafterrain@outlook.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Dec 2025 11:32:18 +0100
Message-ID: <2025121618-trimmer-clever-0be6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0c4a13ba88594fd4a27292853e736c6b4349823d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025121618-trimmer-clever-0be6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


