Return-Path: <stable+bounces-46612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381168D0A75
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72DA281F17
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2176315E96;
	Mon, 27 May 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qLGTW0QV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDB17E8F5;
	Mon, 27 May 2024 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836403; cv=none; b=cpUXOW4wYGsZyyZXqseFbd+lm6XzwVGbzfaxZvQXrTWRikCb2QB77JHGhw0kTpEgnqsdg4s92bjX6fKE3KeilP0uOHDX2xSnwkKxzC9moh8hDtjyEKhaHimY2xRuabRdcJ29DVHJ7j5K73btd+K4H1dys76H1twftw9RcDERpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836403; c=relaxed/simple;
	bh=lJHyrgezMFoNID80NhIdK7Vspcb0jsUBhaWSGmJOrW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAZmYk++cfXrcnboiE/lUmW/gOw17h8ME4kn15jdzU+Y+h+hz28/hhQ1+uSn6TKitiD9in7OK5DsopOE+2aH3oXE5XwEklJIPznb1C1trOF4UCECGYoxMN8631ELzMC6q3nr4kAoMnujJDaHsArBGjvWCc81A5ZzRX0pbnUItTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qLGTW0QV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CAAC2BBFC;
	Mon, 27 May 2024 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836403;
	bh=lJHyrgezMFoNID80NhIdK7Vspcb0jsUBhaWSGmJOrW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLGTW0QVBItL54fRdBHWpnfmevTZfB/YGYf9G9Gg7cNSq61oecZ71t1dGAzFS8gBm
	 7eld+qU04GAbxQqlWHDQRhz+36P43XgX5+zAT18PuSQqC/pHc7vu1czsYK4fw2IE6q
	 CXAtjcAaF4HivbpAGR9tCUO+nR7rX04k7NfFnpME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+43120c2af6ca2938cc38@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.9 039/427] ALSA: timer: Set lower bound of start tick time
Date: Mon, 27 May 2024 20:51:26 +0200
Message-ID: <20240527185605.328089202@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 4a63bd179fa8d3fcc44a0d9d71d941ddd62f0c4e upstream.

Currently ALSA timer doesn't have the lower limit of the start tick
time, and it allows a very small size, e.g. 1 tick with 1ns resolution
for hrtimer.  Such a situation may lead to an unexpected RCU stall,
where  the callback repeatedly queuing the expire update, as reported
by fuzzer.

This patch introduces a sanity check of the timer start tick time, so
that the system returns an error when a too small start size is set.
As of this patch, the lower limit is hard-coded to 100us, which is
small enough but can still work somehow.

Reported-by: syzbot+43120c2af6ca2938cc38@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/000000000000fa00a1061740ab6d@google.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240514182745.4015-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/timer.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -544,6 +544,14 @@ static int snd_timer_start1(struct snd_t
 			     SNDRV_TIMER_IFLG_START))
 		return -EBUSY;
 
+	/* check the actual time for the start tick;
+	 * bail out as error if it's way too low (< 100us)
+	 */
+	if (start) {
+		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000)
+			return -EINVAL;
+	}
+
 	if (start)
 		timeri->ticks = timeri->cticks = ticks;
 	else if (!timeri->cticks)



