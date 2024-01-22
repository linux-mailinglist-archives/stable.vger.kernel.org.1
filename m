Return-Path: <stable+bounces-14749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BA7838266
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393121F27610
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FB75BADB;
	Tue, 23 Jan 2024 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SG4TyxAr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B85BAD9;
	Tue, 23 Jan 2024 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974343; cv=none; b=LWqZcVUxnPN2o54h4zUKqVM56eQbZEedbCH9cac2qY/PXdMJKVq0eZQNAk9OfHt6+cBJuu3+TGP0NFL1cbVF3Dz2oday1UVKp1LnBLkebSuCBEUh5b77v0lgNAzAAfI3eJ1h4A6ua2TWx4Eh2/rTGdwGOhABGp2BThCEHWEnZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974343; c=relaxed/simple;
	bh=3ik3krRZx98IWr9hpmqXv9aeoIuqHUY3D6Bozzlkz8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQHLQvG5BeinD+lzM2ZUDa2ah1ENekVNzyuIkccolYMlq1QJ0/bf7D7Yf3zf5NjtoVkUufjxITzemErOcTKJySJxHakuLvywUzIFNScGwXW4DmPUQ/8m7FG/9qP0g4U2t0GXKgaOR1d+h1zJ7sfOX4vvdWrPu2cf9hhtamjyMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SG4TyxAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294D1C433F1;
	Tue, 23 Jan 2024 01:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974343;
	bh=3ik3krRZx98IWr9hpmqXv9aeoIuqHUY3D6Bozzlkz8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SG4TyxArJFz0fs3rbbEvkc8py0LOGbRECPL454PRA8o45EynayZZzzbNWSKaPIPzR
	 2iU8xQDkenFX2SJd2IOaiIJJNmyRhyse8LMYUhfPthvx7MXGtenCh/b1BTlaKC40VJ
	 jn8+UuqFu7OJITnMui+qwpG5V/tAFsU80FlyQsJ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Mike Isely <isely@pobox.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+621409285c4156a009b3@syzkaller.appspotmail.com
Subject: [PATCH 5.15 184/374] media: pvrusb2: fix use after free on context disconnection
Date: Mon, 22 Jan 2024 15:57:20 -0800
Message-ID: <20240122235751.026504623@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

From: Ricardo B. Marliere <ricardo@marliere.net>

[ Upstream commit ded85b0c0edd8f45fec88783d7555a5b982449c1 ]

Upon module load, a kthread is created targeting the
pvr2_context_thread_func function, which may call pvr2_context_destroy
and thus call kfree() on the context object. However, that might happen
before the usb hub_event handler is able to notify the driver. This
patch adds a sanity check before the invalid read reported by syzbot,
within the context disconnection call stack.

Reported-and-tested-by: syzbot+621409285c4156a009b3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000a02a4205fff8eb92@google.com/

Fixes: e5be15c63804 ("V4L/DVB (7711): pvrusb2: Fix race on module unload")
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Acked-by: Mike Isely <isely@pobox.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-context.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 14170a5d72b3..1764674de98b 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -268,7 +268,8 @@ void pvr2_context_disconnect(struct pvr2_context *mp)
 {
 	pvr2_hdw_disconnect(mp->hdw);
 	mp->disconnect_flag = !0;
-	pvr2_context_notify(mp);
+	if (!pvr2_context_shutok())
+		pvr2_context_notify(mp);
 }
 
 
-- 
2.43.0




