Return-Path: <stable+bounces-203515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F32ADCE6921
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56CEC30275FF
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF12E7BD3;
	Mon, 29 Dec 2025 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uRxHkiJr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EDF30CDB6
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008421; cv=none; b=bmILzINWVDpgRqOxIg+apt/tXFAaC7BeOc+zwhzwbYKJQH6blE5/OvXSEr3z+v98u89W3BJZelK9eyRz6iAdNqjCJIvhVv4pxmr0ahgCQwAU6RRQEh2qZHZgASuVAOm0SO5077u8/S7TGzwaiZeRJ7DF5s1x8oM1wiW5xD2krA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008421; c=relaxed/simple;
	bh=iRw7BYWi9QXrOzu0H5y7Ww0CLBFa+/UtgBj/XOsPQQA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WY7801r7QNbDbZBdUWlsqlEOeLkkZCUc0fcSc+i+0aMbZm96srl87T+klIXqU4UDgennX1EA9CrLnjpzneqXTyqGbAglE1BfjSiHg2NQWmdPqbc7nBE47IdEvjP+o8NaOVFfA2CsP0L5aPPQmOMMWypB3KOXNpfxSH4SpGkgqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uRxHkiJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B990AC116C6;
	Mon, 29 Dec 2025 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008420;
	bh=iRw7BYWi9QXrOzu0H5y7Ww0CLBFa+/UtgBj/XOsPQQA=;
	h=Subject:To:Cc:From:Date:From;
	b=uRxHkiJrUx91LE8v0Me2cM8sdsG8xk0kReL9Esvh3WP06gXbIL0CmL6bnGk6FhAdB
	 K4/FkiFJUslxDHnOIhaAZUe2OxnA0AElf8h7ND+pStjBYS/Vof1i3t9wC865LWhmr6
	 ROOHDI+Ux+GV/6YIN29ygQSiiGaZ2tNalP5ZI+JA=
Subject: FAILED: patch "[PATCH] gfs2: fix freeze error handling" failed to apply to 6.1-stable tree
To: a.velichayshiy@ispras.ru,agruenba@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:40:07 +0100
Message-ID: <2025122907-defense-blanching-5c39@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4cfc7d5a4a01d2133b278cdbb1371fba1b419174
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122907-defense-blanching-5c39@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4cfc7d5a4a01d2133b278cdbb1371fba1b419174 Mon Sep 17 00:00:00 2001
From: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
Date: Mon, 17 Nov 2025 12:05:18 +0300
Subject: [PATCH] gfs2: fix freeze error handling

After commit b77b4a4815a9 ("gfs2: Rework freeze / thaw logic"),
the freeze error handling is broken because gfs2_do_thaw()
overwrites the 'error' variable, causing incorrect processing
of the original freeze error.

Fix this by calling gfs2_do_thaw() when gfs2_lock_fs_check_clean()
fails but ignoring its return value to preserve the original
freeze error for proper reporting.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b77b4a4815a9 ("gfs2: Rework freeze / thaw logic")
Cc: stable@vger.kernel.org # v6.5+
Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 644b2d1e7276..54c6f2098f01 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -749,9 +749,7 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who,
 			break;
 		}
 
-		error = gfs2_do_thaw(sdp, who, freeze_owner);
-		if (error)
-			goto out;
+		(void)gfs2_do_thaw(sdp, who, freeze_owner);
 
 		if (error == -EBUSY)
 			fs_err(sdp, "waiting for recovery before freeze\n");


