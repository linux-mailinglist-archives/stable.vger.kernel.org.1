Return-Path: <stable+bounces-45674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3550C8CD22F
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 14:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2041C2100A
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245713BAC8;
	Thu, 23 May 2024 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xoTPBHkD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CBC13B5A6
	for <stable@vger.kernel.org>; Thu, 23 May 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466817; cv=none; b=nXVev+3R8CXFbH7UkYGJk5YDa/iyQO8HdniCftdinUKLIDBVpFCDHtT94fVHIpzlvFQ6n9ImTklgqEPPLErLwrP36ID0bj433lY8phRGfNnNktcoQEbDeFpnblD68sWYe7ISVk8r/po6IJcWP72snk18amQCdsowDWtrBPVFqoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466817; c=relaxed/simple;
	bh=koObKfCQdfJ93+AU42anG1G9oFrQY4V1880EWm/oRBY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BBNf6VG4z1mZLA9lxptubVL8flsVUklsGSH67tXTunikNW0fl9ZxkjNHASvpA1HPVbvYDZSMROub1glIgJy23iR5J+wXsoWsFQ7YPKSmrt6ewhy5SjLnHqBNpbVuvsKzer/DhVDafkfwSX44QoxPKXPvNqVkXy3f7vJuQksDl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xoTPBHkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7B4C2BD10;
	Thu, 23 May 2024 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716466816;
	bh=koObKfCQdfJ93+AU42anG1G9oFrQY4V1880EWm/oRBY=;
	h=Subject:To:Cc:From:Date:From;
	b=xoTPBHkDr3NKS4mzWEK6qcs7tXew6fm9fYSg92+C+k49K0B3UnRygvWbJeHijgRz7
	 E6DvzOxRfEAOGeTXaMmyubYBZRTW/v8n6rQ46gxh2OZGVQrjsjDwLObmNZGSTJFAuP
	 0wLRzkMfHTeAFAh3Ai9WBLTVZtC0II3ANLVM5UaY=
Subject: FAILED: patch "[PATCH] binder: fix max_thread type inconsistency" failed to apply to 5.10-stable tree
To: cmllamas@google.com,aliceryhl@google.com,arve@android.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 May 2024 14:20:13 +0200
Message-ID: <2024052313-runner-spree-04c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 42316941335644a98335f209daafa4c122f28983
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052313-runner-spree-04c1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 42316941335644a98335f209daafa4c122f28983 Mon Sep 17 00:00:00 2001
From: Carlos Llamas <cmllamas@google.com>
Date: Sun, 21 Apr 2024 17:37:49 +0000
Subject: [PATCH] binder: fix max_thread type inconsistency
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
size_t to __u32 in order to avoid incompatibility issues between 32 and
64-bit kernels. However, the internal types used to copy from user and
store the value were never updated. Use u32 to fix the inconsistency.

Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS declaration")
Reported-by: Arve Hjønnevåg <arve@android.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20240421173750.3117808-1-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index dd6923d37931..b21a7b246a0d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5367,7 +5367,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			goto err;
 		break;
 	case BINDER_SET_MAX_THREADS: {
-		int max_threads;
+		u32 max_threads;
 
 		if (copy_from_user(&max_threads, ubuf,
 				   sizeof(max_threads))) {
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 7270d4d22207..5b7c80b99ae8 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -421,7 +421,7 @@ struct binder_proc {
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
-	int max_threads;
+	u32 max_threads;
 	int requested_threads;
 	int requested_threads_started;
 	int tmp_ref;


