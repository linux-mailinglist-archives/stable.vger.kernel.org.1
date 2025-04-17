Return-Path: <stable+bounces-133934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26F8A9289F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D567916AC26
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5B7256C8C;
	Thu, 17 Apr 2025 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oPIlVL6i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE11E98ED;
	Thu, 17 Apr 2025 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914590; cv=none; b=koNFbnCWxRcGf8sGDgI2YF4CsYq66DGMvnAzVvPV2GArCID4WdQC8sQpYLNYrVnc8DlHZQYtP0qCoTPlaYAKV3To2gCKQVUbuFPNLtDuvYbbF9yUP92wlaoWzpKWabplHK1bQemaU0fPvavSg4EwrP3eWw7ZJej8Y8j8Ve0RNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914590; c=relaxed/simple;
	bh=p9de63wXU4LzSmVDPk+ZyfvCbsvd4PfybKkblayOKio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEpN1bKV4wNrTpudCaq9LEiNyui14G1/NhLNHYXLGJY7GS6ArmM5RZokbex3aqiC2XSDn3ynbgpHhPLXN3dAl34J6rj5FNbKeUNgPOgeaT3hpwAy8YKh1eKKkE4uwu5s2NVNiLhh9+0s4zPV+svn+sm3VZ0flldhZgwOCevBTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oPIlVL6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56006C4CEE4;
	Thu, 17 Apr 2025 18:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914589;
	bh=p9de63wXU4LzSmVDPk+ZyfvCbsvd4PfybKkblayOKio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPIlVL6iS4LIEUz/9u0fJR9Vw4BmWQ9mIZyW/mx++KFtSEzmK+Xjpkx+KI2U3Cgwk
	 YSsoFMvHIk4ogWSJ5vBiELVEAC7or2mi3sMNOsVoYmaeVzpJSbgllEWds3dAV8tiOB
	 s1sv7coX0FNeiwUTYf10OW8hLtFGfBBeHwlXKgJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+58928048fd1416f1457c@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.13 265/414] io_uring/kbuf: reject zero sized provided buffers
Date: Thu, 17 Apr 2025 19:50:23 +0200
Message-ID: <20250417175122.090068378@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit cf960726eb65e8d0bfecbcce6cf95f47b1ffa6cc upstream.

This isn't fixing a real issue, but there's also zero point in going
through group and buffer setup, when the buffers are going to be
rejected once attempted to get used.

Cc: stable@vger.kernel.org
Reported-by: syzbot+58928048fd1416f1457c@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/kbuf.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -484,6 +484,8 @@ int io_provide_buffers_prep(struct io_ki
 	p->nbufs = tmp;
 	p->addr = READ_ONCE(sqe->addr);
 	p->len = READ_ONCE(sqe->len);
+	if (!p->len)
+		return -EINVAL;
 
 	if (check_mul_overflow((unsigned long)p->len, (unsigned long)p->nbufs,
 				&size))



