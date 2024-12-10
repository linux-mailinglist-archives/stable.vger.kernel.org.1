Return-Path: <stable+bounces-100370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDA79EAC39
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9774228FF8F
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F0778F2B;
	Tue, 10 Dec 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KvkHuast"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC578F27
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823089; cv=none; b=tz9XgwrG9/YYMv59Mdf3FMNAKE18J4GVcGn9Sp3fNRovYqsdec8WpINRisavWjxPHbdexhmKs6D2kK+6hi9aYeDn5NS+jFQkndXZ54xVaJh7Fznm+n7QhwVKQxIyam5YYwSyG24uLVYp+5q4ZnIemGMFBbUHx1bwlxi0a2PEXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823089; c=relaxed/simple;
	bh=Hrwcktk89hOh+61K0ZMFDD/1uYm3K6l3adNFPXrFN3o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uDVtl4lgm+eTa76hpwpwunuzrT+4Cotmim90MssrKpxLV/AtICnDdcHORl6l9KAtl4UHl9X7nYOlS5mpdmbGQYPj5fH47gUXXJBqdwh2IURK8b9xPwdcdoMWAqkK7VAn+em0tb0RHhTOs7dZlEh/Ro+2QaI4w/ukkGog6HXUZ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KvkHuast; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA9DC4CED6;
	Tue, 10 Dec 2024 09:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733823088;
	bh=Hrwcktk89hOh+61K0ZMFDD/1uYm3K6l3adNFPXrFN3o=;
	h=Subject:To:Cc:From:Date:From;
	b=KvkHuastTTVOnHuhUvdNi2oUUWaqRbmpfq/rhtjSkfO1Wglm4kCPjE6QDIdPWU210
	 3xx/FlSngKH15HAhh9fbJnvlW9r8B44yeoUfKPpnfjof5YtpP7aYbnrWhzwl7DUs68
	 Z95nrqrfmtkzdzKDZYqaT2gOXDPkrKeJOO6cKsLA=
Subject: FAILED: patch "[PATCH] modpost: Add .irqentry.text to OTHER_SECTIONS" failed to apply to 5.10-stable tree
To: tglx@linutronix.de,masahiroy@kernel.org,senozhatsky@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:30:43 +0100
Message-ID: <2024121043-moneyless-stucco-c8f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7912405643a14b527cd4a4f33c1d4392da900888
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121043-moneyless-stucco-c8f1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


