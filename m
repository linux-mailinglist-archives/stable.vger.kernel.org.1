Return-Path: <stable+bounces-100371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B299EAC3B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFFB169D06
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20C178F2A;
	Tue, 10 Dec 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fO91WH4z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1790223E9F
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823090; cv=none; b=NgFPrro6lUQ6JuTamWwlCKjwALLFyQx2JzNLUlYYl7CJUEkLpiRIKEi2u8VjcWqYrv5rmnuJnfmjoRyK3rnwEck5C4w0tu7yy1VShRxfyCtqm6aBAs+eIP7ZF/CM259jut2vclqNNhjReRIr9dGI6vesy5/CgGAuNPRnob3io9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823090; c=relaxed/simple;
	bh=7QI6Y8KlKgm4lt1+mgdxYLIwFnM249TypTXWyz5di74=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sd61FLBmYzs0+F7TRFYyvWo7Dh/aiWLCmbpIoOgtDoJbKlmg8WsoGAMeQ/hHIL+sbKfGA7dty4PyeI+JoUwXyuzIOvDoRX/5FTURG+UoRM8EwHmfXkKec6SjvhSrKrAg5DWjHcfIM9BtMWJz9BtHQqURXkcnxfeetbYvr5FP6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fO91WH4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEBDC4CED6;
	Tue, 10 Dec 2024 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733823090;
	bh=7QI6Y8KlKgm4lt1+mgdxYLIwFnM249TypTXWyz5di74=;
	h=Subject:To:Cc:From:Date:From;
	b=fO91WH4zoE5zWRHyoYQSLh6OcE4X0Z71jb5/7zZne3cKEF70Q3xv1rKUS6NJV6oue
	 2R4Zs43vJI5U1qw0NJ7bsyJr/P9tFBDLOSRMfk+BgylOKTPXVnanWomdiPHCrvfX1F
	 tEVoRVHo0Tr4mqua1XtwoOud2W+5MH5dGHSTkFMs=
Subject: FAILED: patch "[PATCH] modpost: Add .irqentry.text to OTHER_SECTIONS" failed to apply to 5.4-stable tree
To: tglx@linutronix.de,masahiroy@kernel.org,senozhatsky@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:30:44 +0100
Message-ID: <2024121044-elbow-varmint-5f14@gregkh>
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
git cherry-pick -x 7912405643a14b527cd4a4f33c1d4392da900888
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121044-elbow-varmint-5f14@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7912405643a14b527cd4a4f33c1d4392da900888 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 1 Dec 2024 12:17:30 +0100
Subject: [PATCH] modpost: Add .irqentry.text to OTHER_SECTIONS

The compiler can fully inline the actual handler function of an interrupt
entry into the .irqentry.text entry point. If such a function contains an
access which has an exception table entry, modpost complains about a
section mismatch:

  WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference ...

  The relocation at __ex_table+0x447c references section ".irqentry.text"
  which is not in the list of authorized sections.

Add .irqentry.text to OTHER_SECTIONS to cure the issue.

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org # needed for linux-5.4-y
Link: https://lore.kernel.org/all/20241128111844.GE10431@google.com/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0584cbcdbd2d..fb787a5715f5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -772,7 +772,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 		".ltext", ".ltext.*"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", \
-		".coldtext", ".softirqentry.text"
+		".coldtext", ".softirqentry.text", ".irqentry.text"
 
 #define ALL_TEXT_SECTIONS  ".init.text", ".exit.text", \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS


