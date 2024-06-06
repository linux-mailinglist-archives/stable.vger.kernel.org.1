Return-Path: <stable+bounces-49888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAC78FEF44
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8887C2881B5
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289A21A257A;
	Thu,  6 Jun 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TxQR+uLp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2F1CBE82;
	Thu,  6 Jun 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683760; cv=none; b=eG9UpCufnzDFzXirHOgwEV3Ic3EKqlGiV+EMWEFXrjmdKEp67CYPdEKAcBEAoGjWdBxKs8gn5K9u9W/hxJyU3wYb8afTm05RTwkQ3YM3b/CzwRLO2/l9GbIYF5CzcUEsIMYg2syj/+3n0lI89hRUSQUbUQcIsLui1q47k3PR9g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683760; c=relaxed/simple;
	bh=u7yJ7P6vFMLXbQfP8LxYuRQ/ZJKfh51M9xq5YCUHA2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHw4sCOiUDiVzfe6MvbRhGLvXeh77JyiDrag5CNSSj+CMM+L+ToQZGDKI/nsS5HGcZgmfkue3tYq5D3Hnofa+SrWrCeAh/QcxlVa490+8LjvY1Z5QuoOuNvmRr1ZWlxtG4gLs1c6+xxOqJIfUtpG6YN+o9iEs+NchybWxc2T3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TxQR+uLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB53C2BD10;
	Thu,  6 Jun 2024 14:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683760;
	bh=u7yJ7P6vFMLXbQfP8LxYuRQ/ZJKfh51M9xq5YCUHA2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxQR+uLpPb72N5CFHvh1xtIBuWGIFpjsZFViLfeC0H11pvwHD5Hy7RFAzSmKB8ToL
	 pYJRXhcLFswl6aMFCIES97dCYaR+6kpSzuY1kR+tn48Mt9zRAIssleQuIJ5IGJv+S3
	 REyvMqvX2AEZ1Z/eat1/hkWsRV5Ci75GqjkkISNQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+43120c2af6ca2938cc38@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 737/744] ALSA: timer: Set lower bound of start tick time
Date: Thu,  6 Jun 2024 16:06:49 +0200
Message-ID: <20240606131756.105341743@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
[ backport note: the error handling is changed, as the original commit
  is based on the recent cleanup with guard() in commit beb45974dd49
  -- tiwai ]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/timer.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -553,6 +553,16 @@ static int snd_timer_start1(struct snd_t
 		goto unlock;
 	}
 
+	/* check the actual time for the start tick;
+	 * bail out as error if it's way too low (< 100us)
+	 */
+	if (start) {
+		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000) {
+			result = -EINVAL;
+			goto unlock;
+		}
+	}
+
 	if (start)
 		timeri->ticks = timeri->cticks = ticks;
 	else if (!timeri->cticks)



