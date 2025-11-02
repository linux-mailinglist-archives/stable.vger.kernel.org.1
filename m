Return-Path: <stable+bounces-192032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A777C28F9B
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77C714E54C1
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B451B87EB;
	Sun,  2 Nov 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zkG6xWIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E363CF
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762090966; cv=none; b=M6Z8/DpXoacOWgDFZOZY5kAHWmr4Zkp6/CWMGvDIuWlV4XDk8bV/cPne+rc4fJwG8hnHIK47g+/ge/fcUCbcOjASSrgg9IcBEIdCt8/kb6lE7d4sV72Z9k5mt+F3zDqsbm/RKe8F7ysgVDcuxPVKs/wPWAZg22dWbzkmhLUkldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762090966; c=relaxed/simple;
	bh=tURHq+ywfo9gorS4nnE6rEBSbDTfGYlkMTnzvWhnwqA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YojAGrxyX7I3ej4Ut6la1mOqs/Ukw6hpV9LTLZQq2uuhJmqBFvAJrDbm7A+byrfY8/I0OOLCtG6YX3M/kl9YyOpXt8t4V6y0BjT2iayz3rdWxjuGAK5HUJvHe2k28AaKrneriG/sp0ZIz183oTofSxviD9BCF/mGsR5hiESDaaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zkG6xWIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C98BC116B1;
	Sun,  2 Nov 2025 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762090966;
	bh=tURHq+ywfo9gorS4nnE6rEBSbDTfGYlkMTnzvWhnwqA=;
	h=Subject:To:Cc:From:Date:From;
	b=zkG6xWIFH/jgGMJexrrvfdJ2UBQ3lZk+VWKCMisatmI4alKMUt9JPERKaSkrztNXB
	 POkrtou0F79BYQmMl+1rl/zvtZs5zC2TnkYMhQgdzdCbbOLcCkznS9tfQQkVL+WBpJ
	 GXZtCUgN7jdtOAgGRBRVM0j+cqP8EyE2euzkrXtM=
Subject: FAILED: patch "[PATCH] cpuidle: governors: menu: Select polling state in some more" failed to apply to 6.17-stable tree
To: rafael.j.wysocki@intel.com,christian.loehle@arm.com,dsmythies@telus.net,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:42:43 +0900
Message-ID: <2025110243-dupe-pentagram-9b47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x db86f55bf81a3a297be05ee8775ae9a8c6e3a599
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110243-dupe-pentagram-9b47@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db86f55bf81a3a297be05ee8775ae9a8c6e3a599 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Thu, 23 Oct 2025 19:12:57 +0200
Subject: [PATCH] cpuidle: governors: menu: Select polling state in some more
 cases

A throughput regression of 11% introduced by commit 779b1a1cb13a ("cpuidle:
governors: menu: Avoid selecting states with too much latency") has been
reported and it is related to the case when the menu governor checks if
selecting a proper idle state instead of a polling one makes sense.

In particular, it is questionable to do so if the exit latency of the
idle state in question exceeds the predicted idle duration, so add a
check for that, which is sufficient to make the reported regression go
away, and update the related code comment accordingly.

Fixes: 779b1a1cb13a ("cpuidle: governors: menu: Avoid selecting states with too much latency")
Closes: https://lore.kernel.org/linux-pm/004501dc43c9$ec8aa930$c59ffb90$@telus.net/
Reported-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/12786727.O9o76ZdvQC@rafael.j.wysocki

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 7d21fb5a72f4..23239b0c04f9 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -318,10 +318,13 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 		/*
 		 * Use a physical idle state, not busy polling, unless a timer
-		 * is going to trigger soon enough.
+		 * is going to trigger soon enough or the exit latency of the
+		 * idle state in question is greater than the predicted idle
+		 * duration.
 		 */
 		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-		    s->target_residency_ns <= data->next_timer_ns) {
+		    s->target_residency_ns <= data->next_timer_ns &&
+		    s->exit_latency_ns <= predicted_ns) {
 			predicted_ns = s->target_residency_ns;
 			idx = i;
 			break;


