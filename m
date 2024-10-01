Return-Path: <stable+bounces-78468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6662B98BAF6
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981BB1C227E3
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3341BF7F5;
	Tue,  1 Oct 2024 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o9dbB0Ie"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB019AD4F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781931; cv=none; b=apyqyggGgsYI2f98EeZo+Z81pDzxhp6u+2uT4Y3TxocOTNmr0lIQDDG76dVMYhMVsxdSqzHRw/HqzFmZpY/ykPsdAxmkKXl80A45OVbWEqVNWyV/RcYBkTWd+cDQfdPLS6oJpT6bNpI6VGO66YGaFby6GFiFNElldzbz8LJg3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781931; c=relaxed/simple;
	bh=MSvBCI6M2hBoxAumm6YXQ+yq5Ac97aHHjJZqO72Ov2c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jALYr17tWiKLCvu2rOtX44ScXaH3QQDMXpqg6Jt/64JKA1Z7dtK6Rq1EPbllPT7YwXZdi8u3gu/Zfjr7ljOHERQLS9fL5MemwRJ9ZxDOUnpedcdPvRkZp21ywkRYAQSTXpmKk2QpVwuGqaI8hIHVAub4mGHVIDYaiIxdGjdih00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o9dbB0Ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2515CC4CEC6;
	Tue,  1 Oct 2024 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727781931;
	bh=MSvBCI6M2hBoxAumm6YXQ+yq5Ac97aHHjJZqO72Ov2c=;
	h=Subject:To:Cc:From:Date:From;
	b=o9dbB0Ie13ciKByUb3AIdR5Yw2m43yF/BnLBzqjs8DSkDRRwM8++A2yFNeNh5E5Pk
	 7n4id5xlguOdPzlcs8Z6CJMpPpL5aI6pmeyvgTpNIKvZlK0GYgt24p3F1RulE/007P
	 8il4YSPdR2V0QSEGJslFIbRnkTvrYZMg7IfJKmEM=
Subject: FAILED: patch "[PATCH] debugfs show actual source in /proc/mounts" failed to apply to 6.10-stable tree
To: tsi@tuyoix.net,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 13:25:28 +0200
Message-ID: <2024100128-prison-ploy-dfd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3a987b88a42593875f6345188ca33731c7df728c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100128-prison-ploy-dfd6@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

3a987b88a425 ("debugfs show actual source in /proc/mounts")
49abee5991e1 ("debugfs: Convert to new uid/gid option parsing helpers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a987b88a42593875f6345188ca33731c7df728c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>
Date: Sat, 10 Aug 2024 13:25:27 -0600
Subject: [PATCH] debugfs show actual source in /proc/mounts
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After its conversion to the new mount API, debugfs displays "none" in
/proc/mounts instead of the actual source.  Fix this by recognising its
"source" mount option.

Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
Link: https://lore.kernel.org/r/e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net
Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 91521576f500..66d9b3b4c588 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -89,12 +89,14 @@ enum {
 	Opt_uid,
 	Opt_gid,
 	Opt_mode,
+	Opt_source,
 };
 
 static const struct fs_parameter_spec debugfs_param_specs[] = {
 	fsparam_gid	("gid",		Opt_gid),
 	fsparam_u32oct	("mode",	Opt_mode),
 	fsparam_uid	("uid",		Opt_uid),
+	fsparam_string	("source",	Opt_source),
 	{}
 };
 
@@ -126,6 +128,12 @@ static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param
 	case Opt_mode:
 		opts->mode = result.uint_32 & S_IALLUGO;
 		break;
+	case Opt_source:
+		if (fc->source)
+			return invalfc(fc, "Multiple sources specified");
+		fc->source = param->string;
+		param->string = NULL;
+		break;
 	/*
 	 * We might like to report bad mount options here;
 	 * but traditionally debugfs has ignored all mount options


