Return-Path: <stable+bounces-48707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22EA8FEA24
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17251C22207
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65E819E7E0;
	Thu,  6 Jun 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LFtvzMWZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F111990A6;
	Thu,  6 Jun 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683107; cv=none; b=Ab0OwMnnXEd4IF1EHsLISdgSh9E4Rf78qnpr7PjWoxvk3g9xKKB7AGUk5cwOiqJJm7bg4Hvdt1zgRt1Uar9gOEk7eDhM7zmnGP9O/6S4bAzQxFqsNGFb0PYLUw3B0AOk4WxhxBHS0uDMStuFmlmWMumBpV95yP+T3jzzvGWQqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683107; c=relaxed/simple;
	bh=r5RB7WOoN3OdgGWCAZby+Eqke3cKbwb9V8X0VfC0GPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSH07EKU/U4c+amYYImrYmFAAKFudHflJoa8BRMFwMPQ5L0cyad2IhbQf74PWFp13ZZBc68lCOjfntFGcsBQM5xYTNhUayiAMsFo4FmWn9MYjA2sAW0BUlqV2VF82dwO8Ge+Q+eHtwmROrKpQJmIcMtF/vKTgu5PuVby//xZETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LFtvzMWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7FEC32781;
	Thu,  6 Jun 2024 14:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683107;
	bh=r5RB7WOoN3OdgGWCAZby+Eqke3cKbwb9V8X0VfC0GPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFtvzMWZCjOKLJ9k1jK+Ts1+arOOyyvUYXokEOmZvZCKOuruJHegjZ9923wWbNooq
	 uq3gE1CuIFRP9ZxTg49Fbe54Zp5hrTz8CNrmChYENuDxcETTJvR9GJC86imSqGoQV9
	 5o49uQJGBtlYSBtiqokuOksM8BpV7NSGaA/GFL7w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 031/744] ALSA: Fix deadlocks with kctl removals at disconnection
Date: Thu,  6 Jun 2024 15:55:03 +0200
Message-ID: <20240606131733.455310327@linuxfoundation.org>
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

commit 87988a534d8e12f2e6fc01fe63e6c1925dc5307c upstream.

In snd_card_disconnect(), we set card->shutdown flag at the beginning,
call callbacks and do sync for card->power_ref_sleep waiters at the
end.  The callback may delete a kctl element, and this can lead to a
deadlock when the device was in the suspended state.  Namely:

* A process waits for the power up at snd_power_ref_and_wait() in
  snd_ctl_info() or read/write() inside card->controls_rwsem.

* The system gets disconnected meanwhile, and the driver tries to
  delete a kctl via snd_ctl_remove*(); it tries to take
  card->controls_rwsem again, but this is already locked by the
  above.  Since the sleeper isn't woken up, this deadlocks.

An easy fix is to wake up sleepers before processing the driver
disconnect callbacks but right after setting the card->shutdown flag.
Then all sleepers will abort immediately, and the code flows again.

So, basically this patch moves the wait_event() call at the right
timing.  While we're at it, just to be sure, call wait_event_all()
instead of wait_event(), although we don't use exclusive events on
this queue for now.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218816
Cc: <stable@vger.kernel.org>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20240510101424.6279-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/init.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -523,6 +523,14 @@ void snd_card_disconnect(struct snd_card
 	}
 	spin_unlock(&card->files_lock);	
 
+#ifdef CONFIG_PM
+	/* wake up sleepers here before other callbacks for avoiding potential
+	 * deadlocks with other locks (e.g. in kctls);
+	 * then this notifies the shutdown and sleepers would abort immediately
+	 */
+	wake_up_all(&card->power_sleep);
+#endif
+
 	/* notify all connected devices about disconnection */
 	/* at this point, they cannot respond to any calls except release() */
 
@@ -550,7 +558,6 @@ void snd_card_disconnect(struct snd_card
 	mutex_unlock(&snd_card_mutex);
 
 #ifdef CONFIG_PM
-	wake_up(&card->power_sleep);
 	snd_power_sync_ref(card);
 #endif
 }



