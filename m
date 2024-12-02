Return-Path: <stable+bounces-96122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7279E0924
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ECE2B3B740
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A52B17B500;
	Mon,  2 Dec 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tvp9bOjj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E717ADE8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156287; cv=none; b=kWiyxIrWh1/GUdSEgb1iycNiDYykT8KmChSt25li7Vms3Wlq4DhSTwWiL5ZI45ggqu74rnjxeN83yTyZapYFE3sAV8hpcxg7F4v50/qP/v1mQ5Ad4E1fdW+Fes1OmAN3/tB0rJlCCksl6Mv3lzsqAWrYwTSQ/AtMN5BbclJ/RIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156287; c=relaxed/simple;
	bh=oGCY0Hx5op9yuS3JIlK82//A8cc80sJpYc3L1J7xkLY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ODFYjOeLUQznf5IMuiNjO33f4/ttcby1StChngoVgzpw4Re7MF5aORCkX6AaRo+z0g1IKR7KRUw0jTSRzdofUI9kMtdNZa0e49ucKjucKrk6+G7LRIfIN9BTFkpDgpyu6yLGiX3n1huOQW+83DRr3IykPcUTSPIKt5U1G69liKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tvp9bOjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45361C4CED1;
	Mon,  2 Dec 2024 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733156286;
	bh=oGCY0Hx5op9yuS3JIlK82//A8cc80sJpYc3L1J7xkLY=;
	h=Subject:To:Cc:From:Date:From;
	b=tvp9bOjj0xrXogIVOgcvBRt+XR26FxPAM2HOzi6fi0W49/G6GAHSVZuGY22K8Pop7
	 ccLLRaTQWwSNQMKpt24j+Tll8/mNt2AwjKi8fhi6X0eTquj4ND0+DX80AIKRJyeP9Z
	 xvaeKKo9fO/w2IZjutXNxYTspj+jAzd2rK3//ht4=
Subject: FAILED: patch "[PATCH] fcntl: make F_DUPFD_QUERY associative" failed to apply to 6.11-stable tree
To: brauner@kernel.org,jlayton@kernel.org,lennart@poettering.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 17:18:03 +0100
Message-ID: <2024120203-carat-landlord-afcf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 2714b0d1f36999dbd99a3474a24e7301acbd74f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120203-carat-landlord-afcf@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2714b0d1f36999dbd99a3474a24e7301acbd74f1 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 8 Oct 2024 13:30:49 +0200
Subject: [PATCH] fcntl: make F_DUPFD_QUERY associative

Currently when passing a closed file descriptor to
fcntl(fd, F_DUPFD_QUERY, fd_dup) the order matters:

    fd = open("/dev/null");
    fd_dup = dup(fd);

When we now close one of the file descriptors we get:

    (1) fcntl(fd, fd_dup) // -EBADF
    (2) fcntl(fd_dup, fd) // 0 aka not equal

depending on which file descriptor is passed first. That's not a huge
deal but it gives the api I slightly weird feel. Make it so that the
order doesn't matter by requiring that both file descriptors are valid:

(1') fcntl(fd, fd_dup) // -EBADF
(2') fcntl(fd_dup, fd) // -EBADF

Link: https://lore.kernel.org/r/20241008-duften-formel-251f967602d5@brauner
Fixes: c62b758bae6a ("fcntl: add F_DUPFD_QUERY fcntl()")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-By: Lennart Poettering <lennart@poettering.net>
Cc: stable@vger.kernel.org
Reported-by: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 22dd9dcce7ec..3d89de31066a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -397,6 +397,9 @@ static long f_dupfd_query(int fd, struct file *filp)
 {
 	CLASS(fd_raw, f)(fd);
 
+	if (fd_empty(f))
+		return -EBADF;
+
 	/*
 	 * We can do the 'fdput()' immediately, as the only thing that
 	 * matters is the pointer value which isn't changed by the fdput.


