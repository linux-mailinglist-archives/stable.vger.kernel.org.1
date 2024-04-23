Return-Path: <stable+bounces-40679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7853A8AE72D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2CC1F26247
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC43126F10;
	Tue, 23 Apr 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H++2iSCT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C57E765
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877137; cv=none; b=hvFbaeQscriqqhWt9269q58Boe43BQXIaMe0vELrbF/7tIQVunGkRRIp8LtmFLTLkrRQGVMcgu7J9V9HXCa95WrmS6mRx/ILzZQLoUfNP1JGtDlpxnNltXoimtF8FPy+UVBMlIoLNEf4dEguk5rwntDjmRghBOuVYXafkhD9DM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877137; c=relaxed/simple;
	bh=qr34IEVHnqeDLgfnBeKW7Sb84D7qBHZKie4AzR+dLy4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QEFTNEN1YT34ibdZ04xCSBzR5FstB8t+mKTu3Boz9918W1d98uzcu0nAMoIS3SFUJzt2kLyb9Edn1Vm1NsM2wWpqdZHiFI2J/lRi7fW9xdeDbHoM0EaCiHLQ3TOctxbzqNoIHG88IBJvWI2SyNOdvft8qNXoLPY5AIeNmzANrek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H++2iSCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5BBC116B1;
	Tue, 23 Apr 2024 12:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877137;
	bh=qr34IEVHnqeDLgfnBeKW7Sb84D7qBHZKie4AzR+dLy4=;
	h=Subject:To:Cc:From:Date:From;
	b=H++2iSCTgcDmVziXIH1+i/Y4TvDzNIAiCJd/0n2LtrO+F77Z0N5JrszU03uyjBFrW
	 X3gGwwjguQR6MUlVAcxa0uXRYCjwz0kxUokFjkvnX0ylEfSQXEQmU/vMzcm7kyOi42
	 N8shxmEB0GhPZfqGO126P/8OTgETT/tkloOxLyG8=
Subject: FAILED: patch "[PATCH] init/main.c: Fix potential static_command_line memory" failed to apply to 5.4-stable tree
To: ytcoode@gmail.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:58:47 -0700
Message-ID: <2024042347-create-item-ebf8@gregkh>
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
git cherry-pick -x 46dad3c1e57897ab9228332f03e1c14798d2d3b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042347-create-item-ebf8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

46dad3c1e578 ("init/main.c: Fix potential static_command_line memory overflow")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46dad3c1e57897ab9228332f03e1c14798d2d3b9 Mon Sep 17 00:00:00 2001
From: Yuntao Wang <ytcoode@gmail.com>
Date: Fri, 12 Apr 2024 16:17:32 +0800
Subject: [PATCH] init/main.c: Fix potential static_command_line memory
 overflow

We allocate memory of size 'xlen + strlen(boot_command_line) + 1' for
static_command_line, but the strings copied into static_command_line are
extra_command_line and command_line, rather than extra_command_line and
boot_command_line.

When strlen(command_line) > strlen(boot_command_line), static_command_line
will overflow.

This patch just recovers strlen(command_line) which was miss-consolidated
with strlen(boot_command_line) in the commit f5c7310ac73e ("init/main: add
checks for the return value of memblock_alloc*()")

Link: https://lore.kernel.org/all/20240412081733.35925-2-ytcoode@gmail.com/

Fixes: f5c7310ac73e ("init/main: add checks for the return value of memblock_alloc*()")
Cc: stable@vger.kernel.org
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/init/main.c b/init/main.c
index 881f6230ee59..5dcf5274c09c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -636,6 +636,8 @@ static void __init setup_command_line(char *command_line)
 	if (!saved_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
 
+	len = xlen + strlen(command_line) + 1;
+
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);


