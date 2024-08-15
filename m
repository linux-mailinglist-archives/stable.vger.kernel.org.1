Return-Path: <stable+bounces-68267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B2595316C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABFE1C20D98
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A8F1A00DF;
	Thu, 15 Aug 2024 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w2j3jVLu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1140118D630;
	Thu, 15 Aug 2024 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730025; cv=none; b=JuLTxMGIfM9z/C2h7qi5rgleB5+pgF6xJ+NrgLyv0e6MF085NsHMWhLJORFwLUCvrqVUlGo7LbHp+s3Ffa0+eNDLeXoSi15q79QeUFCcVUdDJpECrxLRx5HvHo0le+q0vhjRgAroDoEZlaMII1Mmi64hspBnVad1QwRwcwAi6WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730025; c=relaxed/simple;
	bh=wZuQ/FwJv8WNSinpxiJkv5bKbNUcKjQGfQRzDK0F4oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azgrFoZs7z/6N+KW3D0leE6b+Lz7LvK0Bhy89QMylOy/GD3wWN7d78jzqAiZKkVUh6bxJRXHbV89cBk9VAxWSRS9lwTp4s3AWy7LXT3W5eELuON8e7DPWPV7yQyYFDFMhsMMkSm3i8wM61pFoYMCCqsAph0bE3zXwrYywW/rcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w2j3jVLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F4EC32786;
	Thu, 15 Aug 2024 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730024;
	bh=wZuQ/FwJv8WNSinpxiJkv5bKbNUcKjQGfQRzDK0F4oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w2j3jVLu4MEw2GJdBepCiVqCOKOPPBbK+T9HlrP4gEb9s3KJf8eM3+xDFbaCfdyOh
	 auHZy4mpbnngciGczGDs9LP64qiTdbBlWuL+LxGujiSo/dRNBUGOhe0OI3mHmFG0LT
	 y4K8H0aj1PnY3Twmc2zIi49ATVqE1Nf3K0JvXpC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 281/484] lirc: rc_dev_get_from_fd(): fix file leak
Date: Thu, 15 Aug 2024 15:22:19 +0200
Message-ID: <20240815131952.258909105@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit bba1f6758a9ec90c1adac5dcf78f8a15f1bad65b ]

missing fdput() on a failure exit

Fixes: 6a9d552483d50 "media: rc: bpf attach/detach requires write permission" # v6.9
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/lirc_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index d73f02b0db842..54f4a7cd88f43 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -841,8 +841,10 @@ struct rc_dev *rc_dev_get_from_fd(int fd, bool write)
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (write && !(f.file->f_mode & FMODE_WRITE))
+	if (write && !(f.file->f_mode & FMODE_WRITE)) {
+		fdput(f);
 		return ERR_PTR(-EPERM);
+	}
 
 	fh = f.file->private_data;
 	dev = fh->rc;
-- 
2.43.0




