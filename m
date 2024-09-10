Return-Path: <stable+bounces-75584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB58973548
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BDA28A4BA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F118DF9E;
	Tue, 10 Sep 2024 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlTPBg3K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9614D431;
	Tue, 10 Sep 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965160; cv=none; b=ZYrTD6ifvihAvYzDIFk5i0xge7mA+jJm4hFQkN87GPuFmX6mzGbL1q2eECgXAGeuDScItN5lD/V/AYY3WTmweArPOMnwwoBsbktrM2QiDfWtFDfAh0egYqxJ6r7rqvT1/r4kms01+67iTRqgYKpsiPNiHQuigBkWr2DsLo4Pj6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965160; c=relaxed/simple;
	bh=gbNJBW1bagVSgyNLCIPRZC/Z3/rj+1sk7icdlSSWqf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+HOvRna3WCPglr8LtCkQ0JhFiLyjrPkLvkjN1QFEvfdwAHat0xEHbY1N8Zruik8umdpJXoHXQ5ruN6SZpwR+fV26FsAQBpKyHvbnjPyE+HiNW0Z/4I/DpYokxxr9do2bA05+OO+sejf7TpzitZ75U4MKE+3zL/jHSBUzZBHrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlTPBg3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B371C4CEC3;
	Tue, 10 Sep 2024 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725965160;
	bh=gbNJBW1bagVSgyNLCIPRZC/Z3/rj+1sk7icdlSSWqf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlTPBg3KdKt5y+/HPgUyl9c+9HRys3Aust+1ejAZ7+mgiOSKLgC6RJE+iP5ZGBUGi
	 CsyaNbCYjc6hQRHxpzRGLsTnkS4iNw3OSGjszBDEV0/OIvG1y1EuBUuIPZBdczQ9dB
	 UrFU4adua0f5HDODNhb0eLq7u5huTAJ96d1uYf6M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+0122fa359a69694395d5@syzkaller.appspotmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 150/186] Input: uinput - reject requests with unreasonable number of slots
Date: Tue, 10 Sep 2024 11:34:05 +0200
Message-ID: <20240910092600.768267788@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 206f533a0a7c683982af473079c4111f4a0f9f5e ]

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

When exercising uinput interface syzkaller may try setting up device
with a really large number of slots, which causes memory allocation
failure in input_mt_init_slots(). While this allocation failure is
handled properly and request is rejected, it results in syzkaller
reports. Additionally, such request may put undue burden on the
system which will try to free a lot of memory for a bogus request.

Fix it by limiting allowed number of slots to 100. This can easily
be extended if we see devices that can track more than 100 contacts.

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+0122fa359a69694395d5@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=0122fa359a69694395d5
Link: https://lore.kernel.org/r/Zqgi7NYEbpRsJfa2@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/uinput.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index f2593133e524..790db3ceb208 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -416,6 +416,20 @@ static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
 		return -EINVAL;
 	}
 
+	/*
+	 * Limit number of contacts to a reasonable value (100). This
+	 * ensures that we need less than 2 pages for struct input_mt
+	 * (we are not using in-kernel slot assignment so not going to
+	 * allocate memory for the "red" table), and we should have no
+	 * trouble getting this much memory.
+	 */
+	if (code == ABS_MT_SLOT && max > 99) {
+		printk(KERN_DEBUG
+		       "%s: unreasonably large number of slots requested: %d\n",
+		       UINPUT_NAME, max);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.43.0




