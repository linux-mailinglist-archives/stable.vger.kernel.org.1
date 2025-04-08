Return-Path: <stable+bounces-128835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A12AA7F598
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F8E3B6697
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18525FA20;
	Tue,  8 Apr 2025 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XThf/myT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028C25FA18
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095774; cv=none; b=Zi5sQUQ85611f9BUaAU62kZU585G99NTL6+Uq1Edj8fIuvR9V+Jib7YUq7cBmaC9P931SLfYyiBd8yjI4OIk93NztS/sCI+vNaomFuh7Fd0BtCm3AxxebSzArkSUkmq7IvwS4JW8ZQ0GcLQ1SZIfwjGOeVVxroCxbictU0eNsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095774; c=relaxed/simple;
	bh=yOw1Xrrzri0cSrXtpGIEG/Aqcvt2SJEL6pdaDMKlTC0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ysr2gepYV8x7GieOAKgz4V2yUu0MknS7fw62sGd0W7elcXZDnQNgggF+qUZ3qVwTpIhiKXqCrTSULu7Vk4C/VAk13jnQhtTWCjea/BL2z+oxnlYu50I4YWSnTQp/SMHp0ba4SKoQVWfat2gNW2/7mGgl/jayFKIh47XANvN4IoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XThf/myT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D744DC4CEE5;
	Tue,  8 Apr 2025 07:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744095774;
	bh=yOw1Xrrzri0cSrXtpGIEG/Aqcvt2SJEL6pdaDMKlTC0=;
	h=Subject:To:Cc:From:Date:From;
	b=XThf/myTMRTO4UsYh1rD+0rpSyvSJxq3/Pv2dG3F+FzLDgPmPiq8cGpWQPr7IYL9/
	 XyHUDbsd+Dk703Suf/wz+Qr1zhPxb4If+daiZSjdPsPLmUhqvJbRfxsIBUNE80Hs8a
	 deRZL9HZM4uLPMeTUshouLrEtRkMPecgMNBCSTco=
Subject: FAILED: patch "[PATCH] platform/x86: ISST: Correct command storage data length" failed to apply to 5.10-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 09:01:21 +0200
Message-ID: <2025040821-pleading-cone-6de8@gregkh>
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
git cherry-pick -x 9462e74c5c983cce34019bfb27f734552bebe59f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040821-pleading-cone-6de8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


