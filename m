Return-Path: <stable+bounces-128836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B08A7F584
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4807D189B215
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 07:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701EE25FA12;
	Tue,  8 Apr 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVDeDvCT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C726138B
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095783; cv=none; b=C91G5y1YY/o4PeOofSWBflyTadXg0sH5pTCb07Lma4yM86HaywjVqsmWnFHaO/dO/YM2NcaZuANfnl3CEIoM3aYPbL4kccrw26wB2lJMbnoTJNfr4KfSd9PU7WXDO0aqSrXo3TdCEq+6q48coYSCL8rbK2jVmPq/5dryKOMXO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095783; c=relaxed/simple;
	bh=6rgm0fFqk4s/DDKpDtxiVKOtV3YuF4aDKCjlFB7XGK0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b25EpC4066WI7AS1ghno8M95FdWo2D31k8UUk6/Fxc68mL5hUNgKCSTHNYI2QATAzB6i9aLmPDi6iBkbmrqLl1k+4fFlJ3Q/IWpM8QoBL7PfTe6zHl+uF0oOjqBiGA5HDjoTcaXFRn8P1TghIOMH8CzE9oscrfsHeWLfuJYOns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVDeDvCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A75DC4CEE5;
	Tue,  8 Apr 2025 07:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744095782;
	bh=6rgm0fFqk4s/DDKpDtxiVKOtV3YuF4aDKCjlFB7XGK0=;
	h=Subject:To:Cc:From:Date:From;
	b=oVDeDvCTM89rnBaErK4//+BQ5/jdrFntYLL9eaJN86FkuSlN77REiLH9b8vSKDWCv
	 Dn2ux3EsrdStOwzRNGHURBL3nD4NUkUkuaRTTfjtBKDum9L60oMyKF29gKQfh3/eYF
	 tTwYersgtgVFQyM0RAILHDHmcOIJaTKUxvdVBwb0=
Subject: FAILED: patch "[PATCH] platform/x86: ISST: Correct command storage data length" failed to apply to 5.4-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 09:01:21 +0200
Message-ID: <2025040821-underdone-luster-6e41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 9462e74c5c983cce34019bfb27f734552bebe59f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040821-underdone-luster-6e41@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9462e74c5c983cce34019bfb27f734552bebe59f Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Fri, 28 Mar 2025 15:47:49 -0700
Subject: [PATCH] platform/x86: ISST: Correct command storage data length
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After resume/online turbo limit ratio (TRL) is restored partially if
the admin explicitly changed TRL from user space.

A hash table is used to store SST mail box and MSR settings when modified
to restore those settings after resume or online. This uses a struct
isst_cmd field "data" to store these settings. This is a 64 bit field.
But isst_store_new_cmd() is only assigning as u32. This results in
truncation of 32 bits.

Change the argument to u64 from u32.

Fixes: f607874f35cb ("platform/x86: ISST: Restore state on resume")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250328224749.2691272-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index dbcd3087aaa4..31239a93dd71 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -84,7 +84,7 @@ static DECLARE_HASHTABLE(isst_hash, 8);
 static DEFINE_MUTEX(isst_hash_lock);
 
 static int isst_store_new_cmd(int cmd, u32 cpu, int mbox_cmd_type, u32 param,
-			      u32 data)
+			      u64 data)
 {
 	struct isst_cmd *sst_cmd;
 


