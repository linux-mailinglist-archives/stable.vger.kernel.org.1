Return-Path: <stable+bounces-201170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42742CC1FBB
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6B6E3053291
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A612238171;
	Tue, 16 Dec 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="if3JzYIp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388593246F4
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881162; cv=none; b=ltdk6+ef2JsCDUWq0RIEpcFAJ2LgkchjLImgi+1zrRPlJ3rKSaaR8vDSLAw6ONXXIOMwPWnYa3fceo7ZKUxFaqMXBXITLluhT5zxgB+/oZL+5jMQ+FjldeRGEnmnhXfXsL4YZ4lxbiqCy6GtPpQ2Dv1pXGs1U8oh/eWVn5FreEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881162; c=relaxed/simple;
	bh=cdUDB1ibMg24R2uCuJAf9AUCSlIRgTtY7s9FJTXBaT8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rX69A4FwQ2vUMIF1UGJOQY9e/MR8Q+BfFIPdifKCwRQhbIsFqXrg2bd5rCo0OAkrF+EFRuYOvho3M+LCwx95fRxTfqWz6I48kYkCAOJxU5JXK8yrujyGUstIKKULLAyX6xJynI9d0HNvfAkuQ4KLQWuY8WcS3FxaywD7oojobqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=if3JzYIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FD9C4CEFB;
	Tue, 16 Dec 2025 10:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765881162;
	bh=cdUDB1ibMg24R2uCuJAf9AUCSlIRgTtY7s9FJTXBaT8=;
	h=Subject:To:Cc:From:Date:From;
	b=if3JzYIpNVa9dz8sZFux6HadnzpoAST0CTcuPLi6affhq1+R5Jxgx++TEy6Fau10b
	 qvT6ooyheeWo5JKYw8eQBRTpdMT9Ln/diwjUSbhcMz9VflbHrSsEc0iwLf6nt6Q82z
	 1W8sV94SF8zGgf41HmvxO+u/3FvE5uxP02BxYxjM=
Subject: FAILED: patch "[PATCH] ALSA: wavefront: Fix integer overflow in sample size" failed to apply to 5.10-stable tree
To: moonafterrain@outlook.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Dec 2025 11:32:19 +0100
Message-ID: <2025121619-slug-udder-b8fe@gregkh>
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
git cherry-pick -x 0c4a13ba88594fd4a27292853e736c6b4349823d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025121619-slug-udder-b8fe@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


