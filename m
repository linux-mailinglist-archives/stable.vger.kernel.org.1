Return-Path: <stable+bounces-62699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD11940D94
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C26282DFB
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5513195801;
	Tue, 30 Jul 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ln4jyIFm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75561194C75
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331707; cv=none; b=gdE2anKF17xA5WDV4HxxD0ukbhzd4vBRU09GxL9yAYMd/cXKLt7Lwut5ssy9PmFxiaYk2fG8b4NCpRZl3948+MwE2Lq/aZ1UMKJFvgfYIaIhvxoIAb/od7VysWhneSdnyzJk6UO6Wu5MeuWOuULS8zpG7sq0LGq1OPm37hZmgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331707; c=relaxed/simple;
	bh=TcUpK8sdF0dXelwIX2UTS7YHUDxZzOnmJNfZiYFBm6E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XPHsTVtizOgGenKBogkt2MKJ3JbC8HO8c2yGFaQs0zkz/8/CO7nAo8I9ViTrkIkV6SoxlFcwd5xcTNV+NRCmJf+VmiAYu0qJPKhvpSMd3IayVx5rDRqzc9UsuV8rzG5DPL27DjmGqEhJNiGbGdm3B5KJ5DbNfkss4U8UbwWqfyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ln4jyIFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC0FC32782;
	Tue, 30 Jul 2024 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331707;
	bh=TcUpK8sdF0dXelwIX2UTS7YHUDxZzOnmJNfZiYFBm6E=;
	h=Subject:To:Cc:From:Date:From;
	b=ln4jyIFmOmXcRENUXSTDKH02wyaNQhYF/QUEJ0DbPt8zo4VqPMZAW3O+xVxF0pto/
	 39B4w23oXtnsAFrHuoNsv8mHO6s724x8CYaRPhZ3+v9Nn+UG4Wpk2SUH/2qGVe/Bk7
	 FLNlDBlmWtRcq0RFRK5nX9nRbU1me/q5GUh7chWM=
Subject: FAILED: patch "[PATCH] perf/x86/intel/pt: Fix a topa_entry base address calculation" failed to apply to 4.19-stable tree
To: adrian.hunter@intel.com,dave.hansen@linux.intel.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:28:23 +0200
Message-ID: <2024073023-blame-activist-10a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x ad97196379d0b8cb24ef3d5006978a6554e6467f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073023-blame-activist-10a9@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

ad97196379d0 ("perf/x86/intel/pt: Fix a topa_entry base address calculation")
38bb8d77d0b9 ("perf/x86/intel/pt: Split ToPA metadata and page layout")
539f7c26b41d ("perf/x86/intel/pt: Use pointer arithmetics instead in ToPA entry calculation")
fffec50f541a ("perf/x86/intel/pt: Use helpers to obtain ToPA entry size")
f6d079ce867d ("perf/x86/intel/pt: Export pt_cap_get()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ad97196379d0b8cb24ef3d5006978a6554e6467f Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Mon, 24 Jun 2024 23:10:56 +0300
Subject: [PATCH] perf/x86/intel/pt: Fix a topa_entry base address calculation

topa_entry->base is a bit-field. Bit-fields are not promoted to a 64-bit
type, even if the underlying type is 64-bit, and so, if necessary, must
be cast to a larger type when calculations are done.

Fix a topa_entry->base address calculation by adding a cast.

Without the cast, the address was limited to 36-bits i.e. 64GiB.

The address calculation is used on systems that do not support Multiple
Entry ToPA (only Broadwell), and affects physical addresses on or above
64GiB. Instead of writing to the correct address, the address comprising
the first 36 bits would be written to.

Intel PT snapshot and sampling modes are not affected.

Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240624201101.60186-3-adrian.hunter@intel.com

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 14db6d9d318b..047a2cd5b3fe 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -878,7 +878,7 @@ static void pt_update_head(struct pt *pt)
  */
 static void *pt_buffer_region(struct pt_buffer *buf)
 {
-	return phys_to_virt(TOPA_ENTRY(buf->cur, buf->cur_idx)->base << TOPA_SHIFT);
+	return phys_to_virt((phys_addr_t)TOPA_ENTRY(buf->cur, buf->cur_idx)->base << TOPA_SHIFT);
 }
 
 /**


