Return-Path: <stable+bounces-78396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB79298B923
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51801C22961
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B028119C561;
	Tue,  1 Oct 2024 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vjMQ2ae3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA54189918
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777862; cv=none; b=bm6Zc+OOS++ZIR1crudDkEu0x0JLi76cUe9eFCtREr79W1YKlH2FEYBXWWqMvwB6iEKXTrC5zh16+6MR7sIwul0dl7/lFEMWnEN/LNWrtt4a7PDZNJrvVKI9pQq+GRDxRqfX9tjJcROjYEwnyy/98TE7tjC9s9r5GZcbqBFW6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777862; c=relaxed/simple;
	bh=MZCszR/2Oyh+qWBtRzQbGnNW/CSfqhR02T8Nq37EeWY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p6tY1kt76ZVxOlSFMuuwa92NPB6nCWcOIdkhdcqm7UqDmW10FLXm3XoAieQKhz2fBYoydL0WRLIHbrx7R11XDJSRPJJY9nPudECW1Mv1K32a+29u9SzXMoIK48yIT56grJ5MsMSyZJ4Fxlqfz5hQjDxAT38La07p6Kn2zbPoVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vjMQ2ae3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CADC4CEC6;
	Tue,  1 Oct 2024 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727777862;
	bh=MZCszR/2Oyh+qWBtRzQbGnNW/CSfqhR02T8Nq37EeWY=;
	h=Subject:To:Cc:From:Date:From;
	b=vjMQ2ae3nGm2Ek/DVfqmRSkfk2VZW09dgtLWFkd424LVKFWfR4Qc8XBrvhU0JjPFu
	 78rH6zKrUhSCLKmm5U064B8YPUdzk631vi2yfL61wJd0M5uzwwnWG3wykPlB5SBDk3
	 cKhSrKzIOOctCeNJk0HoR6kT4vK6WByASv233ENU=
Subject: FAILED: patch "[PATCH] ksmbd: allow write with FILE_APPEND_DATA" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:17:34 +0200
Message-ID: <2024100133-crablike-static-40ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2fb9b5dc80cabcee636a6ccd020740dd925b4580
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100133-crablike-static-40ed@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

2fb9b5dc80ca ("ksmbd: allow write with FILE_APPEND_DATA")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
369c1634cc7a ("ksmbd: don't open-code %pD")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2fb9b5dc80cabcee636a6ccd020740dd925b4580 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Sep 2024 20:26:33 +0900
Subject: [PATCH] ksmbd: allow write with FILE_APPEND_DATA

Windows client write with FILE_APPEND_DATA when using git.
ksmbd should allow write it with this flags.

Z:\test>git commit -m "test"
fatal: cannot update the ref 'HEAD': unable to append to
 '.git/logs/HEAD': Bad file descriptor

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 9e859ba010cf..19900625d5d2 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -496,7 +496,7 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 	int err = 0;
 
 	if (work->conn->connection_type) {
-		if (!(fp->daccess & FILE_WRITE_DATA_LE)) {
+		if (!(fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE))) {
 			pr_err("no right to write(%pD)\n", fp->filp);
 			err = -EACCES;
 			goto out;


