Return-Path: <stable+bounces-98987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5279B9E6BA2
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493AD1887B2E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9E21DFE2B;
	Fri,  6 Dec 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dTKyH0i3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797124C83
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480140; cv=none; b=RKtOIU9CD9DQGIotNwpIYUGzS8nw6Spc3MfrUHxMJKRc3MZQgM6I9JKJVuXi0EcoLmlqCAQ6xJFEAxj7CuaGL0+Fwf1VAHJE7BRiQEEVOu0ZLObwU+zNRAw87wLGcEXdYeK3szpnkdY4MfalYjgwwnMPWxfnlPlWDeeseB5ouqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480140; c=relaxed/simple;
	bh=wF9j5IPNQAGBZ1OzJDIaa3gsUMCViN5OhYlZi7qTC38=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V6rLb4cwNgCyn8R7F/AzIrMnSTQI+KdDUuXwXKgcF5Wt8F/HtF6QJ3YaF4209MsJSYajS24aGdCslme/Ae+WKWfkcaSyethzaeGRnL2AQqWj9bw+yJvyZg4CqRjT7aSqf5pyEHvGL/itBblfCuclKrGWgQrNKKUgJA5NMgU/sRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dTKyH0i3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A275C4CED1;
	Fri,  6 Dec 2024 10:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733480140;
	bh=wF9j5IPNQAGBZ1OzJDIaa3gsUMCViN5OhYlZi7qTC38=;
	h=Subject:To:Cc:From:Date:From;
	b=dTKyH0i3c0vx3gdEhyDKVtOnhBPcyS0Ax51PwivUuPCvVMoYAoIIpTuOdfzGcwgZ+
	 zeKMlJ+Xi4AJONuDygCVlS5uhB5/J8bAeCV5oCSX7KDQ1EFnIO+9w0rz7Lg24tprTO
	 TcAC6HwAHBsPpzj84aHE+6XebTPov9S3PtQi1ers=
Subject: FAILED: patch "[PATCH] zram: clear IDLE flag in mark_idle()" failed to apply to 5.15-stable tree
To: senozhatsky@chromium.org,akpm@linux-foundation.org,bgeffon@google.com,kawasin@google.com,minchan@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 11:15:23 +0100
Message-ID: <2024120623-unleash-sustainer-86ec@gregkh>
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
git cherry-pick -x d37da422edb0664a2037e6d7d42fe6d339aae78a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120623-unleash-sustainer-86ec@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d37da422edb0664a2037e6d7d42fe6d339aae78a Mon Sep 17 00:00:00 2001
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Tue, 29 Oct 2024 00:36:15 +0900
Subject: [PATCH] zram: clear IDLE flag in mark_idle()

If entry does not fulfill current mark_idle() parameters, e.g.  cutoff
time, then we should clear its ZRAM_IDLE from previous mark_idle()
invocations.

Consider the following case:
- mark_idle() cutoff time 8h
- mark_idle() cutoff time 4h
- writeback() idle - will writeback entries with cutoff time 8h,
  while it should only pick entries with cutoff time 4h

The bug was reported by Shin Kawamura.

Link: https://lkml.kernel.org/r/20241028153629.1479791-3-senozhatsky@chromium.org
Fixes: 755804d16965 ("zram: introduce an aged idle interface")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Shin Kawamura <kawasin@google.com>
Acked-by: Brian Geffon <bgeffon@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org>

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a16dbffcdca3..cee49bb0126d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -410,6 +410,8 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 #endif
 		if (is_idle)
 			zram_set_flag(zram, index, ZRAM_IDLE);
+		else
+			zram_clear_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
 	}
 }


