Return-Path: <stable+bounces-116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA46C7F72DA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7B6B21377
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988921C693;
	Fri, 24 Nov 2023 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0JbRUc9r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D481DDDE
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD82C433CA;
	Fri, 24 Nov 2023 11:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700825756;
	bh=1RhQkDhO7kpGqwzGbhqRiYQrhT0ZZ0LElCnFr7Fgykc=;
	h=Subject:To:Cc:From:Date:From;
	b=0JbRUc9rsxidA6rWzGUz8JT3DTzs4FkYpikl7ksO1Edy9+Rs881Lecpw9b2n0Bw2a
	 cstQ4vt508UZ8sbqR4H0rbf1hyvrJqaA4zWtm2bnI3dZloEGpu6TbSqPFfH/o5zMbb
	 F/6zSeXiPT7fJxhN1HwzMIz7c4oVJ7DAl5BDPND0=
Subject: FAILED: patch "[PATCH] prctl: Disable prctl(PR_SET_MDWE) on parisc" failed to apply to 6.6-stable tree
To: deller@gmx.de,sam@gentoo.org,stable@vger.kernel.org,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 11:35:55 +0000
Message-ID: <2023112455-magnify-upturned-8e18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 793838138c157d4c49f4fb744b170747e3dabf58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112455-magnify-upturned-8e18@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

793838138c15 ("prctl: Disable prctl(PR_SET_MDWE) on parisc")
24e41bf8a6b4 ("mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl")
0da668333fb0 ("mm: make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 793838138c157d4c49f4fb744b170747e3dabf58 Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Sat, 18 Nov 2023 19:33:35 +0100
Subject: [PATCH] prctl: Disable prctl(PR_SET_MDWE) on parisc

systemd-254 tries to use prctl(PR_SET_MDWE) for it's MemoryDenyWriteExecute
functionality, but fails on parisc which still needs executable stacks in
certain combinations of gcc/glibc/kernel.

Disable prctl(PR_SET_MDWE) by returning -EINVAL for now on parisc, until
userspace has catched up.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Sam James <sam@gentoo.org>
Closes: https://github.com/systemd/systemd/issues/29775
Tested-by: Sam James <sam@gentoo.org>
Link: https://lore.kernel.org/all/875y2jro9a.fsf@gentoo.org/
Cc: <stable@vger.kernel.org> # v6.3+

diff --git a/kernel/sys.c b/kernel/sys.c
index 420d9cb9cc8e..e219fcfa112d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2394,6 +2394,10 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
 	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
 		return -EINVAL;
 
+	/* PARISC cannot allow mdwe as it needs writable stacks */
+	if (IS_ENABLED(CONFIG_PARISC))
+		return -EINVAL;
+
 	current_bits = get_current_mdwe();
 	if (current_bits && current_bits != bits)
 		return -EPERM; /* Cannot unset the flags */


