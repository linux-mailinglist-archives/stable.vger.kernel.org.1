Return-Path: <stable+bounces-46848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39EA8D0B83
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B0F1C2161D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341F626ACA;
	Mon, 27 May 2024 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fZHCQEZ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175417E90E;
	Mon, 27 May 2024 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837010; cv=none; b=UdheY+4zG7xXwLAfCK2UKZuxh6PktypAtVafqSoGzixiVwWFrqC0CByFn2dIts/9u22PHVN2e1YBn1bRGarss0SQw+e3MeboPvn5/ghEwEOfzWFdo5IahM55y1Cw6bEHlS2bw44cAbqWo+oEr/9OX44QFCwNn6K7yl+Ulz/y+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837010; c=relaxed/simple;
	bh=TJyKCcmvBHkddlO5DEkPLmJ5QfWo+eTUviEUPyB/F5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHi67J+GfP7OMUe7YEFoCNLkkf4TmUOWbyN8mjJjnFb95mjyLMBPl7yJoBB6mVo9jx80IKylMmIGuPJme9SJnqZJHwlfk4bXQsg9dUw03talwNtfy+fXTnHsuZTf+76dUJ0LtK0S2YhhcODGq4ncbnYblVAjVtry861PYw9TONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fZHCQEZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C2EC32781;
	Mon, 27 May 2024 19:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837009;
	bh=TJyKCcmvBHkddlO5DEkPLmJ5QfWo+eTUviEUPyB/F5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZHCQEZ2l9mmgQjjiu/QXKb+cqp6AJN4xTR5jFMtBNdCQOOwAP+udASjcvxJ8nBpg
	 FgZuS0YMFvpUw8lk3/LFnUyc8yfcHpgqFOkiEwi08Z3/kj2dR9HHt9zGE8+bRfloVR
	 +JtAbpw7RZPAvH6xrxtYgEeTGnl9adgLgCTHE0vw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 233/427] dm-delay: fix workqueue delay_timer race
Date: Mon, 27 May 2024 20:54:40 +0200
Message-ID: <20240527185624.233011604@linuxfoundation.org>
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

From: Benjamin Marzinski <bmarzins@redhat.com>

[ Upstream commit 8d24790ed08ab4e619ce58ed4a1b353ab77ffdc5 ]

delay_timer could be pending when delay_dtr() is called. It needs to be
shut down before kdelayd_wq is destroyed, so it won't try queueing more
work to kdelayd_wq while that's getting destroyed.

Also the del_timer_sync() call in delay_presuspend() doesn't protect
against the timer getting immediately rearmed by the queued call to
flush_delayed_bios(), but there's no real harm if that does happen.
timer_delete() is less work, and is basically just as likely to stop a
pointless call to flush_delayed_bios().

Fixes: 26b9f228703f ("dm: delay target")
Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-delay.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 5eabdb06c6498..eec0daa4b227a 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -154,8 +154,10 @@ static void delay_dtr(struct dm_target *ti)
 {
 	struct delay_c *dc = ti->private;
 
-	if (dc->kdelayd_wq)
+	if (dc->kdelayd_wq) {
+		timer_shutdown_sync(&dc->delay_timer);
 		destroy_workqueue(dc->kdelayd_wq);
+	}
 
 	if (dc->read.dev)
 		dm_put_device(ti, dc->read.dev);
@@ -335,7 +337,7 @@ static void delay_presuspend(struct dm_target *ti)
 	mutex_unlock(&delayed_bios_lock);
 
 	if (!delay_is_fast(dc))
-		del_timer_sync(&dc->delay_timer);
+		timer_delete(&dc->delay_timer);
 	flush_delayed_bios(dc, true);
 }
 
-- 
2.43.0




