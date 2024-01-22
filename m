Return-Path: <stable+bounces-13411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466C6837BF3
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7670A1C2848B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84A71420C0;
	Tue, 23 Jan 2024 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d7X09Pqi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E3131748;
	Tue, 23 Jan 2024 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969449; cv=none; b=dgrS0R2pQnFj82krK4UKgOyTKGoqbjdC88kjKPz6OAEvLazP9LGemALorIZOMgadjRHuJaUbGz4gJYaiFul2r8AzgIbATWehD641jN/429P1MRWixVCOTQ4/kgJVnZdNthlopAiol5GNL0dUD5n/fkPKs5L/jNAfgOXjUNqe0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969449; c=relaxed/simple;
	bh=VqU16vs751sl3MpltP4VM0gTEC6ceVkGcPlts/SkR4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vcjed1fKpNDEcE/Ax1TZ58IGs1TvU0s/f47eWikhFx41ZucBFLY41lFk1yjyZb/Btp/hl5WxnGae3M+2pBq7U7wD1KqF8P90XOj0BV6EOaiIB6INAf2MVJu8MCvPzbK4UvI5L5RpKWRaNOYEByzm+UxT1dEkYTyrsxAZ7vq89VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d7X09Pqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACD2C43390;
	Tue, 23 Jan 2024 00:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969449;
	bh=VqU16vs751sl3MpltP4VM0gTEC6ceVkGcPlts/SkR4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d7X09PqipuoOHRXkWzNyZbYqyFF43472aMC5YIxYmoF2RS8udwTMm0WZC2xu7bWYn
	 T0XbCrgw2aHQhT/cFIzpW76WaD8/nLr9ohq9dTc6ulqtc+/I7p/Y4Opojzk+WqxBq/
	 j2PQj91DPjg2x+NHps7JQSA47aqmfYhoWFjjq8v8=
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
Subject: [PATCH 6.7 254/641] media: pvrusb2: fix use after free on context disconnection
Date: Mon, 22 Jan 2024 15:52:38 -0800
Message-ID: <20240122235825.861757443@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

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




