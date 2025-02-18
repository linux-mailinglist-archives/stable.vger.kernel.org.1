Return-Path: <stable+bounces-116746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584E3A39B5B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DCB189425F
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B48235BF0;
	Tue, 18 Feb 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZhqbS/GV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E1154C12
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879210; cv=none; b=g4EVyqbObmAqzMNdEUvxW6RdVcS7ooOZZbOy1qUKT6Ia7xjxhk+3MONrtZj6ljq4VnmibbMiL8YjVNhsP4DsPtUlYzZYRAGqscnf+rCf/q+hWEk7cQ0ZW8YBuuGr+lf4oIZ1/JPiMXxybnqwIYyI40hCL5h6gDlfqWu2EH8t5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879210; c=relaxed/simple;
	bh=pbOUaqW1T7n5nLg7VL5I89T4+rECun55nQy4nOpDExg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rQy7WAQ1ZYpZpcMDR5rFy6wvyQpK0Tt66deiPUyg6LtsY3HxXuDWtHtDJX/OwOdSci2bXN1ZVIywYNXsHUB7zAiWk2jS89oNeHiOUbcJVOr03IQQulbc/lT7aNRKkyFYHaWKYISR6LsqcrVbiv8exwckLNWIvSAgWnbgI9wa+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZhqbS/GV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C225AC4CEE2;
	Tue, 18 Feb 2025 11:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739879210;
	bh=pbOUaqW1T7n5nLg7VL5I89T4+rECun55nQy4nOpDExg=;
	h=Subject:To:Cc:From:Date:From;
	b=ZhqbS/GVIeiL4v4nHe/cl5m3tJg/worKtEbLLQpWenFjQ+bJ1rKipD7Eg5VzZNJ+L
	 WHT/w4tLjy+uONPHPlLx0ctlyI2EN+ks0pxP2ZkGIuhzmZIjbJ24yHQXAVQgbo0G2w
	 lWWSGDKHNHQ1NGTuiyTKJ453beqjZ+lxQ8oKMyaY=
Subject: FAILED: patch "[PATCH] USB: gadget: f_midi: f_midi_complete to call queue_work" failed to apply to 5.4-stable tree
To: jilliandonahue58@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:46:46 +0100
Message-ID: <2025021846-penholder-punisher-66e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 4ab37fcb42832cdd3e9d5e50653285ca84d6686f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021846-penholder-punisher-66e6@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4ab37fcb42832cdd3e9d5e50653285ca84d6686f Mon Sep 17 00:00:00 2001
From: Jill Donahue <jilliandonahue58@gmail.com>
Date: Tue, 11 Feb 2025 10:48:05 -0700
Subject: [PATCH] USB: gadget: f_midi: f_midi_complete to call queue_work

When using USB MIDI, a lock is attempted to be acquired twice through a
re-entrant call to f_midi_transmit, causing a deadlock.

Fix it by using queue_work() to schedule the inner f_midi_transmit() via
a high priority work queue from the completion handler.

Link: https://lore.kernel.org/all/CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com/
Fixes: d5daf49b58661 ("USB: gadget: midi: add midi function driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Jill Donahue <jilliandonahue58@gmail.com>
Link: https://lore.kernel.org/r/20250211174805.1369265-1-jdonahue@fender.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 47260d65066a..da82598fcef8 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -283,7 +283,7 @@ f_midi_complete(struct usb_ep *ep, struct usb_request *req)
 			/* Our transmit completed. See if there's more to go.
 			 * f_midi_transmit eats req, don't queue it again. */
 			req->length = 0;
-			f_midi_transmit(midi);
+			queue_work(system_highpri_wq, &midi->work);
 			return;
 		}
 		break;


